# Adding some function for glassfish server
function gf () {
#GlassFish directory
    $bin = "D:\Work\Tools\glassfish\bin\"
    $log = "D:\Work\Tools\glassfish\domains\domain1\logs\"

    function execBat([string] $bat) {
        $file = [String]::concat($bin, $bat)
        cmd /c $file
    }

    if($args[0].equals("start")) {
        Write "Starting glassfish server"
        execBat "asadmin.bat start-domain domain1"
        
        Send-Growl-Easy Glassfish Start "Glassfish state changed" "Glassfish has been succesfully started"
    } elseif($args[0].equals("stop")) {
        Write "Stopping glassfish server"
        execBat "asadmin.bat stop-domain domain1"
    Send-Growl-Easy Glassfish Start "Glassfish state changed" "Glassfish has been succesfully stop"

    } elseif($args[0].equals("restart")) {
        Write "Restarting glassfish server"
        Write "Stopping glassfish server"
        execBat "asadmin.bat stop-domain domain1"
        Write "Starting glassfish server"
        execBat "asadmin.bat start-domain domain1"

    Send-Growl-Easy Glassfish Start "Glassfish state changed" "Glassfish has been succesfully restarted"

    } elseif($args[0].equals("tail")) {
        $logFile = [String]::concat($log, "server.log")
        Write $logFile
        d:/tools/cygwin/bin/tailf.exe $logFile 
    }
}
