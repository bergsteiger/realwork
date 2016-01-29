// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarCommon.pas' rev: 6.00

#ifndef dxBarCommonHPP
#define dxBarCommonHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
#include <dxCommon.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxbarcommon
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall DrawCloseButton(HDC DC, Types::TRect &ARect, bool Selected, bool Pressed, bool Flat, Dxcommon::TdxCorner ACorner);
extern PACKAGE void __fastcall dxBarPopupNCCalcSize(HWND Handle, Types::TRect &ARect, Dxcommon::TdxCorner &Corner, Dxbar::TdxBarItem* Combo, bool AllowResizing);
extern PACKAGE void __fastcall dxBarPopupNCPaint(HWND Handle, bool AllowResizing, bool Flat, bool MouseAboveCloseButton, bool CloseButtonIsTracking, Types::TRect &CloseButtonRect, Types::TRect &GripRect, Dxcommon::TdxCorner Corner);

}	/* namespace Dxbarcommon */
using namespace Dxbarcommon;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarCommon
