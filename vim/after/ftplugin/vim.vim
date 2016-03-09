" formatoptions needs to be set here

set formatoptions+=jn
set formatoptions-=ro
au BufReadPost * set formatoptions+=jn
au BufReadPost * set formatoptions-=ro
