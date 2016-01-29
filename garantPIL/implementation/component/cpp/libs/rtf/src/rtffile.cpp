
#include <stdio.h>
#include "rtffile.h"

RTFFileWriter::RTFFileWriter(FILE *fl, RTFCharSet new_charset)
	:file_st(fl), RTFWriter(new_charset)
{
}

RTFFileWriter::~RTFFileWriter()
{
	file_st = 0;
}

int RTFFileWriter::set_file(FILE *fl)
{
	file_st = fl;
	return 0;
}

int RTFFileWriter::RawWrite(const char *buf, int size)
{
	if (!file_st)
		return 0;
	return fwrite(buf, 1, size, file_st);
}
