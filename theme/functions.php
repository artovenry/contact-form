<?
require __DIR__ . "/vendor/autoload.php";
if(ART_ENV === 'development')add_filter('wpcf7_skip_mail', '__return_true');
