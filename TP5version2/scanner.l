%{
	#include <stdio.h>
	#include <strings.h>
	#include "parser.h"
	char msg[120]; //para poder armar mensajes a enviar a yyerror
%}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput
%option yylineno

L				[[:alpha:]]
D				[0-9]
LD				[[:alnum:]]
S				[[:space:]]
Asignacion		<-
Comentario		"##".*
O				[[:punct:]]{-}[\(\),+\-*/\;]

%%

programa					{return PROGRAMA;}
fin-prog					{return FIN;}
declarar					{return DECLARAR;}
leer						{return LEER;}
escribir 					{return ESCRIBIR;}
{L}{LD}*					{yylval = strdup(yytext); return IDENTIFICADOR;}
{D}+						{yylval = strdup(yytext); return CONSTANTE;}
"("							{return '(';}
")"							{return ')';}
"."							{return '.';}
","							{return ',';}
"+"							{return '+';}
"-"							{return '-';}
"*"							{return '*';}
"/"							{return '/';}
";"							{return ';';}
{Asignacion}				{return ASIGNACION;}
{O}+						{nerrlex++; sprintf(msg,"Error léxico: cadena desconocida: %s",yytext); yyerror(msg);}
{L}{LD}*{O}+({LD}|{O})*		{nerrlex++; sprintf(msg,"Error léxico: identificador inválido: %s",yytext); yyerror(msg);}
{D}+{L}+{LD}*				{nerrlex++; sprintf(msg,"Error léxico: constante inválida: %s",yytext); yyerror(msg);}
{S}+						|
{Comentario}				;

%%