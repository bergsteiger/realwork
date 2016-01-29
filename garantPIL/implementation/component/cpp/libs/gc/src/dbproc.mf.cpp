#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: dbproc.mf.cpp,v 1.20 2012/08/03 10:29:13 yaroslav Exp $
 */
#include <cstdlib> // GARANT_GCC
#include <cstdio>
#include <cstring>

#include "deflate.h"
#include "dbproc.mf.h"
#include "shared/Core/GDS/StopWatch.h"

static int getCompressedData(void *, size_t ,z_stream *, YFILE *);

#define MF_VERSION 4063
#define ocompr_buf_sz 16384

DbProcMetaFile :: DbProcMetaFile(const char *fn, int bWrite, int pk, int vb):
	recCount(0),
	fl(0),
	status(0),
	verbose(vb),
	rdbuf(0),
	rdbsz(0),
	c_stream(0),
	compr_buf(0)
{
  int fd= -1;
  if( bWrite ){
#ifdef WITH_DBL_THREAD
	fl= (LPTHREAD_CNTX)fn;
#endif
    initWrite(fd,pk,0);
  }else{
#ifdef WITH_DBL_THREAD
	fl= (LPTHREAD_CNTX)fn;
#endif
    initRead(fd,0);
  }
}

DbProcMetaFile :: DbProcMetaFile(int fd, int bWrite, int pk, int vb):
	recCount(0),
	fl(0),
	status(0),
	verbose(vb),
	rdbuf(0),
	rdbsz(0),
	c_stream(0),
	compr_buf(0)
{
  if( bWrite ){
    initWrite(fd,pk,1);
  }else{
    initRead(fd,1);
  }
}

void DbProcMetaFile :: initWrite(int fd, int pk, int needDup )
{
	DbProcMFHeader t;
	memset(&t, 0, sizeof(t));
	t.signature[0] = 'D';
	t.signature[1] = 'b';
	t.signature[2] = 'M';
	t.signature[3] = 'f';
	t.version = MF_VERSION;
	t.dataOffset = sizeof( t );
	t.pack = pk;
	t.nRecords= 0x7fffffff;
	ywrite( &t, sizeof(t), 1, fl );
	status =0;
	wmode = 1;
}
void DbProcMetaFile :: initRead(int fd, int needDup )
{
  rdbsz = RDBFSZ;
  rdbuf = (char *)malloc(rdbsz);
  if( !rdbuf ){
    status = errno;
    return;
  }
  status = 0;
  wmode = 0;

  yread( 0, 1, (int)(sizeof(DbProcMFHeader)&0x7fffffff), fl );

  DbProcMFHeader *pT=
#ifdef WITH_DBL_THREAD

						(DbProcMFHeader *)(fl->p_Bf)
#else
						0
#endif
													;
	
  if( pT->signature[0] != 'D' || pT->signature[1] != 'b' ||
	 pT->signature[2] != 'M' || pT->signature[3] != 'f' ){
	 status =2;
	 return;
   }
   if( pT->version != MF_VERSION || pT->dataOffset != sizeof(*pT) ){
	 status = 3;
	 return;
   }
   packed = pT->pack= 0;
   recCount = pT->nRecords;
   verbose= 0;
#ifdef WITH_DBL_THREAD
   r= (DbProcMRecord*)(fl->p_Bf + (int)(sizeof(DbProcMFHeader)&0x7fffffff));
   m_DeActualCount= (int)((sizeof(DbProcMFHeader)+sizeof(DbProcMRecord))&0x7fffffff);

   tmpLast= -1;
   action= r->action;
   recSize= r->recSize;

	*fl->p_Rd += m_DeActualCount;
#endif
	m_DeActualCount= 0;
}

#if defined (_DEBUG) && defined (WIN32) // GARANT_WIN32
	extern "C" void put_stat(void *pThread, int Write);
#endif

DbProcMetaFile :: ~DbProcMetaFile()
{
#ifndef WITH_DBL_THREAD
	if( wmode && c_stream ){
		int err;
		for(;;){
			err = deflate(c_stream, Z_FINISH);
			if( (err==Z_OK||err==Z_STREAM_END)&&c_stream->total_out ){
				ywrite( compr_buf, 1, c_stream->total_out, fl);
				c_stream->total_out = 0;
				c_stream->next_out = (unsigned char *)compr_buf;
				c_stream->avail_out = ocompr_buf_sz;
			}
			if (err == Z_STREAM_END) break;
			if( err != Z_OK ){
				printf("deflate != Z_OK, (%d)\n",err);
				deflateEnd(c_stream);
				break;
			}
		}
		err = deflateEnd(c_stream);
#ifdef OPT_PACK
		TRY_FREE(c_stream, c_stream->state->pending_buf);
		TRY_FREE(c_stream, c_stream->state->head);
		TRY_FREE(c_stream, c_stream->state->prev);
		TRY_FREE(c_stream, c_stream->state->window);
		ZFREE(c_stream, c_stream->state);
		c_stream->state = Z_NULL;
#endif
		if( err != Z_OK ){
			printf("deflate != Z_OK, (%d)\n",err);
		}
		fflush(fl);
		// no try to write recCount to the file header
		clearerr(fl);
		(void)fseek(fl, st_pos, ACE_OS_SEEK_SET);
		if( !ferror(fl) ){
			DbProcMFHeader t;
			if(yread(&t,1,sizeof(t),fl)==sizeof(t)){
				t.nRecords = recCount;
				clearerr(fl);
				(void)fseek(fl, st_pos, ACE_OS_SEEK_SET);
				if( !ferror(fl) ){
					ywrite(&t,sizeof(t),1,fl);
				}
			}
		}
	}else if( c_stream ){
		int  err = inflateEnd(c_stream);
		if( err != Z_OK ){
			printf("inflateEnd != Z_OK, (%d)\n",err);
		}
	}
	if( fl ) fclose(fl);
#else
	if(wmode){
		DbProcMRecord tmp;
		memcpy(&tmp, END_METAFILE_SIGN, sizeof(long));
#ifdef AS_PROCESS
		write_my_pipe(fl, (char*)&tmp, sizeof(DbProcMRecord));
		write_my_pipe(fl, (char*)&tmp, sizeof(DbProcMRecord));
#else
		fl->LastWrite++;
		write_my_pipe(fl, (char*)&tmp, sizeof(DbProcMRecord));
#endif
#if defined (_DEBUG) && defined (WIN32) // GARANT_WIN32
		put_stat(fl->h_currPipe, 1);
#endif
	}
#endif
	if( rdbuf ) free(rdbuf);
	if( compr_buf) delete compr_buf;
	if( c_stream ) delete c_stream;
}

int DbProcMetaFile :: OK()
{
	return fl != 0 && status == 0;
}
void DbProcMetaFile :: noteEOM()
{
  // nothing to do - somebody will destruct me
}
int DbProcMetaFile :: write( const DbProcMRecord *b)
{
	recCount ++;
#ifndef WITH_DBL_THREAD
	if( c_stream ){
		int err;
		c_stream->next_in = (unsigned char *)b;
		c_stream->avail_in = b->recSize;
		do{
			if( (err=deflate(c_stream,Z_NO_FLUSH)) != Z_OK ) {
				printf("Deflate  (%d)\n",err);
				status =1;
				return 1;
			}
			if( c_stream->total_out ){
				size_t tmp=ywrite( compr_buf, 1, c_stream->total_out, fl);
				if( tmp != c_stream->total_out ){
					status = errno;
					return 1;
				}
				c_stream->total_out = 0;
				c_stream->next_out = (unsigned char *)compr_buf;
				c_stream->avail_out = ocompr_buf_sz;
			}
		}while( c_stream->avail_in );
	}else{
#endif
		size_t tmp = ywrite(b, 1, b->recSize, fl );
		if( tmp != b->recSize ){
			status = errno;
			return 1;
		}
#ifndef WITH_DBL_THREAD
	}
#endif
	return 0;
}

const DbProcMetaHolder:: DbProcMRecord *DbProcMetaFile::next( 
		const DbProcMRecord *&pp )
