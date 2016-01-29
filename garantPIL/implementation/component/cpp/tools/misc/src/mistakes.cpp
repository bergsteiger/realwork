#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

#include "SearchB.h"
#include "protect.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		SearchBase* base = new SearchBase (argv [1]);
		FILE *in_file = fopen (argv [2], "rt");
		int log_handle = ace_os_open (argv [3], ACE_OS_O_CREAT | ACE_OS_O_WRONLY | ACE_OS_O_TEXT);

		while (!feof (in_file)) {
			char str [256];
			if (!fgets (str, sizeof (str), in_file))
				break;

			if (strchr (str, ';'))
				*strchr (str, ';') = '\0';

			if (log_handle != -1) {
				char buffer [128];
				sprintf (buffer, "Запрос: %s\n", str);
				ace_os_write (log_handle, buffer, strlen (buffer));
			}

			std::string correct;
			std::vector <std::string> cant;
			base->correct_mistakes (str, correct, cant, false, log_handle);

			if (log_handle != -1) {
				char buffer [128];
				sprintf (buffer, "\n");
				ace_os_write (log_handle, buffer, strlen (buffer));
			}

		}
		fclose (in_file);
		ace_os_close (log_handle);

		exit (EXIT_SUCCESS);
	}
}
