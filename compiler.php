<?php
/**
 * Created by PhpStorm.
 * User: robert
 * Date: 3/9/14
 * Time: 1:09 AM
 */

require_once "vendor/autoload.php";

echo "Compiling coffeescript\n";

/**
 * Parses a directory for files, recursively
 * @param $path string The folder to start processing
 */
function parseDir ($path) {
    foreach (glob($path) as $filename) {
        if (strpos($filename, ".coffee"))
        {
            parseFile($filename);
        }
        else if (strpos($filename, ".css")) {
            parseFile($filename);
        }
        else if (strpos($filename, ".") == "") {
            parseDir($filename . "/*");
        }
    }
}

/**
 * Compiles, and minifies a file
 * @param $file string The filename to process
 */
function parseFile ($file) {
    echo "Compiling $file\n";

    $contents = file_get_contents($file);
    $extension = "";

    if (strpos($file, ".coffee")) {
        $ar = compile_coffee($contents, true, $file);
        $contents = $ar["contents"];
        $file = $ar["file"];
        $extension = ".js";
    }

    if (strpos($file, ".js") || $extension == ".js") {
        $ar = minify_js($contents, true, $file);
        $contents = $ar["contents"];
        $file = $ar["file"];
        $extension = ".min.js";
    }

    if (strpos($file, ".css")) {
        $ar = minify_css($contents, true, $file);
        $contents = $ar["contents"];
        $file = $ar["file"];
        $extension = ".min.css";
    }
}

function minify_css ($css, $do_output, $file) {
    $min = CssMin::minify($css);
    $min_file = str_replace(".css", ".min.css", $file);

    return place_file($min_file, $min, $do_output, $file);
}

function minify_js ($js, $do_output, $file) {
    $min = JSMinPlus::minify($js);
    $min_file = str_replace(".js", ".min.js", $file);

    return place_file($min_file, $min, $do_output, $file);
}

/**
 * Places a file on the filesystem if do_output, and displays it.
 * @param $file string the file to write
 * @param $content string the content to write
 * @param $do_output bool actually write the file?
 * @param $old_file string the old file
 * @return array and array of the new config
 */
function place_file($file, $content, $do_output, $old_file) {
    if ($do_output) {
        file_put_contents($file, $content);

        echo "Compiled $old_file to $file\n";
    }
    else {
        echo "Compiled $old_file\n";
    }

    return array("contents" => $content, "file" => $file);
}

/**
 * Compiles a coffeescript file to javascript and returns the result
 * @param $coffee string Contents of a coffee script file
 * @param $do_output bool Output the result of the compile?
 * @return array The content of a javascript file and the new filename
 */
function compile_coffee ($coffee, $do_output, $file) {
    $js = CoffeeScript\Compiler::compile ($coffee, array("filename" => $file, "header" => false));
    $js_file = str_replace(".coffee", ".js", $file);

    return place_file($js_file, $js, $do_output, $file);
}

parseDir("src/*");