#include <stdio.h>
#include <ctype.h> //contiene isalpha, isdigit, etc.

typedef enum {
    CONSTENTERA, IDENTIFICADOR, NUMERAL, ERROR, FDT //0,1,2,3,4
} TOKEN;


int transicion(int fila, char caracter);
int esEstadoAceptor(int est);
int tieneCentinela (int est);
TOKEN token(int est);
TOKEN scanner ();
