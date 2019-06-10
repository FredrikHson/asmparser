
%{
#include <stdio.h>

int yylex();
int yyerror(const char *s);
int yylineno;

%}

%define parse.error verbose
%locations
%token STRING OTHER COMMENT

%type <name> STRING

%union{
    char name[512];
    int number;
    float fnum;
}

%%

prog:
  stmts
;

stmts:
        | stmt
        | stmt stmts

stmt:
        STRING {
                printf("Your entered a string - %s\n", $1);
        }
        | OTHER
;

%%

int yyerror(const char *s)
{
    printf("\nSyntax Error on line %d %s\n",yylineno, s);
    return 0;
}

int main()
{
    yyparse();
    return 0;
}
