// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarNameEd.pas' rev: 6.00

#ifndef dxBarNameEdHPP
#define dxBarNameEdHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
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

namespace Dxbarnameed
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TdxBarNameEd;
class PASCALIMPLEMENTATION TdxBarNameEd : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TEdit* EName;
	Stdctrls::TButton* BOK;
	Stdctrls::TButton* BCancel;
	Stdctrls::TLabel* LName;
	void __fastcall ENameChange(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
public:
	int Kind;
	Dxbar::TdxBarManager* BarManager;
	Dxbar::TdxBar* Bar;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TdxBarNameEd(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TdxBarNameEd(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TdxBarNameEd(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarNameEd(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall dxBarEditName(AnsiString &AName, int Kind1, int Kind2, Dxbar::TdxBarManager* ABarManager, Dxbar::TdxBar* ABar);

}	/* namespace Dxbarnameed */
using namespace Dxbarnameed;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarNameEd
