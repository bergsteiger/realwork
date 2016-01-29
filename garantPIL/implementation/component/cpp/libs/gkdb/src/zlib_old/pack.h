#ifndef _UNZIP_H_
#define _UNZIP_H_

#ifndef USE_CPP_ZIP 
#error One must define macro USE_CPP_ZIP and must assume C++ linakge
#define G_UNZIP UnZip
#define G_ZIP Pack

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

int UnZip(void * src, int packSize, void * dst, int maxBuf);
unsigned Pack( char* src, int size, char* dst, int out_size);

#ifdef __cplusplus
}
#endif // __cplusplus
#else
	#define G_UNZIP Zip::UnZip
	#define G_ZIP Zip::Pack

	#include "zlib.h"
	#include "ace/Recursive_Thread_Mutex.h"

	class Zip {
	public:
		static unsigned Pack(char *src, int size, char *dst, int out_size);
		static unsigned	UnZip ( void * src, int packSize, void * dst, int maxBuf );
		static ACE_Recursive_Thread_Mutex s_ZipMutex;
	};
#endif // USE_CPP_ZIP

#endif // _UNZIP_H_
