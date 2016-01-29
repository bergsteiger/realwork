// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarExtItems.pas' rev: 6.00

#ifndef dxBarExtItemsHPP
#define dxBarExtItemsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxCommon.hpp>	// Pascal unit
#include <dxBar.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <CommCtrl.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxbarextitems
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TdxBarStaticBorderStyle { sbsNone, sbsLowered, sbsRaised, sbsEtched, sbsBump };
#pragma option pop

class DELPHICLASS TdxBarStatic;
class PASCALIMPLEMENTATION TdxBarStatic : public Dxbar::TdxBarItem 
{
	typedef Dxbar::TdxBarItem inherited;
	
private:
	Classes::TAlignment FAlignment;
	bool FAllowClick;
	TdxBarStaticBorderStyle FBorderStyle;
	int FHeight;
	int FLeftIndent;
	int FRightIndent;
	bool FShowCaption;
	int FWidth;
	void __fastcall SetAlignment(Classes::TAlignment Value);
	void __fastcall SetBorderStyle(TdxBarStaticBorderStyle Value);
	void __fastcall SetShowCaption(bool Value);
	void __fastcall SetSizeValue(int Index, int Value);
	
protected:
	virtual bool __fastcall CanClicked(void);
	virtual bool __fastcall HasAccel(Dxbar::TdxBarItemLink* AItemLink);
	
public:
	__fastcall virtual TdxBarStatic(Classes::TComponent* AOwner);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property bool AllowClick = {read=FAllowClick, write=FAllowClick, default=0};
	__property TdxBarStaticBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Glyph ;
	__property int Height = {read=FHeight, write=SetSizeValue, index=4, default=0};
	__property ImageIndex  = {default=-1};
	__property int LeftIndent = {read=FLeftIndent, write=SetSizeValue, index=1, default=0};
	__property int RightIndent = {read=FRightIndent, write=SetSizeValue, index=2, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property int Width = {read=FWidth, write=SetSizeValue, index=3, default=0};
	__property OnClick ;
public:
	#pragma option push -w-inl
	/* TdxBarItem.Destroy */ inline __fastcall virtual ~TdxBarStatic(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarStaticControl;
class PASCALIMPLEMENTATION TdxBarStaticControl : public Dxbar::TdxBarItemControl 
{
	typedef Dxbar::TdxBarItemControl inherited;
	
private:
	TdxBarStaticBorderStyle __fastcall GetBorderStyle(void);
	int __fastcall GetBorderWidth(void);
	HIDESBASE TdxBarStatic* __fastcall GetItem(void);
	int __fastcall GetSizeValue(int Index);
	
protected:
	virtual bool __fastcall CanClicked(void);
	virtual bool __fastcall CanHaveZeroSize(void);
	virtual bool __fastcall CanSelect(void);
	virtual void __fastcall CaptionChanged(void);
	void __fastcall DrawGlyphAndCaption(HDC DC, const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType, bool AllowCenter);
	virtual void __fastcall DrawInterior(HDC DC, const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	virtual void __fastcall GlyphChanged(void);
	virtual Classes::TAlignment __fastcall GetAlignment(void);
	int __fastcall GetAutoWidth(void);
	virtual int __fastcall GetDefaultHeight(void);
	virtual int __fastcall GetDefaultWidth(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual bool __fastcall IsDestroyOnClick(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	__property Classes::TAlignment Alignment = {read=GetAlignment, nodefault};
	__property TdxBarStaticBorderStyle BorderStyle = {read=GetBorderStyle, nodefault};
	__property int BorderWidth = {read=GetBorderWidth, nodefault};
	__property int Height = {read=GetSizeValue, index=4, nodefault};
	__property int LeftIndent = {read=GetSizeValue, index=1, nodefault};
	__property int RightIndent = {read=GetSizeValue, index=2, nodefault};
	__property int Width = {read=GetSizeValue, index=3, nodefault};
	
public:
	__property TdxBarStatic* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarStaticControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarItemControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarItemControl.Destroy */ inline __fastcall virtual ~TdxBarStaticControl(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TdxBarGlyphLayout { glLeft, glRight, glTop, glBottom };
#pragma option pop

class DELPHICLASS TdxBarLargeButton;
class PASCALIMPLEMENTATION TdxBarLargeButton : public Dxbar::TdxBarButton 
{
	typedef Dxbar::TdxBarButton inherited;
	
private:
	bool FAutoGrayScale;
	TdxBarGlyphLayout FGlyphLayout;
	int FHeight;
	int FHotImageIndex;
	Graphics::TBitmap* FLargeGlyph;
	Graphics::TBitmap* FHotGlyph;
	int FLargeImageIndex;
	bool FShowCaption;
	int FWidth;
	void __fastcall SetAutoGrayScale(bool Value);
	void __fastcall SetGlyphLayout(TdxBarGlyphLayout Value);
	void __fastcall SetHeight(int Value);
	void __fastcall SetHotGlyph(Graphics::TBitmap* Value);
	void __fastcall SetHotImageIndex(int Value);
	void __fastcall SetLargeGlyph(Graphics::TBitmap* Value);
	void __fastcall SetLargeImageIndex(int Value);
	void __fastcall SetShowCaption(bool Value);
	void __fastcall SetWidth(int Value);
	void __fastcall OnHotGlyphChanged(System::TObject* Sender);
	void __fastcall OnLargeGlyphChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall GlyphLayoutChanged(void);
	virtual bool __fastcall HasAccel(Dxbar::TdxBarItemLink* AItemLink);
	virtual void __fastcall HeightChanged(void);
	virtual void __fastcall HotGlyphChanged(void);
	bool __fastcall IsHotImageLinked(void);
	bool __fastcall IsLargeImageLinked(void);
	virtual void __fastcall LargeGlyphChanged(void);
	virtual void __fastcall ShowCaptionChanged(void);
	virtual bool __fastcall UseHotImages(void);
	virtual bool __fastcall UseLargeImages(void);
	virtual void __fastcall WidthChanged(void);
	
public:
	__fastcall virtual TdxBarLargeButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarLargeButton(void);
	
__published:
	__property bool AutoGrayScale = {read=FAutoGrayScale, write=SetAutoGrayScale, default=1};
	__property TdxBarGlyphLayout GlyphLayout = {read=FGlyphLayout, write=SetGlyphLayout, default=2};
	__property int Height = {read=FHeight, write=SetHeight, default=0};
	__property Graphics::TBitmap* HotGlyph = {read=FHotGlyph, write=SetHotGlyph};
	__property int HotImageIndex = {read=FHotImageIndex, write=SetHotImageIndex, default=-1};
	__property Graphics::TBitmap* LargeGlyph = {read=FLargeGlyph, write=SetLargeGlyph};
	__property int LargeImageIndex = {read=FLargeImageIndex, write=SetLargeImageIndex, default=-1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
};


class DELPHICLASS TdxBarLargeButtonControl;
class PASCALIMPLEMENTATION TdxBarLargeButtonControl : public Dxbar::TdxBarButtonControl 
{
	typedef Dxbar::TdxBarButtonControl inherited;
	
private:
	Graphics::TBitmap* __fastcall GetHotGlyph(void);
	HIDESBASE TdxBarLargeButton* __fastcall GetItem(void);
	Graphics::TBitmap* __fastcall GetLargeGlyph(void);
	bool __fastcall GetCurrentImage(bool ASelected, Graphics::TBitmap* &CurrentGlyph, Imglist::TCustomImageList* &CurrentImages, int &CurrentImageIndex);
	bool __fastcall IsSizeAssigned(void);
	
protected:
	virtual int __fastcall ArrowWidth(void);
	virtual void __fastcall GlyphLayoutChanged(void);
	virtual void __fastcall HeightChanged(void);
	virtual void __fastcall HotGlyphChanged(void);
	virtual void __fastcall LargeGlyphChanged(void);
	virtual void __fastcall ShowCaptionChanged(void);
	virtual void __fastcall WidthChanged(void);
	virtual int __fastcall GetDefaultHeight(void);
	virtual int __fastcall GetDefaultWidth(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	__property Graphics::TBitmap* HotGlyph = {read=GetHotGlyph};
	__property Graphics::TBitmap* LargeGlyph = {read=GetLargeGlyph};
	
public:
	__property TdxBarLargeButton* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarLargeButtonControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarButtonControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarItemControl.Destroy */ inline __fastcall virtual ~TdxBarLargeButtonControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarColorCombo;
class PASCALIMPLEMENTATION TdxBarColorCombo : public Dxbar::TdxBarCustomCombo 
{
	typedef Dxbar::TdxBarCustomCombo inherited;
	
private:
	Graphics::TColor FAutoColor;
	AnsiString FAutoColorText;
	Graphics::TColor FColor;
	AnsiString FCustomColorText;
	Graphics::TColor FExchangeColor;
	bool FHasExchangeColor;
	bool FSettingColor;
	bool FShowAutoColor;
	bool FShowCustomColorButton;
	Graphics::TColor __fastcall GetCurColor(void);
	void __fastcall SetAutoColor(Graphics::TColor Value);
	void __fastcall SetAutoColorText(AnsiString Value);
	void __fastcall SetColor(Graphics::TColor Value);
	void __fastcall SetCurColor(Graphics::TColor Value);
	void __fastcall SetCustomColorText(AnsiString Value);
	void __fastcall SetShowAutoColor(bool Value);
	void __fastcall SetShowCustomColorButton(bool Value);
	void __fastcall CreateItemsList(void);
	Graphics::TColor __fastcall GetColorByIndex(int AIndex);
	int __fastcall GetIndexOfColor(Graphics::TColor AColor);
	bool __fastcall IsAutoColorTextStored(void);
	bool __fastcall IsCustomColorTextStored(void);
	bool __fastcall IsDropDownCountStored(void);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall DrawItem(int AIndex, const Types::TRect &ARect, Windows::TOwnerDrawState AState);
	virtual void __fastcall MeasureItem(int AIndex, int &AHeight);
	virtual void __fastcall MeasureItemWidth(int AIndex, int &AWidth);
	__property Graphics::TColor ExchangeColor = {read=FExchangeColor, nodefault};
	__property bool HasExchangeColor = {read=FHasExchangeColor, nodefault};
	
public:
	__fastcall virtual TdxBarColorCombo(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall DoClick(void);
	__property Graphics::TColor CurColor = {read=GetCurColor, write=SetCurColor, nodefault};
	
__published:
	__property Graphics::TColor AutoColor = {read=FAutoColor, write=SetAutoColor, default=-2147483640};
	__property AnsiString AutoColorText = {read=FAutoColorText, write=SetAutoColorText, stored=IsAutoColorTextStored};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property AnsiString CustomColorText = {read=FCustomColorText, write=SetCustomColorText, stored=IsCustomColorTextStored};
	__property DropDownCount  = {stored=IsDropDownCountStored, default=8};
	__property bool ShowAutoColor = {read=FShowAutoColor, write=SetShowAutoColor, default=0};
	__property bool ShowCustomColorButton = {read=FShowCustomColorButton, write=SetShowCustomColorButton, default=0};
	__property ShowEditor  = {default=0};
	__property Text  = {stored=false};
public:
	#pragma option push -w-inl
	/* TdxBarCustomCombo.Destroy */ inline __fastcall virtual ~TdxBarColorCombo(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarColorComboControl;
class PASCALIMPLEMENTATION TdxBarColorComboControl : public Dxbar::TdxBarComboControl 
{
	typedef Dxbar::TdxBarComboControl inherited;
	
private:
	#pragma pack(push, 1)
	Types::TRect FCustomColorButtonRect;
	#pragma pack(pop)
	
	HIDESBASE TdxBarColorCombo* __fastcall GetItem(void);
	
protected:
	virtual bool __fastcall DrawSelected(void);
	virtual void __fastcall PressedChanged(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	__property Types::TRect CustomColorButtonRect = {read=FCustomColorButtonRect};
	
public:
	__property TdxBarColorCombo* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TdxBarColorComboControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarComboControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TdxBarColorComboControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarFontNameCombo;
class PASCALIMPLEMENTATION TdxBarFontNameCombo : public Dxbar::TdxBarCustomCombo 
{
	typedef Dxbar::TdxBarCustomCombo inherited;
	
protected:
	virtual void __fastcall DrawItem(int AIndex, const Types::TRect &ARect, Windows::TOwnerDrawState AState);
	void __fastcall LoadFontNames(void);
	virtual void __fastcall MeasureItemWidth(int AIndex, int &AWidth);
	virtual void __fastcall SetText(AnsiString Value);
	
public:
	__fastcall virtual TdxBarFontNameCombo(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall DoClick(void);
	
__published:
	__property ShowEditor  = {default=0};
public:
	#pragma option push -w-inl
	/* TdxBarCustomCombo.Destroy */ inline __fastcall virtual ~TdxBarFontNameCombo(void) { }
	#pragma option pop
	
};


typedef Shortint TDayOfWeek;

#pragma option push -b-
enum TDay { dSunday, dMonday, dTuesday, dWednesday, dThursday, dFriday, dSaturday };
#pragma option pop

typedef Set<TDay, dSunday, dSaturday>  TDays;

#pragma option push -b-
enum TdxBarCalendarStyle { cs3D, csFlat, csUltraFlat };
#pragma option pop

class DELPHICLASS TdxBarCustomCalendar;
class PASCALIMPLEMENTATION TdxBarCustomCalendar : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	System::TDateTime FDragDate;
	System::TDateTime FFirstDate;
	System::TDateTime FSelStart;
	System::TDateTime FSelFinish;
	TdxBarCalendarStyle FStyle;
	Classes::TNotifyEvent FOnDateTimeChanged;
	bool __fastcall GetFlat(void);
	bool __fastcall GetUltraFlat(void);
	void __fastcall SetStyle(TdxBarCalendarStyle Value);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Messages::TMessage &Message);
	MESSAGE void __fastcall WMCaptureChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	
protected:
	virtual TdxBarCalendarStyle __fastcall GetStyle(void);
	virtual System::TDateTime __fastcall GetRealFirstDate(void);
	virtual System::TDateTime __fastcall GetRealLastDate(void);
	virtual System::TDateTime __fastcall GetLastDate(void) = 0 ;
	virtual System::TDateTime __fastcall GetSelStart(void);
	virtual System::TDateTime __fastcall GetSelFinish(void);
	virtual void __fastcall SetFirstDate(System::TDateTime Value);
	virtual void __fastcall SetSelStart(System::TDateTime Value);
	virtual void __fastcall SetSelFinish(System::TDateTime Value);
	DYNAMIC void __fastcall CancelAll(void);
	virtual void __fastcall CheckFirstDate(void) = 0 ;
	DYNAMIC void __fastcall DoDateTimeChanged(void);
	void __fastcall DoInternalSelectPeriod(System::TDateTime ADate);
	virtual System::TDateTime __fastcall PosToDateTime(const Types::TPoint &P) = 0 ;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	__property bool Flat = {read=GetFlat, nodefault};
	__property bool UltraFlat = {read=GetUltraFlat, nodefault};
	__property System::TDateTime RealFirstDate = {read=GetRealFirstDate};
	__property System::TDateTime RealLastDate = {read=GetRealLastDate};
	
public:
	__fastcall virtual TdxBarCustomCalendar(Classes::TComponent* AOwner);
	__property System::TDateTime FirstDate = {read=FFirstDate, write=SetFirstDate};
	__property System::TDateTime LastDate = {read=GetLastDate};
	__property System::TDateTime SelStart = {read=GetSelStart, write=SetSelStart};
	__property System::TDateTime SelFinish = {read=GetSelFinish, write=SetSelFinish};
	__property TdxBarCalendarStyle Style = {read=GetStyle, write=SetStyle, nodefault};
	__property Classes::TNotifyEvent OnDateTimeChanged = {read=FOnDateTimeChanged, write=FOnDateTimeChanged};
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TdxBarCustomCalendar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarCustomCalendar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarDateNavigator;
class DELPHICLASS TdxBarDateCombo;
class PASCALIMPLEMENTATION TdxBarDateCombo : public Dxbar::TCustomdxBarCombo 
{
	typedef Dxbar::TCustomdxBarCombo inherited;
	
private:
	TdxBarDateNavigator* FDatePopup;
	TdxBarDateNavigator* FDateNavigator;
	Stdctrls::TEdit* FDateEdit;
	Forms::TForm* FForm;
	bool FShowTodayButton;
	bool FShowClearButton;
	System::TDateTime __fastcall GetCurDate(void);
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetCurDate(System::TDateTime Value);
	void __fastcall SetDate(System::TDateTime Value);
	void __fastcall DateChanged(System::TObject* Sender);
	void __fastcall DialogClick(System::TObject* Sender);
	void __fastcall DialogDateChanged(System::TObject* Sender);
	void __fastcall DialogDateEditChange(System::TObject* Sender);
	System::TDateTime __fastcall GetDateOfText(AnsiString AText);
	AnsiString __fastcall GetDateText(System::TDateTime ADate);
	
protected:
	virtual bool __fastcall CheckKeyForDropDownWindow(Word Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall CloseUp(void);
	DYNAMIC void __fastcall DropDown(int X, int Y);
	virtual HWND __fastcall GetDropDownWindow(void);
	virtual void __fastcall SetText(AnsiString Value);
	__property TdxBarDateNavigator* DatePopup = {read=FDatePopup};
	
public:
	__fastcall virtual TdxBarDateCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarDateCombo(void);
	DYNAMIC void __fastcall DoClick(void);
	__property System::TDateTime CurDate = {read=GetCurDate, write=SetCurDate};
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	
__published:
	__property bool ShowTodayButton = {read=FShowTodayButton, write=FShowTodayButton, default=1};
	__property bool ShowClearButton = {read=FShowClearButton, write=FShowClearButton, default=1};
};


class PASCALIMPLEMENTATION TdxBarDateNavigator : public TdxBarCustomCalendar 
{
	typedef TdxBarCustomCalendar inherited;
	
private:
	TdxBarDateCombo* FCombo;
	int FColCount;
	int FRowCount;
	int FColWidth;
	int FSideWidth;
	int FRowHeight;
	int FHeaderHeight;
	int FDaysOfWeekHeight;
	int FTodayButtonWidth;
	int FClearButtonWidth;
	int FButtonsOffset;
	int FButtonsHeight;
	int FButtonsRegionHeight;
	Controls::TWinControl* FListBox;
	int FListBoxDelta;
	unsigned FTimer;
	bool FTodayButtonActive;
	bool FTodayButtonPressed;
	bool FClearButtonActive;
	bool FClearButtonPressed;
	void __fastcall CheckSelection(System::TDateTime MarginDate);
	int __fastcall ColOfDate(System::TDateTime ADate);
	Types::TRect __fastcall GetHeaderRect();
	Types::TRect __fastcall GetInternalRect();
	Types::TRect __fastcall GetLeftArrowRect();
	Types::TRect __fastcall GetRightArrowRect();
	Types::TRect __fastcall GetMonthNameRect();
	Types::TRect __fastcall GetTodayButtonRect();
	Types::TRect __fastcall GetClearButtonRect();
	bool __fastcall GetShowButtonsArea(void);
	void __fastcall FreeTimer(void);
	void __fastcall RepaintTodayButton(void);
	void __fastcall RepaintClearButton(void);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	
protected:
	virtual TdxBarCalendarStyle __fastcall GetStyle(void);
	virtual System::TDateTime __fastcall GetRealFirstDate(void);
	virtual System::TDateTime __fastcall GetRealLastDate(void);
	virtual System::TDateTime __fastcall GetLastDate(void);
	virtual void __fastcall SetFirstDate(System::TDateTime Value);
	virtual void __fastcall SetSelFinish(System::TDateTime Value);
	void __fastcall StepToPast(void);
	void __fastcall StepToFuture(void);
	DYNAMIC void __fastcall CancelAll(void);
	virtual void __fastcall CheckFirstDate(void);
	void __fastcall DeactivateAll(void);
	virtual System::TDateTime __fastcall PosToDateTime(const Types::TPoint &P);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	__property int ColCount = {read=FColCount, nodefault};
	__property int RowCount = {read=FRowCount, nodefault};
	__property bool ShowButtonsArea = {read=GetShowButtonsArea, nodefault};
	
public:
	bool IsPopup;
	bool ShowTodayButton;
	bool ShowClearButton;
	__fastcall virtual TdxBarDateNavigator(Classes::TComponent* AOwner);
	void __fastcall SetSize(void);
	int __fastcall GetWidth(void);
	int __fastcall GetHeight(void);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TdxBarDateNavigator(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarDateNavigator(HWND ParentWindow) : TdxBarCustomCalendar(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarDateComboControl;
class PASCALIMPLEMENTATION TdxBarDateComboControl : public Dxbar::TCustomdxBarComboControl 
{
	typedef Dxbar::TCustomdxBarComboControl inherited;
	
private:
	System::TDateTime __fastcall GetDate(void);
	HIDESBASE TdxBarDateCombo* __fastcall GetItem(void);
	void __fastcall SetDate(const System::TDateTime Value);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	
public:
	__property TdxBarDateCombo* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TdxBarDateComboControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TCustomdxBarComboControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TdxBarDateComboControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarTreeView;
class DELPHICLASS TdxBarTreeViewCombo;
typedef void __fastcall (__closure *TdxBarTreeViewComboCanSelectNodeEvent)(TdxBarTreeViewCombo* Sender, Comctrls::TTreeNode* Node, bool &CanSelect);

class PASCALIMPLEMENTATION TdxBarTreeViewCombo : public Dxbar::TCustomdxBarCombo 
{
	typedef Dxbar::TCustomdxBarCombo inherited;
	
private:
	bool FAllowResizing;
	Stdctrls::TButton* FButtonOk;
	Stdctrls::TButton* FButtonCancel;
	bool FChooseByDblClick;
	Forms::TForm* FForm;
	TdxBarTreeView* FFormTreeView;
	TdxBarTreeView* FTreeView;
	bool FFullExpand;
	bool FInSelectedNodeChanged;
	AnsiString FLoadedText;
	Comctrls::TTreeNode* FSelectedNode;
	bool FShowImageInEdit;
	TdxBarTreeViewComboCanSelectNodeEvent FOnCanSelectNode;
	int __fastcall GetDropDownHeight(void);
	int __fastcall GetDropDownWidth(void);
	Imglist::TCustomImageList* __fastcall GetImages(void);
	int __fastcall GetIndent(void);
	Comctrls::TTreeNodes* __fastcall GetItems(void);
	bool __fastcall GetShowButtons(void);
	bool __fastcall GetShowLines(void);
	bool __fastcall GetShowRoot(void);
	Comctrls::TSortType __fastcall GetSortType(void);
	Imglist::TCustomImageList* __fastcall GetStateImages(void);
	Comctrls::TTVExpandedEvent __fastcall GetOnExpanded();
	Comctrls::TTVExpandingEvent __fastcall GetOnExpanding();
	Comctrls::TTVChangingEvent __fastcall GetOnChanging();
	Comctrls::TTVExpandedEvent __fastcall GetOnCollapsed();
	Comctrls::TTVCollapsingEvent __fastcall GetOnCollapsing();
	Comctrls::TTVCompareEvent __fastcall GetOnCompare();
	Comctrls::TTVExpandedEvent __fastcall GetOnGetImageIndex();
	Comctrls::TTVExpandedEvent __fastcall GetOnGetSelectedIndex();
	Comctrls::TTVChangedEvent __fastcall GetOnTreeViewChange();
	void __fastcall SetDropDownHeight(int Value);
	void __fastcall SetDropDownWidth(int Value);
	void __fastcall SetImages(Imglist::TCustomImageList* Value);
	void __fastcall SetIndent(int Value);
	void __fastcall SetItems(Comctrls::TTreeNodes* Value);
	void __fastcall SetSelectedNode(Comctrls::TTreeNode* Value);
	void __fastcall SetShowButtons(bool Value);
	void __fastcall SetShowImageInEdit(bool Value);
	void __fastcall SetShowLines(bool Value);
	void __fastcall SetShowRoot(bool Value);
	void __fastcall SetSortType(Comctrls::TSortType Value);
	void __fastcall SetStateImages(Imglist::TCustomImageList* Value);
	void __fastcall SetOnExpanded(Comctrls::TTVExpandedEvent Value);
	void __fastcall SetOnExpanding(Comctrls::TTVExpandingEvent Value);
	void __fastcall SetOnChanging(Comctrls::TTVChangingEvent Value);
	void __fastcall SetOnCollapsed(Comctrls::TTVExpandedEvent Value);
	void __fastcall SetOnCollapsing(Comctrls::TTVCollapsingEvent Value);
	void __fastcall SetOnCompare(Comctrls::TTVCompareEvent Value);
	void __fastcall SetOnGetImageIndex(Comctrls::TTVExpandedEvent Value);
	void __fastcall SetOnGetSelectedIndex(Comctrls::TTVExpandedEvent Value);
	void __fastcall SetOnTreeViewChange(Comctrls::TTVChangedEvent Value);
	void __fastcall FormSize(System::TObject* Sender);
	
protected:
	virtual bool __fastcall CheckKeyForDropDownWindow(Word Key, Classes::TShiftState Shift);
	bool __fastcall DoCanSelectNode(void);
	virtual void __fastcall DoSelectedNodeChanged(void);
	virtual void __fastcall DrawInterior(Graphics::TCanvas* ACanvas, const Types::TRect &R, Dxbar::TdxBarItemLink* ItemLink);
	DYNAMIC void __fastcall DropDown(int X, int Y);
	virtual HWND __fastcall GetDropDownWindow(void);
	bool __fastcall HasImageInEdit(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetText(AnsiString Value);
	
public:
	__fastcall virtual TdxBarTreeViewCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarTreeViewCombo(void);
	DYNAMIC void __fastcall DoClick(void);
	__property Comctrls::TTreeNode* SelectedNode = {read=FSelectedNode, write=SetSelectedNode};
	__property TdxBarTreeView* TreeView = {read=FTreeView};
	
__published:
	__property bool AllowResizing = {read=FAllowResizing, write=FAllowResizing, default=1};
	__property bool ChooseByDblClick = {read=FChooseByDblClick, write=FChooseByDblClick, default=1};
	__property int DropDownHeight = {read=GetDropDownHeight, write=SetDropDownHeight, default=200};
	__property int DropDownWidth = {read=GetDropDownWidth, write=SetDropDownWidth, default=150};
	__property bool FullExpand = {read=FFullExpand, write=FFullExpand, default=0};
	__property Imglist::TCustomImageList* Images = {read=GetImages, write=SetImages};
	__property int Indent = {read=GetIndent, write=SetIndent, nodefault};
	__property Comctrls::TTreeNodes* Items = {read=GetItems, write=SetItems};
	__property bool ShowButtons = {read=GetShowButtons, write=SetShowButtons, nodefault};
	__property ShowEditor  = {default=0};
	__property bool ShowImageInEdit = {read=FShowImageInEdit, write=SetShowImageInEdit, default=1};
	__property bool ShowLines = {read=GetShowLines, write=SetShowLines, nodefault};
	__property bool ShowRoot = {read=GetShowRoot, write=SetShowRoot, nodefault};
	__property Comctrls::TSortType SortType = {read=GetSortType, write=SetSortType, nodefault};
	__property Imglist::TCustomImageList* StateImages = {read=GetStateImages, write=SetStateImages};
	__property Comctrls::TTVExpandedEvent OnExpanded = {read=GetOnExpanded, write=SetOnExpanded};
	__property Comctrls::TTVExpandingEvent OnExpanding = {read=GetOnExpanding, write=SetOnExpanding};
	__property TdxBarTreeViewComboCanSelectNodeEvent OnCanSelectNode = {read=FOnCanSelectNode, write=FOnCanSelectNode};
	__property Comctrls::TTVChangingEvent OnChanging = {read=GetOnChanging, write=SetOnChanging};
	__property Comctrls::TTVExpandedEvent OnCollapsed = {read=GetOnCollapsed, write=SetOnCollapsed};
	__property Comctrls::TTVCollapsingEvent OnCollapsing = {read=GetOnCollapsing, write=SetOnCollapsing};
	__property Comctrls::TTVCompareEvent OnCompare = {read=GetOnCompare, write=SetOnCompare};
	__property Comctrls::TTVExpandedEvent OnGetImageIndex = {read=GetOnGetImageIndex, write=SetOnGetImageIndex};
	__property Comctrls::TTVExpandedEvent OnGetSelectedIndex = {read=GetOnGetSelectedIndex, write=SetOnGetSelectedIndex};
	__property Comctrls::TTVChangedEvent OnTreeViewChange = {read=GetOnTreeViewChange, write=SetOnTreeViewChange};
};


class PASCALIMPLEMENTATION TdxBarTreeView : public Comctrls::TCustomTreeView 
{
	typedef Comctrls::TCustomTreeView inherited;
	
private:
	#pragma pack(push, 1)
	Types::TRect FCloseButtonRect;
	#pragma pack(pop)
	
	#pragma pack(push, 1)
	Types::TRect FGripRect;
	#pragma pack(pop)
	
	bool FCloseButtonIsTracking;
	TdxBarTreeViewCombo* FCombo;
	Dxcommon::TdxCorner FCorner;
	bool FMouseAboveCloseButton;
	Comctrls::TTreeNode* __fastcall FindNode(const AnsiString AText);
	void __fastcall SaveAndHide(void);
	MESSAGE void __fastcall TVMSetImageList(Messages::TMessage &Message);
	MESSAGE void __fastcall TVMSetItem(Messages::TMessage &Message);
	MESSAGE void __fastcall WMCaptureChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TWMGetMinMaxInfo &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMNCLButtonDown(Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSysColorChange(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Message);
	
protected:
	DYNAMIC void __fastcall Change(Comctrls::TTreeNode* Node);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	bool IsPopup;
	__fastcall virtual TdxBarTreeView(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarTreeView(void);
	__property Items ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TdxBarTreeView(HWND ParentWindow) : Comctrls::TCustomTreeView(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarTreeViewComboControl;
class PASCALIMPLEMENTATION TdxBarTreeViewComboControl : public Dxbar::TCustomdxBarComboControl 
{
	typedef Dxbar::TCustomdxBarComboControl inherited;
	
private:
	HIDESBASE TdxBarTreeViewCombo* __fastcall GetItem(void);
	
protected:
	virtual int __fastcall GetHeight(void);
	virtual void __fastcall SetFocused(bool Value);
	
public:
	__property TdxBarTreeViewCombo* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TdxBarTreeViewComboControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TCustomdxBarComboControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TdxBarTreeViewComboControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarImageCombo;
class PASCALIMPLEMENTATION TdxBarImageCombo : public Dxbar::TdxBarCustomCombo 
{
	typedef Dxbar::TdxBarCustomCombo inherited;
	
private:
	Stdctrls::TListBox* FDialogListBox;
	Forms::TForm* FForm;
	Imglist::TChangeLink* FImageChangeLink;
	Imglist::TCustomImageList* FImages;
	bool FShowText;
	int __fastcall GetImageIndexes(int Index);
	void __fastcall SetImageIndexes(int Index, int Value);
	void __fastcall SetImages(Imglist::TCustomImageList* Value);
	void __fastcall SetShowText(bool Value);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall ReadImageIndexes(Classes::TReader* Reader);
	void __fastcall WriteImageIndexes(Classes::TWriter* Writer);
	void __fastcall DialogListBoxDblClick(System::TObject* Sender);
	void __fastcall DialogListBoxDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall DialogListBoxMeasureItem(Controls::TWinControl* Control, int Index, int &Height);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall DrawItem(int AIndex, const Types::TRect &ARect, Windows::TOwnerDrawState AState);
	virtual void __fastcall ImagesChanged(void);
	virtual void __fastcall MeasureItem(int AIndex, int &AHeight);
	virtual void __fastcall MeasureItemWidth(int AIndex, int &AWidth);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TdxBarImageCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarImageCombo(void);
	DYNAMIC void __fastcall DoClick(void);
	__property int ImageIndexes[int Index] = {read=GetImageIndexes, write=SetImageIndexes};
	
__published:
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Items ;
	__property ShowEditor  = {default=0};
	__property Sorted  = {default=0};
	__property ItemIndex ;
	__property bool ShowText = {read=FShowText, write=SetShowText, default=1};
};


class DELPHICLASS TdxBarImageComboControl;
class PASCALIMPLEMENTATION TdxBarImageComboControl : public Dxbar::TdxBarComboControl 
{
	typedef Dxbar::TdxBarComboControl inherited;
	
protected:
	virtual int __fastcall GetHeight(void);
	virtual void __fastcall ImagesChanged(void);
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TdxBarImageComboControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarComboControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TdxBarImageComboControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarToolbarsListItem;
class PASCALIMPLEMENTATION TdxBarToolbarsListItem : public Dxbar::TCustomdxBarSubItem 
{
	typedef Dxbar::TCustomdxBarSubItem inherited;
	
public:
	#pragma option push -w-inl
	/* TCustomdxBarSubItem.Create */ inline __fastcall virtual TdxBarToolbarsListItem(Classes::TComponent* AOwner) : Dxbar::TCustomdxBarSubItem(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomdxBarSubItem.Destroy */ inline __fastcall virtual ~TdxBarToolbarsListItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarToolbarsListItemControl;
class PASCALIMPLEMENTATION TdxBarToolbarsListItemControl : public Dxbar::TdxBarSubItemControl 
{
	typedef Dxbar::TdxBarSubItemControl inherited;
	
protected:
	virtual void __fastcall CreateSubMenuControl(void);
public:
	#pragma option push -w-inl
	/* TdxBarSubItemControl.Destroy */ inline __fastcall virtual ~TdxBarToolbarsListItemControl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarToolbarsListItemControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarSubItemControl(AItemLink) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TdxBarSpinEditButton { sbNone, sbUp, sbDown };
#pragma option pop

#pragma option push -b-
enum TdxBarSpinEditValueType { svtInteger, svtFloat };
#pragma option pop

#pragma option push -b-
enum TdxBarSpinEditPrefixPlace { ppStart, ppEnd };
#pragma option pop

class DELPHICLASS TdxBarSpinEdit;
typedef void __fastcall (__closure *TdxBarSpinEditButtonClickEvent)(TdxBarSpinEdit* Sender, TdxBarSpinEditButton Button);

class PASCALIMPLEMENTATION TdxBarSpinEdit : public Dxbar::TdxBarEdit 
{
	typedef Dxbar::TdxBarEdit inherited;
	
private:
	Extended FIncrement;
	Extended FMaxValue;
	Extended FMinValue;
	AnsiString FPrefix;
	TdxBarSpinEditPrefixPlace FPrefixPlace;
	TdxBarSpinEditValueType FValueType;
	TdxBarSpinEditButtonClickEvent FOnButtonClick;
	Extended __fastcall GetCurValue(void);
	int __fastcall GetIntCurValue(void);
	int __fastcall GetIntValue(void);
	Extended __fastcall GetValue(void);
	void __fastcall SetCurValue(Extended Value);
	void __fastcall SetIncrement(Extended Value);
	void __fastcall SetIntCurValue(int Value);
	void __fastcall SetIntValue(int Value);
	void __fastcall SetMaxValue(Extended Value);
	void __fastcall SetMinValue(Extended Value);
	void __fastcall SetPrefix(const AnsiString Value);
	void __fastcall SetPrefixPlace(TdxBarSpinEditPrefixPlace Value);
	void __fastcall SetValue(Extended Value);
	void __fastcall SetValueType(TdxBarSpinEditValueType Value);
	bool __fastcall IsIncrementStored(void);
	bool __fastcall IsMaxValueStored(void);
	bool __fastcall IsMinValueStored(void);
	bool __fastcall IsValueStored(void);
	void __fastcall AddPrefix(AnsiString &Text);
	void __fastcall RemovePrefix(AnsiString &Text);
	
protected:
	bool __fastcall CheckRange(void);
	void __fastcall DoButtonClick(TdxBarSpinEditButton Button);
	Extended __fastcall GetCheckedValue(Extended Value);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	void __fastcall PrepareValue(Extended &Value);
	Extended __fastcall TextToValue(AnsiString Text);
	virtual void __fastcall SetText(AnsiString Value);
	AnsiString __fastcall ValueToText(Extended Value);
	
public:
	__fastcall virtual TdxBarSpinEdit(Classes::TComponent* AOwner);
	__property Extended CurValue = {read=GetCurValue, write=SetCurValue};
	__property int IntCurValue = {read=GetIntCurValue, write=SetIntCurValue, nodefault};
	__property int IntValue = {read=GetIntValue, write=SetIntValue, nodefault};
	
__published:
	__property TdxBarSpinEditValueType ValueType = {read=FValueType, write=SetValueType, default=0};
	__property Extended Increment = {read=FIncrement, write=SetIncrement, stored=IsIncrementStored};
	__property Extended MaxValue = {read=FMaxValue, write=SetMaxValue, stored=IsMaxValueStored};
	__property Extended MinValue = {read=FMinValue, write=SetMinValue, stored=IsMinValueStored};
	__property AnsiString Prefix = {read=FPrefix, write=SetPrefix};
	__property TdxBarSpinEditPrefixPlace PrefixPlace = {read=FPrefixPlace, write=SetPrefixPlace, default=1};
	__property Text  = {stored=false};
	__property Extended Value = {read=GetValue, write=SetValue, stored=IsValueStored};
	__property TdxBarSpinEditButtonClickEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
public:
	#pragma option push -w-inl
	/* TdxBarItem.Destroy */ inline __fastcall virtual ~TdxBarSpinEdit(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarSpinEditControl;
class PASCALIMPLEMENTATION TdxBarSpinEditControl : public Dxbar::TdxBarEditControl 
{
	typedef Dxbar::TdxBarEditControl inherited;
	
private:
	TdxBarSpinEditButton FActiveButton;
	bool FButtonPressed;
	#pragma pack(push, 1)
	Types::TRect FButtonsRect;
	#pragma pack(pop)
	
	unsigned FTimerID;
	HIDESBASE TdxBarSpinEdit* __fastcall GetItem(void);
	void __fastcall SetActiveButton(TdxBarSpinEditButton Value);
	void __fastcall SetButtonPressed(bool Value);
	
protected:
	void __fastcall BreakProcess(void);
	TdxBarSpinEditButton __fastcall ButtonFromPoint(const Types::TPoint &P);
	virtual void __fastcall Paint(const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	__property TdxBarSpinEditButton ActiveButton = {read=FActiveButton, write=SetActiveButton, nodefault};
	__property bool ButtonPressed = {read=FButtonPressed, write=SetButtonPressed, nodefault};
	__property Types::TRect ButtonsRect = {read=FButtonsRect};
	
public:
	__property TdxBarSpinEdit* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarWinControl.Create */ inline __fastcall virtual TdxBarSpinEditControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarEditControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarWinControl.Destroy */ inline __fastcall virtual ~TdxBarSpinEditControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarControlContainerItem;
class PASCALIMPLEMENTATION TdxBarControlContainerItem : public Dxbar::TdxBarItem 
{
	typedef Dxbar::TdxBarItem inherited;
	
private:
	Controls::TControl* FControl;
	Forms::TCustomForm* FPlace;
	#pragma pack(push, 1)
	Types::TPoint FPrevControlSize;
	#pragma pack(pop)
	
	Classes::TWndMethod FPrevControlWndProc;
	bool __fastcall GetInPlaceControl(void);
	void __fastcall SetControl(Controls::TControl* Value);
	void __fastcall ControlWndProc(Messages::TMessage &Message);
	bool __fastcall IsControlAssigned(Controls::TControl* AControl);
	void __fastcall SaveControlSize(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetName(const AnsiString NewName);
	virtual bool __fastcall CanClicked(void);
	virtual bool __fastcall GetHidden(void);
	virtual bool __fastcall HasAccel(Dxbar::TdxBarItemLink* AItemLink);
	virtual void __fastcall HideControl(Dxbar::TdxBarItemControl* AControl);
	virtual bool __fastcall NeedToBeHidden(void);
	__property bool InPlaceControl = {read=GetInPlaceControl, nodefault};
	__property Forms::TCustomForm* Place = {read=FPlace};
	
public:
	__fastcall virtual TdxBarControlContainerItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TdxBarControlContainerItem(void);
	
__published:
	__property Controls::TControl* Control = {read=FControl, write=SetControl};
};


class DELPHICLASS TdxBarControlContainerControl;
class PASCALIMPLEMENTATION TdxBarControlContainerControl : public Dxbar::TdxBarItemControl 
{
	typedef Dxbar::TdxBarItemControl inherited;
	
private:
	bool FInPlaceControl;
	Controls::TControl* __fastcall GetControl(void);
	HIDESBASE TdxBarControlContainerItem* __fastcall GetItem(void);
	Forms::TCustomForm* __fastcall GetPlace(void);
	
protected:
	virtual void __fastcall BeforeDestroyParentHandle(void);
	virtual bool __fastcall CanClicked(void);
	virtual bool __fastcall CanSelect(void);
	virtual int __fastcall GetHeight(void);
	virtual int __fastcall GetWidth(void);
	virtual bool __fastcall IsDestroyOnClick(void);
	bool __fastcall IsShowingControl(void);
	virtual bool __fastcall NeedCaptureMouse(void);
	virtual void __fastcall Paint(const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	void __fastcall PlaceControl(void);
	bool __fastcall ShowsControl(void);
	__property Controls::TControl* Control = {read=GetControl};
	__property bool InPlaceControl = {read=FInPlaceControl, nodefault};
	__property Forms::TCustomForm* Place = {read=GetPlace};
	
public:
	__fastcall virtual ~TdxBarControlContainerControl(void);
	__property TdxBarControlContainerItem* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarControlContainerControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarItemControl(AItemLink) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarProgressItem;
class PASCALIMPLEMENTATION TdxBarProgressItem : public TdxBarStatic 
{
	typedef TdxBarStatic inherited;
	
private:
	int FMax;
	int FMin;
	int FPosition;
	bool FSmooth;
	int FStep;
	void __fastcall SetMax(int Value);
	void __fastcall SetMin(int Value);
	void __fastcall SetPosition(int Value);
	void __fastcall SetSmooth(bool Value);
	void __fastcall SetStep(int Value);
	
protected:
	void __fastcall UpdateBar(void);
	
public:
	__fastcall virtual TdxBarProgressItem(Classes::TComponent* AOwner);
	void __fastcall SetParams(int AMin, int AMax);
	void __fastcall StepBy(int Delta);
	void __fastcall StepIt(void);
	
__published:
	__property BorderStyle  = {default=1};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property bool Smooth = {read=FSmooth, write=SetSmooth, default=0};
	__property int Step = {read=FStep, write=SetStep, default=10};
public:
	#pragma option push -w-inl
	/* TdxBarItem.Destroy */ inline __fastcall virtual ~TdxBarProgressItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarProgressControl;
class PASCALIMPLEMENTATION TdxBarProgressControl : public TdxBarStaticControl 
{
	typedef TdxBarStaticControl inherited;
	
private:
	HIDESBASE TdxBarProgressItem* __fastcall GetItem(void);
	
protected:
	virtual HBRUSH __fastcall BarBrush(void);
	int __fastcall BarHeight(void);
	Types::TRect __fastcall BarRect();
	int __fastcall BarWidth(void);
	virtual bool __fastcall CanHaveZeroSize(void);
	virtual void __fastcall DrawInterior(HDC DC, const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	virtual Classes::TAlignment __fastcall GetAlignment(void);
	virtual int __fastcall GetDefaultWidth(void);
	void __fastcall UpdateBar(void);
	
public:
	__property TdxBarProgressItem* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarProgressControl(Dxbar::TdxBarItemLink* AItemLink) : TdxBarStaticControl(AItemLink) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TdxBarItemControl.Destroy */ inline __fastcall virtual ~TdxBarProgressControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarMRUListItem;
class PASCALIMPLEMENTATION TdxBarMRUListItem : public Dxbar::TdxBarListItem 
{
	typedef Dxbar::TdxBarListItem inherited;
	
private:
	int FMaxItemCount;
	bool FRemoveItemOnClick;
	void __fastcall SetMaxItemCount(int Value);
	
protected:
	void __fastcall CheckItemCount(void);
	virtual AnsiString __fastcall GetDisplayText(const AnsiString AText);
	
public:
	__fastcall virtual TdxBarMRUListItem(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall DirectClick(void);
	void __fastcall AddItem(const AnsiString S, System::TObject* AObject);
	void __fastcall RemoveItem(const AnsiString S, System::TObject* AObject);
	
__published:
	__property int MaxItemCount = {read=FMaxItemCount, write=SetMaxItemCount, default=5};
	__property bool RemoveItemOnClick = {read=FRemoveItemOnClick, write=FRemoveItemOnClick, default=0};
public:
	#pragma option push -w-inl
	/* TdxBarListItem.Destroy */ inline __fastcall virtual ~TdxBarMRUListItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarInPlaceSubItem;
typedef void __fastcall (__closure *TdxBarInPlaceSubItemEvent)(TdxBarInPlaceSubItem* Sender, Dxbar::TdxBarItemLink* Link);

class PASCALIMPLEMENTATION TdxBarInPlaceSubItem : public Dxbar::TdxBarContainerItem 
{
	typedef Dxbar::TdxBarContainerItem inherited;
	
private:
	bool FExpanded;
	bool FExpandedChanging;
	bool FKeepBeginGroupWhileExpanded;
	TdxBarInPlaceSubItemEvent FOnAfterExpand;
	TdxBarInPlaceSubItemEvent FOnBeforeCollapse;
	void __fastcall SetExpanded(bool Value);
	
protected:
	virtual void __fastcall AddListedItemLinks(Dxbar::TdxBarItemLinks* AItemLinks, int AIndex, bool FirstCall, Dxbar::TdxBarItemLink* CallingItemLink);
	virtual void __fastcall DeleteListedItemLinks(Dxbar::TdxBarItemLinks* AItemLinks, int AIndex);
	virtual bool __fastcall HideWhenRun(void);
	void __fastcall ChangeNextItemLinkBeginGroup(Dxbar::TdxBarItemLink* ALink, bool Value);
	DYNAMIC void __fastcall DoAfterExpand(Dxbar::TdxBarItemLink* ALink);
	DYNAMIC void __fastcall DoBeforeCollapse(Dxbar::TdxBarItemLink* ALink);
	
__published:
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=0};
	__property bool KeepBeginGroupWhileExpanded = {read=FKeepBeginGroupWhileExpanded, write=FKeepBeginGroupWhileExpanded, nodefault};
	__property TdxBarInPlaceSubItemEvent OnAfterExpand = {read=FOnAfterExpand, write=FOnAfterExpand};
	__property TdxBarInPlaceSubItemEvent OnBeforeCollapse = {read=FOnBeforeCollapse, write=FOnBeforeCollapse};
public:
	#pragma option push -w-inl
	/* TCustomdxBarContainerItem.Destroy */ inline __fastcall virtual ~TdxBarInPlaceSubItem(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomdxBarSubItem.Create */ inline __fastcall virtual TdxBarInPlaceSubItem(Classes::TComponent* AOwner) : Dxbar::TdxBarContainerItem(AOwner) { }
	#pragma option pop
	
};


class DELPHICLASS TdxBarInPlaceSubItemControl;
class PASCALIMPLEMENTATION TdxBarInPlaceSubItemControl : public Dxbar::TdxBarContainerItemControl 
{
	typedef Dxbar::TdxBarContainerItemControl inherited;
	
private:
	HIDESBASE TdxBarInPlaceSubItem* __fastcall GetItem(void);
	
protected:
	virtual void __fastcall ControlClick(bool ByMouse);
	DYNAMIC void __fastcall DblClick(void);
	virtual int __fastcall GetDefaultHeight(void);
	virtual int __fastcall GetDefaultWidth(void);
	virtual bool __fastcall HasSubMenu(void);
	virtual bool __fastcall IsExpandable(void);
	virtual void __fastcall KeyDown(Word Key);
	virtual void __fastcall Paint(const Types::TRect &ARect, Dxbar::TdxBarPaintType PaintType);
	virtual bool __fastcall WantsKey(Word Key);
	
public:
	__property TdxBarInPlaceSubItem* Item = {read=GetItem};
public:
	#pragma option push -w-inl
	/* TdxBarSubItemControl.Destroy */ inline __fastcall virtual ~TdxBarInPlaceSubItemControl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TdxBarItemControl.Create */ inline __fastcall virtual TdxBarInPlaceSubItemControl(Dxbar::TdxBarItemLink* AItemLink) : Dxbar::TdxBarContainerItemControl(AItemLink) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Word StartOfWeek;
extern PACKAGE AnsiString sdxBarDatePopupToday;
extern PACKAGE AnsiString sdxBarDatePopupClear;
static const int NullDate = 0xfff551a0;
extern PACKAGE int __fastcall DateOf(System::TDateTime ADateTime);
extern PACKAGE Dialogs::TColorDialog* __fastcall dxBarColorDialog(void);
extern PACKAGE Dialogs::TFontDialog* __fastcall dxBarFontDialog(void);

}	/* namespace Dxbarextitems */
using namespace Dxbarextitems;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarExtItems
