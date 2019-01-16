<?
require __DIR__ . "/vendor/autoload.php";
add_filter( 'wpcf7_load_js', '__return_false' );
add_filter( 'wpcf7_load_css', '__return_false' );
