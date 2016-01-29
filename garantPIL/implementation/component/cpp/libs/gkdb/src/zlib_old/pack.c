#include	<stdio.h>
#ifndef	unix
	#include	<process.h>
#endif
#include	"zlib.h"
#ifndef USE_CPP_ZIP
#include	"pack.h"
#endif

unsigned Pack(char *src, int size, char *dst, int out_size)
{
	static z_stream g_stream;
	int err;
	//static int init= 1;

	//if(init){
	//	init = 0;
		g_stream.zalloc = (alloc_func)0;
		g_stream.zfree = (free_func)0;
		g_stream.opaque = (voidpf)0;
		err = deflateInit(&g_stream, Z_BEST_COMPRESSION);
		if( err != Z_OK )
			return 0;
		g_stream.avail_in = size;
	//}
	g_stream.avail_out = out_size;
	g_stream.next_in = (unsigned char*)src;
	g_stream.next_out = (unsigned char*)dst;
	for (;;) {
		err = deflate(&g_stream, Z_FINISH);
		if (err == Z_STREAM_END) break;
		if( err != Z_OK ){
			deflateEnd(&g_stream);
			return 0;
		}
	}
	err = deflateEnd(&g_stream);
	if( err != Z_OK )
		return 0;

	return (unsigned)g_stream.total_out;
}

unsigned Pack_old(char *src, int size, char *dst, int out_size)
{
	z_stream c_stream;
	int err;

	c_stream.zalloc = (alloc_func)0;
	c_stream.zfree = (free_func)0;
	c_stream.opaque = (voidpf)0;
	err = deflateInit(&c_stream, Z_BEST_COMPRESSION);
	if( err != Z_OK )
		return 0;
	c_stream.avail_in = size;
	c_stream.avail_out = out_size;
	c_stream.next_in = (unsigned char*)src;
	c_stream.next_out = (unsigned char*)dst;
	for (;;) {
		err = deflate(&c_stream, Z_FINISH);
		if (err == Z_STREAM_END) break;
		if( err != Z_OK ){
			deflateEnd(&c_stream);
			return 0;
		}
	}
	err = deflateEnd(&c_stream);
	if( err != Z_OK )
		return 0;

	return (unsigned)c_stream.total_out;
}

