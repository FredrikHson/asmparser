%{
#include <stdio.h>
#include <string.h>
#include "preprocessor.tab.h"
#include "preprocessor.h"
    int yyindent=0;
void showError();
%}

%option yylineno

cppcomment      (\/\/.*)
include (\#\ *include\ *[<\"].*[>\"])


%x C_COMMENT
%%


"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT>\n   { }
<C_COMMENT>.    { }
{cppcomment}    { }
{include}       { handle_include(); return(INC);}
\n              { yylineno++; printf("\n%*s",yyindent,""); }
.               { printf("%s",yytext); }

%%


void showError(){
    printf("%s",yytext);
}
