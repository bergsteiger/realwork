// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElStyleManProp.pas' rev: 6.00

#ifndef ElStyleManPropHPP
#define ElStyleManPropHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ElTreeTreeComboEdit.hpp>	// Pascal unit
#include <ElTreeColorCombo.hpp>	// Pascal unit
#include <ElTreeBtnEdit.hpp>	// Pascal unit
#include <ElTreeSpinEdit.hpp>	// Pascal unit
#include <ElTreeMemoEdit.hpp>	// Pascal unit
#include <ElTreeDTPickEdit.hpp>	// Pascal unit
#include <ElTreeComboBox.hpp>	// Pascal unit
#include <ElSplit.hpp>	// Pascal unit
#include <ElLabel.hpp>	// Pascal unit
#include <ElCLabel.hpp>	// Pascal unit
#include <ElBtnCtl.hpp>	// Pascal unit
#include <ElCombos.hpp>	// Pascal unit
#include <ElPanel.hpp>	// Pascal unit
#include <ElToolBar.hpp>	// Pascal unit
#include <ElPopBtn.hpp>	// Pascal unit
#include <ElTreeGrids.hpp>	// Pascal unit
#include <ElTree.hpp>	// Pascal unit
#include <ElVCLUtils.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ElStyleMan.hpp>	// Pascal unit
#include <ElPromptDlg.hpp>	// Pascal unit
#include <ElTreeStdEditors.hpp>	// Pascal unit
#include <ElClrCmb.hpp>	// Pascal unit
#include <ElInputDlg.hpp>	// Pascal unit
#include <ElHeader.hpp>	// Pascal unit
#include <ElTools.hpp>	// Pascal unit
#include <frmStyleImageSelect.hpp>	// Pascal unit
#include <ElUnicodeStrings.hpp>	// Pascal unit
#include <ElEdits.hpp>	// Pascal unit
#include <ElXPThemedControl.hpp>	// Pascal unit
#include <ElFrmPers.hpp>	// Pascal unit
#include <ElStrUtils.hpp>	// Pascal unit
#include <ElIni.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <DsnConst.hpp>	// Pascal unit
#include <DesignWindows.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
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

namespace Elstylemanprop
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TStyleManEditDialog;
class DELPHICLASS TElPropListItem;
class PASCALIMPLEMENTATION TStyleManEditDialog : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Dialogs::TOpenDialog* OpenDialog;
	Dialogs::TSaveDialog* SaveDialog;
	Eltoolbar::TElToolBar* ElToolBar1;
	Eltoolbar::TElToolButton* btnLoadFromFile;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Eltoolbar::TElToolButton* btnSaveToFile;
	Eltoolbar::TElToolButton* ElToolButton3;
	Eltoolbar::TElToolButton* btnAddStyle;
	Eltoolbar::TElToolButton* btnAddProp;
	Eltoolbar::TElToolButton* btnDelete;
	Eltoolbar::TElToolButton* ElToolButton7;
	Elpanel::TElPanel* LeftPanel;
	Elsplit::TElSplitter* ElSplitter1;
	Eltreegrids::TElTreeStringGrid* gridProps;
	Elpanel::TElPanel* ElPanel2;
	Eltreegrids::TElTreeStringGrid* gridStyles;
	Ellabel::TElLabel* ElLabel1;
	Ellabel::TElLabel* ElLabel2;
	Eltreecombobox::TElTreeInplaceComboBox* inpComboEnum;
	Eltreecombobox::TElTreeInplaceComboBox* inpComboBoolean;
	Eltreestdeditors::TElTreeInplaceEdit* inpEditText;
	Eltreespinedit::TElTreeInplaceSpinEdit* inpEditInt;
	Eltreespinedit::TElTreeInplaceFloatSpinEdit* inpEditFloat;
	Eltreecolorcombo::TElTreeInplaceColorCombo* inpComboColor;
	Eltreetreecomboedit::TElTreeInplaceTreeComboEdit* inpComboSet;
	Elfrmpers::TElFormPersist* ElFormPersist1;
	Elini::TElIniFile* ElIniFile1;
	Eltreebtnedit::TElTreeInplaceButtonEdit* inpEditImage;
	Eltreedtpickedit::TElTreeInplaceDateTimePicker* inpDTPick;
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall gridPropsItemFocused(System::TObject* Sender);
	void __fastcall gridStylesItemFocused(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall gridPropsDblClick(System::TObject* Sender);
	void __fastcall btnAddPropClick(System::TObject* Sender);
	void __fastcall gridStylesInplaceEditorNeeded(System::TObject* Sender, Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltree::TElTreeInplaceEditor* &Editor);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall inpComboBooleanBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpComboBooleanAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboColorAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboColorBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpDTPickAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpDTPickBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditFloatBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditFloatAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpEditIntBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditIntAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpEditTextBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditTextAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboEnumAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboEnumBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpComboSetBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpComboSetAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall btnAddStyleClick(System::TObject* Sender);
	void __fastcall inpEditImageBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditImageAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall ImageButtonClick(System::TObject* Sender);
	void __fastcall gridStylesCompareItems(System::TObject* Sender, Eltree::TElTreeItem* Item1, Eltree::TElTreeItem* Item2, int &res);
	
private:
	Elstyleman::TElStyleManager* FStyleManager;
	Classes::TStringList* SL;
	Eltree::TElTreeItem* RootStyleItem;
	Classes::TMemoryStream* ImageStream;
	
protected:
	void __fastcall AddProperty(void);
	AnsiString __fastcall GetDisplayValue(AnsiString StyleName, TElPropListItem* Item);
	void __fastcall inpComboSetItemChecked(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall UpdateButtons(void);
	
public:
	void __fastcall SetData(Elstyleman::TElStyleManager* StyleManager);
	void __fastcall GetData(Elstyleman::TElStyleManager* StyleManager);
	void __fastcall SetDataFromStyles(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TStyleManEditDialog(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TStyleManEditDialog(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TStyleManEditDialog(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TStyleManEditDialog(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TElStyleManEditor;
class PASCALIMPLEMENTATION TElStyleManEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TElStyleManEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TElStyleManEditor(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TElPropListItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
protected:
	AnsiString FPropertyName;
	Typinfo::TTypeKind FTypeKind;
	AnsiString FTypeName;
	AnsiString FAClassName;
	
public:
	__property AnsiString PropertyName = {read=FPropertyName, write=FPropertyName};
	__property Typinfo::TTypeKind TypeKind = {read=FTypeKind, write=FTypeKind, nodefault};
	__property AnsiString TypeName = {read=FTypeName, write=FTypeName};
	__property AnsiString AClassName = {read=FAClassName, write=FAClassName};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TElPropListItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TElPropListItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TElPropListCollection;
class PASCALIMPLEMENTATION TElPropListCollection : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TElPropListItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TStringList* FExclusions;
	
protected:
	TElPropListItem* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TElPropListItem* Value);
	bool __fastcall PropertyExcluded(AnsiString PropName);
	
public:
	HIDESBASE TElPropListItem* __fastcall Add(void);
	__fastcall TElPropListCollection(void);
	TElPropListItem* __fastcall FindItemByName(const AnsiString Name);
	__fastcall virtual ~TElPropListCollection(void);
	void __fastcall ExcludeProperty(AnsiString PropName);
	__property TElPropListItem* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TElPropListCollection* PropList;
extern PACKAGE void __fastcall RegisterStyleMgrClass(TMetaClass* AnObject, AnsiString Prefix);

}	/* namespace Elstylemanprop */
using namespace Elstylemanprop;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElStyleManProp
