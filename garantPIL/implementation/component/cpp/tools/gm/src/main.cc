#include "mpcxc.h"
#include <stdlib.h>
#include <string.h>
//

#include "gsscreen.h"

extern "C" {
extern int parse_cmdline(int argc, char **argv);
extern int read_settings(void);
extern int gmmain(void);
extern void help(void);
}
extern void init_screen(ProgressScreen *);

int main(int argc, char *argv[])
{
	int use_settings;

	if(!(use_settings=parse_cmdline(argc, argv)))
		return -3;
	use_settings--;
	if(use_settings)
		if(!read_settings()) return -4;
	GSScreen scr(cd_koi, mpcxc_cd_cursys());
	init_screen(&scr);
	if(!gmmain()) {
		// Write error message to log;
		return -7;
	}
	scr.CloseScreen();
	return 0;
}

