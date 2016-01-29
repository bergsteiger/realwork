#include "pack.h"

unsigned Zip::Pack(char *src, int size, char *dst, int out_size)
{
	z_stream c_stream;
	int err;

	s_ZipMutex.acquire();
	
	c_stream.zalloc = (alloc_func)0;
	c_stream.zfree = (free_func)0;
	c_stream.opaque = (voidpf)0;
	err = deflateInit(&c_stream, Z_BEST_COMPRESSION);
	if( err != Z_OK ) {
		s_ZipMutex.release();
		return 0;
	}
	c_stream.avail_in = size;
	c_stream.avail_out = out_size;
	c_stream.next_in = (unsigned char*)src;
	c_stream.next_out = (unsigned char*)dst;
	for (;;) {
		err = deflate(&c_stream, Z_FINISH);
		if (err == Z_STREAM_END) break;
		if( err != Z_OK ){
			deflateEnd(&c_stream);
			s_ZipMutex.release();
			return 0;
		}
	}
	err = deflateEnd(&c_stream);
	if( err != Z_OK ) {
		s_ZipMutex.release();
		return 0;
	}
	s_ZipMutex.release();
	return (unsigned)c_stream.total_out;
}

