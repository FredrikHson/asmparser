#include "textlist.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


void textlist_append(textlist** list, const char* text)
{
    textlist* tnew = malloc(sizeof(textlist));
    tnew->len = strlen(text);
    tnew->text = malloc(tnew->len + 1);
    memcpy(tnew->text, text, tnew->len + 1);
    tnew->prev = 0;
    tnew->next = 0;

    if(*list != 0)
    {
        textlist* cursor = *list;

        while(cursor->next != 0)
        {
            cursor = cursor->next;
        }

        cursor->next = tnew;
        tnew->prev = cursor;
    }
    else
    {
        *list = tnew;
    }
}

void textlist_remove(textlist* list)
{
}

void textlist_free(textlist* list)
{
    textlist* cursor = list;

    while(cursor->prev != 0)
    {
        cursor = cursor->prev;
    }

    while(cursor != 0)
    {
        textlist* freeme = cursor;

        if(freeme->text != 0)
        {
            free(freeme->text);
        }

        cursor = cursor->next;
        free(freeme);
    }
}
