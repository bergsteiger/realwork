//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("impallc3.res");
USEPACKAGE("vcl35.bpi");
USEUNIT("impreg.pas");
USEPACKAGE("vcldb35.bpi");
USEPACKAGE("qrpt35.bpi");
USEPACKAGE("vclmid35.bpi");
USEPACKAGE("vcldbx35.bpi");
USEPACKAGE("dcctc3.bpi");
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
