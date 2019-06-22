#include <string.h>
#include <stdio.h>
#include "preprocessor.h"
#include "preprocessor.tab.h"
#include <getopt.h>
#include <linux/limits.h>
#include <unistd.h>
#include "textlist.h"
#include <stdlib.h>
#include <libgen.h>

extern char* yytext;

int yyerror(const char* s)
{
    printf("\nSyntax Error on line %d %s\n", yylineno, s);
    return 0;
}

textlist* sysincludes = 0;
textlist* includes = 0;
char inputfile[PATH_MAX] = {0};

int main(int argc, char* argv[])
{
    static const struct option longOpts[] =
    {

        { "i", required_argument, 0, 'i' },
        { "isystem", required_argument, 0, 'I' },
    };
    int c;
    int longIndex = 0;

    while((c = getopt_long(argc, argv, "i:I:", longOpts, &longIndex)) != -1)
    {
        switch(c)
        {
            case 'i':
                textlist_append(&includes, optarg);
                break;

            case 'I':
                textlist_append(&sysincludes, optarg);
                break;

            default:
                break;
        }
    }

    textlist_append(&sysincludes, "/usr/include");

    if(argc - optind > 0)
    {
        sprintf(inputfile, "%s", argv[optind]);
        char filepath[PATH_MAX] = {0};
        sprintf(filepath, "%s", argv[optind]);
        textlist_append(&includes, dirname(filepath));
        yyin = fopen(inputfile, "r");
        yyparse();
    }

    if(sysincludes)
    {
        textlist_free(sysincludes);
    }

    if(includes)
    {
        textlist_free(includes);
    }

    return 0;
}

void handle_include() /* just gets the filename */
{
    char* text = yytext ;
    size_t len = strlen(text);
    _Bool beginfilename = 0;
    size_t pos = 0;
    char filename[PATH_MAX] = {0};
    _Bool sys = 0;

    for(int i = 0; i < len; i++)
    {
        if(beginfilename == 0)
        {
            if(yytext[i] == '<' || yytext[i] == '"')
            {
                beginfilename = 1;

                if(yytext[i] == '<')
                {
                    sys = 1;
                }
            }
        }
        else
        {
            if(yytext[i] == '>' || yytext[i] == '"')
            {
                break;
            }

            filename[pos] = yytext[i];
            pos++;
        }
    }

    preprocess(filename, sys);
}

void preprocess(char* filename, _Bool sys)
{
    if(sysincludes == 0)
    {
        sys = 0;
    }

    printf("#line %i \"%s\"\n", 0, filename);

    if(sys)
    {
        char fullpath[PATH_MAX] = {0};
        textlist* cursor = sysincludes;
        _Bool found = 0;

        while(cursor != 0)
        {
            snprintf(fullpath, PATH_MAX, "%s/%s", cursor->text, filename);

            if(access(fullpath, R_OK) == 0)
            {
                found = 1;
                break;
            }

            cursor = cursor->next;
        }

        if(found)
        {
            char command[PATH_MAX] = {0};
            sprintf(command, "cat %s", fullpath);
            system(command);
        }
    }
    else
    {
        char fullpath[PATH_MAX] = {0};
        textlist* cursor = includes;
        _Bool found = 0;

        while(cursor != 0)
        {
            snprintf(fullpath, PATH_MAX, "%s/%s", cursor->text, filename);

            if(access(fullpath, R_OK) == 0)
            {
                found = 1;
                break;
            }

            cursor = cursor->next;
        }

        if(found)
        {
            char command[PATH_MAX] = {0};
            sprintf(command, "cat %s", fullpath);
            system(command);
        }
        else
        {
            fprintf(stderr, "Error %i: could not find %s\n", yylineno, filename);
            exit(1);
        }
    }

    printf("#line %i \"%s\"\n", yylineno, inputfile);
}
