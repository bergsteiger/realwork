#ifndef DELPHI_SUPPORT_H
#define DELPHI_SUPPORT_H

#if defined(_WIN64)
// In Win32, we do not include the 3 C++ ABI pointers in the Delphi VMTs
#define USE_FULL_CXX_ABI
#endif

struct delphi_vmt_t {
    void *vmtSelfPtr;
    void *vmtIntfTable;
    void *vmtAutoTable;
    void *vmtInitTable;
    void *vmtTypeInfo;
    void *vmtFieldTable;
    void *vmtMethodTable;
    void *vmtDynamicTable;
    void *vmtClassName;
    void *vmtInstanceSize;
    void *vmtParent;
#ifdef DELPHI_ARC_SUPPORT
    void *vmtObjAddRef;
    void *vmtObjRelease;
#endif
    void *vmtEquals;
    void *vmtGetHashCode;
    void *vmtToString;
    void *vmtSafeCallException;
    void *vmtAfterConstruction;
    void *vmtBeforeDestruction;
    void *vmtDispatch;
    void *vmtDefaultHandler;
    void *vmtNewInstance;
    void *vmtFreeInstance;
    void *vmtDestroy;
#ifdef USE_FULL_CXX_ABI
    void *cpp_abi1;
    void *cpp_abi2;
    void *cpp_abi3;
#endif // USE_FULL_CXX_ABI
};

struct delphi_object_t {
    delphi_vmt_t const *middle_of_vmt;
};

/**
   Returns true if the pointer pass in is an indirection cell that points to
   a Delphi type info object.
 */
bool is_delphi_type(void const*p);

/**
   Returns true if the src type info matches the dest type info.  The src type may be
   derived from the dest type.  The two types are assumed to be Delphi types, per
   is_delphi_type, and must further be class types.
 */
bool compare_delphi_types(void const *src, void const *dest);

/**
   Returns the Delphi type info from a Delphi class instance.
 */
void const*get_delphi_type_from_object(void const *o);

/**
   Throws a Delphi object as a Delphi language exception.

   You can use this when it is possible that the exception will need to be
   caught on the Delphi side of the RTL.  The Delphi RTL could be coded to
   understand C++ exceptions to the extent that it could extract the Delphi
   object from the C++ exception record, but the way we do it here keeps
   this all on one side of the language house, and a little easier to manage.
 */
extern "C" void __throw_as_delphi(void *exception, void *addr);

#if defined(__WIN32__)
typedef void __fastcall (*dtor_t)(void*, char);
#else
typedef void (*dtor_t)(void*, char);
#endif

/**
   Returns the destructor for a Delphi object.  The dtor is always available in
   the Delphi vtable, and this function fishes it out.
 */
//dtor_t get_delphi_dtor(void const *obj);

void destroy_delphi_exception(void *exc);

#endif
