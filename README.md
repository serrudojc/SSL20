# TPS-Sintaxis
##----------------------------------------------
## Link del enunciado del TP1 de SSL 2020 Zuñiga
https://drive.google.com/file/d/1oLXN4gkKi59VQ4Q-K3hETGXWtB6eFN38/view?usp=sharing

## Link de la tabla de transición preliminar.
https://docs.google.com/spreadsheets/d/1vcvYtR-K229qKiFZ0QtDIM6UUEDJ7bLum4RFkw8W4nw/edit?usp=sharing

## Link del tutorial para usar CodeBlocks (Se puede usar el debugger)
https://drive.google.com/file/d/1BFEUOENFc2LLNztbhnbobaC_D0fg2SSi/view?usp=sharing

## Para compilar en consola usamos
```
gcc -Wall -std=c11 -pedantic-errors -o scanner main.c scanner.c
```

### Luego para ejecutar en la terminal 
```
./scanner.exe
```

Redireccionando la entrada hacian un archivo de texto (ojo, va depender de que terminal, es medio falopa)
```
./scanner<archivo
```
```
./scanner.exe<archivo.txt
```
Para Powershell ↓
```
Get-Content .\datosPrueba.txt | .\scanner.exe
```

##------------------------------------------------
## Link del enunciado del TP2 de SSL 2020 Zuñiga
https://drive.google.com/file/d/1KZVQzjautDMeS_CBT_8_fB20ELV-P8DC/view?usp=sharing
https://drive.google.com/file/d/13biHfHaplypjfCogOCeHhp3czz8bz7-F/view?usp=sharing

Resolucion parcial
https://docs.google.com/document/d/1XtNvKy9ylJgBvZ1IoqZPxtEUHSizGsd_gk2JF-xlY50/edit?usp=sharing

##------------------------------------------------
## Link del enunciado del TP3 de SSL 2020 Zuñiga
En la carpeta

##------------------------------------------------
## Link del enunciado del TP4 de SSL 2020 Zuñiga
En la carpeta
```
flex scanner.l
bison parser.y
gcc -o compiler *.c -lfl
./compiler<entradaok.txt
```
