unit nscPageControl;

// Библиотека : "Визуальные компоненты проекта Немезис"
// Автор      : М. Морозов.
// Начат      : 06.12.2006 г.
// Назначение : Компонент с вкладками
// Версия     : $Id: nscPageControl.pas,v 1.13 2016/09/13 18:32:40 kostitsin Exp $

// $Log: nscPageControl.pas,v $
// Revision 1.13  2016/09/13 18:32:40  kostitsin
// {requestlink: 630194905 }
//
// Revision 1.12  2012/10/26 14:57:56  lulin
// {RequestLink:406489593}
//
// Revision 1.11  2012/10/26 14:48:54  lulin
// {RequestLink:406489593}
//
// Revision 1.10  2011/03/15 16:19:36  lulin
// {RequestLink:228688510}.
// [$255978845].
// [$255983129].
// - не даём таскать сплиттер у толкования без перевода.
//
// Revision 1.9  2009/01/21 14:43:49  lulin
// - боремся с родительским шрифтом (подробности у Вована).
//
// Revision 1.8  2009/01/12 17:38:11  lulin
// - <K>: 133138664. № 24.
//
// Revision 1.7  2007/08/20 09:06:07  mmorozov
// - new: уведомление об изменении активной вкладки (CQ: OIT5-26352);
//
// Revision 1.6  2007/08/06 08:36:32  oman
// - fix: Не обрабатывались OVC-команды (cq26245)
//
// Revision 1.5  2007/07/11 11:11:12  oman
// - new: Вытащен флаг "Меняем закладку от мыши" (cq25768)
//
// Revision 1.4  2007/05/07 07:36:20  oman
// - fix: Обрабатываем таблицу команд (cq25145)
//
// Revision 1.3  2007/05/03 12:49:24  oman
// - fix: Скрыл конструктор
//
// Revision 1.2  2007/05/03 12:44:10  oman
// - new: Новый паге-контрол для базового поиска - борюсь сл шритами...
//
// Revision 1.1  2006/12/07 14:23:11  mmorozov
// - new: используем единые настройки для компонента с вкладками (CQ: OIT5-23819);
//

interface

uses
  Classes,
  Messages,

  ElPgCtl,
  vcmDispatcher
  ;

{$Include ElPack.inc}

type
  _nscDestPageControl_ = TElCustomPageControl;
  {$Include nscPageControl.inc}
  TnscPageControl = class(_nscPageControl_)
  {* Компонент с вкладками }
  private
  // messages
   procedure WMKeyDown(Var Msg: TWMKeyDown);
     message WM_KEYDOWN;
     {-}
   procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
     message WM_SYSKEYDOWN;
     {-}
  protected
  // methods
   function  IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
     {-}
  published
  // properties
    property ActiveTabAfterDelete;     
    property TabPosition;
    property Images;
    property TabIndex;
    property ActivePage;
    property DefaultPage;
    property Align;
    property Enabled;
    property PopupMenu;
    property TabOrder;
    property TabStop;
    property ShowHint;
    property Visible;
    property Color;
    property ParentColor;
    {$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockSite;
    property DockOrientation;
    property DragKind;
    {$ENDIF}
  // events
    {$IFDEF VCL_4_USED}
    property OnStartDock;
    property OnUnDock;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    {$ENDIF}
    property OnStartDragControl;
    property OnEndDragControl;
    property OnTabSheetClick;
    property OnChanging;
    property OnChange;
    property OnGetImageIndex;
    property OnDrawTab;
    property OnDblClick;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnClosePageQuery;
  end;//TnscPageControl

(*  TnscFullPageControl = class(TelPageCOntrol)
  private
   procedure WMKeyDown(Var Msg: TWMKeyDown);
     message WM_KEYDOWN;
     {-}
   procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
     message WM_SYSKEYDOWN;
     {-}
  protected
   procedure ChangeScale(M, D: Integer);
    override;
      {-}
   function  IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
     {-}
  public
   constructor Create(aOwner: TComponent);
    override;
      {-}
  public
   property ChangingActivePageByMouse;    
    protected
      property ParentFont
        default false;
        {-}    
  end;*)

implementation

uses
 SysUtils,
 Graphics,
 Controls,
 Windows,

 OvcBase,
 OvcConst,

 afwVCL,

 {$IfNDef NoVCM}
 {$IfNDef DesignTimeLibrary}
 vcmBase,
 {$EndIf DesignTimeLibrary}
 {$EndIf  NoVCM}

 nscInterfaces,
 nscNewInterfaces,
 nscTabFont
 ;

{$Include nscPageControl.inc}

(*{ TnscFullPageControl }

procedure TnscFullPageControl.ChangeScale(M, D: Integer);
begin
 if csLoading in ComponentState then
  ScalingFlags := ScalingFlags - [sfFont];
 inherited ChangeScale(M, D);
end;

constructor TnscFullPageControl.Create(aOwner: TCOmponent);
begin
 inherited Create(aOwner);
 // HotTrackFont
 afwHackFont(FHotTrackFont, TnscTabFont);
 // ActiveTabFont
 afwHackFont(FActiveTabFont, TnscTabFont);
 // Font
 afwHackControlFont(Self, TnscTabFont);
end;

function TnscFullPageControl.IsHandledShortcut(
  var Msg: TWMKeyDown): Boolean;
var
 l_Controller : TOvcController;
begin
 Result := false;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := true;
   end;
end;

procedure TnscFullPageControl.WMKeyDown(var Msg: TWMKeyDown);
begin
 if not IsHandledShortcut(Msg) then
  inherited;
end;

procedure TnscFullPageControl.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if not IsHandledShortcut(Msg) then
  inherited;
end;*)

{ TnscPageControl }

function TnscPageControl.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
var
 l_Controller : TOvcController;
begin
 Result := false;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := true;
   end;
end;

procedure TnscPageControl.WMKeyDown(var Msg: TWMKeyDown);
begin
 if not IsHandledShortcut(Msg) then
  inherited;
end;

procedure TnscPageControl.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if not IsHandledShortcut(Msg) then
  inherited;
end;

end.