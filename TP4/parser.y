%code top{
    #include <stdio.h>
    #include "scanner.h"
}

%code provides {
    void yyerror(const char *s); 
    extern int nerrlex;
}

%defines "parser.h"
%output "parser.c"
%define api.value.type {char *}
%define parse.error verbose

%token FDT PROGRAMA FIN DECLARAR LEER ESCRIBIR IDENTIFICADOR CONSTANTE
%token ASIGNACION "<-"

%left  '+'  '-'
%left  '*'  '/'
%precedence NEG

%code {
    char *token_names[] = {"FDT", "ASIGNACION", "PROGRAMA", "FIN", "DECLARAR", "LEER", "ESCRIBIR", "IDENTIFICADOR", "CONSTANTE"}
}

%%

inicio:                   PROGRAMA lista-sentencias FIN {if (nerrlex || yynerrs) YYABORT;};

lista-sentencias:         sentencia
                        | sentencia lista-sentencias
                        | %empty
                        ;

sentencia:                DECLARAR IDENTIFICADOR ';'             {printf("declarar %s\n",$2);}
                        | IDENTIFICADOR "<-" expresion ';'       {puts("asignación\n");}
                        | LEER '(' lista-identificadores ')' ';' {puts("leer\n");}
                        | ESCRIBIR '(' lista-expresiones ')' ';' {puts("escribir\n");}
                        | error ';'
                        ;

lista-identificadores:    IDENTIFICADOR ';'
                        | IDENTIFICADOR ',' lista-identificadores
                        ;

lista-expresiones:        expresion ';'
                        | expresion ',' lista-expresiones
                        ;
expresion:                termino
                        | expresion '+' termino                  expresion {puts("suma\n");
                        | expresion '-' termino                  expresion {puts("resta\n");}
                        ;
termino:                  valor
                        | termino '*' valor                       expresion {puts("multiplicación\n");}
                        | termino '/' valor                      expresion {puts("división\n");}
                        ;

valor:                    IDENTIFICADOR
                        | CONSTANTE
                        | '-' expresion                          %prec NEG {puts("inversión\n");}
                        | '(' expresion ')'                      {puts("paréntesis\n");}
                        ;
%%

void yyerror(const char *s){
	printf("línea #%d  %s\n", yylineno, s);
	return;
}