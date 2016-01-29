#include "shared/Core/fix/mpcxc.h"
#include <sys/stat.h>
#ifdef linux
#include <sys/types.h>
#endif

off_t ace_os_filesize(int hfile)
{
	struct stat st;

	return fstat(hfile, &st) ? 0 : st.st_size;
}


