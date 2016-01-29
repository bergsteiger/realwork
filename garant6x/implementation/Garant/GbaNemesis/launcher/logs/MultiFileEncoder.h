#ifndef    _C152DB2A966C4E7CA66E84FC6DB3B692_
#define    _C152DB2A966C4E7CA66E84FC6DB3B692_

#include <windows.h>


#if        (defined (MULTIFILEENCODER_AS_STATIC_LIBS))
#if        (!defined (MULTIFILEENCODER_HAS_DLL))
#define    MULTIFILEENCODER_HAS_DLL 0
#endif  // (!defined (MULTIFILEENCODER_HAS_DLL))
#else   // (defined (MULTIFILEENCODER_AS_STATIC_LIBS))
#if        (!defined (MULTIFILEENCODER_HAS_DLL))
#define    MULTIFILEENCODER_HAS_DLL 1
#endif  // (!defined (MULTIFILEENCODER_HAS_DLL))
#endif  // (defined (MULTIFILEENCODER_AS_STATIC_LIBS))

#define    MULTIFILEENCODER_Export

#if        (defined (MULTIFILEENCODER_HAS_DLL) && (MULTIFILEENCODER_HAS_DLL == 1))
#if        (defined (MULTIFILEENCODER_BUILD_DLL))
#if        (defined (WIN32) && defined (_MSC_VER))
#undef     MULTIFILEENCODER_Export
#define    MULTIFILEENCODER_Export __declspec (dllexport)
#endif  // (defined (WIN32) && defined (_MSC_VER))
#else   // (defined (MULTIFILEENCODER_BUILD_DLL))
#if        (defined (WIN32) && defined (_MSC_VER))
#undef     MULTIFILEENCODER_Export
#define    MULTIFILEENCODER_Export __declspec (dllimport)
#endif  // (defined (WIN32) && defined (_MSC_VER))
#endif  // (defined (MULTIFILEENCODER_BUILD_DLL))
#endif  // (defined (MULTIFILEENCODER_HAS_DLL) && (MULTIFILEENCODER_HAS_DLL == 1))


#if defined (__cplusplus)
extern "C" {
#endif // defined (__cplusplus)

MULTIFILEENCODER_Export
int InitEncode (const char* a_file_name, void*& a_handle);

MULTIFILEENCODER_Export
int EncodeData (void* a_handle, const void* a_buffer, const size_t a_size);

MULTIFILEENCODER_Export
void DoneEncode (void*& a_handle);

#if defined (__cplusplus)
}
#endif // defined (__cplusplus)

#endif  // _C152DB2A966C4E7CA66E84FC6DB3B692_
