#if !defined(_WIN64)
#error Only for WIN64
#endif

namespace System 
{
    typedef struct
    {
        void * initFuncAddr;
        void * exitFuncAddr;
    } UnitEntryTable;

    typedef struct
    {
        int TypeCount;
        void * TypeTable;
        int UnitCount;
        void * UnitNames; // PShortString; { concatenation of Pascal strings, one for each unit }
    } PackageTypeInfo;

    typedef struct
    {
        int UnitCount;
        UnitEntryTable * UnitInfo;
        PackageTypeInfo TypeInfo;  // currently set to zero
    } PackageInfoTable;
}

namespace Sysinit
{

    void _PackageLoad(System::PackageInfoTable *);
    void _PackageUnload(System::PackageInfoTable *);
}

extern "C" 
{
    /*
      __PackageInfoTable must land in an initialized data section, as the
      linker will fill in its contents.  So we initialize it here to include
      some non-zero values, to avoid the possibility of the compiler dropping
      it into an uninitialized data section (BSS).
    */
    System::PackageInfoTable __PackageInfoTable = { -1, 0, 0 };

    __declspec(dllexport) void Initialize()
    {
        Sysinit::_PackageLoad(&__PackageInfoTable);
    }

    __declspec(dllexport) void Finalize()
    {
        Sysinit::_PackageUnload(&__PackageInfoTable);
    }

    __declspec(dllexport) System::PackageInfoTable *__GetPackageInfoTable()
    {
        return &__PackageInfoTable;
    }

    void __LinkPackage()
    {
    }
}
