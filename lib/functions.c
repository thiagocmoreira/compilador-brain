#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void writeIntoFile(FILE* file, const char* content) {
    if (file != NULL) {
        fprintf(file, "%s", content);
    } else {
        exit(0);
    }
}

void writeLibrary(FILE *file){
    writeIntoFile(file, "#include <stdio.h>\n#include <stdlib.h>\n#include <math.h>\n#include <string.h>\n\n");
}
void writeMain(FILE *file){
    writeIntoFile(file, "int main(int argc, char **argv){\n");
}
void writeEndMain(FILE *file){
    writeIntoFile(file, "\n\treturn 0;\n}\n");
}

void writeSimplePrint(FILE *file, const char *string){
    char print[60] = "";
    strcat(print, "\n\tprintf(\"");
    strcat(print, string);
    strcat(print, "\");");
    writeIntoFile(file, print);
}
