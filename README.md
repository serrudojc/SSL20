# TPS-Sintaxis

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