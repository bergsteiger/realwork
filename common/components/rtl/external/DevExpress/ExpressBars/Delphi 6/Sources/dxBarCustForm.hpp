// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarCustForm.pas' rev: 6.00

#ifndef dxBarCustFormHPP
#define dxBarCustFormHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
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

namespace Dxbarcustform
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum dxBarCustForm__2 { glbGroups, glbItems };
#pragma option pop

class DELPHICLASS TdxBarCustomizingForm;
class PASCALIMPLEMENTATION TdxBarCustomizingForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Comctrls::TPageControl* PageControl;
	Comctrls::TTabSheet* TabSheet1;
	Comctrls::TTabSheet* TabSheet2;
	Stdctrls::TButton* BBarDelete;
	Stdctrls::TButton* BBarNew;
	Stdctrls::TButton* BBarRename;
	Stdctrls::TButton* BClose;
	Stdctrls::TLabel* LabelToobars;
	Comctrls::TTabSheet* TabSheet3;
	Extctrls::TPanel* Panel2;
	Extctrls::TPanel* Panel3;
	Extctrls::TPanel* Panel4;
	Extctrls::TPanel* Panel6;
	Extctrls::TPanel* Panel7;
	Stdctrls::TListBox* LCategories;
	Stdctrls::TListBox* LCommandsPlace;
	Stdctrls::TLabel* LabelCategories;
	Stdctrls::TLabel* LabelCommands;
	Comctrls::TTabSheet* TabSheet4;
	Stdctrls::TListBox* LAllCommands;
	Stdctrls::TCheckBox* CBShowCommandsWithShortCut;
	Extctrls::TPanel* Panel5;
	Extctrls::TPanel* Panel8;
	Extctrls::TPanel* Panel9;
	Stdctrls::TLabel* DescriptionLabel;
	Stdctrls::TLabel* LabelDescription;
	Extctrls::TBevel* Bevel1;
	Dxbar::TdxBarManager* BarManager1;
	Dxbar::TdxBarPopupMenu* CategoriesPopupMenu;
	Dxbar::TdxBarButton* CategoriesAdd;
	Dxbar::TdxBarButton* CategoriesInsert;
	Dxbar::TdxBarButton* CategoriesRename;
	Dxbar::TdxBarButton* CategoriesDelete;
	Dxbar::TdxBarButton* CommandsAdd;
	Dxbar::TdxBarButton* CommandsDelete;
	Dxbar::TdxBarButton* CommandsClear;
	Dxbar::TdxBarPopupMenu* CommandsPopupMenu;
	Dxbar::TdxBarButton* CommandsSubMenuEditor;
	Dxbar::TdxBarButton* CommandsMoveUp;
	Dxbar::TdxBarButton* CommandsMoveDown;
	Dxbar::TdxBarButton* CategoriesVisible;
	Dxbar::TdxBarCombo* CategoriesItemsVisible;
	Stdctrls::TListBox* BarsListBoxPlace;
	Buttons::TSpeedButton* CategoriesPopupButtonPlace;
	Buttons::TSpeedButton* CommandsPopupButtonPlace;
	Stdctrls::TButton* BBarReset;
	Extctrls::TPanel* StandardOptionsPanel;
	Stdctrls::TLabel* LabelMenuAnimations;
	Stdctrls::TComboBox* ComboBoxMenuAnimations;
	Stdctrls::TCheckBox* CBHint1;
	Stdctrls::TCheckBox* CBHint2;
	Stdctrls::TCheckBox* CBLargeIcons;
	Extctrls::TPanel* EnhancedOptionsPanel;
	Stdctrls::TLabel* Label1;
	Stdctrls::TComboBox* ComboBoxMenuAnimationsEx;
	Stdctrls::TCheckBox* CBHint1Ex;
	Stdctrls::TCheckBox* CBHint2Ex;
	Stdctrls::TCheckBox* CBLargeIconsEx;
	Extctrls::TBevel* Bevel2;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Extctrls::TBevel* Bevel3;
	Stdctrls::TCheckBox* CBMenusShowRecentItemsFirst;
	Stdctrls::TCheckBox* CBShowFullMenusAfterDelay;
	Stdctrls::TButton* BResetUsageData;
	Buttons::TBitBtn* BHelp;
	Comctrls::TTabSheet* TabSheet5;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TListBox* lbGroups;
	Stdctrls::TButton* btnGroupAdd;
	Stdctrls::TButton* btnGroupDelete;
	Stdctrls::TListBox* lbGroupItems;
	Stdctrls::TButton* btnGroupItemAdd;
	Stdctrls::TButton* btnGroupItemDelete;
	Buttons::TSpeedButton* btnMoveUp;
	Buttons::TSpeedButton* btnMoveDown;
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall PageControlChange(System::TObject* Sender);
	void __fastcall BHelpClick(System::TObject* Sender);
	void __fastcall BCloseClick(System::TObject* Sender);
	void __fastcall BBarNewClick(System::TObject* Sender);
	void __fastcall BBarRenameClick(System::TObject* Sender);
	void __fastcall BBarDeleteClick(System::TObject* Sender);
	void __fastcall BBarResetClick(System::TObject* Sender);
	void __fastcall LCategoriesClick(System::TObject* Sender);
	void __fastcall LCategoriesKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall LCategoriesMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall LCategoriesDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall LCategoriesEndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall CategoriesPopupMenuPopup(System::TObject* Sender);
	void __fastcall CategoriesAddClick(System::TObject* Sender);
	void __fastcall CategoriesInsertClick(System::TObject* Sender);
	void __fastcall CategoriesRenameClick(System::TObject* Sender);
	void __fastcall CategoriesItemsVisibleChange(System::TObject* Sender);
	void __fastcall CategoriesVisibleClick(System::TObject* Sender);
	void __fastcall CategoriesDeleteClick(System::TObject* Sender);
	void __fastcall LCommandsClick(System::TObject* Sender);
	void __fastcall CommandsPopupMenuPopup(System::TObject* Sender);
	void __fastcall CommandsAddClick(System::TObject* Sender);
	void __fastcall CommandsDeleteClick(System::TObject* Sender);
	void __fastcall CommandsClearClick(System::TObject* Sender);
	void __fastcall CommandsMoveUpClick(System::TObject* Sender);
	void __fastcall CommandsMoveDownClick(System::TObject* Sender);
	void __fastcall CommandsSubMenuEditorClick(System::TObject* Sender);
	void __fastcall CBMenusShowRecentItemsFirstClick(System::TObject* Sender);
	void __fastcall CBShowFullMenusAfterDelayClick(System::TObject* Sender);
	void __fastcall BResetUsageDataClick(System::TObject* Sender);
	void __fastcall CBLargeIconsClick(System::TObject* Sender);
	void __fastcall CBHint1Click(System::TObject* Sender);
	void __fastcall CBHint1ExClick(System::TObject* Sender);
	void __fastcall CBHint2Click(System::TObject* Sender);
	void __fastcall ComboBoxMenuAnimationsClick(System::TObject* Sender);
	void __fastcall LAllCommandsClick(System::TObject* Sender);
	void __fastcall LAllCommandsDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall CBShowCommandsWithShortCutClick(System::TObject* Sender);
	void __fastcall lbGroupsClick(System::TObject* Sender);
	void __fastcall lbGroupsDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall lbGroupsEnter(System::TObject* Sender);
	void __fastcall lbGroupsKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall lbGroupsMeasureItem(Controls::TWinControl* Control, int Index, int &Height);
	void __fastcall btnGroupAddClick(System::TObject* Sender);
	void __fastcall btnGroupDeleteClick(System::TObject* Sender);
	void __fastcall lbGroupItemsClick(System::TObject* Sender);
	void __fastcall lbGroupItemsDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall lbGroupItemsEnter(System::TObject* Sender);
	void __fastcall lbGroupItemsKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall btnGroupItemAddClick(System::TObject* Sender);
	void __fastcall btnGroupItemDeleteClick(System::TObject* Sender);
	void __fastcall btnMoveUpClick(System::TObject* Sender);
	void __fastcall btnMoveDownClick(System::TObject* Sender);
	
