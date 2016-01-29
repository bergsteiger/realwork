#include "shared/Core/fix/mpcxc.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	if (argc < 3)
		exit (EXIT_FAILURE);

	long version = atol (argv [2]);

	FILE* delta2read = fopen (argv [1], "rb");
	fseek (delta2read, 0, SEEK_END);
	long filesize = ftell (delta2read);
	fseek (delta2read, 0, SEEK_SET);

	char* delta = new char [filesize];
	fread (delta, filesize, 1, delta2read);
	fclose (delta2read);

	long header_size;
	memcpy (&header_size, delta, sizeof (header_size));
	memcpy (delta + header_size, &version, sizeof (version));

	FILE* delta2write = fopen (argv [3] ? argv [3] : argv [1], "wb");
	fwrite (delta, filesize, 1, delta2write);
	delete []delta;
	fclose (delta2write);

	return 0;
}



