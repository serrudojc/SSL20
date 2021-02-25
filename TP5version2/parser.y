%{
    #include <stdio.h>
    #include <strings.h>
    #include "scanner.h"
    #include "semantic.h"
    #include "symbol.h"
%}

%code provides {
    void yyerror(const char *s);
    void yyerrorsem(const char *s, int codigo);
    extern int nerrlex;
    extern int nerrsem;
    char msg[120]; //para poder armar mensajes a enviar a yyerror
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
    char *token_names[] = {"ASIGNACION", "PROGRAMA", "FIN", "DECLARAR", "LEER", "ESCRIBIR", "IDENTIFICADOR", "CONSTANTE"};
}

%%

inicio:                   {comenzar();} PROGRAMA lista-sentencias FIN {finalizar(); if (nerrlex || yynerrs || nerrsem) YYABORT;}
                        ;

lista-sentencias:         %empty
                        | lista-sentencias sentencia
                        ;                      

sentencia:                DECLARAR IDENTIFICADOR ';'                {if (!procesarIDnuevo($2)) {yyerrorsem($2,1); YYERROR;} }
                        | IDENTIFICADOR "<-" expresion ';'          {if (buscar($1)) asignar($3,$1); else {yyerrorsem($1,2); YYERROR;} }
                        | LEER '(' lista-identificadores ')' ';'
                        | ESCRIBIR '(' lista-expresiones ')' ';'
                        | error ';'
                        ;

lista-identificadores:    IDENTIFICADOR                             {if (buscar($1)) leer($1); else {yyerrorsem($1,2); YYERROR;} }
                        | lista-identificadores ',' IDENTIFICADOR   {if (buscar($3)) leer($3); else {yyerrorsem($3,2); YYERROR;} }
                        ;

lista-expresiones:        expresion                                 {escribir($1);}
                        | lista-expresiones ',' expresion           {escribir($3);}
                        ;

expresion:              '-' expresion       %prec NEG       {$$ = neg($2);}
                        | '(' expresion ')'                 {$$ = $2;}
                        | expresion '+' expresion           {$$ = sum($1,$3);}
                        | expresion '-' expresion           {$$ = rest($1,$3);}
                        | expresion '*' expresion           {$$ = mult($1,$3);}
                        | expresion '/' expresion           {$$ = divi($1,$3);}
                        | IDENTIFICADOR                     {if (buscar($1)) $$ = $1; else {yyerrorsem($1,2); YYERROR;} }
                        | CONSTANTE                         {$$ = $1;}
                        ;

%%

void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}

void yyerrorsem(const char *s, int codigo){
    sprintf(msg,"Error semántico: identificador %s ",s);
    switch (codigo)
	{
	case 1:
		strcat(msg, "ya declarado");
		break;
	case 2:
		strcat(msg, "NO declarado");
		break;
	}
    nerrsem ++;
    yyerror(msg);
    return;
}