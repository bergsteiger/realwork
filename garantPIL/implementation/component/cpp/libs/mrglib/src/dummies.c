#include "shared/Core/fix/mpcxc.h"
#include <sys/stat.h>

#include "gdbapi.h"

#ifdef __GNUC__
	off_t filelength(int hfile)
	{
		struct stat st;

		return fstat(hfile, &st) ? 0 : st.st_size;
	}
#endif // __GNUC__

#ifdef __BORLANDC__
	int mkstemp(char *fname)
	{
		mktemp(fname);
		return ace_os_open(fname, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY, S_IRWALL);
	}
#endif // __BORLANDC__
