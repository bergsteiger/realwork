//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DCLgtQRExpC50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("gtQRExpReg.pas");
USERES("gtQRExpReg.dcr");
USEPACKAGE("gtQRExpC50.bpi");
USEPACKAGE("VCLJPG50.bpi");
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
