/*
Grupo G02, miércoles noche
Serrudo Juan Carlos
Rosinke Martin
Cruz David
*/

#include <stdio.h>
#include "parser.h"
#include "scanner.h"

extern int yynerrs;
//int nerrlex = 0;

int main()
{
	switch (yyparse())
	{
	case 0:
		puts("Compilación terminada con éxito\n");
		printf("Errores sintácticos: %d - Errores léxicos: %d\n", yynerrs, nerrlex);
		return 0;
	case 1:
		puts("Errores de compilación\n");
		printf("Errores sintácticos: %d - Errores léxicos: %d\n", yynerrs, nerrlex);
		return 1;
	case 2:
		puts("Memoria insuficiente\n");
		return 2;
	}
	return 0;
}