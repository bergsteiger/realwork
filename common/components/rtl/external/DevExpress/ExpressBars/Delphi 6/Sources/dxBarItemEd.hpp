// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarItemEd.pas' rev: 6.00

#ifndef dxBarItemEdHPP
#define dxBarItemEdHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
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

namespace Dxbaritemed
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TdxBarItemAddEditor;
class PASCALIMPLEMENTATION TdxBarItemAddEditor : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* LName;
	Stdctrls::TLabel* LCaption;
	Stdctrls::TLabel* LType;
	Stdctrls::TLabel* LCategory;
	Stdctrls::TEdit* Edit1;
	Stdctrls::TEdit* Edit2;
	Stdctrls::TComboBox* ComboBox1;
	Stdctrls::TComboBox* ComboBox2;
	Stdctrls::TButton* BOk;
	Stdctrls::TButton* BCancel;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ComboBox1Click(System::TObject* Sender);
	void __fastcall BOkClick(System::TObject* Sender);
	
private:
	Dxbar::TdxBarItem* ABarItem;
	Dxbar::TdxBarManager* BarManager;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TdxBarItemAddEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TdxBarItemAddEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TdxBarItemAddEditor(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarItemAddEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Dxbar::TdxBarItem* __fastcall dxBarItemAddEditor(Dxbar::TdxBarManager* ABarManager, int ACategoryIndex);

}	/* namespace Dxbaritemed */
using namespace Dxbaritemed;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarItemEd
