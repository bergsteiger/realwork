// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarReg.pas' rev: 6.00

#ifndef dxBarRegHPP
#define dxBarRegHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <VCLEditors.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxbarreg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TImageIndexProperty;
class PASCALIMPLEMENTATION TImageIndexProperty : public Designeditors::TIntegerProperty 
{
	typedef Designeditors::TIntegerProperty inherited;
	
private:
	Dxbar::TdxBarManager* __fastcall GetBarManager(void);
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImages(void);
	__property Dxbar::TdxBarManager* BarManager = {read=GetBarManager};
	__property Imglist::TCustomImageList* Images = {read=GetImages};
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
	void __fastcall ListMeasureWidth(const AnsiString Value, Graphics::TCanvas* ACanvas, int &AWidth);
	void __fastcall ListMeasureHeight(const AnsiString Value, Graphics::TCanvas* ACanvas, int &AHeight);
	void __fastcall ListDrawValue(const AnsiString Value, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool ASelected);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TIntegerProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TImageIndexProperty(void) { }
	#pragma option pop
	
private:
	void *__ICustomPropertyListDrawing;	/* Vcleditors::ICustomPropertyListDrawing */
	
public:
	operator ICustomPropertyListDrawing*(void) { return (ICustomPropertyListDrawing*)&__ICustomPropertyListDrawing; }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Dxbarreg */
using namespace Dxbarreg;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarReg
