#include <stdio.h>
#include <string.h>

int nVarTemp = 0;
char auxTemp[10]; 
void reservar(char *var);

char* getTemp (){
    nVarTemp++;
    sprintf(auxTemp,"Temp#%d",nVarTemp);
    reservar(auxTemp);
    return strdup(auxTemp);
}

void comenzar(){
    printf("Load rtlib,\n");
}

void finalizar(){
    printf("Exit ,\n");
}

void reservar(char *var){
	printf("Reserve %s,4\n", var);
}

void leer(char *var){        
	printf("Read %s,Integer\n", var);
}

void escribir(char *var){        
	printf("Write %s,Integer\n", var);
}

void asignar(char *var1, char *var2){
	printf("Store %s,%s\n", var1, var2);
}

char* sum(char *var1, char *var2){
	char *varTemp = getTemp();
	printf("ADD %s,%s,%s\n", var1, var2, varTemp);
	return varTemp;
}

char* rest(char *var1, char *var2){
	char *varTemp = getTemp();
	printf("SUB %s,%s,%s\n", var1, var2, varTemp);
	return varTemp;
}

char* mult(char *var1, char *var2){
	char *varTemp = getTemp();
	printf("MUL %s,%s,%s\n", var1, var2, varTemp);
	return varTemp;
}

char* divi(char *var1, char *var2){
	char *varTemp = getTemp();
	printf("DIV %s,%s,%s\n", var1, var2, varTemp);
	return varTemp;
}

char* neg(char *var){
	char *varTemp = getTemp();
	printf("NEG %s,,%s\n", var, varTemp);
	return varTemp;
}