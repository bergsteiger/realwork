//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtQRExpC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("gtDocEngC50.bpi");
USEUNIT("gtQRXportIntf.pas");
USEPACKAGE("VCLJPG50.bpi");
USEPACKAGE("GTRTLC50.bpi");
USEPACKAGE("QR4RunC5.bpi");
USEPACKAGE("gtDocEngC50Pro.bpi");
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
