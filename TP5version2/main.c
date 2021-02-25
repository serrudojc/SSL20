/*
Grupo G02, miércoles noche
Serrudo Juan Carlos
Rosinke Martin
*/

#include <stdio.h>
#include "parser.h"
#include "scanner.h"

extern int yynerrs;
int nerrlex = 0;
int nerrsem = 0;

int main()
{
	switch (yyparse())
	{
	case 0:
		puts("Compilación terminada con éxito");
		printf("Errores sintácticos: %d - Errores léxicos: %d - Errores Semánticos: %d\n", yynerrs, nerrlex, nerrsem);
		return 0;
	case 1:
		puts("Errores de compilación");
		printf("Errores sintácticos: %d - Errores léxicos: %d - Errores Semánticos: %d\n", yynerrs, nerrlex, nerrsem);
		return 1;
	case 2:
		puts("Memoria insuficiente\n");
		return 2;
	}
	return 0;
}
