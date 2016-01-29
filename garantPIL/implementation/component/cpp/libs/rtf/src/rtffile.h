#ifndef _RTFFILE_H_
#define _RTFFILE_H_

#include <stdio.h>
#include "rtfwrite.h"

class RTFFileWriter : public RTFWriter {
	public:
		RTFFileWriter(FILE *fl, RTFCharSet new_charset = CS_ANSI);
		~RTFFileWriter();

		int set_file(FILE *fl);
	protected:
		FILE* file_st;
		virtual int RawWrite(const char *buf, int size);
};
#endif // _RTFFILE_H_
