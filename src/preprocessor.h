#ifndef __PREPROCESSOR_H__
#define __PREPROCESSOR_H__
#include <stdio.h>
int yylex();
int yyerror(const char *s);

int yylineno;
FILE *yyin;

void handle_include();
void preprocess(char *filename,_Bool sys);

#endif
