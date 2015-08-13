<?php

/*
http://whiteboxcomputing.com/php/crawler/

Modify to work with Codoforum

Author: nguoianphu@gmail.com
Website: www.nguoianphu.com
*/

class Crawler
{
    private $url;        // The full URL linking to the root page
    private $scheme;    // The scheme of the root page
    private $domain;    // The domain name of the root page
    private $path;        // The path (relative to scheme://host/) to the root page
    private $file;        // The root file to scan (filename only)
    
    private $crawled;    // The pages crawled
    private $seen;        // All urls encountered
    private $toCrawl;    // The pages still to be crawled
    
    private $debug  = true;
    private $debug2 = false;
    
    /**
     * Crawls a page. The given url must contain both a scheme and a host name. In
     *  other words, new Crawler('http://google.com/index.htm') is valid while new
     *  Crawler('./index.php') is not.
     */
    public function __construct($url)
    {
        $parts = parse_url($url);
        if (!isset($parts['scheme'])) throw new Exception("url passed to constructor must contain scheme (http://)");
        if (empty($parts['scheme'])) throw new Exception("url passed to constructor must contain scheme (http://)");
        if (!isset($parts['host'])) throw new Exception("url passed to constructor must contain domain name (example.com)");
        if (empty($parts['host'])) throw new Exception("url passed to constructor must contain domain name (example.com)");
        $this->scheme = strtolower($parts['scheme']);
        $this->domain = strtolower($parts['host']);
        $root = $parts['path'];
        $this->path = pathinfo($root, PATHINFO_DIRNAME);
        $this->file = pathinfo($root, PATHINFO_BASENAME);
        $this->url = $url;
        if ($this->path == '\\') $this->path = '/';
        
        $this->toCrawl = array($url);
        $this->crawled = array();
        $this->seen    = array();
        
        while(!empty($this->toCrawl)) {
            foreach($this->toCrawl as $key=>$value) {
                $this->crawl($value);
                $this->seen[] = $value;
                unset($this->toCrawl[$key]);
            }
        }    
    }
    
    private function crawl($url)
    {
        if ($this->debug) echo "<i>Crawled:</i> $url<br />";
        
        $links = $this->scanForLinks($url);
        if ($links === false) return;
		
		
        
        $pages = array();
        foreach($links as $link) {
            
            $parts = parse_url($link);
            
            if ($this->debug2) echo "<b>Testing: $link</b><br />";
            
            // Ignore link without path specification
            if (!isset($parts['path']) || empty($parts['path'])) continue;
			
			// Ignore link with {{ in codoforum
            if (preg_match("/{{/", $parts['path'])) continue;
            
			// Ignore link with codoforum attachments
            if (preg_match("/attachment/", $parts['path'])) continue;
			
            // Ignore other schemes
            if (isset($parts['scheme'])) {
                $scheme = strtolower($parts['scheme']);
                if ($scheme != $this->scheme) continue;
            }
            
            // Ignore other domain names
            if (isset($parts['host'])) {
                $domain = strtolower($parts['host']);
                if ($domain != $this->domain) continue;
            }
			
            // Replace initial / with full path
            $path = $parts['path'];
            if ($path[0] != '/')
                $path = $this->path .'/'. $path;
            
            $isDir = (substr($path, -1) == '/');
            $path = explode('/', $path);
            $level = 0;
            $new = array();
            foreach($path as $part)
            {
                // Ignore ./ and //
                if ($part == '.' || $part == '') continue;
                
                if ($part == '..') {
                    // Go a level deeper 
                    $level--;
                    if ($level < 0) break;
                } else {
                    $new[$level] = $part;
                    $level++;
                }
            }
            // Ignore anything deeper than the current level
            if ($level < 1) continue;
            
            // Parse
            $parsed = $this->scheme.'://'.$this->domain; // .$this->path;
            
            for ($i=0; $i<$level; $i++) $parsed .= '/'.$new[$i];
            if ($isDir) $parsed .= '/';
                
            if ($this->debug2) echo $parsed . "<br />";
            
            // If not seen yet & not queued --> queue
            if (!(in_array($parsed, $this->seen)
               || in_array($parsed, $this->toCrawl))) $this->toCrawl[] = $parsed;                
        }
        
        // Scanned succesfully -> add to crawled list
        $this->crawled[] = $url;
    }
        
