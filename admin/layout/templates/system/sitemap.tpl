<style type="text/css">

    .error {

        background: #770000;
        color: white;
        border: 1px solid #600;
        padding: 6px;
        margin-top: 15px;
    }

    .info{

        background: rgb(100,100,100);
        color: white;
        border: 1px solid #600;
        padding: 6px;
        margin-top: 15px;
    }
    .success {

        background: #428bca;
        color: white;
        border: 1px solid #1471af;
        padding: 6px;        
        margin-top: 15px;

    }

    .warn {

        padding: 6px;
        background: rgb(170, 15, 1);
        color: white;
        margin-bottom: 10px;
    }

</style>
<section class="content-header" id="breadcrumb_forthistemplate_hack">
    <h1>&nbsp;</h1>
    <ol class="breadcrumb" style="float:left; left:10px;">
        <li><a href="index.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class=""><i class="fa fa-desktop"></i> System</li> 
        <li class="active"><i class="fa fa-level-up"></i> Sitemap</li>
    </ol>

</section>


<div class="row col-md-12">

    <div class="warn" id="warn1">Backup your Sitemap before starting the generated process!</div>
    <div class="warn" id="warn2">chmod 666 sitemap.xml first!</div>


    <!-- <div><button class="btn btn-primary" onclick="begin_generate()">Start Generate Sitemap Process</button></div> -->
    <div style="" class="info" id="codo_import_status"></div>

</div>

<div class="row col-md-12" style="margin:15px;display: yes" id="ftp">

    <div class="col-lg-8">
        <div class="box box-primary">

            <div class="box-body">
				
                <fieldset>
                    <div class="form-group">
                        <label>Full website URL</label>
                        <label>Must have index.php at the end</label>
                        <input id="site_url" type="text" name="site_url" class="form-control" value="" />


                    </div>
					
                    <div class="form-group">
                        <label>Sitemap URL</label>
                        <input id="sitemap_url" type="text" name="sitemap_url" class="form-control" value="" />


                    </div>

                    <div class="form-group">
                        <input type="button" onclick="begin_generate()" name="Login" value="Submit" alt="Login">
                </fieldset>

                    </div>
            </div>
        </div>
    </div>
	
	<script type="text/javascript">
		document.getElementById("site_url").value = window.location.protocol + "//" + window.location.hostname + "/index.php";
		document.getElementById("sitemap_url").value = window.location.protocol + "//" + window.location.hostname + "/sitemap.xml";
	</script>
	
    <script type="text/javascript">

		
        function begin_generate() {
		
			$('#warn1').hide();
			$('#warn2').hide();
			$('#ftp').hide();

            var sts = $('#codo_import_status');
            setTimeout(step_crawl, 1000);

            sts.html("> Start crawling your website ...<br>");
			
			sts.append("> Crawling ...<br>");
			sts.append("> It may take a long time. Please wait ...<br>");

        }
        



        function step_crawl() {

			var site_url = $('#site_url').val();
			var sitemap_url = $('#sitemap_url').val();
			
            jQuery.get('index.php?page=system/sitemap&sitemap=true',{
                site_url: site_url,
                sitemap_url: sitemap_url,
                CSRF_token: '{$token}'
            }, function (data) {

             var   sts = $('#codo_import_status');

                sts.append(data);
				
				sts.append("<br />");
				sts.append("> Crawled and Created sitemap.xml<br>");

            });

        }


    </script>
