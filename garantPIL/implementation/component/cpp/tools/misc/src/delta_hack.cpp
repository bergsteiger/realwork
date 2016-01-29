#include "shared/Core/fix/mpcxc.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	{
		FILE* delta2read = fopen (argv [1], "rb");

		fseek (delta2read, 0, SEEK_END);
		long filesize = ftell (delta2read);
		fseek (delta2read, 0, SEEK_SET);

		long header_size;
		fread (&header_size, sizeof (long), 1, delta2read);
		header_size += 40;
		fseek (delta2read, 0, SEEK_SET);

		char* header = new char [header_size];
		fread (header, header_size, 1, delta2read);

		char zero;
		fread (&zero, 1, 1, delta2read);

		long tail_size = filesize - header_size - sizeof (zero);
		if (zero == 1) {
			char skip_buffer [181*2+75+2/*weight*/+4+4];
			fread (skip_buffer, sizeof (skip_buffer), 1, delta2read);
			tail_size -= sizeof (skip_buffer);
			filesize -= sizeof (skip_buffer);
		}
		long filesize_4 = filesize - 4;
		memcpy (header + header_size - 4, &filesize_4, sizeof (filesize_4));
		char *buffer = new char [tail_size];
		fread (buffer, 1, tail_size, delta2read);

		fclose (delta2read);

		FILE* delta2write = fopen (argv [2], "wb");
		fwrite (header, 1, header_size, delta2write);
		zero = 0;
		fwrite (&zero, 1, 1, delta2write);
		fwrite (buffer, 1, tail_size - 4, delta2write);
		fwrite (&filesize_4, 1, sizeof (filesize_4), delta2write);
		fclose (delta2write);

		exit (EXIT_SUCCESS);
	}

	return 0;
}



