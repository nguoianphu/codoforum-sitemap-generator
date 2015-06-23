<?php

/*
 * @CODOLICENSE
 */

define('IN_CODOF',TRUE);
error_reporting(-1);
ini_set("display_errors",1);

date_default_timezone_set('Europe/London'); 

require "adminload.php";
require "Lib.php";

$ruri = str_replace("index.php?u=/","",RURI);
define('A_RURI',$ruri . 'admin/'); //http://root URI
define('A_DURI',str_replace("admin/","",DURI)); // http://~sites/
//define('DEFAULT_PATH',)//http://localhost/codoforum/sites/default/

//DATAPATH:  "/opt/lampp/htdocs/codoforum/sites/2013/12/20/xyz/"
//ABSPATH:  "/opt/lampp/htdocs/codoforum/"
Constants::post_boot('');

codoForumAdmin::$action["index"]="index";
codoForumAdmin::$action["categories"]="categories";
codoForumAdmin::$action["login"]="login";
codoForumAdmin::$action["users"]="users";
codoForumAdmin::$action["config"]="config";
codoForumAdmin::$action["pages/pages"]="pages/pages";
codoForumAdmin::$action["ui/themes"]="ui/themes";
codoForumAdmin::$action["ui/blocks"]="ui/blocks";
codoForumAdmin::$action["ui/smileys"]="ui/smileys";
codoForumAdmin::$action["mail/configuration"]="mail/configuration";
codoForumAdmin::$action["mail/templates"]="mail/templates";
codoForumAdmin::$action["sso"]="sso";
codoForumAdmin::$action["plugins/plugins"]="plugins/plugins";
codoForumAdmin::$action["ploader"]="ploader";
codoForumAdmin::$action["moderation/ban_user"]="moderation/ban_user";
codoForumAdmin::$action["moderation/approve_users"]="moderation/approve_users";
codoForumAdmin::$action["system/importer"]="system/importer";
codoForumAdmin::$action["system/cron"]="system/cron";
codoForumAdmin::$action["system/upgrade"]="system/upgrade";
codoForumAdmin::$action["system/massmail"]="system/massmail";
// nguoianphu sitemap
codoForumAdmin::$action["system/sitemap"]="system/sitemap";
codoForumAdmin::$action["permission/roles"]="permission/roles";
codoForumAdmin::$action["permission/role_edit"]="permission/role_edit";
codoForumAdmin::$action["permission/categories"]="permission/categories";



//start 
codoForumAdmin::run();
