//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcctc4.res");
USEUNIT("dcreg.pas");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldbx40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("vclx40.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
