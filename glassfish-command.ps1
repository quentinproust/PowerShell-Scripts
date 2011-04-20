#----------------------------------------------------------------------------
#   Commands to control glassfish.
#   Argument:
#       -start : will obviously start glassfish.
#       -stop  : will stop glassfish.
#       -restart : do I really need to tell you what it does ?
#       -tail : tail the server.log file for domain1.
#----------------------------------------------------------------------------

$glassfishProperties = @{
    "installFolder" = "D:/work/tools/glassfish";
    "okIcon" = "d:/Poshscript/glassfish.gif";
    "failIcon" = "d:/Poshscript/red.ico"
};

function gf () {
    # Configuration for path to glassfish
    # Bin folder path to execute command on glassfish
    $bin = $glassfishProperties.Get_Item("installFolder") + "/bin/"
    # Log folder to tail
    $log = $glassfishProperties.Get_Item("installFolder") + "/domains/domain1/logs/"

    # A usefull function to execut the bat file from powershell. 
    function execBat([string] $bat) {
        $file = [String]::concat($bin, $bat)
        cmd /c $file
    }

    function growl-state($isOk, $message) {
        $icon = ""
        if($isOk -eq $True) {
            $icon = $glassfishProperties.Get_Item("okIcon") 
        } else {
            $icon = $glassfishProperties.Get_Item("failIcon") 
        }
        growl Glassfish /t:$message /i:$icon
    }

    if($args[0].equals("start")) {
        Write "Starting glassfish server"
        execBat "asadmin.bat start-domain domain1"
        growl-state $True "Glassfish was started"

    } elseif($args[0].equals("stop")) {
        Write "Stopping glassfish server"
        execBat "asadmin.bat stop-domain domain1"
        growl-state $True "Glassfish was stopped"

    } elseif($args[0].equals("restart")) {
        Write "Restarting glassfish server"
        Write "Stopping glassfish server"
        execBat "asadmin.bat stop-domain domain1"
        Write "Starting glassfish server"
        execBat "asadmin.bat start-domain domain1"
        growl-state $True "Glassfish was restarted"

    } elseif($args[0].equals("tail")) {
        $logFile = $log + "server.log"
        Write $logFile
        d:/tools/cygwin/bin/tailf.exe $logFile 
    }
}
