unit evButton;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В.     }
{ Модуль: evButton - }
{ Начат: 07.10.1998 15:39 }
{ $Id: evButton.pas,v 1.25 2013/12/09 14:09:17 fireton Exp $ }

// $Log: evButton.pas,v $
// Revision 1.25  2013/12/09 14:09:17  fireton
// - без этого модуля не собираются проекты Архивариуса
//
// Revision 1.23  2012/08/29 14:48:49  kostitsin
// [$378542059],
// [$378560607]
//
// Revision 1.22  2012/08/29 13:21:30  kostitsin
// [$378542059]
//
// Revision 1.21  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.18.14.5  2007/04/20 13:24:03  lulin
// - не пишем мусор.
//
// Revision 1.18.14.4  2007/04/20 11:07:19  lulin
// - убираем ненужную функциональность.
//
// Revision 1.18.14.3  2007/04/20 09:06:04  lulin
// - убираем ненужную функциональность.
//
// Revision 1.18.14.2  2007/04/02 06:34:02  lulin
// - вычищено ненужное свойство.
//
// Revision 1.18.14.1  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.18  2004/11/30 13:31:36  mmorozov
// new: published property TevButton.AutoSize;
//
// Revision 1.17  2004/09/14 09:14:20  lulin
// - cleanup: редко используемые поля убраны под define'ы.
// - упорядочено наследование.
// - поправлены имена.
//
// Revision 1.16  2004/09/13 15:50:24  lulin
// - cleanup: выкинул лишний модуль из Toolbar 97.
// - bug fix: за Мишей - не компилировался VCM.
//
// Revision 1.15  2003/12/26 16:51:12  law
// - new behavior: переделана логика обработки BottonCombo - теперь если меню нету, то и стрелки вниз нету.
// - bug fix: иногда при восстановлении из истории портился Caption главного окна.
//
// Revision 1.14  2003/08/01 11:46:04  law
// - bug fix: не "залипали" кнопки.
//
// Revision 1.13  2001/10/05 11:39:24  law
// - cleanup: убрано восстановление ImageIndex.
//
// Revision 1.12  2001/10/04 16:01:49  law
// - new behavior: в _TevCustomButton теперь используются TevCustomAction.
//
// Revision 1.11  2001/09/21 09:58:54  law
// - cleanup.
//
// Revision 1.10  2001/08/29 07:59:54  law
// - new behavior: добавлены свойства по умолчанию.
//
// Revision 1.9  2001/06/25 16:20:44  voba
// - new behavior: свойство Enabled теперь сохраняется для операции ev_ccNone.
//
// Revision 1.8  2001/04/13 08:28:59  law
// - new behavior: по другому сделана обработка стандаотных операций.
//
// Revision 1.7  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.6  2000/12/15 15:10:34  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }
{$Include TB97Ver.inc}

interface

uses
  Classes,
  Controls,

  tb97Ctls,

  l3Types

  {$IfDef evNeedDisp}
  ,
  evStandardActions
  {$EndIf evNeedDisp}
  ;

type
  TevCustomButton = class(TCustomToolbarButton97)
    protected
    // internal methods
      function GlyphStored: Bool;
        override;
        {-}
      function GlyphMaskStored: Boolean;
        override;
        {-}
    protected
    // property methods
      {$IfDef evNeedDisp}
      function  pm_GetOperation: TevOperation;
      procedure pm_SetOperation(Value: TevOperation);
        {-}
      {$EndIf evNeedDisp}
    protected
    // internal methods
      function EnabledStored: Bool;
        {-}
      procedure DoClick;
        override;
        {-}
      function GetActionLinkClass: TControlActionLinkClass;
        override;
        {-}
      procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);
        override;
        {-}
      function  HackCheck: Boolean;
        virtual;
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
    public
    /// public properties
      {$IfDef evNeedDisp}
      property Operation: TevOperation
        read pm_GetOperation
        write pm_SetOperation
        default ev_ccNone;
        {-}
      {$EndIf evNeedDisp}  
      property Enabled
        stored EnabledStored;
        {-}
      property Glyph;
        {-}
      property GlyphMask;
        {-}
      property DisplayMode
        default dmGlyphOnly;
        {-}
    published
    // published properties
      property Top
        default 0;
        {-}
      property Width
        default 23;
        {-}
      property Height
        default 23;
        {-}
  end;//TevCustomButton

  TevCustomButtonActionLink = class(TToolbarButton97ActionLink, IUnknown)
    protected
    // internal methods
      // IUnknown
      function _AddRef: Integer;
        stdcall;
        {* - реализация метода _AddRef интерфейса IUnknown, увеличивает число ссылок на объект. }
      function _Release: Integer;
        stdcall;
        {* - реализация метода _Release интерфейса IUnknown, уменьшает число ссылок на объект и уничтожает его, если число ссылок становится = 0. }
      function QueryInterface(const IID: TGUID; out Obj): HResult;
        virtual;
        stdcall;
        {-}
    protected
    // internal methods
      procedure SetHint(const Value: string);
        override;
        {-}
  end;//TevCustomButtonActionLink

  TevButton = class(TevCustomButton)
    published
      property AutoSize;
      {$IfDef evNeedDisp}
      property Operation;
      {$EndIf evNeedDisp}
      property Hint;
      {$IFDEF Delphi4}
      property Action;
      {$ENDIF}
      property Alignment;
      property AllowAllUp;
      {$IFDEF Delphi4}
      property Anchors;
      {$ENDIF}
      property Cancel;
      property Color;
      {$IFDEF Delphi4}
      property Constraints;
      {$ENDIF}
      property GroupIndex;
      property Default;
      property DisplayMode;
      property Down;
      property DragCursor;
      property DragMode;
      property DropdownAlways;
      property DropdownArrow;
      property DropdownArrowWidth;
      property DropdownCombo;
      property DropdownMenu;
      property Caption;
      property Enabled;
      property Flat;
      property Font;
      property Glyph;
      property GlyphMask;
      property HelpContext;
      property ImageIndex;
      property Images;
      property Layout;
      property Margin;
      property ModalResult;
      property NoBorder;
      property NumGlyphs;
      property Opaque;
      property ParentFont;
      property ParentColor;
      property ParentShowHint;
      {$IfDef tb97NeedRepeating}
      property Repeating;
      property RepeatDelay;
      property RepeatInterval;
      {$EndIf tb97NeedRepeating}
      property ShowBorderWhenInactive;
      property ShowHint;
      property Spacing;
      property Visible;
      property WordWrap;

      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      {$IfDef tb97NeedOnDropdown}
      property OnDropdown;
      {$EndIf tb97NeedOnDropdown}
      property OnEndDrag;
      property OnMouseDown;
      {$IfDef tb97NeedMouseEvents}
      property OnMouseEnter;
      property OnMouseExit;
      {$EndIf tb97NeedMouseEvents}
      property OnMouseMove;
      property OnMouseUp;
      property OnStartDrag;
  end;//TevButton

