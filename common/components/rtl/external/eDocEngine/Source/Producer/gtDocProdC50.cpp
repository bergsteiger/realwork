//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtDocProdC50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("gtDocProducer.pas");
USEPACKAGE("inet50.bpi");
USEPACKAGE("gtDocEngC50.bpi");
USEPACKAGE("GTDOCENGC50PRO.bpi");
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
