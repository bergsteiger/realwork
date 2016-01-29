//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcctc3.res");
USEPACKAGE("vcl35.bpi");
USEUNIT("dcreg.pas");
USEPACKAGE("vcldbx35.bpi");
USEPACKAGE("vcldb35.bpi");
USEPACKAGE("vclx35.bpi");
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