implementation

uses
  ActnList

  {$IfDef evNeedDisp}
  ,
  evAction,
  evDisp
  {$EndIf evNeedDisp}
  ;

{ start class TevCustomButton }

constructor TevCustomButton.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 Width := 23;
 Height := 23;
 DisplayMode := dmGlyphOnly;
end;

function TevCustomButton.GlyphStored: Bool;
  {-}
begin
 Result := inherited GlyphStored AND ((Images = nil) OR (ImageIndex < 0));
end;

function TevCustomButton.GlyphMaskStored: Boolean;
  //override;
  {-}
begin
 Result := inherited GlyphMaskStored AND ((Images = nil) OR (ImageIndex < 0));
end;

{$IfDef evNeedDisp}
function TevCustomButton.pm_GetOperation: TevOperation;
  {-}
begin
 if (Action Is TevCustomAction) then
  Result := TevCustomAction(Action).Operation
 else
  Result := ev_ccNone;
end;

procedure TevCustomButton.pm_SetOperation(Value: TevOperation);
  {-}
begin
 if (Operation <> Value) then
  Action := evOperationDispatcher.GetAction(Value);
end;
{$EndIf evNeedDisp}

function  TevCustomButton.HackCheck: Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

procedure TevCustomButton.DoClick;
  //override;
  {-}
var
 l_Checked : Bool;
begin
 if (Action = nil) then
  inherited
 else begin
  l_Checked := Down;
  Action.Tag := Tag;
  inherited;
  if HackCheck then
   Down := l_Checked;
 end;
end;

function TevCustomButton.GetActionLinkClass: TControlActionLinkClass;
  //override;
  {-}
begin
 Result := TevCustomButtonActionLink;
end;

function TevCustomButton.EnabledStored: Bool;
  {-}
begin
 {$IfDef evNeedDisp}
 Result := (Operation = ev_ccNone);
 {$Else  evNeedDisp}
 Result := true;
 {$EndIf evNeedDisp}
end;

procedure TevCustomButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
  //override;
  {-}
{$IfDef evNeedDisp}
var
 l_Hint : String;
{$EndIf evNeedDisp} 
begin
 {$IfDef evNeedDisp}
 if (Hint = '') OR not (csLoading in ComponentState) OR (Operation = ev_ccNone) then
  inherited
 else
 begin
  l_Hint := Hint;
  try
   inherited;
  finally
   Hint := l_Hint;
  end;//try..finally
 end;//Hint = ''
 {$Else  evNeedDisp}
 inherited;
 {$EndIf evNeedDisp}
end;

// start class TevCustomButtonActionLink

procedure TevCustomButtonActionLink.SetHint(const Value: string);
  //override;
  {-}
begin
 {$IfDef evNeedDisp}
 if (FClient Is TevCustomButton) then
 begin
  with TevCustomButton(FClient) do
  begin
   if (Hint = '') OR not (csLoading in ComponentState) OR (Operation = ev_ccNone) then
    inherited;
  end;
 end//FClient Is TevCustomButton
 else
 {$EndIf evNeedDisp}
  inherited;
end;

function TevCustomButtonActionLink._AddRef: Integer;
  //stdcall;
  {* - реализация метода _AddRef интерфейса IUnknown, увеличивает число ссылок на объект. }
begin
 Result := -1;
end;

function TevCustomButtonActionLink._Release: Integer;
  //stdcall;
  {* - реализация метода _Release интерфейса IUnknown, уменьшает число ссылок на объект и уничтожает его, если число ссылок становится = 0. }
begin
 Result := -1;
end;

function TevCustomButtonActionLink.QueryInterface(const IID: TGUID; out Obj): HResult;
  //virtual;
  //stdcall;
  {-}
begin
 if TObject(Self).GetInterface(IID, Obj) then
  Result := S_Ok
 else
  Result := E_NoInterface;
end;

end.

