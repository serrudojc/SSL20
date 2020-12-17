%top{
	#include <stdio.h>
	#include "tokens.h"
}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput

L				[[:alpha:]]
D				[0-9]
LD				[[:alnum:]]
S				[[:space:]]
Asignacion		<-
Comentario		"##".*
O				[[:punct:]]{-}[\(\).,+\-*/\;]

%%
programa			return PROGRAMA;
fin-prog			return FIN;
declarar			return DECLARAR;
leer				return LEER;
escribir 			return ESCRIBIR;
{L}{LD}*			return IDENTIFICADOR;
{D}+				return CONSTANTE;
"("					return '(';	
")"					return ')';
"."					return '.';
","					return ',';
"+"					return '+';
"-"					return '-';
"*"					return '*';
"/"					return '/';
";"					return ';';
{Asignacion}				return ASIGNACION;
{O}+						printf("Error léxico: cadena desconocida: %s\n",yytext);
{L}{LD}*{O}+({LD}|{O})*		printf("Error léxico: identificador inválido: %s\n",yytext);
{D}+{L}+{LD}*				printf("Error léxico: constante inválida: %s\n",yytext);
{S}+						|
{Comentario}				;
%%