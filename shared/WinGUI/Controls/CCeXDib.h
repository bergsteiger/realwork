////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Controls/CCeXDib.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Controls::CCeXDib
//
// класс для поддержки расширенных графиеских эффектов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_CONTROLS_CCEXDIB_H__
#define __SHARED_WINGUI_CONTROLS_CCEXDIB_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4700B8F90119_CUSTOM_INCLUDES*
#ifndef	HDIB
#define HDIB	HANDLE
#endif

#ifndef WIDTHBYTES
#define WIDTHBYTES(bits)    (((bits) + 31) / 32 * 4)
#endif

#ifndef BFT_BITMAP
#define BFT_BITMAP 0x4d42   // 'BM'
#endif
//#UC END# *4700B8F90119_CUSTOM_INCLUDES*

namespace WinGUI {

// класс для поддержки расширенных графиеских эффектов
class CCeXDib {
	SET_OBJECT_COUNTER (CCeXDib)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~CCeXDib ();


//#UC START# *4700B8F90119*
public:
	CCeXDib();

	HDIB Create(DWORD dwWidth, DWORD dwHeight, WORD wBitCount);
	void Clone(CCeXDib* src);
	void Draw(HDC hDC, DWORD dwX, DWORD dwY);
	void Copy(HDC hDC, DWORD dwX, DWORD dwY);
	LPBYTE GetBits();
	void Clear(BYTE byVal = 0);

	void SetGrayPalette();
	void SetPaletteIndex(BYTE byIdx, BYTE byR, BYTE byG, BYTE byB);
	void SetPixelIndex(DWORD dwX, DWORD dwY, BYTE byI);
	void BlendPalette(COLORREF crColor, DWORD dwPerc);

	WORD GetBitCount();
	DWORD GetLineWidth();
	DWORD GetWidth();
	DWORD GetHeight();
	WORD GetNumColors();

	BOOL WriteBMP(LPCTSTR bmpFileName);

private:
	void FreeResources();

	DWORD GetPaletteSize();
	DWORD GetSize();

	RGBQUAD RGB2RGBQUAD(COLORREF cr);

	HDIB				m_hDib;
    BITMAPINFOHEADER    m_bi;
	DWORD				m_dwLineWidth;
	WORD				m_wColors;

	HBITMAP				m_hBitmap;	// Handle to bitmap
	HDC					m_hMemDC;	// Handle to memory DC
	LPVOID				m_lpBits;	// Pointer to actual bitmap bits
//#UC END# *4700B8F90119*
}; // class CCeXDib

} // namespace WinGUI


#endif //__SHARED_WINGUI_CONTROLS_CCEXDIB_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

