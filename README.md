# Script tester for Pester

> :fire: This is just a prototype.

A prototype of script that manipulates a self-contained `.ps1` to enable testing it. We split the script in three pieces based on the comments and rewrite the script to make it only contain functions. Then we revert it back.

[![https://gyazo.com/5003ee5d2a501e0cbb8223653ec03974](https://i.gyazo.com/5003ee5d2a501e0cbb8223653ec03974.gif)](https://gyazo.com/5003ee5d2a501e0cbb8223653ec03974)

## Sample usage

- To observe what is happening, the easiest way is to star VSCode, open `tester.ps1` and `script.ps1`. 
- Set breakpoints in `tester.ps1` on both `. $path` lines.
- Run the script and see script.ps1 change.
- Observe the output in the console to see the tests pass.
