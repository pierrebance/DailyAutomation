<?php
$pckgs = array();
if ($handle = opendir('./')) {
    while (false !== ($file = readdir($handle))) {
		if(strpos($file, ".zip")){
			array_push($pckgs, $file);
		}
    }

    closedir($handle);
}
sort($pckgs, SORT_STRING | SORT_FLAG_CASE);
echo "packages=" . implode('|', $pckgs);;
?>
