function growl-ok($module, $message) {
    & "C:/Program Files/Growl for Windows/growlnotify.com" $module /t:$message /i:D:\PoshScript\green.ico
}

function growl-bad($module, $message) {
    & "C:/Program Files/Growl for Windows/growlnotify.com" $module /t:$message /i:D:\PoshScript\red.ico
}

function maven-build($module, $command) {
    cmd /c $command > /dev/null

    $build = cat /dev/null | grep "BUILD ERROR"
    if($build -eq $null) {
       growl-ok $module "Build Success" 
    } else {
       cat /dev/null
       growl-bad $module "The build has failed"
       throw "Maven build has failed"
    }
}
