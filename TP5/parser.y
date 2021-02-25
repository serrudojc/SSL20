%{
    #include <stdio.h>
    #include "scanner.h"
    #include "symbol.h"
    #include "semantic.h"

    void mostrarError(char *id, int e);
    extern int errlex; 	/* Contador de Errores Léxicos */
    char *error_inicio[] = {"Error semantico: identificador ", "Error semantico: identificador "};
    char *error_fin[] = {" ya declarado", " NO declarado"};
    int errsem = 0;
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

inicio:                 PROGRAMA {iniciar();}
                        lista-sentencias
                        FIN {detener();
                             if (nerrlex || yynerrs || errsem) YYABORT;}
                        ;

lista-sentencias:         sentencia
                        | sentencia lista-sentencias
                        | %empty
                        ;                      

sentencia:                DECLARAR IDENTIFICADOR ';'                {printf("Reserve %s\n", $2);}
                        | IDENTIFICADOR "<-" expresion ';'          {guardar($3,$1);}
                        | LEER '(' lista-identificadores ')' ';'    
                        | ESCRIBIR '(' lista-expresiones ')' ';'    
                        | error ';'
                        ;

lista-identificadores:    IDENTIFICADOR                             {leer($1);}
                        | IDENTIFICADOR ',' lista-identificadores   {leer($1);}
                        ;

lista-expresiones:        expresion                                 {escribir($1);}
                        | expresion ',' lista-expresiones           {escribir($1);}
                        ;

expresion:              '-' expresion             %prec NEG {$$ = invertir($2);}
                        | '(' expresion ')'                 {$$ = $2;}
                        | expresion '+' expresion           {$$ = sumar($1, $3);}
                        | expresion '-' expresion           {$$ = restar($1, $3);}
                        | expresion '*' expresion           {$$ = multiplicar($1, $3);}
                        | expresion '/' expresion           {$$ = dividir($1, $3);}
                        | IDENTIFICADOR                     {if(!existe($1)){mostrarError($1,1); YYERROR;}else $$ = $1;}
                        | CONSTANTE                         {$$=$1;}
                        ;

%%

void yyerror(const char *s){
	printf("línea #%d  %s\n", yylineno, s);
	return;
}

void mostrarError(char *id, int e){
	char *buffer = malloc(strlen(error_inicio[e])+strlen(error_fin[e]) + strlen(id) + 1);
	sprintf(buffer, "%s%s%s", error_inicio[e], id,error_fin[e]);
	yyerror(buffer);
	errsem++;
	free(buffer);
}

