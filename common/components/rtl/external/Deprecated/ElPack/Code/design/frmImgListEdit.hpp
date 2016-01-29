// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmImgListEdit.pas' rev: 6.00

#ifndef frmImgListEditHPP
#define frmImgListEditHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <StdCtrls.hpp>	// Pascal unit
#include <ElClrCmb.hpp>	// Pascal unit
#include <ElCombos.hpp>	// Pascal unit
#include <ElBtnEdit.hpp>	// Pascal unit
#include <ElEdits.hpp>	// Pascal unit
#include <ElCheckCtl.hpp>	// Pascal unit
#include <ElSplit.hpp>	// Pascal unit
#include <ElStatBar.hpp>	// Pascal unit
#include <ElImgLst.hpp>	// Pascal unit
#include <ElFlatCtl.hpp>	// Pascal unit
#include <ElScrollBox.hpp>	// Pascal unit
#include <ElPanel.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ElPopBtn.hpp>	// Pascal unit
#include <ElBtnCtl.hpp>	// Pascal unit
#include <ElXPThemedControl.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <DsnConst.hpp>	// Pascal unit
#include <DesignWindows.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <ExtDlgs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
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

namespace Frmimglistedit
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TForEachSelectedHandler)(Comctrls::TListItem* Item, int ItemIndex, void * UserData);

class DELPHICLASS TListView;
class PASCALIMPLEMENTATION TListView : public Comctrls::TListView 
{
	typedef Comctrls::TListView inherited;
	
public:
	#pragma option push -w-inl
	/* TCustomListView.Create */ inline __fastcall virtual TListView(Classes::TComponent* AOwner) : Comctrls::TListView(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomListView.Destroy */ inline __fastcall virtual ~TListView(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TListView(HWND ParentWindow) : Comctrls::TListView(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TElImageListEditForm;
class PASCALIMPLEMENTATION TElImageListEditForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Elpanel::TElPanel* ElPanel1;
	Elflatctl::TElFlatController* ElFlatController1;
	Elimglst::TElImageList* WorkImageList;
	Menus::TPopupMenu* popupLoad;
	Menus::TMenuItem* itemImageList;
	Menus::TMenuItem* itemBitmaps;
	Menus::TMenuItem* itemBmpToIL;
	Menus::TPopupMenu* popupSave;
	Menus::TMenuItem* itemSaveToIL;
	Menus::TMenuItem* itemILToBitmap;
	Menus::TMenuItem* itemILSelToBitmap;
	Elpopbtn::TElPopupButton* ApplyButton;
	Dialogs::TSaveDialog* SD;
	Dialogs::TOpenDialog* OD;
	Menus::TPopupMenu* popupSel;
	Menus::TMenuItem* popupSel_Delete;
	Menus::TMenuItem* popupSel_L1;
	Menus::TMenuItem* popupSel_Copy;
	Menus::TMenuItem* popupSel_Paste;
	Elpanel::TElPanel* ElPanel2;
	Elpopbtn::TElPopupButton* btnLoad;
	Elpopbtn::TElPopupButton* btnSave;
	Elpopbtn::TElPopupButton* btnClear;
	Elpopbtn::TElPopupButton* btnMono;
	Elpopbtn::TElPopupButton* btnCopy;
	Elpopbtn::TElPopupButton* btnPaste;
	Elstatbar::TElStatusBar* ElStatusBar1;
	Elpanel::TElPanel* ElPanel3;
	TListView* WorkListView;
	Elsplit::TElSplitter* ElSplitter1;
	Elpopbtn::TElPopupButton* btnDelete;
	Elpopbtn::TElPopupButton* btnMove;
	Menus::TMenuItem* popupSel_Move;
	Menus::TMenuItem* popupSel_Mono;
	Extctrls::TPanel* pTop;
	Extctrls::TPanel* pColor;
	Elscrollbox::TElScrollBox* ScrollBox;
	Extctrls::TImage* Image;
	Elclrcmb::TElColorCombo* ccTrans;
	Stdctrls::TLabel* lbTrans;
	Menus::TMenuItem* popupSel_TransCol;
	Elpopbtn::TElPopupButton* btnTrans;
	Elpopbtn::TElPopupButton* btnSelectAll;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall itemImageListClick(System::TObject* Sender);
	void __fastcall itemBmpToILClick(System::TObject* Sender);
	void __fastcall itemBitmapsClick(System::TObject* Sender);
	void __fastcall itemSaveToILClick(System::TObject* Sender);
	void __fastcall itemILToBitmapClick(System::TObject* Sender);
	void __fastcall itemILSelToBitmapClick(System::TObject* Sender);
	void __fastcall WorkListViewKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall WorkListViewSelectItem(System::TObject* Sender, Comctrls::TListItem* Item, bool Selected);
	void __fastcall WorkListViewStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall WorkListViewDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall WorkListViewDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnMonoClick(System::TObject* Sender);
	void __fastcall popupSelPopup(System::TObject* Sender);
	void __fastcall ApplyButtonClick(System::TObject* Sender);
	void __fastcall OkButtonClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	void __fastcall btnPasteClick(System::TObject* Sender);
	void __fastcall WorkImageListChange(System::TObject* Sender);
	void __fastcall popupSavePopup(System::TObject* Sender);
	void __fastcall ElSplitter1PositionChanged(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall btnMoveClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall WorkListViewDeletion(System::TObject* Sender, Comctrls::TListItem* Item);
	void __fastcall ImageMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall popupSel_TransColClick(System::TObject* Sender);
	void __fastcall ImageDblClick(System::TObject* Sender);
	void __fastcall btnTransClick(System::TObject* Sender);
	void __fastcall btnSelectAllClick(System::TObject* Sender);
	void __fastcall WorkListViewMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ScrollBoxMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
private:
	Dialogs::TOpenDialog* fOD;
	Elimglst::TElImageList* fEditImageList;
	bool fModified;
	int fMoveIndex;
	
protected:
	void __fastcall SetImageSize(int Width, int Height);
	void __fastcall SetImageList(Elimglst::TElImageList* IL);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Msg);
	void __fastcall CheckEnabledPaste(void);
	void __fastcall UpdateSelected(void);
	MESSAGE void __fastcall WMChangeTrans(Messages::TMessage &Msg);
	void __fastcall ForEachSelected(TForEachSelectedHandler Handler, void * UserData);
	void __fastcall DeleteHandler(Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	void __fastcall SaveImageHandler(Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	void __fastcall MoveImagesToPos(System::TObject* Sender, int NewPos, int OldPos);
	void __fastcall MonoImageHandler(Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	void __fastcall TransHandler(Comctrls::TListItem* Item, int ItemIndex, void * UserData);
	
public:
	void __fastcall SetEditImageList(Elimglst::TElImageList* IL);
	__property bool Modified = {read=fModified, nodefault};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TElImageListEditForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElImageListEditForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElImageListEditForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TElImageListEditForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word WM_CHANGETRANSPARENT = 0x500;
extern PACKAGE void __fastcall IDERegisterModule(void);

}	/* namespace Frmimglistedit */
using namespace Frmimglistedit;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmImgListEdit
