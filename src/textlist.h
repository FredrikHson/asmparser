#ifndef _TEXTLIST_H_
#define _TEXTLIST_H_

#include <uchar.h>

typedef struct textlist
{
    struct textlist* next;
    struct textlist* prev;
    char *text;
    size_t len;
}textlist;

void textlist_append(textlist **list,const char *text);
void textlist_remove(textlist *list);
void textlist_free(textlist *list);

#endif
