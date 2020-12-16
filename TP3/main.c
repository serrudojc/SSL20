/*

*/

#include "scanner.h"

int TOKEN;
char *token_names[] = {
	"Fin de archivo"
	,"Asignacion"
	,"Programa"
	,"Fin-Prog"
	,"Declarar"
	,"Leer"
	,"Escribir"
	,"Identificador"
	,"Constante"
};
int main()
{
	do{
		TOKEN = yylex();
		if(TOKEN<=ESCRIBIR){
			printf("Token: %s\n", token_names[TOKEN]);
		}else if(TOKEN == IDENTIFICADOR || TOKEN == CONSTANTE){
			printf("Token: %s\tlexema: %s\n", token_names[TOKEN], yytext);
		}else{
			printf("Token: \'%c\'\n", TOKEN);
		}
	}while(TOKEN != FDT);
	
	return 0;
}