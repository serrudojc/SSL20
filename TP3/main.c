/*
Grupo G02, miércoles noche
Serrudo Juan Carlos
Rosinke Martin
Cruz David
*/

#include "scanner.h"

int TOKEN;
char *token_names[] = {
	"Fin de archivo",	//0
	"Asignacion",		//1
	"Programa",			//2
	"Fin-Prog",			//3
	"Declarar",			//4
	"Leer",				//5
	"Escribir",			//6
	"Identificador",	//7
	"Constante"			//8
};
int main()
{
	do{
		TOKEN = yylex();
		if(TOKEN <= ESCRIBIR)
			printf("Token: %s\n", token_names[TOKEN]);
		else 
			if(TOKEN == IDENTIFICADOR || TOKEN == CONSTANTE)
				printf("Token: %s\tlexema: %s\n", token_names[TOKEN], yytext);
			else
				printf("Token: \'%c\'\n", TOKEN);
	}while(TOKEN != FDT);
	
	return 0;
}