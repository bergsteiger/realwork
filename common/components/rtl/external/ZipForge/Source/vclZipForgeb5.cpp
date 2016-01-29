//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("vclZipForgeb5.res");
USEUNIT("ZFZlib.pas");
 
 
USEUNIT("ZFConst.pas");
 
 
USEUNIT("ZFExcept.pas");
USEUNIT("ZFFolderDialog.pas");
USEUNIT("ZFStrFunc.pas");
USEUNIT("ZipForge.pas");
USERES("ZipForge.dcr");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
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
