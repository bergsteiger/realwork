#include <_defs.h>

namespace ms_api
{
    struct exception_record;
}

/**
   This is a routine pointer setup in the Delphi RTL to allocate a Delphi exception
   object for OS exceptions.  If it is non-null, we can use it.  If VCL is linked in
   this definition will be shadowed by the Delphi RTL.  We just define it here so
   that users will not get unresolved externs if they don't link the Delphi RTL.
*/
typedef void *(*ExceptObjProc_t)(ms_api::exception_record *excRec);
namespace System {
    _RTLENTRY ExceptObjProc_t ExceptObjProc = 0;
}
