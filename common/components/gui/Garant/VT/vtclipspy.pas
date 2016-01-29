unit vtClipSpy;

{ $Id: vtclipspy.pas,v 1.10 2012/11/01 09:42:28 lulin Exp $ }

// $Log: vtclipspy.pas,v $
// Revision 1.10  2012/11/01 09:42:28  lulin
// - забыл точку с запятой.
//
// Revision 1.9  2012/11/01 07:44:16  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.8  2004/09/02 13:05:55  law
// - все dynamic методы заменил на virtual.
//
// Revision 1.7  2004/03/24 17:21:25  law
// - bug fix: AV при выходе из Эвереста.
//
// Revision 1.6  2003/04/19 11:24:50  law
// - new file: vtDefine.inc.
//
// Revision 1.5  2003/03/18 17:14:50  law
// - bug fix: не очищался ClipBoardSpy.
//
// Revision 1.4  2001/04/05 08:52:17  law
// - cleanup: использование модулей WinTypes и WinProcs заменен на Windows.
//
// Revision 1.3  2000/12/15 15:36:29  law
// - вставлены директивы Log.
//

{$I vtDefine.inc }

interface

{.$IFDEF WIN32}
{.$DEFINE ThreadClipSpy}
{.$ENDIF}

Uses Windows,
     Messages,Classes, Controls;


Type

 TClipSpyWnd = Class(TWinControl)
   private
    { Private declarations }
    fWndNext       : HWnd;
    fChained       : Boolean;
    fOnChange      : TNotifyEvent;
    procedure ForwardMessage(var Message: TMessage);
    procedure WMDestroyClipboard(var Message: TMessage); message WM_DESTROYCLIPBOARD;
    procedure WMChangeCBChain(var Message: TWMChangeCBChain); message WM_CHANGECBCHAIN;
    procedure WMDrawClipboard(var Message: TMessage); message WM_DRAWCLIPBOARD;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure SetOnChange (aOnChange: TNotifyEvent);
  protected
    { Protected declarations }
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
    procedure Change; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    //constructor Create(AOwner: TComponent); override;
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

 {$IFDEF ThreadClipSpy}
 TClipSpy = class(TThread)
  protected
   fClipWnd : TClipSpyWnd;
   procedure SetOnChange (aOnChange: TNotifyEvent);
   procedure SetNotifyControl(aNotifyControl : TWinControl);
   procedure Execute; override;
  public
   constructor Create;
   destructor Destroy; override;
   property OnChange: TNotifyEvent {read FOnChange} write SetOnChange;
   property NotifyControl : TWinControl {read fNotifyControl} write SetNotifyControl;
 end;
{$ENDIF}
 function ClipboardIsEmpty : Boolean;

var
 ClipBoardSpy : {$IFDEF ThreadClipSpy} TClipSpy {$ELSE} TClipSpyWnd {$ENDIF};

implementation
 Uses SysUtils, ClipBrd, l3Base;

procedure TClipSpyWnd.SetOnChange (aOnChange: TNotifyEvent);
 begin
  If @fOnChange <> @aOnChange then fOnChange := aOnChange;
  If @aOnChange <> nil then HandleNeeded;
 end;

procedure TClipSpyWnd.ForwardMessage(var Message: TMessage);
 begin
  if fWndNext <> 0 then
    with Message do SendMessage(fWndNext, Msg, WParam, LParam);
 end;

procedure TClipSpyWnd.CreateParams(var Params: TCreateParams);
 begin
  Inherited CreateParams(Params);
  with Params do
   begin
    Style := Style and not WS_CHILD;
   end;
 end;

procedure TClipSpyWnd.CreateWnd;
 var
  lHandle: HWND;
 begin
  inherited CreateWnd;
  if Handle <> 0 then
   begin
    lHandle := Handle;
    fWndNext := SetClipboardViewer(lHandle);
    fChained := True;
   end;
 end;

procedure TClipSpyWnd.DestroyWindowHandle;
 begin
  if fChained then
   begin
    ChangeClipboardChain(Handle, fWndNext);
    fChained := False;
   end;
  fWndNext := 0;
  inherited DestroyWindowHandle;
 end;

procedure TClipSpyWnd.Change;
 begin
  if Assigned(fOnChange) then fOnChange(Self);
 end;

procedure TClipSpyWnd.WMChangeCBChain(var Message: TWMChangeCBChain);
 begin
  if Message.Remove = fWndNext
   then fWndNext := Message.Next
   else ForwardMessage(TMessage(Message));
  inherited;
 end;

procedure TClipSpyWnd.WMNCDestroy(var Message: TWMNCDestroy);
 begin
  if FChained then
   begin
    ChangeClipboardChain(Handle, fWndNext);
    fChained := False;
    fWndNext := 0;
   end;
  inherited;
 end;

procedure TClipSpyWnd.WMDrawClipboard(var Message: TMessage);
 begin
  ForwardMessage(Message);
  Change;
 end;

procedure TClipSpyWnd.WMDestroyClipboard(var Message: TMessage);
 begin
  Change;
 end;

function ClipboardIsEmpty: Boolean;
 begin
  Result := (Clipboard.FormatCount = 0);
 end;

{$IFDEF ThreadClipSpy}

{TClipSpy}
 constructor TClipSpy.Create;
  begin
   Inherited Create(True);
   Priority:=tpIdle;
   Resume;
  end;

 destructor TClipSpy.Destroy;
  begin
   fClipWnd.Free;
   inherited Destroy;
  end;

procedure TClipSpy.SetOnChange (aOnChange: TNotifyEvent);
 begin
  fClipWnd.OnChange := aOnChange;
 end;

procedure TClipSpy.SetNotifyControl(aNotifyControl : TWinControl);
 begin
  fClipWnd.NotifyControl := aNotifyControl;
 end;

procedure TClipSpy.Execute;
 begin
  fClipWnd := TClipSpyWnd.Create(nil);
  while not (Terminated) do; // Sleep(0);
  //fClipWnd.Free;
 end;
{$ENDIF}

procedure DoneSpy;
begin
 FreeAndNil(ClipBoardSpy);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtclipspy.pas initialization enter'); {$EndIf}
 ClipBoardSpy := {$IFDEF ThreadClipSpy} TClipSpy.Create {$ELSE} TClipSpyWnd.Create(Nil) {$ENDIF};
 l3System.AddExitProc(DoneSpy);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtclipspy.pas initialization leave'); {$EndIf}
end.
