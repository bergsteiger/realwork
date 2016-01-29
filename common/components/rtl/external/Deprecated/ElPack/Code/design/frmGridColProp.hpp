// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmGridColProp.pas' rev: 6.00

#ifndef frmGridColPropHPP
#define frmGridColPropHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <HTMLLbx.hpp>	// Pascal unit
#include <ElPanel.hpp>	// Pascal unit
#include <ElLabel.hpp>	// Pascal unit
#include <ElCLabel.hpp>	// Pascal unit
#include <ElPopBtn.hpp>	// Pascal unit
#include <ElBtnCtl.hpp>	// Pascal unit
#include <ElEdits.hpp>	// Pascal unit
#include <ElACtrls.hpp>	// Pascal unit
#include <ElTreeGrids.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignConst.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <ElTmSchema.hpp>	// Pascal unit
#include <ElUxTheme.hpp>	// Pascal unit
#include <ElXPThemedControl.hpp>	// Pascal unit
#include <ElTreeComboBox.hpp>	// Pascal unit
#include <ElVCLUtils.hpp>	// Pascal unit
#include <ElHeader.hpp>	// Pascal unit
#include <ElTree.hpp>	// Pascal unit
#include <ElDBConst.hpp>	// Pascal unit
#include <ElDBTreeGrids.hpp>	// Pascal unit
#include <ElDBTree.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <ElSpin.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frmgridcolprop
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TElColumnsDefsProperty;
class PASCALIMPLEMENTATION TElColumnsDefsProperty : public Designeditors::TClassProperty 
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TElColumnsDefsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElColumnsDefsProperty(void) { }
	#pragma option pop
	
};


struct TDataRec;
typedef TDataRec *PDataRec;

#pragma pack(push, 4)
struct TDataRec
{
	int ComboIdx;
	AnsiString DataField;
} ;
#pragma pack(pop)

class DELPHICLASS TColumnDefs;
class PASCALIMPLEMENTATION TColumnDefs : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Elpanel::TElPanel* Panel2;
	Ellabel::TElLabel* NLabel1;
	Ellabel::TElLabel* NLabel2;
	Elspin::TElSpinEdit* Edit1;
	Elpanel::TElPanel* Panel4;
	Elpopbtn::TElPopupButton* Button1;
	Elpopbtn::TElPopupButton* Button2;
	Elpopbtn::TElPopupButton* Button3;
	Elpopbtn::TElPopupButton* Button4;
	Eltreegrids::TElTreeStringGrid* Tree;
	Eltreecombobox::TElTreeInplaceComboBox* InplaceCombo;
	Elactrls::TElAdvancedComboBox* DataSetCB;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall DataSetCBChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall TreeItemDeletion(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall TreeItemDraw(System::TObject* Sender, Eltree::TElTreeItem* Item, Graphics::TCanvas* Surface, const Types::TRect &R, int SectionIndex);
	void __fastcall TreeClick(System::TObject* Sender);
	void __fastcall InplaceComboBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall InplaceComboAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	
private:
	int oldvalue;
	
public:
	Classes::TComponent* AComp;
	Eldbtree::TElStylesDefs* DStylesDefs;
	Eldbtree::TElStylesDefsItem* DStylesDefsItem;
	void __fastcall SetValue(void);
	void __fastcall GetValue(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TColumnDefs(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColumnDefs(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColumnDefs(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TColumnDefs(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TColumnDefs* ColumnDefs;

}	/* namespace Frmgridcolprop */
using namespace Frmgridcolprop;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmGridColProp
