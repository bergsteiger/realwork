// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBar.pas' rev: 6.00

#ifndef dxBarHPP
#define dxBarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <StdCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxbar
{
//-- type declarations -------------------------------------------------------
typedef TCustomImageList TCurImageList;
;

typedef TMetaClass*TdxBarItemClass;

class DELPHICLASS TdxBarDesigner;
class DELPHICLASS TdxBarManager;
class DELPHICLASS TdxBarItem;
class PASCALIMPLEMENTATION TdxBarDesigner : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall DeleteComponent(TdxBarManager* BarManager, Classes::TPersistent* Component) = 0 ;
	virtual void __fastcall SelectComponent(TdxBarManager* BarManager, Classes::TPersistent* Instance) = 0 ;
	virtual Classes::TPersistent* __fastcall SelectedComponent(TdxBarManager* BarManager) = 0 ;
	virtual void __fastcall ShowDefaultEventHandler(TdxBarItem* AItem) = 0 ;
	virtual AnsiString __fastcall UniqueName(TdxBarManager* BarManager, const AnsiString BaseName) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TdxBarDesigner(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TdxBarDesigner(void) { }
	#pragma option pop
	
};


typedef TMetaClass*TdxBarHintWindowClass;

class DELPHICLASS TdxBarHintWindow;
class PASCALIMPLEMENTATION TdxBarHintWindow : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TdxBarHintWindow(Classes::TComponent* AOwner);
	virtual void __fastcall ActivateHint(const Types::TPoint &P, const AnsiString AHint, TdxBarManager* BarManager);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TdxBarHintWindow(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarHintWindow(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TdxBarItemVisible { ivNever, ivInCustomizing, ivAlways };
#pragma option pop

class DELPHICLASS TdxBarGroup;
class PASCALIMPLEMENTATION TdxBarGroup : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	Classes::TComponent* operator[](int Index) { return Items[Index]; }
	
private:
	TdxBarManager* FBarManager;
	bool FEnabled;
	Classes::TList* FItems;
	Classes::TStringList* FItemsNames;
	TdxBarItemVisible FVisible;
	int __fastcall GetCount(void);
	int __fastcall GetIndex(void);
	Classes::TComponent* __fastcall GetItem(int Index);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetIndex(int Value);
	void __fastcall SetVisible(TdxBarItemVisible Value);
	void __fastcall ReadItems(Classes::TReader* Reader);
	void __fastcall WriteItems(Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetName(const AnsiString NewName);
	DYNAMIC void __fastcall SetParentComponent(Classes::TComponent* AParent);
	
public:
	__fastcall virtual TdxBarGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarGroup(void);
	DYNAMIC Classes::TComponent* __fastcall GetParentComponent(void);
	DYNAMIC bool __fastcall HasParent(void);
	void __fastcall Add(Classes::TComponent* AItem);
	void __fastcall Delete(int Index);
	int __fastcall IndexOf(Classes::TComponent* AItem);
	void __fastcall Move(int FromIndex, int ToIndex);
	HIDESBASE void __fastcall Remove(Classes::TComponent* AItem);
	__property TdxBarManager* BarManager = {read=FBarManager};
	__property int Count = {read=GetCount, nodefault};
	__property int Index = {read=GetIndex, write=SetIndex, nodefault};
	__property Classes::TComponent* Items[int Index] = {read=GetItem/*, default*/};
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property TdxBarItemVisible Visible = {read=FVisible, write=SetVisible, default=2};
};


class DELPHICLASS TdxBarPopupMenuLink;
typedef void __fastcall (__closure *TdxBarPopupMenuLinkActionEvent)(TdxBarPopupMenuLink* Sender, int &X, int &Y, bool ClickedByMouse, bool &AllowPopup);

class DELPHICLASS TdxBarPopupMenu;
class DELPHICLASS TdxBarItemLinks;
class DELPHICLASS TCustomdxBarControl;
class DELPHICLASS TdxBarItemControl;
class DELPHICLASS TdxBarItemLink;
#pragma option push -b-
enum TdxBarUserDefine { udCaption, udGlyph, udPaintStyle, udWidth };
#pragma option pop

typedef Set<TdxBarUserDefine, udCaption, udWidth>  TdxBarUserDefines;

#pragma option push -b-
enum TdxBarPaintStyle { psStandard, psCaption, psCaptionInMenu, psCaptionGlyph };
#pragma option pop

class PASCALIMPLEMENTATION TdxBarItemLink : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FBeginGroup;
	TdxBarItemControl* FControl;
	int FData;
	TdxBarItem* FItem;
	#pragma pack(push, 1)
	Types::TRect FItemRect;
	#pragma pack(pop)
	
	int FLoadedRecentIndex;
	int FLoadedUseCount;
	bool FLoadedVisible;
	bool FMostRecentlyUsed;
	TdxBarItemLink* FOriginalItemLink;
	int FPrevRecentIndex;
	int FRowHeight;
	int FUseCount;
	AnsiString FUserCaption;
	TdxBarUserDefines FUserDefine;
	Graphics::TBitmap* FUserGlyph;
	TdxBarPaintStyle FUserPaintStyle;
	int FUserWidth;
	bool FVisible;
	int __fastcall GetAvailableIndex(void);
	TCustomdxBarControl* __fastcall GetBarControl(void);
	TdxBarManager* __fastcall GetBarManager(void);
	bool __fastcall GetBeginGroup(void);
	int __fastcall GetCanVisibleIndex(void);
	AnsiString __fastcall GetCaption();
	Graphics::TBitmap* __fastcall GetGlyph(void);
	TdxBarPaintStyle __fastcall GetPaintStyle(void);
	int __fastcall GetVisibleIndex(void);
	int __fastcall GetWidth(void);
	void __fastcall SetBeginGroup(bool Value);
	void __fastcall SetItem(TdxBarItem* Value);
	void __fastcall SetMostRecentlyUsed(bool Value);
	void __fastcall SetUserCaption(AnsiString Value);
	void __fastcall SetUserDefine(TdxBarUserDefines Value);
	void __fastcall SetUserGlyph(Graphics::TBitmap* Value);
	void __fastcall SetUserPaintStyle(TdxBarPaintStyle Value);
	void __fastcall SetUserWidth(int Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall AddToRecentList(void);
	void __fastcall RemoveFromRecentList(void);
	void __fastcall RestoreRecentIndex(void);
	void __fastcall SaveRecentIndex(void);
	void __fastcall InternalBringToTopInRecentList(bool IncCount);
	void __fastcall Synchronize(TdxBarItemLink* AItemLink);
	void __fastcall CheckMostRecentlyUsed(void);
	int __fastcall GetRecentIndex(void);
	void __fastcall SetRecentIndex(int Value);
	__property int RecentIndex = {read=GetRecentIndex, write=SetRecentIndex, nodefault};
	bool __fastcall CanVisible(void);
	TdxBarItemLink* __fastcall GetRealItemLink(void);
	
protected:
	bool __fastcall HasItem(TdxBarItem* AItem);
	void __fastcall InitiateAction(void);
	bool __fastcall IsAccel(Word Key, Classes::TShiftState Shift);
	void __fastcall ItemLinkChanged(void);
	__property int RowHeight = {read=FRowHeight, write=FRowHeight, nodefault};
	
public:
	__fastcall virtual TdxBarItemLink(Classes::TCollection* Collection);
	__fastcall virtual ~TdxBarItemLink(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BringToTopInRecentList(bool IncCount);
	void __fastcall CreateControl(void);
	void __fastcall DestroyControl(void);
	void __fastcall SendToBottomInRecentList(void);
	__property int AvailableIndex = {read=GetAvailableIndex, nodefault};
	__property TCustomdxBarControl* BarControl = {read=GetBarControl};
	__property TdxBarManager* BarManager = {read=GetBarManager};
	__property int CanVisibleIndex = {read=GetCanVisibleIndex, nodefault};
	__property AnsiString Caption = {read=GetCaption};
	__property TdxBarItemControl* Control = {read=FControl};
	__property int Data = {read=FData, write=FData, default=0};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph};
	__property Types::TRect ItemRect = {read=FItemRect, write=FItemRect};
	__property TdxBarPaintStyle PaintStyle = {read=GetPaintStyle, nodefault};
	__property TdxBarItemLink* RealItemLink = {read=GetRealItemLink};
	__property int VisibleIndex = {read=GetVisibleIndex, nodefault};
	__property int Width = {read=GetWidth, nodefault};
	
__published:
	__property bool BeginGroup = {read=GetBeginGroup, write=SetBeginGroup, default=0};
	__property TdxBarItem* Item = {read=FItem, write=SetItem};
	__property bool MostRecentlyUsed = {read=FMostRecentlyUsed, write=SetMostRecentlyUsed, default=1};
	__property AnsiString UserCaption = {read=FUserCaption, write=SetUserCaption};
	__property TdxBarUserDefines UserDefine = {read=FUserDefine, write=SetUserDefine, default=0};
	__property Graphics::TBitmap* UserGlyph = {read=FUserGlyph, write=SetUserGlyph};
	__property TdxBarPaintStyle UserPaintStyle = {read=FUserPaintStyle, write=SetUserPaintStyle, default=0};
	__property int UserWidth = {read=FUserWidth, write=SetUserWidth, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
};


#pragma option push -b-
enum TdxBarItemAlign { iaLeft, iaCenter, iaRight, iaClient };
#pragma option pop

#pragma option push -b-
enum TdxBarPaintType { ptHorz, ptMenu, ptVert };
#pragma option pop

class PASCALIMPLEMENTATION TdxBarItemControl : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	#pragma pack(push, 1)
	Types::TRect FBeginGroupRect;
	#pragma pack(pop)
	
	bool FBreakingRow;
	bool FChangeRecentGroup;
	bool FHasWindow;
	bool FIsActive;
	TdxBarItemLink* FItemLink;
	bool FLastInRow;
	bool FNonRecent;
	TCustomdxBarControl* FParent;
	bool FPressed;
	bool FSelectedByMouse;
	TdxBarItemAlign __fastcall GetAlign(void);
	TdxBarManager* __fastcall GetBarManager(void);
	bool __fastcall GetFlat(void);
	bool __fastcall GetIsSelected(void);
	TdxBarItem* __fastcall GetItem(void);
	int __fastcall GetNormalItemHeightInSubMenu(void);
	int __fastcall GetRealHeight(void);
	int __fastcall GetRealWidth(void);
	bool __fastcall GetUnclickAfterDoing(void);
	void __fastcall SetPressed(bool Value);
	
protected:
	DYNAMIC void __fastcall AlignChanged(void);
	virtual void __fastcall BeforeDestroyParentHandle(void);
	virtual void __fastcall BeginGroupChanged(void);
	virtual void __fastcall CaptionChanged(void);
	virtual void __fastcall EnabledChanged(void);
	virtual void __fastcall GlyphChanged(void);
	virtual void __fastcall PressedChanged(void);
	virtual void __fastcall ShortCutChanged(void);
	virtual void __fastcall VisibleChanged(void);
	virtual bool __fastcall CanClicked(void);
	virtual bool __fastcall CanCustomize(void);
	virtual bool __fastcall CanSelect(void);
	bool __fastcall CanVisuallyPressed(void);
	virtual void __fastcall Click(bool ByMouse);
	virtual void __fastcall ControlActivate(bool Immediately);
	virtual void __fastcall ControlInactivate(bool Immediately);
	virtual void __fastcall ControlClick(bool ByMouse);
	virtual void __fastcall ControlUnclick(bool ByMouse);
	DYNAMIC void __fastcall DblClick(void);
	virtual bool __fastcall DrawSelected(void);
	DYNAMIC bool __fastcall WantsDblClick(void);
	virtual void __fastcall KeyDown(Word Key);
	virtual bool __fastcall WantsKey(Word Key);
	void __fastcall DrawLowered(HDC DC, Types::TRect &R);
	void __fastcall DrawGlyph(const Types::TRect &R, TdxBarPaintType PaintType, bool IsGlyphEmpty, bool Selected, bool Down, bool DrawDowned, bool Center, bool ForceUseBkBrush);
	void __fastcall DrawGlyphAndBkgnd(const Types::TRect &R, const Types::TRect &GlyphRect, TdxBarPaintType PaintType, Graphics::TBitmap* AGlyph, Imglist::TCustomImageList* AImages, int AImageIndex, bool IsGlyphEmpty, bool Selected, bool Down, bool DrawDowned, bool ForceUseBkBrush, bool GrayScale);
	void __fastcall DrawGlyphAndTextInSubMenu(HDC DC, Types::TRect &R, bool Selected, bool ShowGlyph, bool Down);
	void __fastcall DrawItemText(HDC DC, AnsiString S, const Types::TRect &PaintRect, unsigned Alignment, bool Enabled, bool Selected, bool Rotated, bool Clipped, bool Flat);
	void __fastcall FrameAndFillRect(HDC DC, Types::TRect &R, bool Selected, bool Pressed);
	void __fastcall GetArrowParams(TdxBarPaintType APaintType, bool ASelected, bool ADroppedDown, HBRUSH &ABrush, unsigned &AArrowColor);
	virtual AnsiString __fastcall GetCaption();
	virtual bool __fastcall GetEnabled(void);
	virtual Graphics::TBitmap* __fastcall GetGlyph(void);
	virtual int __fastcall GetImageIndex(void);
	virtual Imglist::TCustomImageList* __fastcall GetImages(void);
	virtual AnsiString __fastcall GetHint();
	virtual Imglist::TCustomImageList* __fastcall GetHotImages(void);
	virtual Imglist::TCustomImageList* __fastcall GetLargeImages(void);
	virtual Classes::TShortCut __fastcall GetShortCut(void);
	virtual int __fastcall GetTextAreaOffset(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetMinHeight(void);
	virtual int __fastcall GetMinWidth(void);
	virtual int __fastcall GetWidth(void);
	virtual bool __fastcall HasHint(void);
	bool __fastcall ImageExists(void);
	bool __fastcall ImageIndexLinked(void);
	virtual bool __fastcall IsDestroyOnClick(void);
	virtual bool __fastcall IsExpandable(void);
	bool __fastcall MousePressed(void);
	virtual bool __fastcall NeedCaptureMouse(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, TdxBarPaintType PaintType);
	bool __fastcall ParentIsQuickCustControl(void);
	bool __fastcall WantMouse(void);
	__property TdxBarItemAlign Align = {read=GetAlign, nodefault};
	__property AnsiString Caption = {read=GetCaption};
	__property bool Enabled = {read=GetEnabled, nodefault};
	__property bool Flat = {read=GetFlat, nodefault};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph};
	__property int Height = {read=GetRealHeight, nodefault};
	__property AnsiString Hint = {read=GetHint};
	__property Imglist::TCustomImageList* HotImages = {read=GetHotImages};
	__property int ImageIndex = {read=GetImageIndex, nodefault};
	__property Imglist::TCustomImageList* Images = {read=GetImages};
	__property Imglist::TCustomImageList* LargeImages = {read=GetLargeImages};
	__property int MinHeight = {read=GetMinHeight, nodefault};
	__property int MinWidth = {read=GetMinWidth, nodefault};
	__property int NormalItemHeightInSubMenu = {read=GetNormalItemHeightInSubMenu, nodefault};
	__property bool Pressed = {read=FPressed, write=SetPressed, nodefault};
	__property Classes::TShortCut ShortCut = {read=GetShortCut, nodefault};
	__property int TextAreaOffset = {read=GetTextAreaOffset, nodefault};
	__property bool UnclickAfterDoing = {read=GetUnclickAfterDoing, nodefault};
	__property int Width = {read=GetRealWidth, nodefault};
	
public:
	__fastcall virtual TdxBarItemControl(TdxBarItemLink* AItemLink);
	__fastcall virtual ~TdxBarItemControl(void);
	virtual void __fastcall Repaint(void);
	__property TdxBarManager* BarManager = {read=GetBarManager};
	__property bool HasWindow = {read=FHasWindow, nodefault};
	__property bool IsActive = {read=FIsActive, nodefault};
	__property bool IsSelected = {read=GetIsSelected, nodefault};
	__property TdxBarItem* Item = {read=GetItem};
	__property TdxBarItemLink* ItemLink = {read=FItemLink};
	__property TCustomdxBarControl* Parent = {read=FParent};
};


class DELPHICLASS TdxDockControl;
#pragma option push -b-
enum TdxBarDockingStyle { dsNone, dsLeft, dsTop, dsRight, dsBottom };
#pragma option pop

class DELPHICLASS TdxBars;
class DELPHICLASS TdxDockRow;
class DELPHICLASS TdxBarControl;
class DELPHICLASS TdxBar;
class PASCALIMPLEMENTATION TdxDockControl : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FAllowDocking;
	TdxBarManager* FBarManager;
	TdxBarDockingStyle FDockingStyle;
	Classes::TList* FRowList;
	int FRowMarginSize;
	TdxBars* __fastcall GetBars(void);
	TdxBarDockingStyle __fastcall GetDockingStyle(void);
	bool __fastcall GetHorizontal(void);
	bool __fastcall GetIsDesigning(void);
	bool __fastcall GetIsLoading(void);
	bool __fastcall GetMain(void);
	TdxDockRow* __fastcall GetRow(int Index);
	int __fastcall GetRowCount(void);
	bool __fastcall GetTopLeft(void);
	bool __fastcall GetVertical(void);
	void __fastcall SetBarManager(TdxBarManager* Value);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall AddBarControl(TdxBarControl* ABarControl, const Types::TPoint &APos, bool Update);
	void __fastcall DeleteBarControl(TdxBarControl* ABarControl, void * ADockCol, bool Update);
	void __fastcall MoveBarControl(TdxBarControl* ABarControl, const Types::TPoint &APos);
	void __fastcall AssignPositions(void);
	virtual void __fastcall BarManagerChanged(void);
	virtual bool __fastcall CanDocking(TdxBar* Bar);
	virtual void __fastcall ColorChanged(void);
	Types::TRect __fastcall GetDockZoneBounds();
	void __fastcall GetDockZoneMargins(int Row, int ZoneNumber, int &M1, int &M2);
	Types::TRect __fastcall GetRectForRow(int ARow);
	virtual int __fastcall GetClientSize(void);
	int __fastcall GetSize(void);
	int __fastcall GetRowAtPos(const Types::TPoint &APos, bool &Insert);
	int __fastcall GetColAtPos(int ARow, const Types::TPoint &APos);
	void __fastcall GetPosForRow(int Row, bool OneOnRow, Types::TPoint &P);
	virtual bool __fastcall GetSunkenBorder(void);
	void __fastcall NCChanged(void);
	void __fastcall PaintBarControls(void);
	void __fastcall SetSize(void);
	void __fastcall UpdateDock(void);
	__property bool AllowDocking = {read=FAllowDocking, write=FAllowDocking, default=1};
	__property bool Horizontal = {read=GetHorizontal, nodefault};
	__property bool IsDesigning = {read=GetIsDesigning, nodefault};
	__property bool IsLoading = {read=GetIsLoading, nodefault};
	__property bool Main = {read=GetMain, nodefault};
	__property int RowMarginSize = {read=FRowMarginSize, write=FRowMarginSize, nodefault};
	__property bool SunkenBorder = {read=GetSunkenBorder, nodefault};
	__property bool TopLeft = {read=GetTopLeft, nodefault};
	__property bool Vertical = {read=GetVertical, nodefault};
	
public:
	__fastcall virtual TdxDockControl(Classes::TComponent* AOwner);
	__fastcall TdxDockControl(Classes::TComponent* AOwner, TdxBarManager* ABarManager, TdxBarDockingStyle ADockStyle);
	__fastcall virtual ~TdxDockControl(void);
	virtual void __fastcall InitiateAction(void);
	__property TdxBarManager* BarManager = {read=FBarManager, write=SetBarManager};
	__property TdxBars* Bars = {read=GetBars};
	__property TdxBarDockingStyle DockingStyle = {read=GetDockingStyle, nodefault};
	__property int RowCount = {read=GetRowCount, nodefault};
	__property Classes::TList* RowList = {read=FRowList};
	__property TdxDockRow* Rows[int Index] = {read=GetRow};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxDockControl(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TdxBarMarkState { msNone, msSelected, msPressed };
#pragma option pop

class PASCALIMPLEMENTATION TCustomdxBarControl : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	HBRUSH FBkBrush;
	TCustomdxBarControl* FChildBar;
	TdxBarItemControl* FClickedControl;
	bool FDestroyFlag;
	TdxDockControl* FDockControl;
	TdxBarDockingStyle FDockingStyle;
	bool FDragDown;
	#pragma pack(push, 1)
	Types::TPoint FDragPoint;
	#pragma pack(pop)
	
	bool FIgnoreMouseClick;
	bool FIsActive;
	TdxBarItemLinks* FItemLinks;
	TdxBarMarkState FMarkState;
	bool FMouseOverClickedControl;
	bool FMovingChanging;
	TCustomdxBarControl* FParentBar;
	TCustomdxBarControl* FPrevActiveBarControl;
	TdxBarItemControl* FSelectedItem;
	int FTextSize;
	int FEditTextSize;
	int FMenuArrowHeight;
	int FMenuArrowWidth;
	int FComboBoxArrowWidth;
	TdxBarManager* __fastcall GetBarManager(void);
	bool __fastcall GetFlat(void);
	bool __fastcall GetIsDestroying(void);
	MESSAGE void __fastcall WMCaptureChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Message);
	MESSAGE void __fastcall WMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMRepaintBar(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	
protected:
	#pragma pack(push, 1)
	Types::TPoint FLastMousePos;
	#pragma pack(pop)
	
	DYNAMIC void __fastcall AdjustSize(void);
	virtual void __fastcall CreateWindowHandle(const Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWindowHandle(void);
	virtual void __fastcall CreateControls(void);
	virtual void __fastcall DestroyControls(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall BeforeDestroyHandle(void);
	virtual void __fastcall CalcDrawingConsts(void);
	virtual bool __fastcall CanAlignControls(void);
	virtual bool __fastcall CanCallInheritedNCCalcSize(void);
	virtual bool __fastcall CanCustomizing(void);
	DYNAMIC bool __fastcall CanFinishMouseTracking(const Messages::TWMNCHitTest &Message);
	DYNAMIC void __fastcall DblClickOnItem(TdxBarItemControl* Item);
	void __fastcall DrawSelectedItem(TdxBarItemControl* AControl);
	virtual int __fastcall GetBeginGroupSize(void) = 0 ;
	virtual HFONT __fastcall GetEditFontHandle(void);
	virtual Types::TRect __fastcall GetFullItemRect(TdxBarItemControl* Item);
	virtual bool __fastcall GetIsCustomizing(void);
	virtual Types::TRect __fastcall GetItemRectEx(TdxBarItemControl* Item, bool IsBeginGroup);
	virtual HRGN __fastcall GetItemRegion(TdxBarItemControl* Item);
	virtual HBRUSH __fastcall GetToolbarBrush(void);
	virtual HBRUSH __fastcall GetToolbarDownedBrush(void);
	virtual HBRUSH __fastcall GetToolbarDownedSelBrush(void);
	virtual HBRUSH __fastcall GetToolbarSelBrush(void);
	void __fastcall GetWindowRect(Types::TRect &R);
	bool __fastcall HasShadow(void);
	virtual bool __fastcall HideOnClick(void);
	virtual bool __fastcall IsChildBar(TCustomdxBarControl* Value);
	virtual TdxBarItemControl* __fastcall ItemAtPosEx(const Types::TPoint &Pos, bool &IsBeginGroup, bool &IsFirstPart, bool &IsVerticalDirection);
	bool __fastcall ItemExists(TdxBarItemControl* Item);
	virtual bool __fastcall MarkExists(void);
	virtual bool __fastcall NotHandleMouseMove(const Types::TPoint &P);
	virtual void __fastcall PaintItem(TdxBarItemControl* AControl);
	virtual void __fastcall PaintSelectedItem(TdxBarItemControl* OldSelectedItem);
	bool __fastcall SelectedItemWantsKey(Word Key);
	virtual void __fastcall SetDockingStyle(TdxBarDockingStyle Value);
	HIDESBASE virtual void __fastcall SetFont(void) = 0 ;
	virtual void __fastcall SetIsActive(bool Value);
	virtual void __fastcall SetKeySelectedItem(TdxBarItemControl* Value);
	virtual void __fastcall SetMarkState(TdxBarMarkState Value) = 0 ;
	virtual void __fastcall SetMouseSelectedItem(TdxBarItemControl* Value);
	virtual void __fastcall SetSelectedItem(TdxBarItemControl* Value);
	void __fastcall UpdateControlStyle(void);
	bool __fastcall WantMouse(void);
	__property TCustomdxBarControl* ChildBar = {read=FChildBar, write=FChildBar};
	__property TdxDockControl* DockControl = {read=FDockControl, write=FDockControl};
	__property TdxBarDockingStyle DockingStyle = {read=FDockingStyle, write=SetDockingStyle, nodefault};
	__property bool Flat = {read=GetFlat, nodefault};
	__property bool IsDestroying = {read=GetIsDestroying, nodefault};
	__property TdxBarMarkState MarkState = {read=FMarkState, write=SetMarkState, nodefault};
	__property TCustomdxBarControl* ParentBar = {read=FParentBar, write=FParentBar};
	__property TdxBarItemControl* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	__property int BeginGroupSize = {read=GetBeginGroupSize, nodefault};
	__property HBRUSH ToolbarBrush = {read=GetToolbarBrush, nodefault};
	__property HBRUSH ToolbarDownedBrush = {read=GetToolbarDownedBrush, nodefault};
	__property HBRUSH ToolbarDownedSelBrush = {read=GetToolbarDownedSelBrush, nodefault};
	__property HBRUSH ToolbarSelBrush = {read=GetToolbarSelBrush, nodefault};
	
public:
	__fastcall virtual TCustomdxBarControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomdxBarControl(void);
	Types::TRect __fastcall GetItemRect(TdxBarItemControl* Item);
	virtual void __fastcall HideAll(void);
	TdxBarItemControl* __fastcall ItemAtPos(const Types::TPoint &Pos);
	virtual void __fastcall RepaintBar(void);
	__property TdxBarManager* BarManager = {read=GetBarManager};
	__property HBRUSH BkBrush = {read=FBkBrush, nodefault};
	__property Canvas ;
	__property int ComboBoxArrowWidth = {read=FComboBoxArrowWidth, nodefault};
	__property HFONT EditFontHandle = {read=GetEditFontHandle, nodefault};
	__property int EditTextSize = {read=FEditTextSize, nodefault};
	__property Font ;
	__property bool IsActive = {read=FIsActive, write=SetIsActive, nodefault};
	__property bool IsCustomizing = {read=GetIsCustomizing, nodefault};
	__property TdxBarItemLinks* ItemLinks = {read=FItemLinks, write=FItemLinks};
	__property int MenuArrowHeight = {read=FMenuArrowHeight, nodefault};
	__property int MenuArrowWidth = {read=FMenuArrowWidth, nodefault};
	__property int TextSize = {read=FTextSize, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCustomdxBarControl(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TdxBarItemLinks : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TdxBarItemLink* operator[](int Index) { return Items[Index]; }
	
private:
	bool FAssigning;
	Classes::TList* FAvailableItems;
	Classes::TList* FCanVisibleItems;
	Classes::TList* FVisibleItems;
	TCustomdxBarControl* FBarControl;
	TdxBarManager* FBarManager;
	System::TObject* FOwner;
	int FPrevRecentItemCount;
	Classes::TList* FRecentItems;
	int FRecentItemCount;
	bool FUseRecentItems;
	Classes::TNotifyEvent FOnChange;
	TdxBarItemLink* __fastcall GetAvailableItem(int Index);
	int __fastcall GetAvailableItemCount(void);
	TdxBarItemLink* __fastcall GetCanVisibleItem(int Index);
	int __fastcall GetCanVisibleItemCount(void);
	HIDESBASE TdxBarItemLink* __fastcall GetItem(int Index);
	int __fastcall GetMostRecentItemCount(void);
	int __fastcall GetRealVisibleItemCount(void);
	TdxBarItemLink* __fastcall GetVisibleItem(int Index);
	int __fastcall GetVisibleItemCount(void);
	HIDESBASE void __fastcall SetItem(int Index, TdxBarItemLink* Value);
	void __fastcall SetRecentItemCount(int Value);
	void __fastcall RefreshVisibilityLists(void);
	__property int MostRecentItemCount = {read=GetMostRecentItemCount, nodefault};
	void __fastcall RestoreRecentItemCount(void);
	__property int RecentItemCount = {read=FRecentItemCount, write=SetRecentItemCount, nodefault};
	void __fastcall EmptyItemRects(void);
	void __fastcall Loaded(bool CheckVisible);
	void __fastcall CheckVisibleIntegrity(void);
	void __fastcall AssignUsageData(TdxBarItemLinks* AItemLinks);
	
protected:
	bool __fastcall CanUseRecentItems(void);
	void __fastcall InitiateActions(void);
	TdxBarItemLink* __fastcall FindItemWithAccel(Word Key, Classes::TShiftState Shift, TdxBarItemLink* Current);
	TdxBarItemLink* __fastcall First(void);
	TdxBarItemLink* __fastcall Last(void);
	TdxBarItemLink* __fastcall Next(TdxBarItemLink* Current);
	TdxBarItemLink* __fastcall Prev(TdxBarItemLink* Current);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	__property int RealVisibleItemCount = {read=GetRealVisibleItemCount, nodefault};
	
public:
	__fastcall TdxBarItemLinks(TdxBarManager* ABarManager);
	__fastcall virtual ~TdxBarItemLinks(void);
	HIDESBASE TdxBarItemLink* __fastcall Add(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	int __fastcall AvailableIndexOf(TdxBarItemLink* Value);
	int __fastcall CanVisibleIndexOf(TdxBarItemLink* Value);
	void __fastcall CreateBarControl(void);
	void __fastcall FreeForeignItems(TdxBarManager* ForeignBarManager);
	bool __fastcall HasItem(TdxBarItem* AItem);
	int __fastcall IndexOf(TdxBarItemLink* Value);
	int __fastcall VisibleIndexOf(TdxBarItemLink* Value);
	__property TdxBarItemLink* AvailableItems[int Index] = {read=GetAvailableItem};
	__property int AvailableItemCount = {read=GetAvailableItemCount, nodefault};
	__property TCustomdxBarControl* BarControl = {read=FBarControl, write=FBarControl};
	__property TdxBarManager* BarManager = {read=FBarManager};
	__property TdxBarItemLink* CanVisibleItems[int Index] = {read=GetCanVisibleItem};
	__property int CanVisibleItemCount = {read=GetCanVisibleItemCount, nodefault};
	__property TdxBarItemLink* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property System::TObject* Owner = {read=FOwner};
	__property TdxBarItemLink* VisibleItems[int Index] = {read=GetVisibleItem};
	__property int VisibleItemCount = {read=GetVisibleItemCount, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TdxBarPaintSubMenuBarEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R);

class PASCALIMPLEMENTATION TdxBarPopupMenu : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	bool DontUseMessageLoop;
	TdxBarManager* FBarManager;
	int FBarSize;
	HFONT FEditFontHandle;
	Graphics::TFont* FFont;
	TdxBarItemLinks* FItemLinks;
	int FOwnerWidth;
	int FOwnerHeight;
	bool FPopupMenuVisible;
	bool FShowAnimation;
	bool FUseOwnFont;
	bool FUseRecentItems;
	Classes::TNotifyEvent FOnCloseUp;
	TdxBarPaintSubMenuBarEvent FOnPaintBar;
	Classes::TNotifyEvent FOnPopup;
	void __fastcall SetBarManager(TdxBarManager* Value);
	void __fastcall SetBarSize(int Value);
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetItemLinks(TdxBarItemLinks* Value);
	void __fastcall SetUseOwnFont(bool Value);
	void __fastcall SetUseRecentItems(bool Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SubMenuCloseUp(System::TObject* Sender);
	void __fastcall SubMenuPopup(System::TObject* Sender);
	void __fastcall OwnerDesignerModified(void);
	
protected:
	virtual void __fastcall DoPaintBar(Graphics::TCanvas* Canvas, const Types::TRect &R);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TdxBarPopupMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarPopupMenu(void);
	void __fastcall Popup(int X, int Y);
	void __fastcall PopupEx(int X, int Y, int AOwnerWidth, int AOwnerHeight, bool AShowAnimation);
	void __fastcall PopupFromCursorPos(void);
	
__published:
	__property TdxBarManager* BarManager = {read=FBarManager, write=SetBarManager};
	__property int BarSize = {read=FBarSize, write=SetBarSize, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont, stored=FUseOwnFont};
	__property TdxBarItemLinks* ItemLinks = {read=FItemLinks, write=SetItemLinks};
	__property bool UseOwnFont = {read=FUseOwnFont, write=SetUseOwnFont, nodefault};
	__property bool UseRecentItems = {read=FUseRecentItems, write=SetUseRecentItems, default=0};
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property TdxBarPaintSubMenuBarEvent OnPaintBar = {read=FOnPaintBar, write=FOnPaintBar};
	__property Classes::TNotifyEvent OnPopup = {read=FOnPopup, write=FOnPopup};
};


class PASCALIMPLEMENTATION TdxBarPopupMenuLink : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TWinControl* FControl;
	TdxBarPopupMenu* FPopupMenu;
	TdxBarPopupMenuLinkActionEvent FOnAction;
	TdxBarManager* __fastcall GetBarManager(void);
	void __fastcall SetControl(Controls::TWinControl* Value);
	void __fastcall SetPopupMenu(TdxBarPopupMenu* Value);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall DoAction(HWND Wnd, const Types::TPoint &P);
	__property TdxBarManager* BarManager = {read=GetBarManager};
	
__published:
	__property Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property TdxBarPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property TdxBarPopupMenuLinkActionEvent OnAction = {read=FOnAction, write=FOnAction};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TdxBarPopupMenuLink(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TdxBarPopupMenuLink(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarPopupMenuLinks;
class PASCALIMPLEMENTATION TdxBarPopupMenuLinks : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TdxBarPopupMenuLink* operator[](int Index) { return Items[Index]; }
	
private:
	TdxBarManager* FBarManager;
	HIDESBASE TdxBarPopupMenuLink* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TdxBarPopupMenuLink* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TdxBarPopupMenuLinks(TdxBarManager* ABarManager);
	HIDESBASE TdxBarPopupMenuLink* __fastcall Add(void);
	bool __fastcall DoAction(Controls::TWinControl* AControl, HWND Wnd, const Types::TPoint &P);
	__property TdxBarManager* BarManager = {read=FBarManager};
	__property TdxBarPopupMenuLink* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TdxBarPopupMenuLinks(void) { }
	#pragma option pop
	
};


typedef Set<TdxBarDockingStyle, dsNone, dsBottom>  TdxBarDockingStyles;

#pragma option push -b-
enum TdxBarManagerStyle { bmsStandard, bmsEnhanced, bmsFlat };
#pragma option pop

#pragma option push -b-
enum TdxBarMenuAnimations { maNone, maRandom, maUnfold, maSlide };
#pragma option pop

typedef void __fastcall (__closure *TdxBarEvent)(TdxBarManager* Sender, TdxBar* ABar);

typedef void __fastcall (__closure *TdxBarItemLinkEvent)(TdxBarManager* Sender, TdxBarItemLink* AItemLink);

typedef void __fastcall (__closure *TdxBarVisibleChangeEvent)(TdxBarManager* Sender, TdxBar* ABar);

typedef void __fastcall (__closure *TdxBarCanDockingEvent)(TdxBar* Sender, TdxBarDockingStyle Style, TdxDockControl* DockControl, bool &CanDocking);

typedef void __fastcall (__closure *TdxBarMenuMergeEvent)(TdxBarManager* Sender, TdxBarManager* ChildBarManager, bool AddItems);

typedef void __fastcall (__closure *TdxBarShowPopupEvent)(TdxBarManager* Sender, TdxBarItemLinks* PopupItemLinks);

typedef void __fastcall (__closure *TdxBarClickItemEvent)(TdxBarManager* Sender, TdxBarItem* ClickedItem);

class PASCALIMPLEMENTATION TdxBarManager : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	bool FAllowCallFromAnotherForm;
	bool FAllowReset;
	bool FAlwaysMerge;
	bool FAlwaysSaveText;
	bool FAutoDockColor;
	bool FAutoHideEmptyBars;
	TdxBars* FBars;
	int FButtonArrowWidth;
	bool FCanCustomize;
	bool FChangingStyle;
	Classes::TStrings* FCategories;
	bool FCreatingFlag;
	bool FDesigning;
	bool FDetachingSubMenu;
	Graphics::TColor FDockColor;
	Classes::TList* FDockControls;
	bool FDragging;
	TdxBarItem* FDraggingItem;
	TdxBarItemLink* FDraggingItemLink;
	HWND FDraggingItemLinkParentHandle;
	HFONT FEditFontHandle;
	bool FFirstDocksUpdate;
	bool FFlatCloseButton;
	HBRUSH FFlatToolbarsBrush;
	HBRUSH FFlatToolbarsDownedBrush;
	HBRUSH FFlatToolbarsDownedSelBrush;
	HBRUSH FFlatToolbarsSelBrush;
	TCustomdxBarControl* FFocusedBarControl;
	Graphics::TFont* FFont;
	Classes::TList* FGroups;
	Graphics::TBitmap* FHelpButtonGlyph;
	Classes::THelpContext FHelpContext;
	Graphics::TColor FImageListBkColor;
	Imglist::TCustomImageList* FImages;
	Imglist::TCustomImageList* FLargeImages;
	Imglist::TCustomImageList* FHotImages;
	Imglist::TChangeLink* FImagesChangeLink;
	Imglist::TChangeLink* FLargeImagesChangeLink;
	Imglist::TChangeLink* FHotImagesChangeLink;
	AnsiString FIniFileName;
	bool FIsCustomizing;
	Classes::TList* FItems;
	int FLargeButtonArrowWidth;
	bool FLargeIcons;
	bool FLockUpdate;
	Forms::TCustomForm* FMainForm;
	TdxBar* FMainMenuBar;
	TdxBarMenuAnimations FMenuAnimations;
	bool FMenusShowRecentItemsFirst;
	bool FModified;
	Byte FMostRecentItemsPercents;
	int FMostRecentlyUsedUseCount;
	TdxBarDockingStyles FNotDocking;
	TdxBarPopupMenuLinks* FPopupMenuLinks;
	Classes::TList* FPopupMenus;
	HWND FPrevActiveMDIChild;
	bool FPrevChildMainMenuVisible;
	int FReadStateCount;
	AnsiString FRegistryPath;
	bool FScaled;
	TdxBarItemControl* FSelectedItem;
	HBRUSH FShadowBrush;
	bool FShowCloseButton;
	bool FShowFullMenusAfterDelay;
	bool FShowHelpButton;
	bool FShowHint;
	bool FShowHintForDisabledItems;
	bool FShowShortCutInHint;
	bool FStoreInIniFile;
	bool FStoreInRegistry;
	bool FStretchGlyphs;
	TdxBarManagerStyle FStyle;
	bool FSunkenBorder;
	Classes::TList* FTempBarsList;
	bool FToolbarsVisibleChanging;
	bool FUseF10ForMenu;
	bool FUseFullReset;
	bool FUseSystemFont;
	int FWaitForDockingTime;
	bool IsMDIMaximized;
	int FBeforeFingersSize;
	int FFingersSize;
	int FSubMenuBeginGroupIndent;
	int FGlyphSize;
	int FButtonWidth;
	int FButtonHeight;
	int FRealButtonArrowWidth;
	TdxBarEvent FOnBarAdd;
	TdxBarEvent FOnBarAfterReset;
	TdxBarEvent FOnBarBeforeReset;
	TdxBarEvent FOnBarClose;
	TdxBarEvent FOnBarDelete;
	TdxBarEvent FOnBarDockingStyleChange;
	TdxBarVisibleChangeEvent FOnBarVisibleChange;
	TdxBarItemLinkEvent FOnItemLinkAdd;
	TdxBarItemLinkEvent FOnItemLinkChange;
	TdxBarItemLinkEvent FOnItemLinkDelete;
	Classes::TNotifyEvent FOnCloseButtonClick;
	TdxBarCanDockingEvent FOnDocking;
	Classes::TNotifyEvent FOnHelpButtonClick;
	Classes::TNotifyEvent FOnHideCustomizingForm;
	TdxBarMenuMergeEvent FOnMenuMerge;
	Classes::TNotifyEvent FOnShowCustomizingForm;
	TdxBarShowPopupEvent FOnShowCustomizingPopup;
	TdxBarShowPopupEvent FOnShowToolbarsPopup;
	TdxBarClickItemEvent FOnClickItem;
	bool __fastcall GetBarControlFocused(void);
	TdxBarItemVisible __fastcall GetCategoryItemsVisible(int AIndex);
	bool __fastcall GetCategoryVisible(int AIndex);
	Graphics::TColor __fastcall GetDockColor(void);
	TdxDockControl* __fastcall GetDockControl(int Index);
	int __fastcall GetDockControlCount(void);
	bool __fastcall GetFlat(void);
	unsigned __fastcall GetFlatToolbarsColor(void);
	unsigned __fastcall GetFlatToolbarsDownedColor(void);
	unsigned __fastcall GetFlatToolbarsDownedSelColor(void);
	unsigned __fastcall GetFlatToolbarsSelColor(void);
	TdxBarGroup* __fastcall GetGroup(int Index);
	int __fastcall GetGroupCount(void);
	bool __fastcall GetIsCustomizing(void);
	bool __fastcall GetIsDestroying(void);
	bool __fastcall GetIsLoading(void);
	int __fastcall GetItemCount(void);
	TdxBarItem* __fastcall GetItem(int Index);
	TdxBarControl* __fastcall GetMainMenuControl(void);
	int __fastcall GetRealLargeButtonArrowWidth(void);
	HBRUSH __fastcall GetShadowBrush(void);
	void __fastcall SetAutoDockColor(bool Value);
	void __fastcall SetAutoHideEmptyBars(bool Value);
	void __fastcall SetBars(TdxBars* Value);
	void __fastcall SetButtonArrowWidth(int Value);
	void __fastcall SetCategories(Classes::TStrings* Value);
	void __fastcall SetCategoryItemsVisible(int AIndex, TdxBarItemVisible Value);
	void __fastcall SetCategoryVisible(int AIndex, bool Value);
	void __fastcall SetDockColor(Graphics::TColor Value);
	void __fastcall SetFlatCloseButton(bool Value);
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetHelpButtonGlyph(Graphics::TBitmap* Value);
	void __fastcall SetHotImages(Imglist::TCustomImageList* Value);
	void __fastcall SetImageListBkColor(Graphics::TColor Value);
	void __fastcall SetImages(Imglist::TCustomImageList* Value);
	void __fastcall SetLargeButtonArrowWidth(int Value);
	void __fastcall SetLargeIcons(bool Value);
	void __fastcall SetLargeImages(Imglist::TCustomImageList* Value);
	void __fastcall SetLockUpdate(bool Value);
	void __fastcall SetMenuAnimations(TdxBarMenuAnimations Value);
	void __fastcall SetMenusShowRecentItemsFirst(bool Value);
	void __fastcall SetMostRecentItemsPercents(Byte Value);
	void __fastcall SetPopupMenuLinks(TdxBarPopupMenuLinks* Value);
	void __fastcall SetScaled(bool Value);
	void __fastcall SetSelectedItem(TdxBarItemControl* Value);
	void __fastcall SetShowCloseButton(bool Value);
	void __fastcall SetShowFullMenusAfterDelay(bool Value);
	void __fastcall SetShowHelpButton(bool Value);
	void __fastcall SetShowHint(bool Value);
	void __fastcall SetShowShortCutInHint(bool Value);
	void __fastcall SetStyle(TdxBarManagerStyle Value);
	void __fastcall SetSunkenBorder(bool Value);
	void __fastcall SetUseSystemFont(bool Value);
	void __fastcall SetWaitForDockingTime(int Value);
	void __fastcall AddCustomizeLink(TdxBarItemLinks* ItemLinks, bool ABeginGroup, TMetaClass* ItemClass);
	void __fastcall CalcButtonsConsts(void);
	void __fastcall DrawDraggingLine(TdxBarItemControl* AControl, bool IsBeginGroup, bool IsFirstPart, bool IsVerticalDirection);
	void __fastcall FontChanged(System::TObject* Sender);
	HWND __fastcall ActiveMDIChild(void);
	void __fastcall MainFormClientWndProc(unsigned Msg, int wParam, int lParam);
	void __fastcall MainFormWndProc(unsigned Msg, int wParam, int lParam);
	Forms::TForm* __fastcall LoadMainFormFromBin(void);
	void __fastcall CheckToolbarsVisibility(void);
	void __fastcall DisplayHint(void);
	void __fastcall HintActivate(bool AShow, const AnsiString CustomHint);
	void __fastcall DestroyItems(void);
	void __fastcall HelpButtonGlyphChanged(System::TObject* Sender);
	void __fastcall HotImageListChange(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall LargeImageListChange(System::TObject* Sender);
	void __fastcall ToolbarsPopupClick(System::TObject* Sender);
	void __fastcall CalcMostRecentlyUsedUseCount(void);
	bool __fastcall ShowRecentItemsFirst(void);
	void __fastcall AddDockControl(TdxDockControl* ADockControl);
	void __fastcall RemoveDockControl(TdxDockControl* ADockControl);
	void __fastcall AddGroup(TdxBarGroup* AGroup);
	void __fastcall RemoveGroup(TdxBarGroup* AGroup);
	bool __fastcall IsDockColorStored(void);
	void __fastcall ReadDockControlHeights(Classes::TReader* Reader);
	void __fastcall WriteDockControlHeights(Classes::TWriter* Writer);
	void __fastcall CreateFlatToolbarsBrushes(void);
	void __fastcall DestroyFlatToolbarsBrushes(void);
	
protected:
	void __fastcall AssignFont(void);
	bool __fastcall CanReset(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall DesignerModified(void);
	DYNAMIC void __fastcall DoBarAfterReset(TdxBar* ABar);
	DYNAMIC void __fastcall DoBarBeforeReset(TdxBar* ABar);
	DYNAMIC void __fastcall DoBarClose(TdxBar* ABar);
	DYNAMIC void __fastcall DoBarDockingStyleChanged(TdxBar* ABar);
	virtual void __fastcall DoClickItem(TdxBarItem* AItem);
	DYNAMIC void __fastcall DoCloseButtonClick(void);
	virtual bool __fastcall DoDocking(TdxBar* ABar, TdxBarDockingStyle AStyle, TdxDockControl* ADockControl);
	DYNAMIC void __fastcall DoHelpButtonClick(void);
	DYNAMIC void __fastcall DoShowCustomizingPopup(TdxBarItemLinks* PopupItemLinks);
	DYNAMIC void __fastcall DoShowToolbarsPopup(TdxBarItemLinks* PopupItemLinks);
	void __fastcall DragAndDrop(TdxBarItem* AItem, TdxBarItemLink* AItemLink);
	int __fastcall GetCategoryRealIndex(int AIndex);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	HWND __fastcall GetWindowForMouseCapturing(void);
	void __fastcall HotImagesChanged(void);
	void __fastcall ImagesChanged(void);
	void __fastcall LargeImagesChanged(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall SetName(const AnsiString NewName);
	void __fastcall UpdateItems(TdxBarItem* Sender);
	__property bool BarControlFocused = {read=GetBarControlFocused, nodefault};
	__property bool Dragging = {read=FDragging, nodefault};
	__property TdxBarItem* DraggingItem = {read=FDraggingItem};
	__property TdxBarItemLink* DraggingItemLink = {read=FDraggingItemLink};
	__property TCustomdxBarControl* FocusedBarControl = {read=FFocusedBarControl};
	__property bool IsDestroying = {read=GetIsDestroying, nodefault};
	__property bool IsLoading = {read=GetIsLoading, nodefault};
	int __fastcall BorderSizeX(void);
	int __fastcall BorderSizeY(void);
	__property int BeforeFingersSize = {read=FBeforeFingersSize, nodefault};
	__property int FingersSize = {read=FFingersSize, nodefault};
	__property int SubMenuBeginGroupIndent = {read=FSubMenuBeginGroupIndent, nodefault};
	__property int GlyphSize = {read=FGlyphSize, nodefault};
	__property int ButtonWidth = {read=FButtonWidth, nodefault};
	__property int ButtonHeight = {read=FButtonHeight, nodefault};
	__property int RealButtonArrowWidth = {read=FRealButtonArrowWidth, nodefault};
	__property int RealLargeButtonArrowWidth = {read=GetRealLargeButtonArrowWidth, nodefault};
	__property bool Flat = {read=GetFlat, nodefault};
	__property HBRUSH FlatToolbarsBrush = {read=FFlatToolbarsBrush, nodefault};
	__property HBRUSH FlatToolbarsDownedBrush = {read=FFlatToolbarsDownedBrush, nodefault};
	__property HBRUSH FlatToolbarsDownedSelBrush = {read=FFlatToolbarsDownedSelBrush, nodefault};
	__property HBRUSH FlatToolbarsSelBrush = {read=FFlatToolbarsSelBrush, nodefault};
	__property unsigned FlatToolbarsColor = {read=GetFlatToolbarsColor, nodefault};
	__property unsigned FlatToolbarsDownedColor = {read=GetFlatToolbarsDownedColor, nodefault};
	__property unsigned FlatToolbarsDownedSelColor = {read=GetFlatToolbarsDownedSelColor, nodefault};
	__property unsigned FlatToolbarsSelColor = {read=GetFlatToolbarsSelColor, nodefault};
	__property HBRUSH ShadowBrush = {read=GetShadowBrush, nodefault};
	
public:
	__fastcall virtual TdxBarManager(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarManager(void);
	TdxBar* __fastcall BarByCaption(const AnsiString ACaption);
	TdxBar* __fastcall BarByName(const AnsiString AName);
	int __fastcall GetAllItemsByCategory(int ACategory, Classes::TList* List);
	int __fastcall GetCountByCategory(int ACategory);
	TdxBarItem* __fastcall GetItemByCategory(int ACategory, int AIndex);
	TdxBarItem* __fastcall GetItemByName(const AnsiString AName);
	int __fastcall GetItemsByCategory(int ACategory, Classes::TList* List);
	void __fastcall MoveItem(int CurIndex, int NewIndex);
	void __fastcall ExchangeItems(int Index1, int Index2);
	void __fastcall CreateToolbarsPopupList(TdxBarItemLinks* ItemLinks);
	void __fastcall Customizing(bool Show);
	void __fastcall HideAll(void);
	void __fastcall ResetUsageData(void);
	void __fastcall ResetUsageDataWithConfirmation(void);
	void __fastcall LoadFromRegistry(AnsiString ARegistryPath);
	void __fastcall SaveToRegistry(AnsiString ARegistryPath);
	void __fastcall LoadFromIniFile(AnsiString AFileName);
	void __fastcall SaveToIniFile(AnsiString AFileName);
	TdxBarGroup* __fastcall CreateGroup(void);
	__property TdxBarItemVisible CategoryItemsVisible[int AIndex] = {read=GetCategoryItemsVisible, write=SetCategoryItemsVisible};
	__property bool CategoryVisible[int AIndex] = {read=GetCategoryVisible, write=SetCategoryVisible};
	__property bool Designing = {read=FDesigning, nodefault};
	__property int DockControlCount = {read=GetDockControlCount, nodefault};
	__property TdxDockControl* DockControls[int Index] = {read=GetDockControl};
	__property int GroupCount = {read=GetGroupCount, nodefault};
	__property TdxBarGroup* Groups[int Index] = {read=GetGroup};
	__property bool IsCustomizing = {read=GetIsCustomizing, nodefault};
	__property int ItemCount = {read=GetItemCount, nodefault};
	__property TdxBarItem* Items[int Index] = {read=GetItem};
	__property bool LockUpdate = {read=FLockUpdate, write=SetLockUpdate, nodefault};
	__property Forms::TCustomForm* MainForm = {read=FMainForm};
	__property TdxBarControl* MainMenuControl = {read=GetMainMenuControl};
	__property TdxBar* MainMenuBar = {read=FMainMenuBar};
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property TdxBarItemControl* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	
__published:
	__property bool AllowCallFromAnotherForm = {read=FAllowCallFromAnotherForm, write=FAllowCallFromAnotherForm, default=0};
	__property bool AllowReset = {read=FAllowReset, write=FAllowReset, default=1};
	__property bool AlwaysMerge = {read=FAlwaysMerge, write=FAlwaysMerge, default=0};
	__property bool AlwaysSaveText = {read=FAlwaysSaveText, write=FAlwaysSaveText, default=0};
	__property bool AutoDockColor = {read=FAutoDockColor, write=SetAutoDockColor, default=1};
	__property bool AutoHideEmptyBars = {read=FAutoHideEmptyBars, write=SetAutoHideEmptyBars, default=0};
	__property bool Scaled = {read=FScaled, write=SetScaled, default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TdxBars* Bars = {read=FBars, write=SetBars};
	__property int ButtonArrowWidth = {read=FButtonArrowWidth, write=SetButtonArrowWidth, default=9};
	__property bool CanCustomize = {read=FCanCustomize, write=FCanCustomize, default=1};
	__property Classes::TStrings* Categories = {read=FCategories, write=SetCategories};
	__property Graphics::TColor DockColor = {read=GetDockColor, write=SetDockColor, stored=IsDockColorStored, nodefault};
	__property bool FlatCloseButton = {read=FFlatCloseButton, write=SetFlatCloseButton, default=0};
	__property Graphics::TBitmap* HelpButtonGlyph = {read=FHelpButtonGlyph, write=SetHelpButtonGlyph};
	__property Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property Imglist::TCustomImageList* HotImages = {read=FHotImages, write=SetHotImages};
	__property Graphics::TColor ImageListBkColor = {read=FImageListBkColor, write=SetImageListBkColor, default=16711935};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property AnsiString IniFileName = {read=FIniFileName, write=FIniFileName};
	__property Imglist::TCustomImageList* LargeImages = {read=FLargeImages, write=SetLargeImages};
	__property int LargeButtonArrowWidth = {read=FLargeButtonArrowWidth, write=SetLargeButtonArrowWidth, default=14};
	__property bool LargeIcons = {read=FLargeIcons, write=SetLargeIcons, default=0};
	__property TdxBarMenuAnimations MenuAnimations = {read=FMenuAnimations, write=SetMenuAnimations, default=0};
	__property bool MenusShowRecentItemsFirst = {read=FMenusShowRecentItemsFirst, write=SetMenusShowRecentItemsFirst, default=1};
	__property Byte MostRecentItemsPercents = {read=FMostRecentItemsPercents, write=SetMostRecentItemsPercents, default=95};
	__property TdxBarDockingStyles NotDocking = {read=FNotDocking, write=FNotDocking, default=0};
	__property TdxBarPopupMenuLinks* PopupMenuLinks = {read=FPopupMenuLinks, write=SetPopupMenuLinks};
	__property AnsiString RegistryPath = {read=FRegistryPath, write=FRegistryPath};
	__property bool ShowCloseButton = {read=FShowCloseButton, write=SetShowCloseButton, default=0};
	__property bool ShowFullMenusAfterDelay = {read=FShowFullMenusAfterDelay, write=SetShowFullMenusAfterDelay, default=1};
	__property bool ShowHelpButton = {read=FShowHelpButton, write=SetShowHelpButton, default=0};
	__property bool ShowHint = {read=FShowHint, write=SetShowHint, default=1};
	__property bool ShowHintForDisabledItems = {read=FShowHintForDisabledItems, write=FShowHintForDisabledItems, default=1};
	__property bool ShowShortCutInHint = {read=FShowShortCutInHint, write=SetShowShortCutInHint, default=0};
	__property bool StoreInIniFile = {read=FStoreInIniFile, write=FStoreInIniFile, default=0};
	__property bool StoreInRegistry = {read=FStoreInRegistry, write=FStoreInRegistry, default=0};
	__property bool StretchGlyphs = {read=FStretchGlyphs, write=FStretchGlyphs, default=1};
	__property TdxBarManagerStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property bool SunkenBorder = {read=FSunkenBorder, write=SetSunkenBorder, default=0};
	__property bool UseF10ForMenu = {read=FUseF10ForMenu, write=FUseF10ForMenu, default=1};
	__property bool UseFullReset = {read=FUseFullReset, write=FUseFullReset, default=0};
	__property bool UseSystemFont = {read=FUseSystemFont, write=SetUseSystemFont, nodefault};
	__property int WaitForDockingTime = {read=FWaitForDockingTime, write=SetWaitForDockingTime, default=21};
	__property TdxBarEvent OnBarAdd = {read=FOnBarAdd, write=FOnBarAdd};
	__property TdxBarEvent OnBarAfterReset = {read=FOnBarAfterReset, write=FOnBarAfterReset};
	__property TdxBarEvent OnBarBeforeReset = {read=FOnBarBeforeReset, write=FOnBarBeforeReset};
	__property TdxBarEvent OnBarClose = {read=FOnBarClose, write=FOnBarClose};
	__property TdxBarEvent OnBarDelete = {read=FOnBarDelete, write=FOnBarDelete};
	__property TdxBarEvent OnBarDockingStyleChange = {read=FOnBarDockingStyleChange, write=FOnBarDockingStyleChange};
	__property TdxBarVisibleChangeEvent OnBarVisibleChange = {read=FOnBarVisibleChange, write=FOnBarVisibleChange};
	__property TdxBarItemLinkEvent OnItemLinkAdd = {read=FOnItemLinkAdd, write=FOnItemLinkAdd};
	__property TdxBarItemLinkEvent OnItemLinkChange = {read=FOnItemLinkChange, write=FOnItemLinkChange};
	__property TdxBarItemLinkEvent OnItemLinkDelete = {read=FOnItemLinkDelete, write=FOnItemLinkDelete};
	__property Classes::TNotifyEvent OnCloseButtonClick = {read=FOnCloseButtonClick, write=FOnCloseButtonClick};
	__property TdxBarCanDockingEvent OnDocking = {read=FOnDocking, write=FOnDocking};
	__property Classes::TNotifyEvent OnHelpButtonClick = {read=FOnHelpButtonClick, write=FOnHelpButtonClick};
	__property Classes::TNotifyEvent OnHideCustomizingForm = {read=FOnHideCustomizingForm, write=FOnHideCustomizingForm};
	__property TdxBarMenuMergeEvent OnMenuMerge = {read=FOnMenuMerge, write=FOnMenuMerge};
	__property Classes::TNotifyEvent OnShowCustomizingForm = {read=FOnShowCustomizingForm, write=FOnShowCustomizingForm};
	__property TdxBarShowPopupEvent OnShowCustomizingPopup = {read=FOnShowCustomizingPopup, write=FOnShowCustomizingPopup};
	__property TdxBarShowPopupEvent OnShowToolbarsPopup = {read=FOnShowToolbarsPopup, write=FOnShowToolbarsPopup};
	__property TdxBarClickItemEvent OnClickItem = {read=FOnClickItem, write=FOnClickItem};
};


class DELPHICLASS TdxBarManagerList;
class PASCALIMPLEMENTATION TdxBarManagerList : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	TdxBarManager* operator[](int Index) { return BarManagers[Index]; }
	
private:
	Classes::TList* FList;
	TdxBarManager* __fastcall GetBarManager(int Index);
	int __fastcall GetCount(void);
	TdxBarManager* __fastcall GetCustomizingBarManager(void);
	
public:
	__fastcall TdxBarManagerList(void);
	__fastcall virtual ~TdxBarManagerList(void);
	__property TdxBarManager* BarManagers[int Index] = {read=GetBarManager/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	__property TdxBarManager* CustomizingBarManager = {read=GetCustomizingBarManager};
};


#pragma option push -b-
enum TdxBarBorderStyle { bbsNone, bbsSingle };
#pragma option pop

class DELPHICLASS TdxBarDockControl;
#pragma option push -b-
enum TdxBarDockAlign { dalNone, dalTop, dalBottom, dalLeft, dalRight };
#pragma option pop

class PASCALIMPLEMENTATION TdxBarDockControl : public TdxDockControl 
{
	typedef TdxDockControl inherited;
	
private:
	bool FAllowZeroSizeInDesignTime;
	bool FSunkenBorder;
	bool FUseOwnColor;
	bool FUseOwnSunkenBorder;
	TdxBarDockAlign __fastcall GetAlign(void);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE bool __fastcall GetIsLoading(void);
	bool __fastcall GetParentColor(void);
	HIDESBASE void __fastcall SetAlign(TdxBarDockAlign Value);
	void __fastcall SetAllowZeroSizeInDesignTime(bool Value);
	HIDESBASE void __fastcall SetColor(Graphics::TColor Value);
	HIDESBASE void __fastcall SetParentColor(bool Value);
	void __fastcall SetSunkenBorder(bool Value);
	void __fastcall SetUseOwnColor(bool Value);
	void __fastcall SetUseOwnSunkenBorder(bool Value);
	HIDESBASE bool __fastcall IsColorStored(void);
	MESSAGE void __fastcall WMCreate(Messages::TWMCreate &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall BarManagerChanged(void);
	virtual bool __fastcall CanDocking(TdxBar* Bar);
	virtual void __fastcall ColorChanged(void);
	virtual int __fastcall GetClientSize(void);
	int __fastcall GetMinSize(void);
	virtual bool __fastcall GetSunkenBorder(void);
	__property bool IsLoading = {read=GetIsLoading, nodefault};
	
public:
	__fastcall virtual TdxBarDockControl(Classes::TComponent* AOwner);
	
__published:
	__property TdxBarDockAlign Align = {read=GetAlign, write=SetAlign, nodefault};
	__property AllowDocking  = {default=1};
	__property bool AllowZeroSizeInDesignTime = {read=FAllowZeroSizeInDesignTime, write=SetAllowZeroSizeInDesignTime, default=0};
	__property Anchors  = {default=3};
	__property BarManager ;
	__property Color  = {read=GetColor, write=SetColor, stored=IsColorStored, default=-2147483643};
	__property bool ParentColor = {read=GetParentColor, write=SetParentColor, stored=IsColorStored, nodefault};
	__property bool SunkenBorder = {read=GetSunkenBorder, write=SetSunkenBorder, stored=FUseOwnSunkenBorder, nodefault};
	__property bool UseOwnColor = {read=FUseOwnColor, write=SetUseOwnColor, default=0};
	__property bool UseOwnSunkenBorder = {read=FUseOwnSunkenBorder, write=SetUseOwnSunkenBorder, default=0};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnDblClick ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
public:
	#pragma option push -w-inl
	/* TdxDockControl.CreateEx */ inline __fastcall TdxBarDockControl(Classes::TComponent* AOwner, TdxBarManager* ABarManager, TdxBarDockingStyle ADockStyle) : TdxDockControl(AOwner, ABarManager, ADockStyle) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxDockControl.Destroy */ inline __fastcall virtual ~TdxBarDockControl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarDockControl(HWND ParentWindow) : TdxDockControl(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TdxBar : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FAllowClose;
	bool FAllowCustomizing;
	bool FAllowQuickCustomizing;
	bool FAllowReset;
	TdxBars* FBars;
	TdxBarBorderStyle FBorderStyle;
	AnsiString FCaption;
	bool FChangingDockingStyle;
	TdxBarDockControl* FDockControl;
	TdxBarDockControl* FDockedDockControl;
	TdxBarDockingStyle FDockedDockingStyle;
	int FDockedLeft;
	int FDockedTop;
	TdxBarDockingStyle FDockingStyle;
	HFONT FEditFontHandle;
	int FFloatLeft;
	int FFloatTop;
	int FFloatClientWidth;
	int FFloatClientHeight;
	Graphics::TFont* FFont;
	Classes::TList* FFreeNotificationItems;
	bool FHidden;
	bool FInternallyHidden;
	bool FIsMainMenu;
	bool FIsPredefined;
	TdxBarItemLinks* FItemLinks;
	TdxBarDockControl* FLoadedDockControl;
	TdxBarDockingStyle FLoadedDockingStyle;
	bool FLoadedVisible;
	bool FLockUpdate;
	AnsiString FName;
	TdxBarDockingStyles FNotDocking;
	bool FMultiLine;
	bool FOneOnRow;
	bool FRotateWhenVertical;
	int FRow;
	bool FShowMark;
	bool FSizeGrip;
	bool FUseOwnFont;
	bool FUseRecentItems;
	bool FUseRestSpace;
	bool FVisible;
	bool FWholeRow;
	TdxBarManager* __fastcall GetBarManager(void);
	TdxBarControl* __fastcall GetControl(void);
	TdxBarDockingStyle __fastcall GetDockedDockingStyle(void);
	TdxBarDockingStyle __fastcall GetDockingStyle(void);
	TdxDockControl* __fastcall GetRealDockControl(void);
	void __fastcall SetAllowClose(bool Value);
	void __fastcall SetAllowQuickCustomizing(bool Value);
	void __fastcall SetBorderStyle(TdxBarBorderStyle Value);
	void __fastcall SetCaption(AnsiString Value);
	void __fastcall SetDockControl(TdxBarDockControl* Value);
	void __fastcall SetDockedDockControl(TdxBarDockControl* Value);
	void __fastcall SetDockedValue(int Index, int Value);
	void __fastcall SetDockingStyle(TdxBarDockingStyle Value);
	void __fastcall SetFloatValue(int Index, int Value);
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetHidden(bool Value);
	void __fastcall SetIsMainMenu(bool Value);
	void __fastcall SetItemLinks(TdxBarItemLinks* Value);
	void __fastcall SetLockUpdate(bool Value);
	void __fastcall SetMultiLine(bool Value);
	void __fastcall SetRotateWhenVertical(bool Value);
	void __fastcall SetRow(int Value);
	void __fastcall SetShowMark(bool Value);
	void __fastcall SetSizeGrip(bool Value);
	void __fastcall SetUseOwnFont(bool Value);
	void __fastcall SetUseRecentItems(bool Value);
	void __fastcall SetUseRestSpace(bool Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetWholeRow(bool Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall ItemLinksChanged(System::TObject* Sender);
	void __fastcall ResetToolbarClick(System::TObject* Sender);
	bool __fastcall IsDockedDockingStyleStored(void);
	bool __fastcall IsDockingStyleStored(void);
	
protected:
	void __fastcall AddFreeNotification(TdxBarItem* AItem);
	void __fastcall RemoveFreeNotification(TdxBarItem* AItem);
	void __fastcall MakeFreeNotification(void);
	int __fastcall BarNCSizeX(TdxBarDockingStyle AStyle);
	int __fastcall BarNCSizeY(TdxBarDockingStyle AStyle);
	bool __fastcall CanClose(void);
	bool __fastcall CanReset(void);
	bool __fastcall HasShadow(void);
	bool __fastcall HasSizeGrip(void);
	bool __fastcall IsShortCut(Classes::TShortCut AShortCut);
	bool __fastcall IsStatusBar(void);
	__property TdxBars* Bars = {read=FBars};
	
public:
	__fastcall virtual TdxBar(Classes::TCollection* Collection);
	__fastcall virtual ~TdxBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ChangeDockingStyle(TdxBarDockingStyle AStyle, TdxDockControl* ADockControl);
	void __fastcall Reset(void);
	void __fastcall ResetWithConfirmation(void);
	__property TdxBarManager* BarManager = {read=GetBarManager};
	__property TdxBarControl* Control = {read=GetControl};
	__property bool IsPredefined = {read=FIsPredefined, nodefault};
	__property bool LockUpdate = {read=FLockUpdate, write=SetLockUpdate, nodefault};
	__property TdxDockControl* RealDockControl = {read=GetRealDockControl};
	
__published:
	__property bool AllowClose = {read=FAllowClose, write=SetAllowClose, default=1};
	__property bool AllowCustomizing = {read=FAllowCustomizing, write=FAllowCustomizing, default=1};
	__property bool AllowQuickCustomizing = {read=FAllowQuickCustomizing, write=SetAllowQuickCustomizing, default=1};
	__property bool AllowReset = {read=FAllowReset, write=FAllowReset, default=1};
	__property TdxBarBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property AnsiString Caption = {read=FCaption, write=SetCaption};
	__property TdxBarDockControl* DockControl = {read=FDockControl, write=SetDockControl};
	__property TdxBarDockControl* DockedDockControl = {read=FDockedDockControl, write=SetDockedDockControl};
	__property TdxBarDockingStyle DockedDockingStyle = {read=GetDockedDockingStyle, write=FDockedDockingStyle, stored=IsDockedDockingStyleStored, nodefault};
	__property int DockedLeft = {read=FDockedLeft, write=SetDockedValue, index=1, nodefault};
	__property int DockedTop = {read=FDockedTop, write=SetDockedValue, index=2, nodefault};
	__property TdxBarDockingStyle DockingStyle = {read=GetDockingStyle, write=SetDockingStyle, stored=IsDockingStyleStored, nodefault};
	__property int FloatLeft = {read=FFloatLeft, write=SetFloatValue, index=1, nodefault};
	__property int FloatTop = {read=FFloatTop, write=SetFloatValue, index=2, nodefault};
	__property int FloatClientWidth = {read=FFloatClientWidth, write=SetFloatValue, index=3, nodefault};
	__property int FloatClientHeight = {read=FFloatClientHeight, write=SetFloatValue, index=4, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont, stored=FUseOwnFont};
	__property bool Hidden = {read=FHidden, write=SetHidden, default=0};
	__property bool IsMainMenu = {read=FIsMainMenu, write=SetIsMainMenu, default=0};
	__property TdxBarItemLinks* ItemLinks = {read=FItemLinks, write=SetItemLinks};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiLine, default=0};
	__property AnsiString Name = {read=FName, write=FName};
	__property TdxBarDockingStyles NotDocking = {read=FNotDocking, write=FNotDocking, default=0};
	__property bool OneOnRow = {read=FOneOnRow, write=FOneOnRow, nodefault};
	__property bool RotateWhenVertical = {read=FRotateWhenVertical, write=SetRotateWhenVertical, default=1};
	__property int Row = {read=FRow, write=SetRow, nodefault};
	__property bool ShowMark = {read=FShowMark, write=SetShowMark, default=1};
	__property bool SizeGrip = {read=FSizeGrip, write=SetSizeGrip, default=1};
	__property bool UseOwnFont = {read=FUseOwnFont, write=SetUseOwnFont, nodefault};
	__property bool UseRecentItems = {read=FUseRecentItems, write=SetUseRecentItems, default=1};
	__property bool UseRestSpace = {read=FUseRestSpace, write=SetUseRestSpace, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property bool WholeRow = {read=FWholeRow, write=SetWholeRow, nodefault};
};


typedef TdxDockControl* TdxDockControls[4];

class PASCALIMPLEMENTATION TdxBars : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TdxBar* operator[](int Index) { return Items[Index]; }
	
private:
	TdxDockControl* FDockControls[4];
	bool FDocking;
	int FDockingZoneSize;
	TdxBarManager* FBarManager;
	bool FLoading;
	bool FMoving;
	TdxBarControl* FMovingBarControl;
	TdxBarDockingStyle FMovingBarOriginalDockingStyle;
	#pragma pack(push, 1)
	Types::TPoint FMovingOffset;
	#pragma pack(pop)
	
	#pragma pack(push, 1)
	Types::TPoint FMovingStaticOffset;
	#pragma pack(pop)
	
	TdxDockControl* __fastcall GetDockControl(TdxBarDockingStyle Index);
	HIDESBASE TdxBar* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TdxBar* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall RegInDock(TdxBarDockingStyle AStyle, TdxDockControl* ADockControl, TdxBarControl* ABarControl, const Types::TPoint &APos);
	void __fastcall UnregFromDock(TdxBarDockingStyle AStyle, TdxDockControl* ADockControl, TdxBarControl* ABarControl);
	void __fastcall ChangeBarControlPos(TdxBarControl* ABarControl, const Types::TPoint &APos);
	TdxBarDockingStyle __fastcall GetDockingStyleAtPos(TdxBar* Bar, const Types::TPoint &Pos, TdxDockControl* &DockControl);
	void __fastcall Moving(TdxBarControl* AMovingBarControl);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	__property int DockingZoneSize = {read=FDockingZoneSize, write=FDockingZoneSize, nodefault};
	
public:
	__fastcall TdxBars(TdxBarManager* ABarManager);
	__fastcall virtual ~TdxBars(void);
	HIDESBASE TdxBar* __fastcall Add(void);
	AnsiString __fastcall GetUniqueToolbarName(const AnsiString BaseName);
	__property TdxBarManager* BarManager = {read=FBarManager};
	__property TdxDockControl* DockControls[TdxBarDockingStyle Index] = {read=GetDockControl};
	__property bool IsLoading = {read=FLoading, write=FLoading, nodefault};
	__property TdxBar* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


typedef void __fastcall (__closure *TdxBarIterationProc)(int Index, TdxBarItemLink* ItemLink, bool &Stop, void * &Data);

class DELPHICLASS TdxDockCol;
class PASCALIMPLEMENTATION TdxDockCol : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TdxBarControl* FBarControl;
	TdxDockRow* FDockRow;
	#pragma pack(push, 1)
	Types::TPoint FPos;
	#pragma pack(pop)
	
	
public:
	__fastcall TdxDockCol(TdxDockRow* ADockRow, TdxBarControl* ABarControl);
	void __fastcall AssignPosition(void);
	__property TdxBarControl* BarControl = {read=FBarControl};
	__property TdxDockRow* DockRow = {read=FDockRow};
	__property Types::TPoint Pos = {read=FPos, write=FPos};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TdxDockCol(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TdxDockRow : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	Classes::TList* FColList;
	TdxDockControl* FDockControl;
	TdxDockCol* __fastcall GetCol(int Index);
	int __fastcall GetColCount(void);
	
public:
	__fastcall TdxDockRow(TdxDockControl* ADockControl);
	__fastcall virtual ~TdxDockRow(void);
	__property int ColCount = {read=GetColCount, nodefault};
	__property Classes::TList* ColList = {read=FColList};
	__property TdxDockCol* Cols[int Index] = {read=GetCol};
	__property TdxDockControl* DockControl = {read=FDockControl};
};


#pragma option push -b-
enum TdxBarMDIButton { mdibMinimize, mdibRestore, mdibClose };
#pragma option pop

class PASCALIMPLEMENTATION TdxBarControl : public TCustomdxBarControl 
{
	typedef TCustomdxBarControl inherited;
	
private:
	HWND BeforeBarGetFocusFocusedWnd;
	TdxBar* FBar;
	TdxBarMarkState FCloseButtonState;
	HWND FDockedHandle;
	HWND FFloatingHandle;
	bool FEditSizingCursor;
	bool FRightBorderSizing;
	bool FHasCaption;
	bool FHasSizeGrip;
	int FHitTest;
	int FInternalLockCount;
	bool FIsDowned;
	int FMDIButtonWidth;
	int FMDIButtonHeight;
	int FMinSize;
	int FMaxSize;
	unsigned FMoreButtonsHintTimer;
	bool FMoving;
	bool FSettingFont;
	int FSizingEditWidth;
	bool FTruncated;
	TdxBarControl* FQuickPopup;
	int NewLeft;
	int NewTop;
	int NewWidth;
	int NewHeight;
	#pragma pack(push, 1)
	Types::TPoint RX;
	#pragma pack(pop)
	
	#pragma pack(push, 1)
	Types::TPoint RY;
	#pragma pack(pop)
	
	int __fastcall GetCaptionBkColor(void);
	bool __fastcall GetHorizontal(void);
	bool __fastcall GetInternallyLocked(void);
	bool __fastcall GetMultiLine(void);
	bool __fastcall GetVertical(void);
	void __fastcall SetCloseButtonState(TdxBarMarkState Value);
	void __fastcall SetMoving(bool Value);
	void __fastcall CalcControlsPositions(void);
	void __fastcall ChangeStyleWinTo(TdxBarDockingStyle AStyle, TdxDockControl* ADockControl);
	void __fastcall DrawEditSizingFrame(int AWidth);
	Types::TPoint __fastcall GetDragPointOffset(TdxBarDockingStyle Style);
	Types::TRect __fastcall GetCaptionNCRect();
	Types::TRect __fastcall GetCaptionRect();
	void __fastcall DrawCaptionElement(HDC DC, const Types::TRect &R, TdxBarMarkState AState);
	void __fastcall DrawCloseButton(HDC DC);
	void __fastcall DrawMark(HDC DC);
	void __fastcall DrawMDIButton(TdxBarMDIButton AButton, bool APressed);
	int __fastcall GetMDIWidth(void);
	int __fastcall GetMDIHeight(void);
	Types::TRect __fastcall RectMDI(TdxBarMDIButton Button);
	bool __fastcall RealMDIButtonsOnBar(void);
	bool __fastcall MDIButtonsOnBar(void);
	bool __fastcall MDIButtonEnabled(TdxBarMDIButton AButton, int State);
	void __fastcall StartMoreButtonsHintTimer(void);
	void __fastcall FinishMoreButtonsHintTimer(void);
	void __fastcall CheckMarkState(const Types::TPoint &P);
	HIDESBASE MESSAGE void __fastcall WMCaptureChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TWMGetMinMaxInfo &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMNCLButtonDown(Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall WMSizing(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall BeginInternal(void);
	void __fastcall EndInternal(void);
	__property bool InternallyLocked = {read=GetInternallyLocked, nodefault};
	virtual void __fastcall CalcDrawingConsts(void);
	virtual bool __fastcall CanAlignControls(void);
	virtual bool __fastcall CanCallInheritedNCCalcSize(void);
	virtual bool __fastcall CanCustomizing(void);
	DYNAMIC bool __fastcall CanFinishMouseTracking(const Messages::TWMNCHitTest &Message);
	Types::TRect __fastcall CloseButtonRect();
	Types::TRect __fastcall CloseButtonRectNC();
	virtual int __fastcall GetBeginGroupSize(void);
	int __fastcall GetCol(void);
	TdxDockCol* __fastcall GetDockCol(void);
	int __fastcall GetRow(void);
	int __fastcall GetMinWidth(TdxBarDockingStyle AStyle);
	int __fastcall GetMinHeight(TdxBarDockingStyle AStyle);
	int __fastcall GetMaxWidth(TdxBarDockingStyle AStyle);
	int __fastcall GetMaxHeight(TdxBarDockingStyle AStyle);
	void __fastcall GetMultiLineBarSize(TdxBarDockingStyle AStyle, int ASize, Types::TPoint &Result);
	Types::TPoint __fastcall GetSizeForWidth(TdxBarDockingStyle AStyle, int AWidth);
	Types::TPoint __fastcall GetSizeForHeight(TdxBarDockingStyle AStyle, int AHeight);
	Types::TPoint __fastcall GetTrackSize(TdxBarDockingStyle AStyle);
	void __fastcall InvalidateMark(void);
	virtual bool __fastcall MarkExists(void);
	Types::TRect __fastcall MarkRect();
	Types::TRect __fastcall MarkRectNC();
	Types::TRect __fastcall SizeGripRect();
	void __fastcall BarManagerStyleChanged(void);
	virtual void __fastcall CaptionChanged(void);
	void __fastcall FrameChanged(void);
	virtual HFONT __fastcall GetEditFontHandle(void);
	virtual Types::TRect __fastcall GetFullItemRect(TdxBarItemControl* Item);
	virtual HRGN __fastcall GetItemRegion(TdxBarItemControl* Item);
	virtual HBRUSH __fastcall GetToolbarBrush(void);
	virtual TdxBarItemControl* __fastcall ItemAtPosEx(const Types::TPoint &Pos, bool &IsBeginGroup, bool &IsFirstPart, bool &IsVerticalDirection);
	virtual bool __fastcall NotHandleMouseMove(const Types::TPoint &P);
	virtual void __fastcall PaintItem(TdxBarItemControl* AControl);
	void __fastcall RebuildBar(void);
	void __fastcall SavePos(void);
	virtual void __fastcall SetFont(void);
	virtual void __fastcall SetIsActive(bool Value);
	virtual void __fastcall SetDockingStyle(TdxBarDockingStyle Value);
	virtual void __fastcall SetKeySelectedItem(TdxBarItemControl* Value);
	virtual void __fastcall SetMarkState(TdxBarMarkState Value);
	__property int CaptionBkColor = {read=GetCaptionBkColor, nodefault};
	__property TdxBarMarkState CloseButtonState = {read=FCloseButtonState, write=SetCloseButtonState, nodefault};
	__property bool Horizontal = {read=GetHorizontal, nodefault};
	__property bool IsDowned = {read=FIsDowned, write=FIsDowned, nodefault};
	__property bool Moving = {read=FMoving, write=SetMoving, nodefault};
	__property bool MultiLine = {read=GetMultiLine, nodefault};
	__property bool Vertical = {read=GetVertical, nodefault};
	__property int MDIButtonWidth = {read=FMDIButtonWidth, nodefault};
	__property int MDIButtonHeight = {read=FMDIButtonHeight, nodefault};
	
public:
	__fastcall virtual TdxBarControl(Classes::TComponent* AOwner, TdxBar* ABar);
	__fastcall virtual ~TdxBarControl(void);
	virtual void __fastcall BarGetFocus(TdxBarItemControl* ASelectedItem);
	virtual void __fastcall BarLostFocus(void);
	virtual void __fastcall HideAll(void);
	virtual void __fastcall Repaint(void);
	virtual void __fastcall RepaintBar(void);
	__property TdxBar* Bar = {read=FBar};
public:
	#pragma option push -w-inl
	/* TCustomdxBarControl.Create */ inline __fastcall virtual TdxBarControl(Classes::TComponent* AOwner) : TCustomdxBarControl(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarControl(HWND ParentWindow) : TCustomdxBarControl(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TXDirection { xdLeft, xdRight };
#pragma option pop

#pragma option push -b-
enum TYDirection { ydTop, ydBottom };
#pragma option pop

class DELPHICLASS TdxBarSubMenuControl;
class DELPHICLASS TdxBarButtonControl;
#pragma option push -b-
enum TdxBarButtonStyle { bsDefault, bsChecked, bsDropDown };
#pragma option pop

class DELPHICLASS TdxBarButton;
class PASCALIMPLEMENTATION TdxBarButtonControl : public TdxBarItemControl 
{
	typedef TdxBarItemControl inherited;
	
private:
	bool FDroppedDown;
	bool FShowAnimation;
	bool __fastcall ArrowPressed(void);
	TdxBarButtonStyle __fastcall GetButtonStyle(void);
	bool __fastcall GetDown(void);
	bool __fastcall GetDropDownEnabled(void);
	TdxBarSubMenuControl* __fastcall GetDropDownMenuControl(void);
	int __fastcall GetGroupIndex(void);
	HIDESBASE TdxBarButton* __fastcall GetItem(void);
	bool __fastcall GetLowered(void);
	TdxBarPaintStyle __fastcall GetPaintStyle(void);
	bool __fastcall MouseOverArrow(void);
	
protected:
	virtual int __fastcall ArrowWidth(void);
	virtual void __fastcall ButtonStyleChanged(void);
	virtual void __fastcall ControlInactivate(bool Immediately);
	virtual void __fastcall ControlClick(bool ByMouse);
	virtual void __fastcall ControlUnclick(bool ByMouse);
	DYNAMIC void __fastcall DoCloseUp(void);
	DYNAMIC void __fastcall DoDropDown(bool ByMouse);
	virtual void __fastcall DownChanged(void);
	void __fastcall DrawArrow(const Types::TRect &ARect, bool Selected, TdxBarPaintType PaintType);
	virtual bool __fastcall DrawSelected(void);
	virtual void __fastcall DropDownEnabledChanged(void);
	virtual void __fastcall GlyphChanged(void);
	virtual int __fastcall GetDefaultHeight(void);
	virtual int __fastcall GetDefaultWidth(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual bool __fastcall IsDestroyOnClick(void);
	virtual void __fastcall KeyDown(Word Key);
	virtual bool __fastcall NeedCaptureMouse(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, TdxBarPaintType PaintType);
	virtual void __fastcall PaintStyleChanged(void);
	virtual bool __fastcall WantsKey(Word Key);
	__property TdxBarButtonStyle ButtonStyle = {read=GetButtonStyle, nodefault};
	__property bool Down = {read=GetDown, nodefault};
	__property bool DropDownEnabled = {read=GetDropDownEnabled, nodefault};
	__property TdxBarSubMenuControl* DropDownMenuControl = {read=GetDropDownMenuControl};
	__property bool DroppedDown = {read=FDroppedDown, nodefault};
	__property int GroupIndex = {read=GetGroupIndex, nodefault};
	__property bool Lowered = {read=GetLowered, nodefault};
	__property TdxBarPaintStyle PaintStyle = {read=GetPaintStyle, nodefault};
	
public:
	__property TdxBarButton* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarButtonControl(TdxBarItemLink* AItemLink) : TdxBarItemControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarItemControl.Destroy */ inline __fastcall virtual ~TdxBarButtonControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarSubItemControl;
class DELPHICLASS TCustomdxBarSubItem;
class PASCALIMPLEMENTATION TdxBarSubItemControl : public TdxBarItemControl 
{
	typedef TdxBarItemControl inherited;
	
private:
	bool FShowAnimation;
	HIDESBASE TCustomdxBarSubItem* __fastcall GetItem(void);
	
protected:
	virtual void __fastcall GlyphChanged(void);
	virtual TdxBarSubMenuControl* __fastcall GetSubMenuControl(void);
	virtual bool __fastcall CanClicked(void);
	virtual void __fastcall ControlActivate(bool Immediately);
	virtual void __fastcall ControlInactivate(bool Immediately);
	virtual void __fastcall ControlClick(bool ByMouse);
	virtual void __fastcall CreateSubMenuControl(void);
	virtual int __fastcall GetDefaultHeight(void);
	virtual int __fastcall GetDefaultWidth(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual bool __fastcall HasSubMenu(void);
	virtual bool __fastcall IsDestroyOnClick(void);
	virtual bool __fastcall IsExpandable(void);
	virtual void __fastcall KeyDown(Word Key);
	virtual void __fastcall Paint(const Types::TRect &ARect, TdxBarPaintType PaintType);
	DYNAMIC bool __fastcall WantsDblClick(void);
	virtual bool __fastcall WantsKey(Word Key);
	
public:
	__fastcall virtual ~TdxBarSubItemControl(void);
	__property TCustomdxBarSubItem* Item = {read=GetItem};
	__property TdxBarSubMenuControl* SubMenuControl = {read=GetSubMenuControl};
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarSubItemControl(TdxBarItemLink* AItemLink) : TdxBarItemControl(AItemLink) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TdxBarSubMenuControl : public TCustomdxBarControl 
{
	typedef TCustomdxBarControl inherited;
	
private:
	bool FDestroyingControls;
	bool FDetachCaptionSelected;
	TdxBarButtonControl* FDropDownButton;
	bool FExpandingMenu;
	unsigned FExpandMenuTimer;
	HBRUSH FLightBrush;
	HPALETTE FLightPalette;
	int FMarkSize;
	TdxBarMenuAnimations FMenuAnimations;
	int FNormalItemHeight;
	int FOnShowLeft;
	int FOnShowTop;
	int FOwnerWidth;
	int FOwnerHeight;
	Classes::TList* FSavedItemLinks;
	unsigned FScrollTimerID;
	bool FShowAnimation;
	int FTopIndex;
	TdxBarSubItemControl* FSubItem;
	TXDirection XDirection;
	TYDirection YDirection;
	Classes::TNotifyEvent FOnCloseUp;
	Classes::TNotifyEvent FOnPopup;
	int __fastcall GetBarSize(void);
	int __fastcall GetBorderSize(void);
	int __fastcall GetMaxVisibleCount(void);
	HBRUSH __fastcall GetToolbarItemsBrush(void);
	void __fastcall SetDetachCaptionSelected(bool Value);
	void __fastcall SetTopIndex(int Value);
	void __fastcall CalcControlsPositions(Types::PPoint Size);
	void __fastcall CreateLightBrush(void);
	void __fastcall DestroyLightBrush(void);
	void __fastcall PreparePalette(HDC DC);
	void __fastcall UnpreparePalette(HDC DC);
	void __fastcall ExpandMenu(void);
	bool __fastcall ExtendedView(void);
	void __fastcall InvalidateDetachCaption(void);
	bool __fastcall MouseOnUpArrow(void);
	bool __fastcall MouseOnDownArrow(void);
	bool __fastcall MouseOnMark(void);
	void __fastcall SetExpandMenuTimer(unsigned Time, bool ExpandAfterDelay);
	void __fastcall KillExpandMenuTimer(void);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	
protected:
	HWND ParentWnd;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWindowHandle(void);
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall DoCloseUp(void);
	DYNAMIC void __fastcall DoPopup(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CalcDrawingConsts(void);
	virtual bool __fastcall CanCustomizing(void);
	virtual void __fastcall CreateControls(void);
	virtual void __fastcall DestroyControls(void);
	void __fastcall DrawBar(const Types::TRect &R);
	virtual int __fastcall GetBeginGroupSize(void);
	virtual HFONT __fastcall GetEditFontHandle(void);
	virtual Types::TRect __fastcall GetItemRectEx(TdxBarItemControl* Item, bool IsBeginGroup);
	virtual bool __fastcall HideOnClick(void);
	virtual TdxBarItemControl* __fastcall ItemAtPosEx(const Types::TPoint &Pos, bool &IsBeginGroup, bool &IsFirstPart, bool &IsVerticalDirection);
	virtual void __fastcall PaintItem(TdxBarItemControl* AControl);
	virtual void __fastcall SetFont(void);
	virtual void __fastcall SetIsActive(bool Value);
	virtual void __fastcall SetMarkState(TdxBarMarkState Value);
	void __fastcall SetRecentItemCount(void);
	virtual void __fastcall SetSelectedItem(TdxBarItemControl* Value);
	void __fastcall SetSizeAndCheckBounds(bool &ChangeXDirection, bool &ChangeYDirection);
	bool __fastcall CanDetach(void);
	bool __fastcall Detachable(void);
	int __fastcall DetachCaptionAreaSize(void);
	Types::TRect __fastcall DetachCaptionRect();
	bool __fastcall MouseOnDetachCaption(void);
	void __fastcall DoDetachMenu(void);
	int __fastcall MarkArrowSize(void);
	virtual bool __fastcall MarkExists(void);
	Types::TRect __fastcall MarkRect();
	bool __fastcall DownArrowExists(void);
	bool __fastcall UpArrowExists(void);
	int __fastcall VisibleCount(void);
	__property int BarSize = {read=GetBarSize, nodefault};
	__property int BorderSize = {read=GetBorderSize, nodefault};
	__property bool DetachCaptionSelected = {read=FDetachCaptionSelected, write=SetDetachCaptionSelected, nodefault};
	__property int MarkSize = {read=FMarkSize, nodefault};
	__property int NormalItemHeight = {read=FNormalItemHeight, nodefault};
	__property HBRUSH ToolbarItemsBrush = {read=GetToolbarItemsBrush, nodefault};
	__property int TopIndex = {read=FTopIndex, write=SetTopIndex, nodefault};
	__property int MaxVisibleCount = {read=GetMaxVisibleCount, nodefault};
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Classes::TNotifyEvent OnPopup = {read=FOnPopup, write=FOnPopup};
	
public:
	__fastcall virtual TdxBarSubMenuControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarSubMenuControl(void);
	HIDESBASE void __fastcall Hide(void);
	virtual void __fastcall HideAll(void);
	virtual void __fastcall RepaintBar(void);
	HIDESBASE void __fastcall Show(void);
	__property int OwnerWidth = {read=FOwnerWidth, write=FOwnerWidth, nodefault};
	__property int OwnerHeight = {read=FOwnerHeight, write=FOwnerHeight, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarSubMenuControl(HWND ParentWindow) : TCustomdxBarControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarItemActionLink;
class PASCALIMPLEMENTATION TdxBarItemActionLink : public Actnlist::TActionLink 
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TdxBarItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHelpContextLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsShortCutLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetAutoCheck(bool Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHelpContext(Classes::THelpContext Value);
	virtual void __fastcall SetHint(const AnsiString Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetShortCut(Classes::TShortCut Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TdxBarItemActionLink(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TdxBarItemActionLink(void) { }
	#pragma option pop
	
};


typedef TMetaClass*TdxBarItemActionLinkClass;

class PASCALIMPLEMENTATION TdxBarItem : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TdxBarItemActionLink* FActionLink;
	TdxBarItemAlign FAlign;
	TdxBarManager* FBarManager;
	AnsiString FCaption;
	int FCategory;
	TdxBarItemLink* FClickItemLink;
	void *FData;
	AnsiString FDescription;
	bool FEnabled;
	Graphics::TBitmap* FGlyph;
	Classes::THelpContext FHelpContext;
	AnsiString FHint;
	int FImageIndex;
	Classes::TList* FLinks;
	TdxBarItemVisible FLoadedVisible;
	Classes::TShortCut FShortCut;
	bool FUnclickAfterDoing;
	TdxBarItemVisible FVisible;
	Classes::TNotifyEvent FOnClick;
	Classes::TNotifyEvent FOnCreate;
	Classes::TNotifyEvent FOnDestroy;
	Classes::TBasicAction* __fastcall GetAction(void);
	bool __fastcall GetActuallyVisible(void);
	TdxBarItemLink* __fastcall GetCurItemLink(void);
	bool __fastcall GetEnabled(void);
	bool __fastcall GetFlat(void);
	int __fastcall GetIndex(void);
	bool __fastcall GetIsDesigning(void);
	bool __fastcall GetIsDestroying(void);
	bool __fastcall GetIsLoading(void);
	int __fastcall GetLinkCount(void);
	TdxBarItemLink* __fastcall GetLinks(int Index);
	bool __fastcall GetVisibleForUser(void);
	void __fastcall SetAction(Classes::TBasicAction* Value);
	void __fastcall SetAlign(TdxBarItemAlign Value);
	void __fastcall SetCaption(AnsiString Value);
	void __fastcall SetCategory(int Value);
	void __fastcall SetDescription(AnsiString Value);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	void __fastcall SetImageIndex(int Value);
	void __fastcall SetShortCut(Classes::TShortCut Value);
	void __fastcall SetVisible(TdxBarItemVisible Value);
	void __fastcall DestroyLinks(void);
	void __fastcall DoActionChange(System::TObject* Sender);
	bool __fastcall IsCaptionStored(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsHelpContextStored(void);
	bool __fastcall IsHintStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsShortCutStored(void);
	bool __fastcall IsVisibleStored(void);
	bool __fastcall IsOnClickStored(void);
	AnsiString __fastcall GetHintFromCaption();
	void __fastcall OnGlyphChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall SetName(const AnsiString NewName);
	DYNAMIC void __fastcall SetParentComponent(Classes::TComponent* AParent);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	DYNAMIC void __fastcall AlignChanged(void);
	virtual void __fastcall BarManagerChanged(void);
	virtual bool __fastcall CanClicked(void);
	virtual void __fastcall CaptionChanged(void);
	virtual void __fastcall EnabledChanged(void);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	virtual bool __fastcall GetHidden(void);
	virtual void __fastcall GlyphChanged(void);
	virtual bool __fastcall HasAccel(TdxBarItemLink* AItemLink);
	bool __fastcall HasControls(void);
	virtual void __fastcall HideControl(TdxBarItemControl* AControl);
	virtual void __fastcall HotGlyphChanged(void);
	bool __fastcall ImageIndexLinked(void);
	virtual void __fastcall LargeGlyphChanged(void);
	virtual bool __fastcall NeedToBeHidden(void);
	virtual void __fastcall ObjectNotification(Classes::TOperation AOperation, System::TObject* AObject);
	virtual void __fastcall ShortCutChanged(void);
	virtual void __fastcall Update(void);
	virtual void __fastcall UpdateEx(void);
	virtual bool __fastcall UseHotImages(void);
	virtual bool __fastcall UseLargeImages(void);
	virtual void __fastcall VisibleChanged(void);
	__property TdxBarItemActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	__property bool Flat = {read=GetFlat, nodefault};
	__property bool Hidden = {read=GetHidden, nodefault};
	__property bool IsDesigning = {read=GetIsDesigning, nodefault};
	__property bool IsDestroying = {read=GetIsDestroying, nodefault};
	__property bool IsLoading = {read=GetIsLoading, nodefault};
	__property Classes::TNotifyEvent OnCreate = {read=FOnCreate, write=FOnCreate};
	
public:
	__fastcall virtual TdxBarItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarItem(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DirectClick(void);
	DYNAMIC void __fastcall DoClick(void);
	DYNAMIC Classes::TComponent* __fastcall GetParentComponent(void);
	DYNAMIC bool __fastcall HasParent(void);
	__property bool ActuallyVisible = {read=GetActuallyVisible, nodefault};
	__property TdxBarManager* BarManager = {read=FBarManager};
	__property TdxBarItemLink* ClickItemLink = {read=FClickItemLink};
	__property TdxBarItemLink* CurItemLink = {read=GetCurItemLink};
	__property void * Data = {read=FData, write=FData};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property int Index = {read=GetIndex, nodefault};
	__property int LinkCount = {read=GetLinkCount, nodefault};
	__property TdxBarItemLink* Links[int Index] = {read=GetLinks};
	__property Classes::TShortCut ShortCut = {read=FShortCut, write=SetShortCut, stored=IsShortCutStored, default=0};
	__property bool UnclickAfterDoing = {read=FUnclickAfterDoing, write=FUnclickAfterDoing, default=0};
	__property bool VisibleForUser = {read=GetVisibleForUser, nodefault};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property TdxBarItemAlign Align = {read=FAlign, write=SetAlign, default=0};
	__property AnsiString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property int Category = {read=FCategory, write=SetCategory, nodefault};
	__property AnsiString Description = {read=FDescription, write=SetDescription};
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, stored=IsEnabledStored, default=1};
	__property Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, stored=IsHelpContextStored, default=0};
	__property AnsiString Hint = {read=FHint, write=FHint, stored=IsHintStored};
	__property TdxBarItemVisible Visible = {read=FVisible, write=SetVisible, stored=IsVisibleStored, nodefault};
	__property Classes::TNotifyEvent OnDestroy = {read=FOnDestroy, write=FOnDestroy};
};


class DELPHICLASS TdxBarWindowItem;
class PASCALIMPLEMENTATION TdxBarWindowItem : public TdxBarItem 
{
	typedef TdxBarItem inherited;
	
private:
	bool FEmptyWindow;
	AnsiString FText;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnCurChange;
	Classes::TNotifyEvent FOnEnter;
	Classes::TNotifyEvent FOnExit;
	Controls::TKeyEvent FOnKeyDown;
	Controls::TKeyPressEvent FOnKeyPress;
	Controls::TKeyEvent FOnKeyUp;
	AnsiString __fastcall GetCurText();
	TdxBarItemLink* __fastcall GetFocusedItemLink(void);
	void __fastcall SetCurText(AnsiString Value);
	
protected:
	virtual bool __fastcall CanClicked(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall CurChange(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall SetText(AnsiString Value);
	__property bool EmptyWindow = {read=FEmptyWindow, write=FEmptyWindow, nodefault};
	
public:
	__property AnsiString CurText = {read=GetCurText, write=SetCurText};
	__property TdxBarItemLink* FocusedItemLink = {read=GetFocusedItemLink};
	
__published:
	__property AnsiString Text = {read=FText, write=SetText};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnCurChange = {read=FOnCurChange, write=FOnCurChange};
	__property Classes::TNotifyEvent OnEnter = {read=FOnEnter, write=FOnEnter};
	__property Classes::TNotifyEvent OnExit = {read=FOnExit, write=FOnExit};
	__property Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property Controls::TKeyPressEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property Controls::TKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
public:
	#pragma option push -w-inl
	/* TdxBarItem.Create */ inline __fastcall virtual TdxBarWindowItem(Classes::TComponent* AOwner) : TdxBarItem(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarItem.Destroy */ inline __fastcall virtual ~TdxBarWindowItem(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TdxBarButton : public TdxBarItem 
{
	typedef TdxBarItem inherited;
	
private:
	bool FAllowAllUp;
	TdxBarButtonStyle FButtonStyle;
	bool FCloseSubMenuOnClick;
	bool FDown;
	bool FDropDownEnabled;
	TdxBarPopupMenu* FDropDownMenu;
	int FGroupIndex;
	bool FLowered;
	TdxBarPaintStyle FPaintStyle;
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetButtonStyle(TdxBarButtonStyle Value);
	void __fastcall SetDown(bool Value);
	void __fastcall SetDropDownEnabled(bool Value);
	void __fastcall SetDropDownMenu(TdxBarPopupMenu* Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetLowered(bool Value);
	void __fastcall SetPaintStyle(TdxBarPaintStyle Value);
	bool __fastcall IsDownStored(void);
	
protected:
	virtual void __fastcall ButtonStyleChanged(void);
	virtual bool __fastcall CanChangePaintStyle(void);
	virtual void __fastcall DownChanged(void);
	DYNAMIC void __fastcall DoDropDown(int X, int Y, bool ByMouse);
	virtual void __fastcall DropDownEnabledChanged(void);
	virtual bool __fastcall HasAccel(TdxBarItemLink* AItemLink);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall PaintStyleChanged(void);
	
public:
	__fastcall virtual TdxBarButton(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property TdxBarButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, default=0};
	__property bool CloseSubMenuOnClick = {read=FCloseSubMenuOnClick, write=FCloseSubMenuOnClick, default=1};
	__property bool DropDownEnabled = {read=FDropDownEnabled, write=SetDropDownEnabled, default=1};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, stored=IsDownStored, default=0};
	__property TdxBarPopupMenu* DropDownMenu = {read=FDropDownMenu, write=SetDropDownMenu};
	__property Glyph ;
	__property ImageIndex  = {default=-1};
	__property bool Lowered = {read=FLowered, write=SetLowered, default=0};
	__property TdxBarPaintStyle PaintStyle = {read=FPaintStyle, write=SetPaintStyle, default=0};
	__property ShortCut  = {default=0};
	__property UnclickAfterDoing  = {default=1};
	__property OnClick ;
public:
	#pragma option push -w-inl
	/* TdxBarItem.Destroy */ inline __fastcall virtual ~TdxBarButton(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarEdit;
class PASCALIMPLEMENTATION TdxBarEdit : public TdxBarWindowItem 
{
	typedef TdxBarWindowItem inherited;
	
private:
	int FMaxLength;
	bool FReadOnly;
	bool FShowCaption;
	int FWidth;
	void __fastcall SetMaxLength(int Value);
	void __fastcall SetShowCaption(bool Value);
	void __fastcall SetWidth(int Value);
	
protected:
	virtual void __fastcall DrawInterior(Graphics::TCanvas* ACanvas, const Types::TRect &R, TdxBarItemLink* ItemLink);
	virtual bool __fastcall HasAccel(TdxBarItemLink* AItemLink);
	virtual void __fastcall WidthChanged(void);
	
public:
	__fastcall virtual TdxBarEdit(Classes::TComponent* AOwner);
	
__published:
	__property Glyph ;
	__property ImageIndex  = {default=-1};
	__property int MaxLength = {read=FMaxLength, write=SetMaxLength, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=0};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property OnClick ;
public:
	#pragma option push -w-inl
	/* TdxBarItem.Destroy */ inline __fastcall virtual ~TdxBarEdit(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCustomdxBarCombo;
typedef void __fastcall (__closure *TdxBarCheckKeyForDropDownWindowEvent)(TCustomdxBarCombo* Sender, Word Key, Classes::TShiftState Shift, bool &AcceptKey);

typedef void __fastcall (__closure *TdxBarGetDropDownWindowEvent)(TCustomdxBarCombo* Sender, HWND &Window);

class PASCALIMPLEMENTATION TCustomdxBarCombo : public TdxBarEdit 
{
	typedef TdxBarEdit inherited;
	
private:
	TdxBarCheckKeyForDropDownWindowEvent FOnCheckKeyForDropDownWindow;
	Classes::TNotifyEvent FOnCloseUp;
	Classes::TNotifyEvent FOnDropDown;
	TdxBarGetDropDownWindowEvent FOnGetDropDownWindow;
	bool __fastcall GetDroppedDown(void);
	bool __fastcall GetShowEditor(void);
	void __fastcall SetDroppedDown(bool Value);
	void __fastcall SetShowEditor(bool Value);
	
protected:
	DYNAMIC void __fastcall AfterDropDown(void);
	void __fastcall CheckDropDownPoint(int &X, int &Y);
	virtual bool __fastcall CheckKeyForDropDownWindow(Word Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall CloseUp(void);
	DYNAMIC void __fastcall DropDown(int X, int Y);
	virtual HWND __fastcall GetDropDownWindow(void);
	virtual void __fastcall InitDropDownWindow(void);
	
public:
	__property HWND DropDownWindow = {read=GetDropDownWindow, nodefault};
	__property bool DroppedDown = {read=GetDroppedDown, write=SetDroppedDown, nodefault};
	
__published:
	__property bool ShowEditor = {read=GetShowEditor, write=SetShowEditor, default=1};
	__property TdxBarCheckKeyForDropDownWindowEvent OnCheckKeyForDropDownWindow = {read=FOnCheckKeyForDropDownWindow, write=FOnCheckKeyForDropDownWindow};
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property TdxBarGetDropDownWindowEvent OnGetDropDownWindow = {read=FOnGetDropDownWindow, write=FOnGetDropDownWindow};
public:
	#pragma option push -w-inl
	/* TdxBarEdit.Create */ inline __fastcall virtual TCustomdxBarCombo(Classes::TComponent* AOwner) : TdxBarEdit(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TdxBarItem.Destroy */ inline __fastcall virtual ~TCustomdxBarCombo(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarCustomCombo;
typedef void __fastcall (__closure *TdxBarDrawItemEvent)(TdxBarCustomCombo* Sender, int AIndex, const Types::TRect &ARect, Windows::TOwnerDrawState AState);

typedef void __fastcall (__closure *TdxBarMeasureItemEvent)(TdxBarCustomCombo* Sender, int AIndex, int &AHeight);

class PASCALIMPLEMENTATION TdxBarCustomCombo : public TCustomdxBarCombo 
{
	typedef TCustomdxBarCombo inherited;
	
private:
	int FDropDownCount;
	int FDropDownWidth;
	bool FInteriorIsDrawing;
	int FItemHeight;
	int FItemIndex;
	Classes::TStrings* FItems;
	Stdctrls::TCustomListBox* FListBox;
	bool FSorted;
	TdxBarDrawItemEvent FOnDrawItem;
	TdxBarMeasureItemEvent FOnMeasureItem;
	int __fastcall GetCurItemIndex(void);
	int __fastcall GetItemsHeight(int Index);
	void __fastcall SetCurItemIndex(int Value);
	void __fastcall SetItemIndex(int Value);
	void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall SetSorted(bool Value);
	void __fastcall CheckLocalPos(void);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall ListBoxDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall ListBoxMeasureItem(Controls::TWinControl* Control, int Index, int &Height);
	
protected:
	Graphics::TCanvas* FCanvas;
	DYNAMIC void __fastcall AfterDropDown(void);
	virtual bool __fastcall CheckKeyForDropDownWindow(Word Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall CloseUp(void);
	DYNAMIC void __fastcall CurChange(void);
	virtual void __fastcall DrawInterior(Graphics::TCanvas* ACanvas, const Types::TRect &R, TdxBarItemLink* ItemLink);
	virtual void __fastcall DrawItem(int AIndex, const Types::TRect &ARect, Windows::TOwnerDrawState AState);
	DYNAMIC void __fastcall DropDown(int X, int Y);
	virtual Graphics::TCanvas* __fastcall GetCanvas(void);
	virtual int __fastcall GetDropDownWidth(void);
	virtual HWND __fastcall GetDropDownWindow(void);
	int __fastcall GetNearestItemIndex(AnsiString AText);
	virtual void __fastcall InitDropDownWindow(void);
	virtual void __fastcall MeasureItem(int AIndex, int &AHeight);
	virtual void __fastcall MeasureItemWidth(int AIndex, int &AWidth);
	virtual void __fastcall SetText(AnsiString Value);
	__property Stdctrls::TCustomListBox* ListBox = {read=FListBox};
	
public:
	__fastcall virtual TdxBarCustomCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarCustomCombo(void);
	__property Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property int CurItemIndex = {read=GetCurItemIndex, write=SetCurItemIndex, nodefault};
	__property int ItemHeight = {read=FItemHeight, write=FItemHeight, default=0};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property int ItemsHeight[int Index] = {read=GetItemsHeight};
	__property bool Sorted = {read=FSorted, write=SetSorted, default=0};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, nodefault};
	
__published:
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, default=8};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, default=0};
	__property TdxBarDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property TdxBarMeasureItemEvent OnMeasureItem = {read=FOnMeasureItem, write=FOnMeasureItem};
};


class DELPHICLASS TdxBarCombo;
class PASCALIMPLEMENTATION TdxBarCombo : public TdxBarCustomCombo 
{
	typedef TdxBarCustomCombo inherited;
	
__published:
	__property ItemHeight  = {default=0};
	__property Items ;
	__property Sorted  = {default=0};
	__property ItemIndex ;
public:
	#pragma option push -w-inl
	/* TdxBarCustomCombo.Create */ inline __fastcall virtual TdxBarCombo(Classes::TComponent* AOwner) : TdxBarCustomCombo(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarCustomCombo.Destroy */ inline __fastcall virtual ~TdxBarCombo(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TCustomdxBarSubItem : public TdxBarItem 
{
	typedef TdxBarItem inherited;
	
private:
	int FBarSize;
	bool FDetachable;
	TdxBar* FDetachingBar;
	TdxBarItemLinks* FItemLinks;
	bool FShowCaption;
	Classes::TNotifyEvent FOnCloseUp;
	Classes::TNotifyEvent FOnDetaching;
	TdxBarPaintSubMenuBarEvent FOnPaintBar;
	Classes::TNotifyEvent FOnPopup;
	int __fastcall GetDetachingBarIndex(void);
	void __fastcall SetBarSize(int Value);
	void __fastcall SetDetachingBar(int Value);
	void __fastcall SetItemLinks(TdxBarItemLinks* Value);
	void __fastcall SetShowCaption(bool Value);
	
protected:
	virtual void __fastcall BarManagerChanged(void);
	virtual bool __fastcall CanClicked(void);
	DYNAMIC void __fastcall DoCloseUp(void);
	DYNAMIC void __fastcall DoDetaching(void);
	virtual void __fastcall DoPaintBar(Graphics::TCanvas* Canvas, const Types::TRect &R);
	DYNAMIC void __fastcall DoPopup(void);
	virtual void __fastcall ObjectNotification(Classes::TOperation AOperation, System::TObject* AObject);
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Classes::TNotifyEvent OnPopup = {read=FOnPopup, write=FOnPopup};
	
public:
	__fastcall virtual TCustomdxBarSubItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomdxBarSubItem(void);
	bool __fastcall CanContainItem(TdxBarItem* AItem);
	TdxBar* __fastcall GetDetachingBar(void);
	__property TdxBarItemLinks* ItemLinks = {read=FItemLinks, write=SetItemLinks};
	
__published:
	__property int BarSize = {read=FBarSize, write=SetBarSize, default=0};
	__property bool Detachable = {read=FDetachable, write=FDetachable, default=0};
	__property int DetachingBar = {read=GetDetachingBarIndex, write=SetDetachingBar, default=-1};
	__property Glyph ;
	__property ImageIndex  = {default=-1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property OnClick ;
	__property Classes::TNotifyEvent OnDetaching = {read=FOnDetaching, write=FOnDetaching};
	__property TdxBarPaintSubMenuBarEvent OnPaintBar = {read=FOnPaintBar, write=FOnPaintBar};
};


class DELPHICLASS TdxBarSubItem;
class PASCALIMPLEMENTATION TdxBarSubItem : public TCustomdxBarSubItem 
{
	typedef TCustomdxBarSubItem inherited;
	
private:
	bool FAllowCustomizing;
	
public:
	__fastcall virtual TdxBarSubItem(Classes::TComponent* AOwner);
	
__published:
	__property bool AllowCustomizing = {read=FAllowCustomizing, write=FAllowCustomizing, default=1};
	__property ItemLinks ;
	__property OnCloseUp ;
	__property OnPopup ;
public:
	#pragma option push -w-inl
	/* TCustomdxBarSubItem.Destroy */ inline __fastcall virtual ~TdxBarSubItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCustomdxBarContainerItem;
class PASCALIMPLEMENTATION TCustomdxBarContainerItem : public TCustomdxBarSubItem 
{
	typedef TCustomdxBarSubItem inherited;
	
private:
	bool FNeedClearItemList;
	Classes::TNotifyEvent FOnGetData;
	
protected:
	virtual void __fastcall AddListedItemLinks(TdxBarItemLinks* AItemLinks, int AIndex, bool FirstCall, TdxBarItemLink* CallingItemLink);
	virtual void __fastcall DeleteListedItemLinks(TdxBarItemLinks* AItemLinks, int AIndex);
	virtual void __fastcall ClearItemList(void);
	virtual bool __fastcall HideWhenRun(void);
	void __fastcall NeedClearItemList(void);
	
public:
	__fastcall virtual ~TCustomdxBarContainerItem(void);
	
__published:
	__property Classes::TNotifyEvent OnGetData = {read=FOnGetData, write=FOnGetData};
public:
	#pragma option push -w-inl
	/* TCustomdxBarSubItem.Create */ inline __fastcall virtual TCustomdxBarContainerItem(Classes::TComponent* AOwner) : TCustomdxBarSubItem(AOwner) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarListItem;
class PASCALIMPLEMENTATION TdxBarListItem : public TCustomdxBarContainerItem 
{
	typedef TCustomdxBarContainerItem inherited;
	
private:
	int FItemIndex;
	Classes::TList* FItemList;
	Classes::TStrings* FItems;
	bool FShowCheck;
	bool FShowNumbers;
	int __fastcall GetDataIndex(void);
	void __fastcall SetDataIndex(int Value);
	void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall ClickItem(System::TObject* Sender);
	
protected:
	virtual void __fastcall AddListedItemLinks(TdxBarItemLinks* AItemLinks, int AIndex, bool FirstCall, TdxBarItemLink* CallingItemLink);
	virtual void __fastcall ClearItemList(void);
	virtual void __fastcall DeleteListedItemLinks(TdxBarItemLinks* AItemLinks, int AIndex);
	virtual AnsiString __fastcall GetDisplayText(const AnsiString AText);
	
public:
	__fastcall virtual TdxBarListItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarListItem(void);
	DYNAMIC void __fastcall DirectClick(void);
	
__published:
	__property int DataIndex = {read=GetDataIndex, write=SetDataIndex, stored=false, nodefault};
	__property int ItemIndex = {read=FItemIndex, write=FItemIndex, default=-1};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool ShowCheck = {read=FShowCheck, write=FShowCheck, default=0};
	__property bool ShowNumbers = {read=FShowNumbers, write=FShowNumbers, default=1};
};


class DELPHICLASS TdxBarContainerItem;
class PASCALIMPLEMENTATION TdxBarContainerItem : public TCustomdxBarContainerItem 
{
	typedef TCustomdxBarContainerItem inherited;
	
protected:
	virtual void __fastcall AddListedItemLinks(TdxBarItemLinks* AItemLinks, int AIndex, bool FirstCall, TdxBarItemLink* CallingItemLink);
	virtual void __fastcall DeleteListedItemLinks(TdxBarItemLinks* AItemLinks, int AIndex);
	
__published:
	__property ItemLinks ;
public:
	#pragma option push -w-inl
	/* TCustomdxBarContainerItem.Destroy */ inline __fastcall virtual ~TdxBarContainerItem(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomdxBarSubItem.Create */ inline __fastcall virtual TdxBarContainerItem(Classes::TComponent* AOwner) : TCustomdxBarContainerItem(AOwner) { }
	#pragma option pop
	
};


typedef TMetaClass*TdxBarItemControlClass;

class DELPHICLASS TdxBarWinControl;
class PASCALIMPLEMENTATION TdxBarWinControl : public TdxBarItemControl 
{
	typedef TdxBarItemControl inherited;
	
private:
	void *FDefWndProc;
	bool FFocused;
	bool FFocusing;
	HWND FHandle;
	int FKeyPressedInside;
	void *FPrevDefWndProc;
	HWND FPrevFocusedControl;
	#pragma pack(push, 1)
	Types::TRect FWindowRect;
	#pragma pack(pop)
	
	HIDESBASE TdxBarWindowItem* __fastcall GetItem(void);
	Types::TRect __fastcall GetWindowRect();
	
protected:
	virtual bool __fastcall CanClicked(void);
	virtual void __fastcall ControlInactivate(bool Immediately);
	virtual void __fastcall ControlClick(bool ByMouse);
	virtual void __fastcall CreateWindowHandle(void);
	virtual void __fastcall DestroyWindowHandle(void);
	bool __fastcall DoKeyDown(Messages::TWMKey &Message);
	bool __fastcall DoKeyPress(Messages::TWMKey &Message);
	bool __fastcall DoKeyUp(Messages::TWMKey &Message);
	virtual AnsiString __fastcall GetText();
	virtual bool __fastcall IsDestroyOnClick(void);
	virtual void __fastcall SetFocused(bool Value);
	virtual void __fastcall SetText(AnsiString Value);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TdxBarWinControl(TdxBarItemLink* AItemLink);
	__fastcall virtual ~TdxBarWinControl(void);
	__property bool Focused = {read=FFocused, write=SetFocused, nodefault};
	__property HWND Handle = {read=FHandle, nodefault};
	__property TdxBarWindowItem* Item = {read=GetItem};
	__property AnsiString Text = {read=GetText, write=SetText};
	__property Types::TRect WindowRect = {read=GetWindowRect, write=FWindowRect};
};


class DELPHICLASS TdxBarEditControl;
class PASCALIMPLEMENTATION TdxBarEditControl : public TdxBarWinControl 
{
	typedef TdxBarWinControl inherited;
	
private:
	int __fastcall GetCaptionWidth(void);
	HIDESBASE TdxBarEdit* __fastcall GetItem(void);
	int __fastcall GetMaxLength(void);
	bool __fastcall GetReadOnly(void);
	bool __fastcall GetShowCaption(void);
	
protected:
	virtual void __fastcall ControlClick(bool ByMouse);
	virtual void __fastcall CreateWindowHandle(void);
	void __fastcall DrawBorder(HDC DC, Types::TRect &ARect, TdxBarPaintType PaintType, bool Selected);
	void __fastcall DrawCaption(HDC DC, Types::TRect &ARect, TdxBarPaintType PaintType, bool Selected);
	virtual bool __fastcall DrawSelected(void);
	void __fastcall DrawTextField(HDC DC, const Types::TRect &ARect);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetMinWidth(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, TdxBarPaintType PaintType);
	virtual void __fastcall SetFocused(bool Value);
	virtual void __fastcall SetText(AnsiString Value);
	virtual void __fastcall WidthChanged(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	__property int CaptionWidth = {read=GetCaptionWidth, nodefault};
	__property int MaxLength = {read=GetMaxLength, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, nodefault};
	__property bool ShowCaption = {read=GetShowCaption, nodefault};
	
public:
	__property TdxBarEdit* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TdxBarEditControl(TdxBarItemLink* AItemLink) : TdxBarWinControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TdxBarEditControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCustomdxBarComboControl;
class PASCALIMPLEMENTATION TCustomdxBarComboControl : public TdxBarEditControl 
{
	typedef TdxBarEditControl inherited;
	
private:
	#pragma pack(push, 1)
	Types::TRect FDropDownButtonRect;
	#pragma pack(pop)
	
	bool FOnPressDroppedDown;
	bool FDroppedDown;
	HWND __fastcall GetDropDownWindow(void);
	HIDESBASE TCustomdxBarCombo* __fastcall GetItem(void);
	
protected:
	virtual void __fastcall ControlInactivate(bool Immediately);
	virtual void __fastcall Paint(const Types::TRect &ARect, TdxBarPaintType PaintType);
	virtual void __fastcall SetDroppedDown(bool Value);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	__property Types::TRect DropDownButtonRect = {read=FDropDownButtonRect};
	__property HWND DropDownWindow = {read=GetDropDownWindow, nodefault};
	
public:
	__property bool DroppedDown = {read=FDroppedDown, write=SetDroppedDown, nodefault};
	__property TCustomdxBarCombo* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TCustomdxBarComboControl(TdxBarItemLink* AItemLink) : TdxBarEditControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TCustomdxBarComboControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarComboControl;
class PASCALIMPLEMENTATION TdxBarComboControl : public TCustomdxBarComboControl 
{
	typedef TCustomdxBarComboControl inherited;
	
private:
	int FLocalItemIndex;
	HIDESBASE TdxBarCustomCombo* __fastcall GetItem(void);
	int __fastcall GetItemIndex(void);
	Classes::TStrings* __fastcall GetItems(void);
	bool __fastcall GetSorted(void);
	void __fastcall SetLocalItemIndex(int Value);
	
protected:
	virtual void __fastcall SetFocused(bool Value);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	__property int ItemIndex = {read=GetItemIndex, nodefault};
	__property Classes::TStrings* Items = {read=GetItems};
	__property bool Sorted = {read=GetSorted, nodefault};
	
public:
	__property TdxBarCustomCombo* Item = {read=GetItem};
	__property int LocalItemIndex = {read=FLocalItemIndex, write=SetLocalItemIndex, nodefault};
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TdxBarComboControl(TdxBarItemLink* AItemLink) : TCustomdxBarComboControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TdxBarComboControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarContainerItemControl;
class PASCALIMPLEMENTATION TdxBarContainerItemControl : public TdxBarSubItemControl 
{
	typedef TdxBarSubItemControl inherited;
	
private:
	HIDESBASE TCustomdxBarContainerItem* __fastcall GetItem(void);
	
protected:
	virtual void __fastcall CreateSubMenuControl(void);
	virtual AnsiString __fastcall GetCaption();
	virtual bool __fastcall IsExpandable(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, TdxBarPaintType PaintType);
	bool __fastcall ShowRealCaption(void);
	
public:
	__property TCustomdxBarContainerItem* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarSubItemControl.Destroy */ inline __fastcall virtual ~TdxBarContainerItemControl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarContainerItemControl(TdxBarItemLink* AItemLink) : TdxBarSubItemControl(AItemLink) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TdxArrowType { atRight, atDown };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
static const Word WM_REPAINTBAR = 0x401;
extern PACKAGE TdxBarDesigner* dxBarDesigner;
extern PACKAGE TMetaClass*dxBarHintWindowClass;
extern PACKAGE TdxBarManagerList* dxBarManagerList;
extern PACKAGE HBRUSH PatternBrush;
extern PACKAGE Classes::TList* InternalItemList;
static const Word crdxBarDrag = 0x411;
static const Word crdxBarDragCopy = 0x412;
static const Word crdxBarDragNoDrop = 0x413;
static const Word crdxBarEditSizing = 0x414;
static const short dxBarManagerTempCategoryIndex = 0xfffffc18;
static const short dxBarCustomizingPopupPaintStyleGroupIndex = 0xfffffc18;
extern PACKAGE int dxBarNonrecentlyUsedItemsColorDelta;
extern PACKAGE int dxBarFlatToolbarsColorDelta;
extern PACKAGE TMetaClass* __fastcall dxBarItemClass(int AIndex);
extern PACKAGE int __fastcall dxBarItemCount(void);
extern PACKAGE TMetaClass* __fastcall dxBarVisibleItemClass(int AIndex);
extern PACKAGE int __fastcall dxBarVisibleItemCount(void);
extern PACKAGE void __fastcall dxBarRegisterItem(TMetaClass* AItemClass, TMetaClass* AItemControlClass, bool AVisible);
extern PACKAGE void __fastcall dxBarUnregisterItem(TMetaClass* AItemClass);
extern PACKAGE void __fastcall dxBarDesignerModified(TdxBarManager* ABarManager);
extern PACKAGE TCustomdxBarControl* __fastcall ActiveBarControl(void);
extern PACKAGE TdxBarItemVisible __fastcall VisibleTodxBarVisible(bool Value);
extern PACKAGE TdxBarManager* __fastcall GetBarManagerByForm(Forms::TCustomForm* AForm);
extern PACKAGE AnsiString __fastcall GetTextOf(const AnsiString S);
extern PACKAGE void __fastcall DrawItemArrow(HDC DC, const Types::TRect &R, TdxArrowType ArrowType, bool Enabled, bool Selected, bool Flat);
extern PACKAGE void __fastcall DrawLargeItemArrow(HDC DC, const Types::TRect &R, TdxArrowType ArrowType, int Size, bool Selected, bool Enabled, bool Flat);
extern PACKAGE void __fastcall FrameFlatSelRect(HDC DC, const Types::TRect &R);
extern PACKAGE Types::TRect __fastcall GetWorkArea(const Types::TPoint &P);
extern PACKAGE bool __fastcall IsVertical(TCustomdxBarControl* ABarControl);
extern PACKAGE void __fastcall DrawVerticalGradient(Graphics::TCanvas* Canvas, const Types::TRect &ARect, Byte FromR, Byte ToR, Byte FromG, Byte ToG, Byte FromB, Byte ToB);
extern PACKAGE void __fastcall TransparentDraw(HDC DrawDC, HBRUSH Brush, const Types::TRect &FullRect, const Types::TRect &R, Graphics::TBitmap* ABitmap, Imglist::TCustomImageList* AImages, int AImageIndex, bool AEnabled, bool AGrayScale, bool AFlat, bool ASelected, bool APressed, Graphics::TColor ImageListBkColor);
extern PACKAGE void __fastcall ProcessMouseMessages(void);
extern PACKAGE void __fastcall ProcessPaintMessages(void);
extern PACKAGE HFONT __fastcall CloneFont(HFONT Source);
extern PACKAGE void __fastcall ClearInternalItemList(void);
extern PACKAGE bool __fastcall LeftButtonPressed(void);
extern PACKAGE bool __fastcall RightButtonPressed(void);
extern PACKAGE TdxBarSubMenuControl* __fastcall dxBarCustomizingPopup(void);
extern PACKAGE TdxBarItemLink* __fastcall dxBarCustomizingPopupItemLink(void);

}	/* namespace Dxbar */
using namespace Dxbar;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBar
