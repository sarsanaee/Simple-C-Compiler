%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include "mytable.h"
    #include <string.h>

    
    
    int yyerror(char *);
    int yylex(void);
    int yylineno;
    extern FILE * yyin;
//    extern FILE * yyout;
    extern FILE *fopen(const char *filename, const char *mode);
    
    //int sym[26];
    //extern fopen(char * , char);

    char* target, source;
    static int tempnum;
 //   char* tempvar  ;
    
    char * newtemp();
    
    int istemp(char* c);
    
    void removetemp();
    void emitln(char *s);
    void emit(char *s);
    static int label = 0;
    
    char* openlabel();
    char* closelabelmin();
    char * closelabel();
    
    char * stack [100]; 
    static int top = 0;
    char * stack_pop();
    char * stack_get_top_element() ;
    void stack_push(char * c);
    static int stack_get_top();
    
    


//static int i;
//int d;
//char temp();

    

    
  /////////////// TABDILE HAMECHI BE CHARECTOR  
    


%}




%token	PAR_OPEN  PAR_CLOSE COMMA SEMICOLON  WHILE RETURN  
%token	IF ELSE CB_OPEN CB_CLOSE PLUS MINUS ASTERISK SLASH ASSIGNMENT
%token	OR AND NOT LESS LESS_EQUAL MORE_EQUAL MORE EQUAL NOT_EQUAL QUOT


%union { char * intval;
        char  charval;
        struct symtab *symp;
        //struct exval *test;
        }
        
        
        

%token <intval> NUMBER
%token <charval> LITERAL_C
%token <symp> ID
%token <intval> CHAR
%token <intval> INT



%type <intval> expression
%type <charval> char_expression   
%type <intval> conditions   
%type <intval> types
       



%left PLUS MINUS
%left ASTERISK SLASH

 
 
 
 
 
 


%%



program
    :program funcdef 
    | funcdef
    |
    ;

funcdef
    : types ID args block_statement
    ;

args
    :  PAR_OPEN var_def_list PAR_CLOSE
    ;
    
var_def_list
    :var_def COMMA var_def
    |var_def 
    |
    ;

    
var_def
    :   types ID
    ;

types
    : INT
    | CHAR
    ;

block_statement
    :   CB_OPEN statements CB_CLOSE
    ;

statements
    : statements statement 
    | statement 
    |
    ;

statement
    : block_statement
    | conditional_statement
    | while_st
    | assignment_statement SEMICOLON
    | ret_statement SEMICOLON
    ;
    
conditional_statement
    
    : IF PAR_OPEN conditions {removetemp(tempnum);} PAR_CLOSE {char *  myelse = openlabel(); stack_push(myelse);  printf("if not %s goto %s ; \n", $3, myelse );} block_statement {/*char *  myelse = closelabel();*/char* myelse = stack_pop();char* endif = openlabel();stack_push(endif);printf("goto %s ; \n%s : \n",stack_get_top_element(), myelse);} elsest {/*char* endelse = closelabel()*/;printf("%s : \n", stack_pop());} 
     ;

elsest
    : ELSE block_statement
    |
    ;
    
while_st 
    : WHILE PAR_OPEN conditions {removetemp(tempnum);} PAR_CLOSE {char * startwhile = openlabel(); char * endwhile = openlabel();stack_push(endwhile); stack_push(startwhile) ;printf("%s :\nif not %s goto %s ; \n",startwhile , $3, endwhile);} block_statement {/*char* a =closelabel()*/char * startwhile = stack_pop(); printf("goto %s ;\n%s :\n",startwhile ,stack_pop());} 
    ;
    
/*conditions 
    : conditions LESS expression { printf("%s = %s < %s;\n",$$ = newtemp() , $1, $3);  }
    | conditions LESS_EQUAL expression { printf("%s = %s <= %s;\n",$$ = newtemp(), $1, $3); }
    | conditions MORE_EQUAL expression { printf("%s = %s > %s;\n",$$ = newtemp(), $1, $3); }
    | conditions MORE expression { printf("%s = %s >= %s;\n",$$ = newtemp(), $1, $3); }
    | conditions NOT_EQUAL expression { printf("%s = %s != %s;\n",$$ = newtemp(), $1, $3); }
    | conditions EQUAL expression { printf("%s = %s == %s;\n",$$ = newtemp(), $1, $3); }
    | expression   { printf("%s = %s;\n",$$ = newtemp(), $1); removetemp();}
    ;

*/


