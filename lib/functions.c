#include <stdio.h>
#include <stlib.h>

void writeIntoFile(FILE* file, const char* content) {
    if (file != NULL) {
        fprintf(file, "%s", content);
    } else {
        Log_error("Não foi possível abrir o arquivo!\n");
        exit(0);
    }
}
