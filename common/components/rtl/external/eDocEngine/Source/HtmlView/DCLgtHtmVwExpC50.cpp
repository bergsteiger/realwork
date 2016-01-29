//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DCLgtHtmVwExpC50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("gtHtmVwExpReg.pas");
USERES("gtHtmVwExpReg.dcr");
USEPACKAGE("gtHtmVwExpC50.bpi");
USEPACKAGE("FrameViewer5.bpi");
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
