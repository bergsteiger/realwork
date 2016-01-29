#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: fstringer.cpp,v 2.20 2012/10/26 09:40:43 vlad Exp $
 */

#include "osdep.h"
#include "fstringer.h"
#include <cstring>
#include <cstdio>
#include <fcntl.h>
//#include <unistd.h>
#include <cerrno>

const char * FileStringer :: get_nexts (int &length)
{
	const char* next_ss = gets (next_l);
	length = next_l;
	if (next_ss) {
		next_s = strdup (next_ss);
		return next_s;
	} else {
		return 0;
	}
}

const char * FileStringer :: gets(int &length)
{
	if (next_l != -1) {
		length = next_l;
		next_l = -1;
		return next_s;
	}
	if( bufpos >= cinbuf ){
		//need to read some from file
		cinbuf = ace_os_read(fd, rbuf, bfsz * 2);
		bufpos = 0;
		if( cinbuf == 0 ){
			// seems like we're at the eof
			length = 0;
			return 0;
		}
	}
	if( bufpos >= bfsz ){
		//move second part to first
		memmove(rbuf, rbuf+bfsz, bfsz );
		bufpos -= bfsz;
		cinbuf -= bfsz;
		cinbuf += ace_os_read(fd, rbuf+bfsz, bfsz );
		if( bufpos >= cinbuf ){
			//can't read more anything...
			length = 0;
			return 0;
		}
	}

	char *bp  = rbuf+bufpos;
	char *p =(char *) memchr(bp, '\n', cinbuf - bufpos );
	if( p ){
		if( p == bp ){
			length = 0;
			bufpos ++;
		}else{
			if( *(p-1) == '\r' ){
				length = p -1 - bp;
			}else{
				length = p - bp;
			}
			bufpos = p+1-rbuf;
		}
	}else{
		// no \n in buf
		length = cinbuf - bufpos;
		bufpos = cinbuf;
	}

	
	bp[length]='\0';

	return bp;
}
FileStringer :: FileStringer( const char *fn, int bsz ):
	fd(0),
	err(0),
	rbuf(0),
	bufpos(0),
	cinbuf(0),
	next_s(0),
	next_l(-1)
{
	#if defined(__GO32__) || defined(__CYGWIN32__) || defined(__MSVC__)
		fd = ace_os_open( fn, ACE_OS_O_RDONLY | ACE_OS_O_BINARY);
	#else
		fd = ace_os_open( fn, ACE_OS_O_RDONLY);
	#endif

	if( fd == -1 ){
		err = errno;
	}else{
		bfsz = (bsz)?bsz:128*1024; //128KB default
		rbuf = new char[bfsz*2+sizeof(char)];
		if( !rbuf)
			err = ENOMEM;
	}
}
int FileStringer :: rewind()
{
	bufpos=0;
	cinbuf=0;
	return ace_os_lseek(fd,0,ACE_OS_SEEK_SET);
}

FileStringer :: ~FileStringer()
{
	if( fd != -1 )
		ace_os_close(fd);
	if( rbuf )
		delete rbuf;
	if (next_s)
		free (next_s);
}
