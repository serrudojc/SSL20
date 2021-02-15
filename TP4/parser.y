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
    char *token_names[] = {"ASIGNACION", "PROGRAMA", "FIN", "DECLARAR", "LEER", "ESCRIBIR", "IDENTIFICADOR", "CONSTANTE"} //hace falta esto?s
}

%%

inicio:                   PROGRAMA lista-sentencias FIN {if (nerrlex || yynerrs) YYABORT;}
                        ;

lista-sentencias:         sentencia
                        | sentencia lista-sentencias
                        ;                      

sentencia:                DECLARAR IDENTIFICADOR ';'                {printf("declarar %s\n", $2);}
                        | IDENTIFICADOR "<-" expresion ';'          {printf("asignación\n");}
                        | LEER '(' lista-identificadores ')' ';'    {printf("leer\n");}
                        | ESCRIBIR '(' lista-expresiones ')' ';'    {printf("escribir\n");}
                        | error ';'
                        ;

lista-identificadores:    IDENTIFICADOR ';'
                        | IDENTIFICADOR ',' lista-identificadores
                        ;

lista-expresiones:        expresion ';'
                        | expresion ',' lista-expresiones
                        ;

expresion:                termino
                        | expresion '+' termino                  {printf("suma\n");}
                        | expresion '-' termino                  {printf("resta\n");}
                        ;

termino:                  valor
                        | termino '*' valor                      {printf("multiplicación\n");}
                        | termino '/' valor                      {printf("división\n");}
                        ;

valor:                    IDENTIFICADOR
                        | CONSTANTE
                        | '-' valor                    %prec NEG {printf("inversión\n");}
                        | '(' expresion ')'                      {printf("paréntesis\n");}
                        ;
%%

void yyerror(const char *s){
	printf("línea #%d  %s\n", yylineno, s);
	return;
}