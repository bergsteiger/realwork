#define STRICT

#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "garutils.h"
#include "SearchB.h"

#include "shared/Adapters/mlmaru/MLMARUAdapter.h"

extern	void	BuildPatternM (ContextPattern&, char*);

int main ( int argc, char *argv[] )
{
	Adapters::MLMA32RUAdapter* adapter = Adapters::MLMA32RUAdapterSingleton::instance ();

	FILE *request_file = fopen (argv [1], "rt");
	while (!feof (request_file)) {
		char request_str [1024]; request_str [0] = '\0';
		fgets (request_str, sizeof (request_str), request_file);

		int length = strlen (request_str);
		while (length && (request_str [length-1] == 10 || request_str [length-1] == 13))
			request_str [--length] = 0;
		if (!length)
			continue;

		Recoding (cd_dos, cd_win, request_str);
		ContextPattern pattern;
		BuildPatternM (pattern, request_str);
		printf ("%s : ", request_str);

		for (int i = 0; i < pattern.WordCount; i++) {
			char	buffer[256];
			unsigned long dwLids[32];
			char	szgram[256];
			int		lCount = adapter->lemmatize (pattern.Word [i], 0, buffer, dwLids, 0, 256, 32, 256);
			char*	lplemm = buffer;

			if (lCount) {
				for (int nindex = 0; nindex < lCount; nindex++) {
					if (nindex)
						printf (",");
					printf ("%s", lplemm);
					lplemm += strlen (lplemm) + 1;
				}
			} else {
				bool digits = true;
				for (int j = 0; j < strlen (pattern.Word [i]) && digits; j++)
					digits = isdigit ((unsigned char)pattern.Word [i][j]);
				if (digits)
					printf ("%s", pattern.Word [i]);
				else
					printf ("?");
			}
			if (i < pattern.WordCount - 1)
				printf ("-");
		}
		printf (":");
		for (int i = 0; i < pattern.WordCount; i++) {
			char	buffer[256];
			unsigned long dwLids[32];
			char	szgram[256];
			int		lCount = adapter->lemmatize (pattern.Word [i], 0, buffer, dwLids, szgram, 256, 32, 256);
			char*	lpgram = szgram;
			char*	lplemm = buffer;

			if (lCount) {
				for (int nindex = 0; nindex < lCount; nindex++) {
					if (nindex)
						printf ("/");

					int ngrams = *lpgram++;
					SGramInfo*  pginfo = (SGramInfo*)lpgram;
					lpgram += ngrams * sizeof(SGramInfo);

					std::set<long> grams;
					for (int count = 0; ngrams-- > 0; pginfo++, count++)
						grams.insert (pginfo->wInfo);
					for (std::set<long>::const_iterator it = grams.begin (); it != grams.end (); it++) {
						if (it != grams.begin ())
							printf ("/");
						printf ("%ld",*it);
					}
				}
			} else {
				bool digits = true;
				for (int j = 0; j < strlen (pattern.Word [i]) && digits; j++)
					digits = isdigit ((unsigned char)pattern.Word [i][j]);
				if (digits)
					printf ("128");
				else
					printf ("?");
			}
			if (i < pattern.WordCount - 1)
				printf ("-");
		}
		printf ("\n");
	}
	fclose (request_file);	

	return 0;
}