private:
	Stdctrls::TListBox* BarsListBox;
	Stdctrls::TListBox* LCommands;
	bool DontSelectComponent;
	bool FDontSelectGroupItems;
	int FDraggingCategoryIndex;
	bool FManualProcessing;
	int FRefreshGroupsEnablesLockCount;
	dxBarCustForm__2 LastActiveGroupListBox;
	int FAllCommandsNameWidth;
	int FAllCommandsCaptionWidth;
	int FAllCommandsShortCutWidth;
	Dxbar::TdxBarGroup* __fastcall GetSelectedGroup(void);
	Classes::TList* __fastcall GetSelectedGroupItems(void);
	void __fastcall SetSelectedGroup(Dxbar::TdxBarGroup* Value);
	void __fastcall SetSelectedGroupItems(Classes::TList* Value);
	void __fastcall BarsListBoxClick(System::TObject* Sender);
	void __fastcall MoveCommand(int Delta);
	void __fastcall SelectBarManager(void);
	void __fastcall CreateAllCommandsListBoxItems(void);
	void __fastcall RefreshAllCommandsListBox(void);
	void __fastcall CreateGroupsListBoxItems(void);
	void __fastcall CreateGroupItemsListBoxItems(void);
	void __fastcall BeginRefreshGroupsEnables(void);
	void __fastcall EndRefreshGroupsEnables(void);
	void __fastcall RefreshGroupsEnables(void);
	void __fastcall SelectedGroupChanged(bool RefreshData);
	void __fastcall SelectedGroupItemsChanged(void);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	__property Dxbar::TdxBarGroup* SelectedGroup = {read=GetSelectedGroup, write=SetSelectedGroup};
	__property Classes::TList* SelectedGroupItems = {read=GetSelectedGroupItems, write=SetSelectedGroupItems};
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall RefreshGroupsListBox(void);
	void __fastcall RefreshGroupItemsListBox(void);
	
