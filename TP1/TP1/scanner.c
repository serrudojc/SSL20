#include "scanner.h"

//https://docs.google.com/spreadsheets/d/1vcvYtR-K229qKiFZ0QtDIM6UUEDJ7bLum4RFkw8W4nw/edit?usp=sharing
int tablaTransicion [4][6] = {
    {1,2,6,7,0,3},
    {1,4,4,4,4,4},
    {2,2,5,5,5,5},
    {8,8,8,8,8,3}
};

int transicion(int fila, char caracter){
    if (isdigit(caracter)){
        return tablaTransicion[fila][0];
    }
    if (isalpha(caracter)){
        return tablaTransicion[fila][1];
    }
    if (caracter == '#'){
        return tablaTransicion[fila][2];
    }
    if (caracter == EOF){
        return tablaTransicion[fila][3];
    }
    if (isspace(caracter)){
        return tablaTransicion[fila][4];
    } else {
        return tablaTransicion[fila][5];
    }
}

int esEstadoAceptor(int est){ //Los estados aceptores del 4 en adelante
    if (est > 3){
        return 1;
    } else {
        return 0;
    }
}

int tieneCentinela (int est){ //devuelve si el estado requirio centinela. Para hacer o no ungetc
    if (est == 4 || est == 5 || est == 8){
        return 1;
    } else {
        return 0;
    }
}

TOKEN token(int est){ //devuelve TOKEN segun el estado
    switch (est)
    {
    case 4:
        return CONSTENTERA;
    case 5:
        return IDENTIFICADOR;
    case 6:
        return NUMERAL;
    case 7:
        return FDT;
    default:
        return ERROR;
    }
}

TOKEN scanner (){

    int estado = 0; //estado inicial
    char c;         //variable caracter a analizar

    while(!esEstadoAceptor(estado)){
        c = getc(stdin);
        estado = transicion(estado, c);
    }
    
    if (tieneCentinela(estado)) ungetc(c,stdin);

    return token (estado);

}