#ifndef WITH_DBL_THREAD
{
return 0;
}
#else
{
  if(r){
	if( recSize+sizeof(DbProcMRecord)+sizeof(DbProcMRecord) > rdbsz ){
		// reallocate rdbuf
		rdbsz = recSize + RDBFSZ +sizeof(DbProcMRecord)+sizeof(DbProcMRecord);
		void *tmpV = malloc( rdbsz );
		if( !tmpV ){
			status = errno;
			r = 0;
			abort();
		}
		(*(DbProcMRecord *)tmpV) = *r;
		free(rdbuf);
		rdbuf = (char *)tmpV;
		if(tmpLast > 0)
			r = (DbProcMRecord*)rdbuf;
	}
		if(tmpLast < 0){
			tmpLast = yread(rdbuf+sizeof(DbProcMRecord), 1, recSize-sizeof(DbProcMRecord),fl);
			if(tmpLast > 0){
				/*if( tmpLast!= r->recSize-sizeof(DbProcMRecord) ){
					status =1;
					r = 0;
					goto getout;
				}*/
				r = (DbProcMRecord*)rdbuf;
				r->action= action;
				r->recSize= recSize;
			}else{
				// буфер с телом рекорда в трубе залочен //
				m_DeActualCount += tmpLast & 0x7fffffff;

				// всегда отпускаем буфер из трубы //
				r = (DbProcMRecord*)rdbuf;
				memcpy(r+1, fl->p_Bf + (*fl->p_Rd), tmpLast & 0x7fffffff);
				r->action= action;
				r->recSize= recSize;
			}
		}else{
			tmpLast = yread(rdbuf+sizeof(DbProcMRecord), 1, recSize-sizeof(DbProcMRecord),fl);
			r = (DbProcMRecord*)rdbuf;
			r->action= action;
			r->recSize= recSize;
			if(tmpLast < 0){
				memcpy(rdbuf+sizeof(DbProcMRecord), fl->p_Bf + *fl->p_Rd, tmpLast & 0x7fffffff);
				*fl->p_Rd += tmpLast & 0x7fffffff;
			}else{
				// буфер с телом рекорда в трубе залочен //
				m_DeActualCount += tmpLast & 0x7fffffff;

				// всегда отпускаем буфер из трубы //
				r = (DbProcMRecord*)rdbuf;
				memcpy(r+1, fl->p_Bf + (*fl->p_Rd), tmpLast & 0x7fffffff);
				r->action= action;
				r->recSize= recSize;
			}
		}
//getout:
	if( &pp  != 0 ){
		pp = r;
		// разлочиваем буфер в трубе //
		*fl->p_Rd += m_DeActualCount;
		m_DeActualCount= 0;
		r= (DbProcMRecord*)(rdbuf+(tmpLast & 0x7fffffff)+sizeof(DbProcMRecord));
		tmpLast= yread( r, 1, sizeof(DbProcMRecord),fl);
		if(tmpLast < 0){
			r= (DbProcMRecord*)(fl->p_Bf + (*fl->p_Rd));
			if(!memcmp(r, END_METAFILE_SIGN, 4)){
				r= 0;
			}else{
				action= r->action;
				recSize= r->recSize;
				*fl->p_Rd += tmpLast & 0x7fffffff;
			}
		}else{
			if(!memcmp(r, END_METAFILE_SIGN, 4)){
				r= 0;
			}else{
				action= r->action;
				recSize= r->recSize;
			}
		}
	}
  }else if( &pp  != 0 ){
    pp= 0;
  }
  return r;
}
#endif
#ifndef WITH_DBL_THREAD

static int getCompressedData(void *buf, 
	size_t rec_length,z_stream *c_stream, YFILE *fl)
{
	static unsigned char compr_buf[RDBFSZ];

	c_stream->total_out = 0;
	c_stream->avail_out = rec_length;
	c_stream->next_out = (unsigned char *)buf;
	int err= 0;

	do{
		if( c_stream->avail_in == 0 ){
			while( c_stream->avail_in == 0 
						&& !err 
						&& c_stream->avail_out ){
				int rd = yread(compr_buf, 1, RDBFSZ, fl );
				if( rd == 0 ){
					// finita la comedia
					return 0;
				}else{
					c_stream->avail_in = rd;
					c_stream->next_in = compr_buf;
				}
				err = inflate(c_stream,Z_NO_FLUSH);
			}
		}else{
			err = inflate(c_stream,Z_NO_FLUSH);
		}
		switch(err){
			case Z_OK:
				break;
			case Z_STREAM_END:
				printf("Stream end!\n");
				return c_stream->total_out;
			default:
				printf("Got error: %d\n", err);
				return 0;
		}
	}while(c_stream->total_out != rec_length );
	return rec_length;
}
#endif
