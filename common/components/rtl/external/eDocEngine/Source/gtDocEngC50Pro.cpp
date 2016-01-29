//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtDocEngC50Pro.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("gtCompressionC50.bpi");
USEPACKAGE("gtFiltersC50.bpi");
USEPACKAGE("VCLJPG50.bpi");
USEPACKAGE("gtDocEngC50.bpi");
USEPACKAGE("gtRtlC50.bpi");
USEFORMNS("gtDocDlg.pas", Gtdocdlg, gtDocumentDlg);
USEFORMNS("gtGfxDlg.pas", Gtgfxdlg, gtGraphicsDlg);
USEFORMNS("gtPlnDlg.pas", Gtplndlg, gtPlainSheetDlg);
USEFORMNS("gtSpdDlg.pas", Gtspddlg, gtSpreadSheetDlg);
USEFORMNS("gtHTMLEngDlg.pas", Gthtmlengdlg, gtHTMLEngineDlg);
USEUNIT("gtBMPEng.pas");
USEFORMNS("gtBMPEngDlg.pas", Gtbmpengdlg, gtBMPEngineDlg);
USEUNIT("gtClipboard.pas");
USEUNIT("gtCstGfxEng.pas");
USEUNIT("gtCstHTMLEng.pas");
USEUNIT("gtCstPDFEng.pas");
USEUNIT("gtCstPlnEng.pas");
USEUNIT("gtCstSpdEng.pas");
USEUNIT("gtCstXLSEng.pas");
USEUNIT("gtDIFEng.pas");
USEFORMNS("gtDIFEngDlg.pas", Gtdifengdlg, gtDIFEngineDlg);
USEUNIT("gtEMFEng.pas");
USEFORMNS("gtEMFEngDlg.pas", Gtemfengdlg, gtEMFEngineDlg);
USEUNIT("gtGIFEng.pas");
USEFORMNS("gtGIFEngDlg.pas", Gtgifengdlg, gtGIFEngineDlg);
USEUNIT("gtHTMLEng.pas");
USEFORMNS("gtImgPrvwDlg.pas", Gtimgprvwdlg, gtImgPrvwDlg);
USEUNIT("gtJPEGEng.pas");
USEFORMNS("gtJPEGEngDlg.pas", Gtjpegengdlg, gtJPEGEngineDlg);
USEUNIT("gtLotusEng.pas");
USEFORMNS("gtLotusEngDlg.pas", Gtlotusengdlg, gtLotusEngineDlg);
USEUNIT("gtMetafileEng.pas");
USEUNIT("gtPDFEng.pas");
USEFORMNS("gtPDFEngDlg.pas", Gtpdfengdlg, gtPDFEngineDlg);
USEUNIT("gtQProEng.pas");
USEFORMNS("gtQProEngDlg.pas", Gtqproengdlg, gtQuattroProEngineDlg);
USEUNIT("gtRTFEng.pas");
USEFORMNS("gtRTFEngDlg.pas", Gtrtfengdlg, gtRTFEngineDlg);
USEUNIT("gtSLKEng.pas");
USEFORMNS("gtSLKEngDlg.pas", Gtslkengdlg, gtSYLKEngineDlg);
USEUNIT("gtTXTEng.pas");
USEFORMNS("gtTXTEngDlg.pas", Gttxtengdlg, gtTextEngineDlg);
USEUNIT("gtWMFEng.pas");
USEFORMNS("gtWMFEngDlg.pas", Gtwmfengdlg, gtWMFEngineDlg);
USEUNIT("gtXHTMLEng.pas");
USEFORMNS("gtXHTMLEngDlg.pas", Gtxhtmlengdlg, gtXHTMLEngineDlg);
USEUNIT("gtXLSEng.pas");
USEFORMNS("gtXLSEngDlg.pas", Gtxlsengdlg, gtExcelEngineDlg);
USEUNIT("gtExXLSEng.pas");
USEUNIT("gtExPDFEng.pas");
USEUNIT("gtExHTMLEng.pas");
USEUNIT("gtPNGEng.pas");
USEFORMNS("gtPNGEngDlg.pas", Gtpngengdlg, gtPNGEngineDlg);
USEUNIT("gtSVGEng.pas");
USEFORMNS("gtSVGEngDlg.pas", Gtsvgengdlg, gtSVGEngineDlg);
USEUNIT("gtTIFFEng.pas");
USEFORMNS("gtTIFFEngDlg.pas", Gttiffengdlg, gtTIFFEngineDlg);
USEPACKAGE("gtCryptC50.bpi");
USEPACKAGE("gtFontC50.bpi");
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

