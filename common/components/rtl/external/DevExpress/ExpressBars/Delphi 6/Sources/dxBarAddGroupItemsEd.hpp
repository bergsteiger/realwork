// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarAddGroupItemsEd.pas' rev: 6.00

#ifndef dxBarAddGroupItemsEdHPP
#define dxBarAddGroupItemsEdHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
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

namespace Dxbaraddgroupitemsed
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmAddGroupItems;
class PASCALIMPLEMENTATION TfrmAddGroupItems : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel2;
	Extctrls::TPanel* Panel3;
	Extctrls::TPanel* Panel4;
	Stdctrls::TListBox* lbGroupItems;
	Extctrls::TPanel* Panel1;
	Extctrls::TPanel* Panel5;
	Stdctrls::TButton* btnOk;
	Stdctrls::TButton* btnCancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall lbGroupItemsDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall lbGroupItemsMeasureItem(Controls::TWinControl* Control, int Index, int &Height);
	
private:
	Dxbar::TdxBarGroup* FGroup;
	Classes::TWndMethod PrevListBoxWndProc;
	void __fastcall SetGroup(Dxbar::TdxBarGroup* Value);
	void __fastcall ListBoxWndProc(Messages::TMessage &Message);
	
public:
	Classes::TList* GroupItems;
	__property Dxbar::TdxBarGroup* Group = {read=FGroup, write=SetGroup};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmAddGroupItems(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmAddGroupItems(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmAddGroupItems(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmAddGroupItems(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall dxBarChooseGroupItem(Dxbar::TdxBarGroup* AGroup, Classes::TList* AGroupItems);

}	/* namespace Dxbaraddgroupitemsed */
using namespace Dxbaraddgroupitemsed;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarAddGroupItemsEd
