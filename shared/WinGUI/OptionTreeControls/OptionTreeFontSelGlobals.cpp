////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/OptionTreeFontSelGlobals.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::WinGUI::OptionTreeControls::OptionTreeFontSelGlobals
// Файл реализации утилитного набора OptionTreeFontSelGlobals
//
// вспомогательные функции для выбора шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeFontSelGlobals.h"

//#UC START# *470AFF7B02DE_CUSTOM_INCLUDES*
#include "afxdisp.h"

BOOL _AfxStringFromCy(CString& str, CY& cy)
{
	VARIANTARG varCy;
	VARIANTARG varBstr;
	AfxVariantInit(&varCy);
	AfxVariantInit(&varBstr);
	V_VT(&varCy) = VT_CY;
	V_CY(&varCy) = cy;
	if (FAILED(VariantChangeType(&varBstr, &varCy, 0, VT_BSTR)))
	{
		VariantClear(&varCy);
		VariantClear(&varBstr);
		return FALSE;
	}
	str = V_BSTR(&varBstr);
	VariantClear(&varCy);
	VariantClear(&varBstr);
	return TRUE;
}

BOOL _AfxCyFromString(CY& cy, LPCTSTR psz)
{
	USES_CONVERSION;

	VARIANTARG varBstr;
	VARIANTARG varCy;
	AfxVariantInit(&varBstr);
	AfxVariantInit(&varCy);
	V_VT(&varBstr) = VT_BSTR;
	V_BSTR(&varBstr) = SysAllocString(T2COLE(psz));
	if (FAILED(VariantChangeType(&varCy, &varBstr, 0, VT_CY)))
	{
		VariantClear(&varBstr);
		VariantClear(&varCy);
		return FALSE;
	}
	cy = V_CY(&varCy);
	VariantClear(&varBstr);
	VariantClear(&varCy);
	return TRUE;
}

void _AfxDrawMaskedBitmap(CDC* pDC, CBitmap* pbmp, CBitmap* pbmpMask, int x, int y, int cx, int cy)
{
	COLORREF oldBkColor = pDC->SetBkColor(RGB(255, 255, 255));
	COLORREF oldTextColor = pDC->SetTextColor(RGB(0, 0, 0));

	CDC dcCompat;
	dcCompat.CreateCompatibleDC(pDC);
	CBitmap* pbmpSave = dcCompat.SelectObject(pbmp);
	pDC->BitBlt(x, y, cx, cy, &dcCompat, 0, 0, DSx);
	dcCompat.SelectObject(pbmpMask);
	pDC->BitBlt(x, y, cx, cy, &dcCompat, 0, 0, DSna);
	dcCompat.SelectObject(pbmp);
	pDC->BitBlt(x, y, cx, cy, &dcCompat, 0, 0, DSx);
	dcCompat.SelectObject(pbmpSave);

	pDC->SetBkColor(oldBkColor);
	pDC->SetTextColor(oldTextColor);
}

void _AfxInitMaskFromBitmap(CBitmap* pbmp, CBitmap* pbmpMask)
{
	BITMAP bmp;
	pbmp->GetObject(sizeof (BITMAP), &bmp);
	pbmpMask->CreateBitmap(bmp.bmWidth, bmp.bmHeight, 1, 1, NULL);

	CDC dcDst;
	dcDst.CreateCompatibleDC(NULL);
	CDC dcSrc;
	dcSrc.CreateCompatibleDC(NULL);
	CBitmap* pOldDst = dcDst.SelectObject(pbmpMask);
	CBitmap* pOldSrc = dcSrc.SelectObject(pbmp);

	COLORREF oldBkColor = dcSrc.SetBkColor(dcSrc.GetPixel(0, 0));
	dcDst.BitBlt(0, 0, bmp.bmWidth, bmp.bmHeight, &dcSrc, 0, 0, NOTSRCCOPY);
	dcSrc.SetBkColor(oldBkColor);

	dcDst.SelectObject(pOldDst);
	dcSrc.SelectObject(pOldSrc);
}
//#UC END# *470AFF7B02DE_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470AFF7B02DE*
//#UC END# *470AFF7B02DE*

} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

