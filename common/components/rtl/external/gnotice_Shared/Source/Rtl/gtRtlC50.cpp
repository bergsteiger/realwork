//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtRtlC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEUNIT("gtClasses.pas");
USEUNIT("gtConsts.pas");
USEUNIT("gtUtils.pas");
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
