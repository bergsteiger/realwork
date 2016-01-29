//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DCLgtDocProdC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("gtDocProdC50.bpi");
USEUNIT("gtDocProdReg.pas");
USERES("gtDocProdReg.dcr");
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
