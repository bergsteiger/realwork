// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarPopupMenuEd.pas' rev: 6.00

#ifndef dxBarPopupMenuEdHPP
#define dxBarPopupMenuEdHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxbarpopupmenued
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TdxBarSubMenuEditor;
class PASCALIMPLEMENTATION TdxBarSubMenuEditor : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	
private:
	Dxbar::TdxBarItemLinks* FItemLinks;
	int FSubMenuWidth;
	void __fastcall SetItemLinks(Dxbar::TdxBarItemLinks* Value);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TWMGetMinMaxInfo &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMNCLButtonDown(Messages::TWMNCHitMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TdxBarSubMenuEditor(Classes::TComponent* AOwner);
	__property Dxbar::TdxBarItemLinks* ItemLinks = {read=FItemLinks, write=SetItemLinks};
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TdxBarSubMenuEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TdxBarSubMenuEditor(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarSubMenuEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ShowdxBarSubMenuEditor(Dxbar::TdxBarItemLinks* AItemLinks);
extern PACKAGE TdxBarSubMenuEditor* __fastcall dxBarSubMenuEditor(void);

}	/* namespace Dxbarpopupmenued */
using namespace Dxbarpopupmenued;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarPopupMenuEd
