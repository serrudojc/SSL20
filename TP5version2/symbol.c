#include <string.h>
#include "semantic.h"

char *tablaSimbolos[100];
int indice = 0;

void colocar (char *simbolo){
    tablaSimbolos[indice] = simbolo;
    indice++;
}

int buscar (char *simbolo){
    for (int i=0 ; i < indice ; i++){
        if (strcmp(tablaSimbolos[i], simbolo) == 0){
            return 1;
        }
    }
    return 0;
}

int procesarIDnuevo (char *simbolo){
    if (!buscar(simbolo)) {
        colocar(simbolo);
        reservar(simbolo);
        return 1;
    } else return 0;
}