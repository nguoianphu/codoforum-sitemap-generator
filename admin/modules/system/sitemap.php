<?php

/*
 * @CODOLICENSE
 */

$smarty = \CODOF\Smarty\Single::get_instance();

require_once ('sitemap_gen.php');

class sitemap {
    
    static function run() {


        if (isset($_GET['site_url']) && isset($_GET['sitemap_url']) && CODOF\Access\CSRF::valid($_GET['CSRF_token'])) {
		
			$sitemapObject = new Crawler($_GET['site_url']);
			$sitemapPath = ABSPATH . 'sitemap.xml';
			$sitemapFile = $sitemapObject->createSitemap($sitemapPath);
			$sitemapFile = $sitemapObject->SendSiteMapUpdateIndicationPing($_GET['sitemap_url']);
            exit();
        }
    }

}

sitemap::run();

$content = $smarty->fetch('system/sitemap.tpl');
