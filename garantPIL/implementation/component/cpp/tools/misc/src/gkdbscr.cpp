#include "shared/Core/fix/mpcxc.h"
#include <cstring>
#include "pagefile.h"


int main(int argc, char* argv[])
{
	if (argc < 3)
	{
		printf("Usage: gkdbscr <one of the base file names> <mode: r | w> [<input/output file name for the new value (64 bytes)>]\n");
		return 1;
	}
	
	char buf[64];

	if (strcmp(argv[2],"w") == 0)
	{
		PagedFile* file = new PagedFile(argv[1], ACE_OS_O_RDWR | ACE_OS_O_BINARY);
		if (argc == 4)
		{
			FILE* inf = mpcxc_fopen(argv[3],"rb");
			if (!inf) return 0;
			int len = fread(buf,1,64,inf);
			if (len != 64)
			{
				printf("ERROR: Cannot read 64 bytes from source file.\n");
			}
			else
			{
				printf("INFORMATION: The new record was inserted.\n");
				file->PutAttr("GSec",buf,64);
			}
			fclose(inf);
		}
		else
		{
			printf("Type 64 bytes for new value:\n");
			int len = fread(buf,1,64,stdin);
			printf("INFORMATION: The new record was inserted.\n");
			file->PutAttr("GSec",buf,64);
		}
		delete file;
		file = 0;
	}
	else if (strcmp(argv[2],"r") == 0)
	{
		PagedFile* file = new PagedFile(argv[1], ACE_OS_O_RDONLY | ACE_OS_O_BINARY);
		char *p = (char*)malloc(8192);
		
		file->GetPage(0L,p);
		
		PagedFileHeader* hdr = (PagedFileHeader*)p;
		
		int offset = hdr->AttrOffs;
		p += offset;
		while (*p && strcmp(p+1,"GSec"))
		{
			p += *p;
			offset += *p;
		}
		
		if (!*p)
		{
			printf("ERROR: Record not found.\n");
			free(p);
			delete file;
			return 0;
		}
		printf("INFORMATION: Record location:\n\tPage: 0\n\tStart position: %d\n\tLength: %d\n",offset,*p);

		if (argc == 4)
		{
			FILE* inf = mpcxc_fopen(argv[3],"wb");
			if (!inf) return 0;
			int len = fwrite(p+6,1,64,inf);
			fclose(inf);
		}
		else
		{
			fprintf(stdout,"\nValue:\n");
			int len = fwrite(p+6,1,64,stdout);
		}
		free(p);
		delete file;
		file = 0;
	}
			
	
	
	return 0;
}



