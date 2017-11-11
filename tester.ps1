# we have file script that we want to keep in one piece,
# but test it end-to-end
$path = '.\script.ps1'
$file = gi $path

# backup the file so we can manipulate it
$originalPath = $file.FullName
$newPath = (Join-Path ($file.Directory) ($file.BaseName + "_" + $file.Extension))

copy $originalPath $newPath

$c = Get-Content $originalPath -Encoding UTF8

# split it to three pieces on the markers
$functionsTopMarker = '# --- functions start'
$functionsBottomMarker = '# --- functions end'

$top = $c.IndexOf($functionsTopMarker)
$bottom = $c.IndexOf($functionsBottomMarker)

$param = $c[0..($top - 1)]
$functions = $c[($top + 1)..($bottom - 1)]
$main = $c[($bottom + 1)..($c.Length)]


# first we want to unit test the functions
# so put only the functions in the file
$functions | Set-Content $originalPath -Encoding UTF8

# include it like you normally would on top of Pester test
. $path

Describe 'hello' {
    It 'outputs the greeting using the given name' {
        hello 'jakub' | should -be 'hello jakub'
    }
}

# then let's test the main part
# to do that we form main function by combining
# the param and the main then adding all the other functions
# we could easily do that during the unit testing, but this is 
# simpler

$f = 'function main {', $param, $main, '}', $functions
$f | Set-Content $originalPath -Encoding UTF8

# include it all again
. $path
Describe 'hello' {
    It 'outputs the greeting using the given name' {
        # invoke our placeholder main function that takes the same 
        # params as our original script
        main 'jakub' | should -be 'hello > jakub <'
    }
}

# revert
del $originalPath
move $newPath $originalPath