/*conditions 
    : conditions LESS expression { printf("%s = %s < %s;\n",$$ = newtemp() , $1, $3);  }
    | conditions LESS_EQUAL expression { printf("%s = %s <= %s;\n",$$ = newtemp(), $1, $3); }
    | conditions MORE_EQUAL expression { printf("%s = %s > %s;\n",$$ = newtemp(), $1, $3); }
    | conditions MORE expression { printf("%s = %s >= %s;\n",$$ = newtemp(), $1, $3); }
    | conditions NOT_EQUAL expression { printf("%s = %s != %s;\n",$$ = newtemp(), $1, $3); }
    | conditions EQUAL expression { printf("%s = %s == %s;\n",$$ = newtemp(), $1, $3); }
    | expression   { printf("%s = %s;\n",$$ = newtemp(), $1); }
    ;
*/


conditions 
    : conditions LESS expression { if(istemp($1)){
                                        if(istemp($3)){removetemp(1);}
                                        printf("%s = %s < %s ;\n", $$ =  $1 ,$1 , $3 ) ;   
                                   }
                                   else if(istemp($3)){
                                        if(istemp($1)){removetemp(1);}
                                        printf("%s = %s < %s ;\n", $$ =  $3 ,$1 , $3 ) ;
                                   }
                                   else{
                                        printf("%s = %s < %s ;\n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s < %s;\n",$$ = newtemp() , $1, $3);  }
    | conditions LESS_EQUAL expression { if(istemp($1)){
                                            if(istemp($3)){removetemp(1);}
                                            printf("%s = %s <= %s ;\n", $$ =  $1 ,$1 , $3 ) ;  
                                     
                                   }
                                   else if(istemp($3)){
                                            if(istemp($1)){removetemp(1);}
                                            printf("%s = %s <= %s ;\n", $$ =  $3 ,$1 , $3 ) ;
                                   }
                                   else{
                                     printf("%s = %s <= %s ;\n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s <= %s;\n",$$ = newtemp(), $1, $3); }
    | conditions MORE_EQUAL expression { if(istemp($1)){
                                            if(istemp($3)){removetemp(1);}
                                            printf("%s = %s >= %s ;\n", $$ =  $1 ,$1 , $3 ) ;   
                                   }
                                   else if(istemp($3)){
                                            if(istemp($1)){removetemp(1);}
                                     printf("%s = %s >= %s ;\n", $$ =  $3 ,$1 , $3 ) ;
                                   }
                                   else{
                                     printf("%s = %s >= %s ;\n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s > %s;\n",$$ = newtemp(), $1, $3); }
    | conditions MORE expression { if(istemp($1)){
                                            if(istemp($3)){removetemp(1);}
                                     printf("%s = %s > %s ;\n", $$ =  $1 ,$1 , $3 ) ;   
                                   }
                                   else if(istemp($3)){
                                            if(istemp($1)){removetemp(1);}                                   
                                     printf("%s = %s > %s ;\n", $$ =  $3 ,$1 , $3 ) ;
                                   }
                                   else{
                                     printf("%s = %s > %s ;\n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s >= %s;\n",$$ = newtemp(), $1, $3); }
    | conditions NOT_EQUAL expression { if(istemp($1)){
                                            if(istemp($3)){removetemp(1);}
                                     printf("%s = %s != %s ;\n", $$ =  $1 ,$1 , $3 ) ;   
                                   }
                                   else if(istemp($3)){
                                            if(istemp($1)){removetemp(1);}
                                     printf("%s = %s != %s ;\n", $$ =  $3 ,$1 , $3 ) ;
                                   }
                                   else{
                                     printf("%s = %s != %s ;\n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s != %s;\n",$$ = newtemp(), $1, $3); }
    | conditions EQUAL expression { if(istemp($1)){
                                            if(istemp($3)){removetemp(1);}
                                    printf("%s = %s == %s ;\n", $$ =  $1 ,$1 , $3 ) ;   
                                   }
                                   else if(istemp($3)){
                                            if(istemp($1)){removetemp(1);}
                                     printf("%s = %s == %s ;\n", $$ =  $3 ,$1 , $3 ) ;
                                   }
                                   else{
                                     printf("%s = %s == %s ;\n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s == %s;\n",$$ = newtemp(), $1, $3); }
    | expression   { if(istemp($1)){
                        printf("%s = %s ;\n",$$ = $1, $1);                    
                     } 
                     else{
                        printf("%s = %s ;\n",$$ = newtemp(), $1);
                     }
                    }//printf("%s = %s;\n",$$ = newtemp(), $1); }
    ;

    
assignment_statement
    : types ID ASSIGNMENT expression {if (!strcmp($1, "int")){printf("%s = %s ;\n", $2 -> name, $4 ); $2 -> type = "int";} else{yyerror("type missmatch ; int assignment to char ; expected 'int' ");} removetemp(tempnum);  }
    | ID ASSIGNMENT expression { if( !strcmp($1 -> type, "int")){printf("%s = %s ;\n", $1 -> name, $3 );}else{yyerror("type miss match ");} removetemp(tempnum); }
    | types ID ASSIGNMENT char_expression {if (!strcmp($1, "char")){printf("%s = %s ;\n", $2 -> name, $4 );$2 -> type = "char";} else{yyerror("type missmatch ; char assignment to int expected 'char' ");} removetemp(tempnum);  }  
    | ID ASSIGNMENT char_expression 
    | types ID ASSIGNMENT {  }
    | error ; 
    ;
    
ret_statement
    : RETURN expression {  } 
    ;
    
/*expression
    : NUMBER { $$ = $1; }
    | ID { $$ = $1 -> name ;}
    | expression PLUS expression { printf("%s = %s + %s ; \n", $$ = newtemp() ,$1 , $3 ) ; }
    | expression MINUS expression { printf("%s = %s - %s ; \n",$$ =newtemp() , $1 , $3 ) ;  }
    | expression ASTERISK expression { printf("%s = %s * %s ; \n", $$ = newtemp() ,$1, $3 ); }
    | expression SLASH expression { printf("%s = %s / %s ; \n",$$ = newtemp() , $1, $3 ); }
    | PAR_OPEN expression PAR_CLOSE { printf("%s = ( %s ) ; \n",$$ = newtemp() , $2 ); }
    ;
*/

expression
    : NUMBER { $$ = $1; }
    | ID { $$ = $1 -> name ;}
    | expression PLUS expression { if(istemp($1)){
                                     if(istemp($3)){removetemp(1);}
                                     printf("%s = %s + %s ; \n", $$ =  $1 ,$1 , $3 ) ;   
                                     
                                   }
                                   else if(istemp($3)){
                                     if(istemp($1)){removetemp(1);}
                                     printf("%s = %s + %s ; \n", $$ =  $3 ,$1 , $3 ) ;
                                     
                                   }
                                   else{
                                     printf("%s = %s + %s ; \n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } 
                                  }//printf("%s = %s + %s ; \n", $$ =  newtemp() ,$1 , $3 ) ; }
    | expression MINUS expression { if(istemp($1)){
                                     if(istemp($3)){removetemp(1);}
                                     printf("%s = %s - %s ; \n", $$ =  $1 ,$1 , $3 ) ;   
                                   }
                                   else if(istemp($3)){
                                     if(istemp($1)){removetemp(1);}
                                     printf("%s = %s - %s ; \n", $$ =  $3 ,$1 , $3 ) ;
                                     
                                   }
                                   else{
                                     printf("%s = %s - %s ; \n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s - %s ; \n",$$ = newtemp() , $1 , $3 ) ;  }
    | expression ASTERISK expression { if(istemp($1)){
                                     if(istemp($3)){removetemp(1);}
                                     printf("%s = %s * %s ; \n", $$ =  $1 ,$1 , $3 ) ;   
                                    
                                   }
                                   else if(istemp($3)){
                                     if(istemp($1)){removetemp(1);}
                                     printf("%s = %s * %s ; \n", $$ =  $3 ,$1 , $3 ) ;
                                     
                                   }
                                   else{
                                     printf("%s = %s * %s ; \n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s * %s ; \n", $$ = newtemp() ,$1, $3 ); }
    | expression SLASH expression { if(istemp($1)){
                                     if(istemp($3)){removetemp(1);}
                                     printf("%s = %s / %s ; \n", $$ =  $1 ,$1 , $3 ) ;   
                                     
                                   }
                                   else if(istemp($3)){
                                     if(istemp($1)){removetemp(1);}
                                     printf("%s = %s / %s ; \n", $$ =  $3 ,$1 , $3 ) ;
                                     
                                   }
                                   else{
                                     printf("%s = %s / %s ; \n", $$ =  newtemp() ,$1 , $3 ) ;
                                   } }//printf("%s = %s / %s ; \n",$$ = newtemp() , $1, $3 ); }
    | PAR_OPEN expression PAR_CLOSE { if(istemp($2)){
                                        printf("%s = ( %s ) ; \n",$$ = $2  , $2 ); 
                                        }
                                      else{
                                        printf("%s = ( %s ) ; \n",$$ = newtemp()  , $2 );
                                      }
                                    }
    ;
      


/*expression
    : NUMBER {$$ -> value = $1}//;$$ -> istemp = 0 ; }
    | ID { $$ -> value = $1 -> name ;}
    | expression PLUS expression { if ($1->istemp){
    
                                    printf("hey in $1");
    
                                    }
                                    else if($3->istemp){
                                        printf("hey in $3");
                                    }
                                    else{
                                        printf("%s = %s + %s  ; \n", $$ -> value = strdup(newtemp()); ,$1 -> value, $3 -> value );
                                    }
    
    
                                  }
    | expression MINUS expression { printf("%s = %s - %s ; \n",$$ = newtemp() , $1 -> value, $3-> value ); }
    | expression ASTERISK expression { printf("%s = %s * %s ; \n",$$ = newtemp() ,$1-> value, $3-> value ); }
    | expression SLASH expression { printf("%s = %s / %s ; \n",$$ = newtemp() , $1-> value, $3-> value ); }
    | PAR_OPEN expression PAR_CLOSE { printf("%s = ( %s ) ; \n",$$ = newtemp() , $2-> value ); }
    ;
  
*/

char_expression
    : QUOT LITERAL_C QUOT { }
    ;
    

%%

struct symtab * symlook(s)
char *s;
{
    char *p;
    struct symtab *sp;
    for(sp = symtab ; sp < &symtab[NSYMS] ; sp++){
        if (sp -> name && ! strcmp(sp->name, s)){
            return sp;
        }
        if (!sp -> name){
            sp->name = strdup(s);
            return sp;
            
        }
    
    }
    yyerror("too many symbols ");
    exit(1);
} 

char * openlabel (){
    label = label + 1;
    //string temp = (char)tempnum + '0' ;
    //tempvar = "T"; 
    //string a = "alireza"
    
    char integer_string[4] = "";
    
    sprintf(integer_string, "%d", label);
    char * temp ;
    temp = strdup("L");
    return  strcat(temp, integer_string); 

}

char * closelabelmin() {
    
    //string temp = (char)tempnum + '0' ;
    //tempvar = "T"; 
    //string a = "alireza"
    label = label -1 ;
    char integer_string[4] = "";
    
    sprintf(integer_string, "%d", label);
    char * temp ;
    temp = strdup("L");
    return  strcat(temp, integer_string); 
    



}

char * closelabel() {
    
    //string temp = (char)tempnum + '0' ;
    //tempvar = "T"; 
    //string a = "alireza"
    
    char integer_string[4] = "";
    
    sprintf(integer_string, "%d", label);
    char * temp ;
    temp = strdup("L");
    return  strcat(temp, integer_string); 
    



}

void removetemp(int n){
    tempnum = tempnum - n;
}


void emitln(char *s){
    printf("%s\n", s );
}

void emit(char *s){
    printf("%s", s );
}

char * newtemp(){
    tempnum = tempnum + 1;
    //string temp = (char)tempnum + '0' ;
    //tempvar = "T"; 
    //string a = "alireza"
    
    char integer_string[4] = "";
    
    sprintf(integer_string, "%d", tempnum);
    char * temp ;
    temp = strdup("T");
    return  strcat(temp, integer_string); 

}

int istemp(char *s){
 
    char *temp = "T";
    if(s[0] == temp[0]){
        return 1;
    }
    
    else{
        return 0;
    }
    
}

void stack_push(char * c){
    stack[top++] = c;
}

char * stack_pop(){
    return stack[--top];
    
}

static int stack_get_top(){
    return top;

}

char * stack_get_top_element(){
    return stack[top - 1];

}





int yyerror(char *s){
    
    fprintf(stderr , "%s line %i \n", s, yylineno);
    exit(0);

}


int main(int argc ,char *argv[]){
    //printf("please write your expression : -> \n \n");
    
    yyin = fopen(argv[1], "r");
    
    yyparse();
    
    fclose(yyin);
    return 0;
}

    
    
    

