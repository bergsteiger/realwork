// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxCommon.pas' rev: 6.00

#ifndef dxCommonHPP
#define dxCommonHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxcommon
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TdxCorner { coTopLeft, coTopRight, coBottomLeft, coBottomRight };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __fastcall dxDropDownNCHeight(void);
extern PACKAGE TdxCorner __fastcall GetCornerForRects(const Types::TRect &EditRect, const Types::TRect &DropDownRect);
extern PACKAGE int __fastcall GetHitTestByCorner(TdxCorner ACorner);
extern PACKAGE void __fastcall DrawCloseButton(HDC DC, Types::TRect &ARect, bool Selected, bool Pressed, TdxCorner ACorner);
extern PACKAGE void __fastcall DrawSizeGrip(HDC DC, Types::TRect &ARect, TdxCorner ACorner);

}	/* namespace Dxcommon */
using namespace Dxcommon;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxCommon
