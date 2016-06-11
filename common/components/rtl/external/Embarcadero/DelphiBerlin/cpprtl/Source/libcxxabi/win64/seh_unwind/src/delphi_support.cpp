#include "ms_api.hpp"

#include "delphi_support.h"

#define POINTER_ADD(P,I) (((char *)(P)) + (I))

static delphi_vmt_t const *get_vmt(void const *o) {
//    return (delphi_vmt_t const *)((char *)(*(char **)o) - sizeof(delphi_vmt_t));
    return (delphi_vmt_t const *)POINTER_ADD(*(char **)o, -sizeof(delphi_vmt_t));
}

void const*get_delphi_type_from_object(void const *o) {
    delphi_vmt_t const *vmt = get_vmt(o);
    return (void const *)POINTER_ADD(vmt->vmtTypeInfo, -sizeof(void *));
}

/**
   This function has to work with a reference to a delphi type that is potentially in a DLL.
   Delphi types start with a builtin indirection cell.  When imported from a DLL, the indirection
   cell that we will see is not that indirection cell, but an entry in the Import Address Table perhaps.
   Therefore, we indirect once to get to the type body, and then back up _that_ pointer to see if
   there is an indirection cell at the front of the body that points to the body.  C++ type info
   objects start with a pointer to a string, so if we have one of those, we'll end up pointing
   to the string, and the only way this will return true is if there is a pointer immediately
   preceeding the string that points to that string.  There are theoretical risks with doing
   the test this way.  The string could be the first item in a segment in the image, and backing
   up a pointer's length would yield an invalid pointer.  In practice, this will never occur, because
   there is always RTL data before any typeinfo.  The second problem would be if the C++ compiler
   ever emitted a C++ type info whose string data immediately followed the type info object.  The
   compiler doesn't ever do this.
 */
bool is_delphi_type(void const *p) {
    void const *ti = *(void const**)p; // indirect once to get to what would be actual RTTI.
    // note: for C++ non-delphi type-infos, ti will now point to a string (the name of the type)
    void const **pti = (void const**)POINTER_ADD(ti, -sizeof(void *)); // and back up over what would be the leading indirection cell
    return *pti == ti; // if the indirection cell points to the next addr, it's a delphi type info
}

#define get_b(p,n) (*(((const char *)(p)) + (n)))

#define tkClass 7
struct ClassTypeInfo {
    void *ClassType;
    void **ParentInfo;
// more stuff follows, but we don't care
};

#if 0
#include <string.h>
#include <stdio.h>
static void print_type_name(void const *tp) {
    char buff[256];
    strncpy(buff, (const char *)POINTER_ADD(tp, 2), get_b(tp, 1));
    buff[get_b(tp, 1)] = '\0';
    printf("%s", buff);
}
#endif

bool compare_delphi_types(void const *src, void const *dest) {
    src = *(void const **)src;
    dest = *(void const **)dest;

//    printf("comparing delphi types %p and %p\n", src, dest);
//    printf("  type name of dest: "); print_type_name(dest); printf("\n");
    /*
      If they are not the same, then we start trying to match hierarchy.  We walk up the parent chain
      of the src type, comparing it to the dest type.  We don't walk the dest type.
     */
    char const *t = (char const *)src;
    while (true) {
//	printf("  type name of src: "); print_type_name(t); printf("\n");
	if (t == dest)
	    return true;
	int len = get_b(t, 1); // get the name len
	t += len + 2;
	ClassTypeInfo const *cti = (ClassTypeInfo const *)t;
	if (!cti->ParentInfo)
	    return false;
	t = (char const *)(*cti->ParentInfo);
    }
}

extern "C" _EXPFUNC void __throw_as_delphi(void *exception, void *addr) {
    ms_api::exception_record new_exc;
    new_exc.ExceptionInformation[0] = (ULONG_PTR)addr;
    new_exc.ExceptionInformation[1] = (ULONG_PTR)exception;
    new_exc.ExceptionInformation[2] = 0;
    new_exc.ExceptionInformation[3] = 0;
    new_exc.ExceptionInformation[4] = 0;
    new_exc.ExceptionInformation[5] = 0;
    new_exc.ExceptionInformation[6] = 0;
    RaiseException(
	ms_api::delphi_throw_code,
	ms_api::exception_noncontinuable,
	7, new_exc.ExceptionInformation);
}

static dtor_t get_delphi_dtor(void const *obj) {
    delphi_vmt_t const *vmt = get_vmt(obj);
    return (dtor_t)vmt->vmtDestroy;
}

void destroy_delphi_exception(void *exc) {
    ms_api::exception_record *x_rec = (ms_api::exception_record *)exc;
    void *obj = ms_api::get_delphi_exception(*x_rec);
    (get_delphi_dtor(obj))(obj, 3);
}
