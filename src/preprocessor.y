
%{
#include <stdio.h>
#include <linux/limits.h>
#include "preprocessor.h"
%}

%define parse.error verbose
%locations
%token OTHER
%token COMMENT
%token INC "#include"
%token STRING "sträng"
%token QUOTE

%type <path> INC

%union{
    char path[4096];
    int number;
    float fnum;
}

%%

prog:
  stmts
;

stmts:
        | stmt stmts

stmt:
        INC {
        }
        | OTHER
;

%%