    private function scanForLinks($url)
    {
        if (substr($url, 0, 7) != 'http://') $url = 'http://'.$url;
        if (substr($url, -1) == '/') $url = substr($url, 0, -1);
        
        if ($url == 'http://localhost') $url = 'http://127.0.0.1';
    
        @$cnt = file_get_contents($url);
        if ($cnt === false) return false;
        
        // Find links (messy!)
        preg_match_all("/<a [^>]*href[\s]*=[\s]*\"([^\"]*)\"/i", $cnt, $links);
        return $links[1];
    }
    
	/**
     * Returns the links found
     */
    public function getPages()
    {
        return $this->crawled;
    }
	
	/**
     * Returns the links found as a site map
     */
    public function getSiteMap()
    {
        // ob_start();
        echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
        echo "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n";
        foreach($this->crawled as $url)
           echo "\t<url><loc>$url</loc></url>\n";
        echo "</urlset>";
        // return ob_get_clean();
    }
	
	/**
     * Create sitemap file
     */
    public function createSitemap($sitemap)
    {
		echo "Openning $sitemap\n";
		echo '<br />';
        $pf = fopen($sitemap, "w");
		if (!$pf) {
			echo "cannot create $sitemap\n";
			return;
		}
		// fwrite($pf, pack("CCC",0xef,0xbb,0xbf));
		fwrite($pf, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\">\n");
		
		foreach($this->crawled as $url) {
			// Replace index.php with empty
			$url = str_replace('/index.php', '', $url);
			fwrite($pf, html_entity_decode("<url>\n  <loc>$url</loc>\n" . "  <changefreq>daily</changefreq>\n" . "  <priority>1.0</priority>\n</url>\n"));
		}

		fwrite($pf, "</urlset>\n");
		fclose($pf);
		echo "Created $sitemap\n";
		echo '<br />';
    }
	
	/**
     * Ping sitemap file to search engines, by RolluS (webmaster@reynald-rollet.fr) from:
     * http://jaspreetchahal.org/php-script-function-to-ping-update-google-bing-yahoo-ask-com-about-sitemap-change/comment-page-1/
     * http://www.benhallbenhall.com/2013/01/script-automatically-submit-sitemap-google-bing-yahoo-ask-etc/
     */
    public function SendSiteMapUpdateIndicationPing($sitemap_url){
        $urls = array();
        // below are the SEs that we will be pining
        // $urls[] = "http://www.google.com/webmasters/tools/ping?sitemap=".urlencode($sitemap_url);
        $urls[] = "http://google.com/webmasters/sitemaps/ping?sitemap=".urlencode($sitemap_url);
        $urls[] = "http://www.bing.com/webmaster/ping.aspx?siteMap=".urlencode($sitemap_url);
        $urls[] = "http://ping.blogs.yandex.ru/ping?sitemap=".urlencode($sitemap_url);
        // $urls[] = "http://submissions.ask.com/ping?sitemap=".urlencode($sitemap_url);

        foreach ($urls as $url)
        {
            $parse = parse_url($url);
            $parsedUrl=$parse['host'];
            echo "Pinging $parsedUrl with $sitemap_url <br />";
            $returnCode = $this->myCurl($url);
            echo "<p> Ping sent to $parsedUrl (return code: $returnCode).<br /></p>";
            }
    }

    // cUrl handler to ping the Sitemap submission URLs for Search Engines…
    private function myCurl($targetUrl){
        $ch = curl_init($targetUrl);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        return $httpCode;
    }
    
}

	// $sitemapObject = new Crawler('http://192.168.88.45/codoforum/index.php');
	// $sitemapPage = $sitemapObject->getSiteMap();
	// $sitemapFile = $sitemapObject->createSitemap('sitemap.xml');

?>
