#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>

#ifdef __MSVC__
	#include <direct.h>
#endif

#include "unifname.h"

int main(int argc, char **argv)
{
	char *fname, *cwd;

	if ( argc < 2 ) {
		printf("Usage:\n\ttestutil <filename>\n");
		return 0;
	}
	cwd = (char *)malloc(1024);
	cwd = getcwd(cwd, 1024);
	fname = unifname(argv[1], cwd);
	if (!fname) {
		free(cwd);
		printf ("Invalid argument: %s isn't a valid file name.\n", argv[1]);
		return 0;
	}
	printf ("File name with full path: %s\n", fname);
	free(cwd);
	free(fname);
	return 0;
}

