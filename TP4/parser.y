%{
    #include <stdio.h>
    #include "scanner.h"
%}

%code provides {
    void yyerror(const char *s); 
    extern int nerrlex;
}

%defines "parser.h"
%output "parser.c"
%start inicio
%define api.value.type {char *}
%define parse.error verbose

%token PROGRAMA FIN DECLARAR LEER ESCRIBIR IDENTIFICADOR CONSTANTE
%token ASIGNACION "<-"

%left  '-'  '+'
%left  '*'  '/'
%precedence NEG

%code {
    char *token_names[] = {"ASIGNACION", "PROGRAMA", "FIN", "DECLARAR", "LEER", "ESCRIBIR", "IDENTIFICADOR", "CONSTANTE"}; //hace falta esto?s
}

%%

inicio:                   PROGRAMA lista-sentencias FIN {if (nerrlex || yynerrs) YYABORT;}
                        ;

lista-sentencias: |  sentencia
                        | sentencia lista-sentencias
                        ;                      

sentencia:                DECLARAR IDENTIFICADOR ';'                {printf("declarar %s\n", $2);}
                        | IDENTIFICADOR "<-" expresion ';'          {printf("asignación\n");}
                        | LEER '(' lista-identificadores ')' ';'    {printf("leer\n");}
                        | ESCRIBIR '(' lista-expresiones ')' ';'    {printf("escribir\n");}
                        | error ';'
                        ;

lista-identificadores:    IDENTIFICADOR
                        | IDENTIFICADOR ',' lista-identificadores
                        ;

lista-expresiones:        expresion
                        | expresion ',' lista-expresiones
                        ;

expresion:              '-' expresion                    %prec NEG {printf("inversión\n");}
                        | '(' expresion ')'                 {printf("paréntesis\n");}
                        | expresion '+' expresion           {printf("suma\n");}
                        | expresion '-' expresion           {printf("resta\n");}
                        | expresion '*' expresion           {printf("multiplicación\n");}
                        | expresion '/' expresion           {printf("división\n");}
                        | IDENTIFICADOR
                        | CONSTANTE
                        ;

%%

void yyerror(const char *s){
	printf("línea #%d  %s\n", yylineno, s);
	return;
}