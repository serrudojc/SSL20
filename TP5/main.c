/*
Grupo G02, miércoles noche
Serrudo Juan Carlos
Rosinke Martin
Cruz David
*/

#include <stdio.h>
#include "parser.h"
#include "scanner.h"
#include "semantic.h"

extern int errsem;
extern int yynerrs;
int nerrlex = 0;

int main()
{
	switch (yyparse())
	{
	case 0:
		puts("Compilación terminada con éxito");
		printf("Errores sintácticos: %d - Errores léxicos: %d - Errores Semánticos: %d\n", yynerrs, nerrlex, errsem);
		return 0;
	case 1:
		puts("Errores de compilación");
		printf("Errores sintácticos: %d - Errores léxicos: %d - Errores Semánticos: %d\n", yynerrs, nerrlex, errsem);
		return 1;
	case 2:
		puts("Memoria insuficiente\n");
		return 2;
	}
	return 0;
}
