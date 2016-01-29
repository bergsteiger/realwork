//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dceldbB5.res");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLDB50.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("elpackB5.bpi");
USEPACKAGE("elpkdbB5.bpi");
USEUNIT("ElDBReg.pas");
USEUNIT("Design\ElDbNavDsgn.pas");
USEUNIT("Design\ElDBTreeDsgn.pas");
USEUNIT("Design\ElDBTreeGridDsgn.pas");
USEUNIT("Design\RelSourcePropDsgn.pas");
USEFORMNS("Design\frmGridColProp.pas", frmGridColProp, TColumnDefs);
USEFORMNS("Design\frmStylesProp.pas", frmStylesProp, TStylesPropDlg);

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

