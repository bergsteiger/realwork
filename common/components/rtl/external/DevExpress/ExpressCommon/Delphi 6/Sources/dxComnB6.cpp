//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("dxrgkeya.pas", Dxrgkeya, frmdxAddNewRegKey);
USEFORMNS("dxreged.pas", Dxreged, frmdxLibREgPathEditor);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
