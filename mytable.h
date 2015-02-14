#define NSYMS 100

struct symtab {
    char *name;
    int value;
    char *type;
} symtab[NSYMS];

/*   struct exval {
    int istemp;
    char* tempval; 
    char * value;
} test[1];
*/

struct symtab *symlook();


