//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("elpkdbB5.res");
USEUNIT("Source\ElDBBoxes.pas");
USEUNIT("Source\ElDBBtnEdit.pas");
USEUNIT("Source\ElDBCtrls.pas");
USEUNIT("Source\ElDBCurrEdit.pas");
USEUNIT("Source\ElDBDTPick.pas");
USEUNIT("Source\ElDBHTMLView.pas");
USEUNIT("Source\ElDBLbl.pas");
USEUNIT("Source\ElDBSpin.pas");
USEUNIT("Source\ElDBLookupCtrls.pas");
USEUNIT("Source\ElDBWideLookupControls.pas");
USEUNIT("Source\ElDBTree.pas");
USEUNIT("Source\ElDBTreeEditors.pas");
USEUNIT("Source\ElDBTreeGrids.pas");
USEUNIT("Source\ElDBConst.pas");

USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLDB50.bpi");
USEPACKAGE("elpackB5.bpi");
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

