// Programa para practicar los ejercicios del libro "Introduction to Compilers
// and Language Design"
// Seccion 2.4

// Se necesita un codigo sin inputs que sea relativamente heavy

# include <stdio.h>
# include <stdlib.h>

// Usado para ver el efecto del preprocesador
# define N 5000000
# define K 5

// filtro
double f[K] = {0.2, 0.1, 0.4, 0.1, 0.2};

// Convolucion 1D
// Input array, Convoluted array, array size
void convolve(const double* input, double* output, int n){
    for (int i = K/2; i < n - K/2; i++){
        double acc = 0.0;
        for (int j = 0; j < K; j++){
            acc += input[i + j - K/2] * f[j];
        }
        output[i] = acc;
    }
}

// Checksum - Evita que el compilador super-optimice el calculo
// Convoluted array, array size
double checksum(const double* v, int n){
    double s = 0.0;
    for(int i = 0; i < n; i++) s += v[i];
    return s;
}

int main(){
    // Declaracion de arrays dinamicos
    double *a = malloc(sizeof(double) * N);
    double *b = malloc(sizeof(double) * N);

    // Verificacion de memoria
    if (a == NULL || b == NULL) {
        printf("Memory allocation failed\n");
        return -1;
    }

    // Llena los arrays
    for (int i = 0; i < N; i++){
        a[i] = (double)(i % 100) / 100.0;
    }

    // Convolve:
    // Aplica una convolución 1D con filtro fijo de tamaño K
    convolve(a, b, N);

    // Checksum
    printf("Checksum: %f\n", checksum(b, N));

    // Free memory
    free(a);
    free(b);
    return 0;
}

// Compiler toolchain:
// gcc main.c -o main
// Preprocesador (-E flag):
//      gcc -E main.c > kernel.i
// Compilador (-S flag):
//      gcc -S main.c
// Assembler (-c flag) takes the .s file
//      gcc -c main.s -o main.o
//          objdump -d main.o
// Linker (no flag) takes the .o file
//      gcc main.o -o main.exe

// Compiler optimization
// -O0  | Sin optimizacion (default)
// -O1
// -O2
// -O3  | Maximo
// -Os  | Optimiza tamaño

// To se the abstract Sintax Tree
// clang -Xclang -ast-dump myfile.c
