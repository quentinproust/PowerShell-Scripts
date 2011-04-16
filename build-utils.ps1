function growl-ok($module, $message) {
    & "C:/Program Files/Growl for Windows/growlnotify.com" $module /t:$message /i:D:\PoshScript\green.ico
}

function growl-bad($module, $message) {
    & "C:/Program Files/Growl for Windows/growlnotify.com" $module /t:$message /i:D:\PoshScript\red.ico
}

function maven-build($module, $command, $test) {
$command = "$command --offline"
    if($test -eq $False) {
        $command = "$command -Dmaven.test.skip=true"
    }

    echo $command
    cmd /c $command | Tee-Object /dev/null

    $build = cat /dev/null | grep "BUILD SUCCES"
    if($build -ne $null) {
       growl-ok $module "Build Success" 
    } else {
       cat /dev/null
       growl-bad $module "The build has failed"
       throw "Maven build has failed"
    }
}
