unit vtRadioButton;

////////////////////////////////////////////////////////////////////////////////
// Библиотека : VT.
// Назначение : Компонент-переключатель.
// Версия     : $Id: vtRadioButton.pas,v 1.10 2014/05/19 11:48:03 kostitsin Exp $
////////////////////////////////////////////////////////////////////////////////

(*-------------------------------------------------------------------------------
  $Log: vtRadioButton.pas,v $
  Revision 1.10  2014/05/19 11:48:03  kostitsin
  {requestlink: 523327528 }

  Revision 1.9  2014/02/03 08:20:35  morozov
  {RequestLink: 515838753}

  Revision 1.8  2013/09/02 15:52:01  lulin
  - правим за Мишей.

  Revision 1.7  2013/08/20 10:04:01  kostitsin
  [$414849897] - добавил в TvtRadioButton свойство OnChange

  Revision 1.6  2013/04/29 12:24:47  morozov
  {RequestLink:452380433}

  Revision 1.5  2013/04/26 16:21:34  lulin
  - правим под XE3.

  Revision 1.4  2013/04/25 14:22:38  lulin
  - портируем.

  Revision 1.3  2013/04/25 13:44:53  morozov
  {RequestLink:363571639}

  Revision 1.2  2013/04/25 13:20:26  morozov
  {RequestLink:363571639}

  Revision 1.1  2008/07/22 10:41:19  mmorozov
  - new: компонент-переключатель (K<103940871>);

-------------------------------------------------------------------------------*)

interface

{$Include vtDefine.inc}

uses
  StdCtrls,
  Messages,
  Windows,
  Controls,
  Classes
  ;

type

 _UnicodeButtonControlParent_ = TRadioButton;
 {$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.inc}
  TvtRadioButton = class(_UnicodeButtonControl_)
  private
    f_OnChange: TNotifyEvent;
  // methods
    function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
      {-}
  private
  // messages
    procedure WMKeyDown(var Msg: TWMKeyDown);
      message WM_KEYDOWN;
      {-}
    procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
      message WM_SYSKEYDOWN;
      {-}
   protected
    procedure SetChecked(Value: Boolean); override;
    procedure DoChanged;
   {$IfNDef XE}
   protected
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
   public
    property OnChange: TNotifyEvent read f_OnChange write f_OnChange;
   {$EndIf  XE}
  end;

 _vtButtonControlWithWMMouseActivateHack_Parent_ = TvtRadioButton;
 {$Include w:\common\components\gui\Garant\VT\vtButtonControlWithWMMouseActivateHack.imp.pas}
 TvtRadioButton1 = class(_vtButtonControlWithWMMouseActivateHack_)
  protected
   procedure DoClick; override;
 end;

implementation

uses
  OvcConst,
  OvcBase,
  SysUtils,
  CommCtrl,
  Consts
  ;

{$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.inc}

{$Include w:\common\components\gui\Garant\VT\vtButtonControlWithWMMouseActivateHack.imp.pas}

procedure TvtRadioButton.DoChanged;
begin
 if Assigned(f_OnChange) then
  f_OnChange(Self);
end;

{$IfNDef XE}
procedure TvtRadioButton.CreateParams(var Params: TCreateParams);
const
 lc_Alignments: array[Boolean, TLeftRight] of DWORD =
  ((BS_LEFTTEXT, 0), (0, BS_LEFTTEXT));
begin
 inherited CreateParams(Params);
 CreateSubClass(Params, 'BUTTON');
 with Params do
  Style := Style or BS_RADIOBUTTON or
   lc_Alignments[UseRightToLeftAlignment, Alignment];
end;
{$EndIf XE}

{$IfNDef XE}
procedure TvtRadioButton.CreateWnd;
begin
  inherited;
  // нужно устанавливать изначальное состояние (K452380433)
  SendMessage(Handle, BM_SETCHECK, Integer(Checked), 0);
end;
{$EndIf XE}

function TvtRadioButton.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
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

procedure TvtRadioButton.SetChecked(Value: Boolean);
begin
 inherited;
 DoChanged;
end;

procedure TvtRadioButton.WMKeyDown(var Msg: TWMKeyDown);
begin
 if not IsHandledShortcut(Msg) then
  inherited;
end;

procedure TvtRadioButton.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if not IsHandledShortcut(Msg) then
  inherited;
end;

{ TvtRadioButton1 }

procedure TvtRadioButton1.DoClick;
begin
 inherited;
 Checked := True;
end;

end.
