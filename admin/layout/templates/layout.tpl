{*

/*
* @CODOLICENSE
*/

*}

{*Smarty*}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>CODOFORUM | Dashboard</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="{$A_RURI}css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="{$A_RURI}css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="{$A_RURI}css/ionicons.min.css" rel="stylesheet" type="text/css" />

        <!-- Theme style -->
        <link href="{$A_RURI}css/AdminLTE.css" rel="stylesheet" type="text/css" />

        <link href="{$A_RURI}css/bootstrap-toggle.min.css" rel="stylesheet" type="text/css" />
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
        <link rel="shortcut icon" type="image/x-icon" href="{$A_RURI}img/favicon.ico?v=1">
        <link rel="apple-touch-icon" sizes="57x57" href="{$A_RURI}img/apple-touch-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="114x114" href="{$A_RURI}img/apple-touch-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="72x72" href="{$A_RURI}img/apple-touch-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="144x144" href="{$A_RURI}img/apple-touch-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="60x60" href="{$A_RURI}img/apple-touch-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="120x120" href="{$A_RURI}img/apple-touch-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="76x76" href="{$A_RURI}img/apple-touch-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="152x152" href="{$A_RURI}img/apple-touch-icon-152x152.png">
        <link rel="icon" type="image/png" href="{$A_RURI}img/favicon-196x196.png" sizes="196x196">
        <link rel="icon" type="image/png" href="{$A_RURI}img/favicon-160x160.png" sizes="160x160">
        <link rel="icon" type="image/png" href="{$A_RURI}img/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="{$A_RURI}img/favicon-16x16.png" sizes="16x16">
        <link rel="icon" type="image/png" href="{$A_RURI}img/favicon-32x32.png" sizes="32x32">

        <!-- jQuery 2.0.2 -->
        <script src="{$A_RURI}js/jquery-2.1.1.min.js"></script>    

    </head>
    <body class="skin-blue">
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a href="index.php" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
                CF - ACP
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                    <ul class="nav navbar-nav">


                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="glyphicon glyphicon-user"></i>
                                <span>{if isset($A_username) }

                                    {$A_username}
                                    {else}
                                        Hello
                                        {/if} <i class="caret"></i></span>
                                    </a>
                                    {if isset($logged_in) && $logged_in eq "yes" }
                                        <ul class="dropdown-menu">
                                            <!-- User image -->
                                            <li class="user-header bg-light-blue">
                                                <img src="{$A_avatar}" class="img-circle" alt="User Image" />
                                                <p>
                                                    {$A_username} - Administrator
                                                    <small>Member since {$A_created}</small>
                                                </p>
                                            </li>

                                            <!-- Menu Footer-->
                                            <li class="user-footer">
                                                <div class="pull-left">
                                                    <a href="../?u=user/profile" target="_blank" class="btn btn-default btn-flat">Profile</a>
                                                </div>
                                                <div class="pull-right">
                                                    <a href="index.php?page=login&logout=true" class="btn btn-default btn-flat">Sign out</a>
                                                </div>
                                            </li>
                                        </ul>
                                    {/if}        
                                </li>
                            </ul>
                        </div>
                    </nav>
                </header>
                <div class="wrapper row-offcanvas row-offcanvas-left">
                    {if isset($logged_in) && $logged_in eq "yes" }
                        <!-- Left side column. contains the logo and sidebar -->
                        <aside class="left-side sidebar-offcanvas">
                            <!-- sidebar: style can be found in sidebar.less -->
                            <section class="sidebar">

                                <!-- sidebar menu: : style can be found in sidebar.less -->
                                <ul class="sidebar-menu">
                                    <li class="{$active.index}">
                                        <a href="index.php">
                                            <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                                        </a>
                                    </li>
                                    <li class="{$active.users}">
                                        <a href="index.php?page=users">
                                            <i class="fa fa-users"></i> <span>Users</span> 
                                        </a>
                                    </li>
                                    <li class="{$active['permission/roles']}">
                                        <a href="index.php?page=permission/roles"><i class="fa fa-key"></i> Role permissions</a>
                                    </li>

                                    <li class="{$active.categories}">
                                        <a href="index.php?page=categories">
                                            <i class="fa fa-table"></i>
                                            <span>Categories</span>
                                        </a>
                                    </li>

                                    <li class="{$active.config}">
                                        <a href="index.php?page=config">
                                            <i class="fa fa-wrench"></i>
                                            <span>Global Settings</span>
                                        </a>
                                    </li>
                                    <li class="{$active['plugins/plugins']}">
                                        <a href="index.php?page=plugins/plugins">
                                            <i class="fa fa-cogs"></i>
                                            <span>Plugins</span>
                                        </a>
                                    </li>


                                    <li class="treeview {$active['moderation/ban_user']} {$active['moderation/approve_users']}">
                                        <a href="#">
                                            <i class="fa fa-shield"></i> <span>Moderation</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                        <ul class="treeview-menu">
                                            <li class="{$active['moderation/approve_users']}"> <a href="index.php?page=moderation/approve_users"><i class="fa fa-check"></i><span> Approve Users</span> </a> </li>                                              
                                            <li class="{$active['moderation/ban_user']}"> <a href="index.php?page=moderation/ban_user"><i class="fa fa-ban"></i><span> Ban User</span> </a> </li>  
                                        </ul>
                                    </li> 


                                    <li class="{$active['pages/pages']}">
                                        <a href="index.php?page=pages/pages">
                                            <i class="fa fa-file-powerpoint-o"></i>
                                            <span> Pages</span>
                                        </a>
                                    </li> 
                                    <li class="treeview {$active['ui/themes']}{$active['ui/blocks']}{$active['ui/smileys']}">
                                        <a href="#">
                                            <i class="fa fa-laptop"></i>
                                            <span>UI Elements</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                        <ul class="treeview-menu">
                                            <li class="{$active['ui/themes']}"><a href="index.php?page=ui/themes"><i class="fa fa-image"></i> Themes</a></li>
                                            <li class="{$active['ui/blocks']}"><a href="index.php?page=ui/blocks"><i class="fa fa-cubes"></i> Blocks</a></li>
                                            <li class="{$active['ui/smileys']}"><a href="index.php?page=ui/smileys"><i class="fa fa-smile-o"></i> Smileys</a></li>


                                        </ul>
                                    </li>

                                    <li  class="treeview {$active['mail/configuration']} {$active['mail/templates']}">
                                        <a href="#">
                                            <i class="fa fa-envelope"></i> <span>Mail Settings</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                        <ul class="treeview-menu">
                                            <li  class="{$active['mail/configuration']}"><a href="index.php?page=mail/configuration"><i class="fa fa-gear"></i> Configuration</a></li>                  
                                            <li  class="{$active['mail/templates']}"><a href="index.php?page=mail/templates"><i class="fa fa-file"></i> Templates</a></li>

                                        </ul>                            
                                    </li>
                                    <li class="treeview {$active['system/importer']} {$active['system/cron']} {$active['system/upgrade']} {$active['system/massmail']} {$active['system/sitemap']}">
                                        <a href="#">
                                            <i class="fa fa-desktop"></i> <span>System</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                        <ul class="treeview-menu">
                                            <li  class="{$active['system/massmail']}"><a href="index.php?page=system/massmail"><i class="fa fa-envelope-square"></i> Mass mail</a></li>                  
                                            <li  class="{$active['system/sitemap']}"><a href="index.php?page=system/sitemap"><i class="fa fa-exclamation-circle"></i> Sitemap</a></li>                  
                                            <li  class="{$active['system/cron']}"><a href="index.php?page=system/cron"><i class="fa fa-clock-o"></i> Cron</a></li>
                                            <li  class="{$active['system/importer']}"><a href="index.php?page=system/importer"><i class="fa fa-exclamation-circle"></i> Importer</a></li>                  
                                            <li  class="{$active['system/upgrade']}"><a href="index.php?page=system/upgrade"><i class="fa fa-level-up"></i> Upgrade</a></li>                  

                                        </ul>
                                    </li>                        
                                </ul>
                            </section>
                            <!-- /.sidebar -->
                        </aside>

                    {else}

                        <style type="text/css">
                            .right-side {

                                margin-left: 0 !important;
                            }
                        </style>
                    {/if}

                    <!-- Right side column. Contains the navbar and content of the page -->
                    <aside class="right-side">
                        <!-- Content Header (Page header) -->

                        <!-- Main content -->
                        <section class="content">
                            {$content}

                        </section><!-- /.content -->
                    </aside><!-- /.right-side -->
                </div><!-- ./wrapper -->


                <!-- Bootstrap -->
                <script src="{$A_RURI}js/bootstrap.min.js" type="text/javascript"></script>
                <!-- AdminLTE App -->
                <script src="{$A_RURI}js/AdminLTE/app.js" type="text/javascript"></script>

                <script src="{$A_RURI}js/Nestable/jquery.nestable.js"></script>

                <script>

                    $div = $('.content');
                    //to get the breadcrumb one element level up
                    $div.before($('#breadcrumb_forthistemplate_hack'));

                </script>
                <script src="{$A_RURI}js/bootstrap-toggle.min.js"></script>    

            </body>
        </html>
