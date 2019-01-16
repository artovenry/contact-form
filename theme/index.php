<?
function render($path, $args=[]){
  if(!preg_match("/^\//", $path))
    $path= __DIR__ . "/views/" .$path;
  if(!file_exists($path))
    if(ART_ENV === "development") throw new Exception("template not found: {$path}");
    else return false;

  Pug\Facade::displayFile($path, $args,["expressionLanguage"=>"php"]);
}

render("contact.pug");
