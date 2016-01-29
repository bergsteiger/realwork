/*
 * $Id: fstringer.h,v 2.3 2012/10/26 09:26:32 vlad Exp $
 */
#ifndef _fstringer_h
#define _fstringer_h

//class String;

class FileStringer
{
public:
	FileStringer(const char *fn, int bsz = 0);
	const char *gets(int &length);
	const char *get_nexts (int &length);
	~FileStringer();
	int OK() const { return (fd != -1 ) && rbuf; }
	int rewind();
protected:
  	int bfsz; //acctualy, real buffers size is bfsz *2
	int fd;
	int err;
	char *rbuf;
	int bufpos;
	int cinbuf;
private:
	char* next_s;
	int next_l;
};
#endif

