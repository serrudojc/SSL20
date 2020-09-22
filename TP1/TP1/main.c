#include "scanner.h"
/*
int main(){

    int estadoActual = 0;
    char caracter; //basura?
    TOKEN esToken;

    int cantConstantes = 0;
    int cantIdentificadores = 0;
    int cantNumeral = 0;
    int cantErrores = 0;

    while (caracter != EOF) {   //este EOF me hace ruido... teoricamente, caracter tiene basura
        while(!esEstadoAceptor(estadoActual)){
            caracter = getchar();
            estadoActual = transicion(estadoActual, caracter);
        }

        if (tieneCentinela(estadoActual)){
            ungetc(caracter, stdin);
            esToken = token(estadoActual);
        }else{
            esToken = token(estadoActual);
        }

        switch (esToken)
        {
        case CONSTENTERA:
            printf("constante entera\n");
            cantConstantes++;
            break;
        case IDENTIFICADOR:
            printf("identificador\n");
            cantIdentificadores++;
            break;
        case NUMERAL:
            printf("Numeral\n");
            cantNumeral++;
            break;
        case ERROR:
            printf("error\n");
            cantErrores++;
            break;
        default:
            break;
        }
        estadoActual = 0;
    }
    printf("----\n");
    printf("Totales:\n");
    printf("Identificadores %d\n", cantIdentificadores);
    printf("Constantes enteras %d\n", cantConstantes);
    printf("Numerales %d\n",cantNumeral);
    printf("Errores %d\n",cantErrores);
    return 0;
}

*/
 int main(){

    TOKEN esToken;

    int cantConstantes = 0;
    int cantIdentificadores = 0;
    int cantNumeral = 0;
    int cantErrores = 0;

    do {
        esToken = scanner ();

        switch (esToken)
        {
        case CONSTENTERA:
            printf("constante entera\n");
            cantConstantes++;
            break;
        case IDENTIFICADOR:
            printf("identificador\n");
            cantIdentificadores++;
            break;
        case NUMERAL:
            printf("Numeral\n");
            cantNumeral++;
            break;
        case ERROR:
            printf("error\n");
            cantErrores++;
            break;
        default:
            break;
        }
        
    } while (esToken != FDT);

    printf("----\n");
    printf("Totales:\n");
    printf("Identificadores %d\n", cantIdentificadores);
    printf("Constantes enteras %d\n", cantConstantes);
    printf("Numerales %d\n",cantNumeral);
    printf("Errores %d\n",cantErrores);
    return 0;
} 