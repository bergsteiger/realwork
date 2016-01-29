////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/OptionTreeFontSelGlobals.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::WinGUI::OptionTreeControls::OptionTreeFontSelGlobals
//
// вспомогательные функции для выбора шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_OPTIONTREEFONTSELGLOBALS_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_OPTIONTREEFONTSELGLOBALS_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *470AFF7B02DE_USER_INCLUDES*
#include <atlconv.h>
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

// Definitions
#define DX_BITMAP        20
#define DY_BITMAP        12
#define DSx				0x00660046L
#define DSna			0x00220326L
#ifndef _countof
	#define _countof(array) (sizeof(array)/sizeof(array[0]))
#endif
AFX_STATIC_DATA int _afxTTDefaults[] = { 8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72};

// Stores all the information about a font
typedef struct OT_FONTSEL_OBJECT
{
	CString strName;
	CY  cySize;
	BOOL bBold;
	BOOL bItalic;
	BOOL bUnderline;
	BOOL bStrikethrough;
	short sWeight;
} FONTOBJECT;

// Merge objects are used when trying to consolidate multiple font properties.
// If the characteristics of these multiple properties differ then this is
// represented in the merge object.
typedef struct OT_FONTSEL_MERGEOBJECT
{
	BOOL bNameOK;
	BOOL bSizeOK;
	BOOL bStyleOK;
	BOOL bUnderlineOK;
	BOOL bStrikethroughOK;
} MERGEOBJECT;

BOOL _AfxStringFromCy(CString& str, CY& cy);
BOOL _AfxCyFromString(CY& cy, LPCTSTR psz);
void _AfxDrawMaskedBitmap(CDC* pDC, CBitmap* pbmp, CBitmap* pbmpMask, int x, int y, int cx, int cy);
void _AfxInitMaskFromBitmap(CBitmap* pbmp, CBitmap* pbmpMask);
//#UC END# *470AFF7B02DE_USER_INCLUDES*

namespace WinGUI {

//#UC START# *470AFF7B02DE_USER_DEFINITION*
//#UC END# *470AFF7B02DE_USER_DEFINITION*

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_OPTIONTREEFONTSELGLOBALS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
