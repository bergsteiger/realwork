#include "pack.h"

#include "zlib.h"

unsigned Zip::UnZip ( void * src, int packSize, void * dst, int maxBuf )
{
	z_stream c_stream;
	int 	 err;


	c_stream.zalloc = (alloc_func)0;
	c_stream.zfree  = (free_func)0;
	c_stream.opaque = (voidpf)0;

	if ( inflateInit(&c_stream) != Z_OK ) {
		return 0;
	}

	c_stream.avail_in  = packSize;
	c_stream.avail_out = maxBuf;
	c_stream.next_in   = (unsigned char*)src;
	c_stream.next_out  = (unsigned char*)dst;

	for ( ; ; )
	{
		err = inflate(&c_stream, Z_FINISH);
		if (err == Z_STREAM_END)
			break;
		if ( err != Z_OK ){
			inflateEnd(&c_stream);
			return 0;
		}
	}

	//return inflateEnd(&c_stream) == Z_OK;
	err = inflateEnd(&c_stream);

	return (err == Z_OK) ? (unsigned)c_stream.total_out : 0;
}
