#include <stddef.h>

namespace System
{
    typedef void* Pointer;
    typedef ssize_t NativeInt;
    typedef size_t  NativeUInt;

    class TMemoryManagerEx {
      public:
            Pointer __fastcall (*GetMem)(NativeInt Size);
            int     __fastcall (*FreeMem)(Pointer P);
            Pointer __fastcall (*ReallocMem)(Pointer P, NativeInt Size);
            Pointer __fastcall (*AllocMem)(NativeInt Size);
            bool    __fastcall (*RegisterExpectedMemoryLeak)(Pointer P);
            bool    __fastcall (*UnregisterExpectedMemoryLeak)(Pointer P);
    } ;

    struct THeapStatus
    {
      NativeUInt TotalAddrSpace;
      NativeUInt TotalUncommitted;
      NativeUInt TotalCommitted;
      NativeUInt TotalAllocated;
      NativeUInt TotalFree;
      NativeUInt FreeSmall;
      NativeUInt FreeBig;
      NativeUInt Unused;
      NativeUInt Overhead;
      NativeUInt HeapErrorCode;
    };


    void*   __cdecl GetMemory(NativeInt Size);
    void*   __cdecl AllocMemory(NativeInt Size);
    int     __cdecl FreeMemory(void*  P);
    void*   __cdecl ReallocMemory(void*  P, NativeInt Size);
    void    __fastcall initialization (void);
    void    __fastcall Finalization (void);
    void    __fastcall SetMemoryManager (const System::TMemoryManagerEx&);
    void    __fastcall GetMemoryManager (System::TMemoryManagerEx&);
    bool    __fastcall IsMemoryManagerSet(void);
    THeapStatus __fastcall GetHeapStatus(void);

}

namespace Borlndmm
{
    void*   __fastcall SysGetMem(size_t Size);
    void*   __fastcall SysAllocMem(size_t Size);
    int     __fastcall SysFreeMem(void*  P);
    void*   __fastcall SysReallocMem(void*  P, size_t Size);
}
