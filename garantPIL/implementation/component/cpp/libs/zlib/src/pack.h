#ifndef _ZLIB_UNZIP_H_
#define _ZLIB_UNZIP_H_

#ifndef USE_CPP_ZIP
#error Reentrant inflate/deflate do require macro USE_CPP_ZIP 
#define G_UNZIP UnZip
#define G_ZIP Pack

#ifdef __cplusplus
extern "C" {
#endif

int UnZip(void * src, int packSize, void * dst, int maxBuf);
unsigned Pack( char* src, int size, char* dst, int out_size);

#ifdef __cplusplus
}
#endif
#else
	#define G_UNZIP Zip::UnZip
	#define G_ZIP Zip::Pack

	//#include "zlib.h"
	//#include "ace/Singleton.h"
	//#include "ace/Recursive_Thread_Mutex.h"

	class Zip {
	// //friend class ACE_Singleton <Zip_i, ACE_Recursive_Thread_Mutex>;
	public:
		static unsigned Pack(char *src, int size, char *dst, int out_size);
		static unsigned UnZip ( void * src, int packSize, void * dst, int maxBuf );
	};
	//typedef ACE_Singleton <Zip_i, ACE_Recursive_Thread_Mutex> Zip;
#endif

#endif
