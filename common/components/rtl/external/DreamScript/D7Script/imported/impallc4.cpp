//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("impallc4.res");
USEPACKAGE("vcl40.bpi");
USEUNIT("impreg.pas");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("qrpt40.bpi");
USEPACKAGE("vclmid40.bpi");
USEPACKAGE("vcldbx40.bpi");
USEPACKAGE("vclx40.bpi");
USEPACKAGE("dcctc4.bpi");
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
