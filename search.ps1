# ----------------------------------------------------------
# msdn search for win32 APIs.
# ----------------------------------------------------------

function Search-MSDN
{

    $url = 'http://search.msdn.microsoft.com/?query=';

    $url += $args[0];

    for ($i = 1; $i -lt $args.count; $i++) {
        $url += '+';
        $url += $args[$i];
    }

    $url += '&locale=en-us&ac=3';

    start-process $url
}

function Search-Java
{

    $url = 'http://javadocs.org/';

    $url += $args[0];
	
	start-process $url
}
