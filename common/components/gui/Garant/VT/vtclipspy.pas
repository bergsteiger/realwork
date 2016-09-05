unit vtClipSpy;

{ $Id: vtclipspy.pas,v 1.16 2016/07/01 14:29:21 dinishev Exp $ }

// $Log: vtclipspy.pas,v $
// Revision 1.16  2016/07/01 14:29:21  dinishev
// Несколько подписчиков.
//
// Revision 1.15  2016/07/01 13:42:56  dinishev
// Убрал f_OnChange
//
// Revision 1.14  2016/07/01 13:13:38  dinishev
// {Requestlink:623484518}
//
// Revision 1.13  2016/06/27 12:39:36  dinishev
// Боремся с падениями.
//
// Revision 1.12  2016/05/10 13:29:15  dinishev
// Bug fix: падали на закрытии тестовых приложений.
//
// Revision 1.11  2016/05/10 12:28:50  dinishev
// Reformat
//
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

uses
 Windows,
 Messages,
 Classes,
 l3ProtoObject,
 l3ClipboardSpy,
 l3InterfacePtrList,
 Controls;

type
 TClipSpyWnd = class(TWinControl)
   private
    { Private declarations }
    fWndNext  : HWnd;
    fChained  : Boolean;
    f_Listners: Tl3InterfacePtrList;
    procedure ForwardMessage(var Message: TMessage);
    procedure WMDestroyClipboard(var Message: TMessage); message WM_DESTROYCLIPBOARD;
    procedure WMChangeCBChain(var Message: TWMChangeCBChain); message WM_CHANGECBCHAIN;
    procedure WMDrawClipboard(var Message: TMessage); message WM_DRAWCLIPBOARD;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
  protected
    { Protected declarations }
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
    procedure Change; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    procedure Subscribe(const aListner: Il3ClipListner);
    procedure Unsubscribe(const aListner: Il3ClipListner);
    destructor Destroy; override;
  end;

 function ClipboardIsEmpty : Boolean;

implementation

uses
 Forms,
 SysUtils,
 ClipBrd,
 l3Base;

type
 PIl3ClipListner = ^Il3ClipListner;

procedure TClipSpyWnd.ForwardMessage(var Message: TMessage);
begin
 if fWndNext <> 0 then
  with Message do
   SendMessage(fWndNext, Msg, WParam, LParam);
end;

procedure TClipSpyWnd.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
 with Params do
  Style := Style and not WS_CHILD;
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
 end; // if Handle <> 0 then
end;

procedure TClipSpyWnd.DestroyWindowHandle;
begin
 if fWndNext = 0 then Exit;
 if fChained then
 begin
  ChangeClipboardChain(Handle, fWndNext);
  fChained := False;
 end; // if fChained then
 fWndNext := 0;
 inherited DestroyWindowHandle;
end;

procedure TClipSpyWnd.Change;

 function DoIt(aData: PIl3ClipListner; Index: Integer): Bool;
 begin
  aData^.Change;
  Result := True;
 end;

begin
 if f_Listners <> nil then
  f_Listners.IterateAllF(l3L2IA(@DoIt));
end;

procedure TClipSpyWnd.WMChangeCBChain(var Message: TWMChangeCBChain);
begin
 if Message.Remove = fWndNext then
  fWndNext := Message.Next
 else
  ForwardMessage(TMessage(Message));
 inherited;
end;

procedure TClipSpyWnd.WMNCDestroy(var Message: TWMNCDestroy);
begin
 if FChained then
 begin
  ChangeClipboardChain(Handle, fWndNext);
  fChained := False;
  fWndNext := 0;
 end; // if FChained then
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

destructor TClipSpyWnd.Destroy;
begin
 FreeAndNil(f_Listners);
 inherited;
end;

procedure TClipSpyWnd.Subscribe(const aListner: Il3ClipListner);
begin
 if f_Listners = nil then
  f_Listners := Tl3InterfacePtrList.Make;
 f_Listners.Add(aListner);
 Self.HandleNeeded;
end;

procedure TClipSpyWnd.Unsubscribe(const aListner: Il3ClipListner);
begin
 f_Listners.Remove(aListner);
end;

end.
