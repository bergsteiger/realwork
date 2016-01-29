// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarImageComboEditor.pas' rev: 6.00

#ifndef dxBarImageComboEditorHPP
#define dxBarImageComboEditorHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBarExtItems.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
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

namespace Dxbarimagecomboeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TdxBarImageComboEditorForm;
class PASCALIMPLEMENTATION TdxBarImageComboEditorForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* ButtonOk;
	Stdctrls::TButton* ButtonCancel;
	Stdctrls::TButton* ButtonAdd;
	Stdctrls::TButton* ButtonDelete;
	Grids::TStringGrid* Grid;
	Stdctrls::TButton* ButtonInsert;
	void __fastcall ButtonAddClick(System::TObject* Sender);
	void __fastcall ButtonInsertClick(System::TObject* Sender);
	void __fastcall ButtonDeleteClick(System::TObject* Sender);
	void __fastcall GridDrawCell(System::TObject* Sender, int Col, int Row, const Types::TRect &Rect, Grids::TGridDrawState State);
	void __fastcall GridSelectCell(System::TObject* Sender, int Col, int Row, bool &CanSelect);
	void __fastcall GridSetEditText(System::TObject* Sender, int ACol, int ARow, const AnsiString Value);
	void __fastcall GridGetEditText(System::TObject* Sender, int ACol, int ARow, AnsiString &Value);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall GridKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	
private:
	Dxbarextitems::TdxBarImageCombo* FCombo;
	AnsiString FPrevCellText;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TdxBarImageComboEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TdxBarImageComboEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TdxBarImageComboEditorForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarImageComboEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall dxBarImageComboEdit(Dxbarextitems::TdxBarImageCombo* ACombo);

}	/* namespace Dxbarimagecomboeditor */
using namespace Dxbarimagecomboeditor;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarImageComboEditor
