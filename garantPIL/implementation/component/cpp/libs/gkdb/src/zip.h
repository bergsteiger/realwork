/*
	Author: Alex Bachin
	Not copyrighted 1994-96
	deflate routine for in-memory compression.
	works like pkzip 1.93 ... 2.04

	restrictions & limitations:
		- large memory model (other models not tested yet)
		- unsigned characters
		- source: ( 0 < size <= 32768 ) (what about 0?)
		- memory in heap - X kilobytes (X about 300K)

	on error ( not enough memory ) returns 0
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
unsigned zipmemory ( char *dst, char *src, unsigned srcsize );
//extern "C"		// in unzip.obj
//{
//	UnZip ( char * src, char * dest );
//}

