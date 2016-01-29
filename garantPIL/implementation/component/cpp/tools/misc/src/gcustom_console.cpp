#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "newdoc.h"
#include "advlog.h"

YBase* aBase = 0;

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		//gcustom_console
		if (argc == 1) {
			printf ("\nUsage: gcustom_console base -day XXX -warning текстовый_файл_предупреждения -disable-dealer-inf -no-ref текстовый_файл_заглушки\n\n");
			exit (EXIT_SUCCESS);
		}
		if (argc == 2) {
			exit (EXIT_SUCCESS);
		}
		u_int32_t days = -1;
		bool disable_dealer_inf = false;
		std::string warning, noref;
		for (int i = 2; i < argc; i++) {
			if (!strcmp (argv [i], "-day")) {
				i++;
				days = atol (argv [i]);
			}
			else if (!strcmp (argv [i], "-disable-dealer-inf"))
				disable_dealer_inf = true;
			else if (!strcmp (argv [i], "-warning")) {
				i++;
				FILE *file = fopen (argv [i], "rt");
				while (!feof (file)) {
					char str [1024];
					if (!fgets (str, sizeof (str), file))
						break;

					int length = strlen (str);
					if (length) {
						if (str [length-1] == 10)
							str [--length] = 0;
						if (length && str [length-1] == 13)
							str [--length] = 0;
					} 
					if (warning.size ())
						warning += "\n";
					warning += str;
				}
				fclose (file);
			}
			else if (!strcmp (argv [i], "-no-ref")) {
				i++;
				FILE *file = fopen (argv [i], "rt");
				while (!feof (file)) {
					char str [1024];
					if (!fgets (str, sizeof (str), file))
						break;

					int length = strlen (str);
					if (length) {
						if (str [length-1] == 10)
							str [--length] = 0;
						if (length && str [length-1] == 13)
							str [--length] = 0;
					} 
					if (noref.size ())
						noref += "\n";
					noref += str;
				}
				fclose (file);
			}
		}
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		if (days != -1) {
			Stream *str = aBase->FindIndex ("Aux")->OpenN ("TMWR", 0, 1);
			if (str) {
				str->Write (&days, sizeof (days));
				aBase->FindIndex ("Aux")->Close (str);
			}
		}
		if (disable_dealer_inf) {
			Stream *str = aBase->FindIndex ("Aux")->OpenN ("DDI", 0, 1);
			u_int32_t flags = DDI_FOR_WARNING | DDI_FOR_DUMMY;
			if (str) {
				str->Write (&flags, sizeof (flags));
				aBase->FindIndex ("Aux")->Close (str);
			}
		}
		if (warning.size ()) {
			Stream *str = aBase->FindIndex ("Aux")->OpenN ("TMWM", 0, 1);
			if (str) {
				str->Write (warning.c_str (), warning.size () + 1);
				aBase->FindIndex ("Aux")->Close (str);
			}
		}
		if (noref.size ()) {
			Stream *str = aBase->FindIndex ("Aux")->OpenN ("DDM", 0, 1);
			if (str) {
				str->Write (noref.c_str (), noref.size () + 1);
				aBase->FindIndex ("Aux")->Close (str);
			}
		}
		delete aBase;
		exit (EXIT_SUCCESS);
	}
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}
