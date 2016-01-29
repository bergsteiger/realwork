#include "shared/Core/fix/mpcxc.h"
#include <vector>
#include "pack.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	{
		FILE* file = mpcxc_fopen (argv [1], "rt");
		if (file) {
			long size = 0;
			std::vector<std::string> strings;
			while (!feof (file)) {
				char str [4096];
				if (!fgets (str, sizeof (str), file))
					break;

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				strings.push_back (str);
				size += length + 1;
			}
			fclose (file);
			char *data = new char [size], *ptr = data;
			for (std::vector<std::string>::const_iterator it = strings.begin (); it != strings.end (); it++) {
				strcpy (ptr, it->c_str ());
				ptr [it->size ()] = '|';
				ptr += it->size () + 1;
			}
			char *packed_data = new char [size + 100];
			long packed_size = G_ZIP (data, size, packed_data, size + 100);
			FILE *outfile = mpcxc_fopen (argv [2], "wb");
			if (outfile) {
				fwrite ("PK\x3\x4", 4, 1, outfile);
				fwrite (&packed_size, sizeof (long), 1, outfile);
				fwrite (&size, sizeof (long), 1, outfile);
				fwrite (packed_data, packed_size, 1, outfile);
				fclose (outfile);
			}
		}
	}
	return 0;
}
