#include "class.h"
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
  char default_file_name[] = "assets/test-class/SimpleClass.class";
  char *file_name = argc > 2 ? argv[1] : default_file_name;
  FILE *fp = fopen(file_name, "rb");
  Class c = Class_read(fp);
  char *s = Class_to_string(c);
  printf("%s\n", s);
  free(s);
  fclose(fp);
}