public:
	Dxbar::TdxBarManager* BarManager;
	__fastcall TdxBarCustomizingForm(Dxbar::TdxBarManager* ABarManager);
	__fastcall virtual ~TdxBarCustomizingForm(void);
	void __fastcall BarManagerStyleChanged(void);
	void __fastcall SelectPage(int APageIndex);
	void __fastcall UpdateHelpButton(void);
	void __fastcall UpdateOptions(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TdxBarCustomizingForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TdxBarCustomizingForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarCustomizingForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall dxBarCustomizing(Dxbar::TdxBarManager* ABarManager, bool AShow);
extern PACKAGE TdxBarCustomizingForm* __fastcall dxBarCustomizingForm(void);
extern PACKAGE void __fastcall HostBarManagerStyleChanged(void);
extern PACKAGE void __fastcall UpdateHelpButton(void);
extern PACKAGE void __fastcall UpdateCustomizingBars(Dxbar::TdxBar* ABar);
extern PACKAGE void __fastcall UpdateCustomizingBarItems(void);
extern PACKAGE void __fastcall UpdateCustomizingBarItemsEx(Dxbar::TdxBarItem* AItem, bool Reread);
extern PACKAGE void __fastcall FullUpdateCustomizingBarItems(void);
extern PACKAGE void __fastcall UpdateBarManagerOptions(void);
extern PACKAGE void __fastcall UpdateCustomizingAllCommands(void);
extern PACKAGE void __fastcall UpdateGroups(void);
extern PACKAGE void __fastcall UpdateGroupItems(void);

}	/* namespace Dxbarcustform */
using namespace Dxbarcustform;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarCustForm
