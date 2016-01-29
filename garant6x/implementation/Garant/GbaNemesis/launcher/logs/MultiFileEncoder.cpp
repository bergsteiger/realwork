#include "MultiFileEncoder.h"

#include "bzlib.h"

#include "wine/wine.h"

#if defined (__cplusplus)
extern "C" {
#endif // defined (__cplusplus)

MULTIFILEENCODER_Export
int InitEncode (const char* a_file_name, void*& a_handle) {
	return (((a_handle = BZ2_bzopen (a_file_name, "wb")) == 0) ? (-1) : (0));
}

MULTIFILEENCODER_Export
int EncodeData (void* a_handle, const void* a_buffer, const size_t a_size) {
	return (BZ2_bzwrite (a_handle, const_cast <void*> (a_buffer), a_size));
}

MULTIFILEENCODER_Export
void DoneEncode (void*& a_handle) {
	(BZ2_bzclose (a_handle), a_handle = 0);
}

#if defined (__cplusplus)
}
#endif // defined (__cplusplus)
