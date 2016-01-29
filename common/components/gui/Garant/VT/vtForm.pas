unit vtForm;

// $Id: vtForm.pas,v 1.30 2015/04/28 14:29:25 lulin Exp $

// $Log: vtForm.pas,v $
// Revision 1.30  2015/04/28 14:29:25  lulin
// - рефакторим.
//
// Revision 1.29  2015/04/28 13:25:00  lulin
// - рефакторим.
//
// Revision 1.28  2015/04/28 10:45:18  lulin
// - рефакторим.
//
// Revision 1.27  2015/03/17 10:03:06  lulin
// - перетряхиваем зависимости.
//
// Revision 1.26  2015/03/17 09:14:02  lulin
// - перетряхиваем зависимости.
//
// Revision 1.25  2013/04/05 12:02:45  lulin
// - портируем.
//
// Revision 1.24  2012/06/04 13:17:25  dinishev
// {Requestlink:365840965}
//
// Revision 1.23  2011/04/04 16:47:32  lulin
// {RequestLink:259175088}.
//
// Revision 1.22  2010/04/12 13:10:44  voba
// - [K:200085802]
//
// Revision 1.21  2008/06/18 14:44:03  voba
// - enh. TvtForm наследуем от Tl3Form
//
// Revision 1.20  2007/03/01 14:16:22  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.19  2007/01/17 13:50:40  oman
// - new: Локализация библиотек - vt (cq24078)
//
// Revision 1.18  2005/09/12 15:02:35  voba
// no message
//
// Revision 1.17  2004/08/02 14:05:43  law
// - открутил VCM от тесной интеграции с моделью Немезиса.
//
// Revision 1.16  2004/06/04 13:07:57  voba
// - add function vtGetFocusedForm
//
// Revision 1.15  2004/06/02 13:29:24  voba
// - изменил реализацию Cut Copy Paste
//
// Revision 1.14  2004/04/12 13:32:40  voba
// - сделал caFree значением по-умолчанию
//
// Revision 1.13  2004/03/18 12:46:02  voba
// no message
//
// Revision 1.12  2004/03/18 08:53:32  voba
// - bug fix: syscommand handler
//
// Revision 1.11  2004/03/17 11:12:24  voba
// - enhancement: при закрытии окна закрываются все его дочерние
//
// Revision 1.10  2004/03/04 14:21:54  voba
// no message
//
// Revision 1.9  2003/04/19 11:24:49  law
// - new file: vtDefine.inc.
//
// Revision 1.8  2003/04/16 14:12:16  voba
// no message
//
// Revision 1.7  2002/07/11 08:44:12  voba
// -new behavior : добавил обработку Esc в модальном режиме
//
// Revision 1.6  2002/02/05 15:16:54  voba
// no message
//
// Revision 1.5  2001/09/04 14:04:30  voba
// no message
//
// Revision 1.4  2001/02/20 13:24:08  voba
// no message
//
// Revision 1.3  2000/12/19 15:12:18  voba
// no message
//
// Revision 1.2  2000/12/15 15:36:29  law
// - вставлены директивы Log.
//

{$Include vtDefine.inc }

interface

uses
  Windows,
  Messages,

  Classes,
  Controls,
  Forms,
  l3Forms,
  {$IfDef vtUseVCM}
  vcmEntityForm,
  {$EndIf vtUseVCM}

  vConst
  ;


Type
 TvtForm = class(
                 {$IfDef vtUseVCM}
                 TvcmEntityForm
                 {$Else  vtUseVCM}
                 Tl3Form
                 {$EndIf vtUseVCM}
                 )
  private
   procedure vtCut   (var Message: TMessage); message vm_Cut;
   procedure vtCopy  (var Message: TMessage); message vm_Copy;
   procedure vtPaste (var Message: TMessage); message vm_Paste;
   procedure vtSave  (var Message: TMessage); message vm_Save;
   procedure vtSaveAs(var Message: TMessage); message vm_SaveAs;
   procedure vtPrint (var Message: TMessage); message vm_Print;
   procedure vtWinSetBtn(var Message: TMessage); message vm_WinSetBtn;

   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
   procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;

   procedure evntOnReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
  protected
   procedure ReadState(Reader: TReader); override;
   procedure CreateHandle; override;

   function Cut    : Boolean; virtual;
   function Copy   : Boolean; virtual;
   function Paste  : Boolean; virtual;
   function Save   : Boolean; virtual;
   function SaveAs : Boolean; virtual;
   function Print  : Boolean; virtual;

   procedure Activate; override;
   procedure DoClose(var Action: TCloseAction); override;
   function  DefaultCloseAction : TCloseAction; virtual;

   function ValidateInputData : Boolean; virtual;
    {* - проверяет правильность введенных значений в момент попытки закрытия формы}

   {$IfNDef Nemesis}
   procedure FocusAndNote(const aControl : TWinControl; const aNote : String); virtual;
    {* - переставляет фокус на контрол и выводит окно с пояснениями}
   {$EndIf  Nemesis} 
   procedure SetSpeedButton(Enabled : Boolean); virtual;

   procedure ReadPlacement; virtual;
   procedure WritePlacement; virtual;

  protected
   procedure InitFields; override;
      {-}                         
  public
    {$IfDef InsiderTest}
      g_AllowModal : Integer;
    {$EndIf InsiderTest}
   {$IfNDef DesignTimeLibrary}
   {$IfDef l3HackedVCL}
   function NeedCancelModal: Boolean;
     override;
     {-}
   {$EndIf l3HackedVCL}
   {$EndIF DesignTimeLibrary}
   function ShowModal: integer;
     override;
     {-}
   function Execute : Boolean; virtual;
   function CloseQuery: Boolean; override;
 end;

 TvtFrame = class(TFrame)
  private
   procedure evntOnReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
  protected
   procedure ReadState(Reader: TReader); override;
   function CheckStamp(const aGUID: TGUID): Boolean;
 end;

function vtGetFocusedForm: TCustomForm;

implementation

uses
  SysUtils,
  StdCtrls,

  {$IFDEF nsTest}
  afwAnswer,
  seModalSupport,
  {$ENDIF nsTest}

  l3Base,
  l3String,
  l3BatchService
  {$IfNDef DesignTimeLibrary}
  ,
  Dialogs

  {$IfDef Nemesis}
  {$Else  Nemesis}
  ,
  vtDialogs
  {$EndIf Nemesis}
  {$EndIf}
  ;

function vtGetFocusedForm: TCustomForm;
var
 lControl : TWinControl;
 lHandle  : THandle;
begin
 Result := nil;
 lHandle := GetFocus;
 repeat
  lControl := FindControl(lHandle);
  if lControl <> nil then
   Break
  else
  begin
   lHandle := GetParent(lHandle);
   if lHandle = 0 then Exit;
  end;
 until False;

 if lControl is TCustomForm then
  Result := TCustomForm(lControl)
 else
  Result := GetParentForm(lControl);
end;

function TvtFrame.CheckStamp(const aGUID: TGUID): Boolean;
begin
 Result := False;
end;

procedure TvtFrame.evntOnReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
 Handled := True;
 l3System.Msg2Log(Message);
end;

procedure TvtFrame.ReadState(Reader: TReader);
begin
 Reader.OnError := evntOnReaderError;
 Inherited;
end;

type
THackComponent = class(TPersistent)
  private
    FOwner: TComponent;
    FName: TComponentName;
    FTag: Longint;
    FComponents: TList;
end;

procedure TvtForm.WMSysCommand(var Message: TWMSysCommand);
var
 lInstance : TComponent;
 I         : Integer;
 lNeedExit : Boolean;
begin
 lNeedExit := False;
 with Message do
  if (CmdType and $FFF0 = SC_CLOSE) then
   with THackComponent(Self) do
    if fComponents <> nil then
    begin
     for I := Pred(fComponents.Count) downto 0 do
     begin
      lInstance := TComponent(FComponents[I]);
      if (lInstance is TCustomForm) and
         (fsModal in TCustomForm(lInstance).FormState) then
       TCustomForm(lInstance).ModalResult := mrCancel;
     end;
     PostMessage(Handle, WM_CLOSE, 0, 0);
     lNeedExit := True;
    end;
 if not lNeedExit then
  inherited;
end;

procedure TvtForm.evntOnReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
 Handled := True;
 l3System.Msg2Log(Message);
end;

procedure TvtForm.ReadState(Reader: TReader);
begin
 Reader.OnError := evntOnReaderError;
 Inherited;
end;

procedure TvtForm.CreateHandle;
begin
 Inherited;
 ReadPlacement;
end;


function TvtForm.ValidateInputData : Boolean;
begin
 Result := True;
end;

{$IfNDef Nemesis}
procedure TvtForm.FocusAndNote(const aControl : TWinControl; const aNote : String);

 function FindControlUserName(const aControl : TWinControl) : string;
  var
   I : Integer;
   lCtrl : TControl;
   lParent : TWinControl;
  begin
   //Result := '';
   lParent := aControl.Parent;
   with lParent do
   begin
    for I := 0 to Pred(ControlCount) do
    begin
     lCtrl := Controls[I];
     If (lCtrl is TLabel) and
        (TLabel(lCtrl).FocusControl = aControl) then
      Result := TLabel(lCtrl).Caption;
    end;
   end;
  end;

var
 lName : string;

begin
 ActiveControl := aControl;
 lName := FindControlUserName(aControl);
 If Length(lName) > 0 then lName := ' "'+lName+'"';
{$IfNDef DesignTimeLibrary}
 vtMessageDlg(l3Fmt(aNote, [lName]), mtWarning);
{$EndIf}
end;
{$EndIf Nemesis}

function TvtForm.CloseQuery: Boolean;
 begin
  Result := (IsAbortResult(ModalResult) or ValidateInputData) and Inherited CloseQuery;
 end;

function TvtForm.Execute : Boolean;
begin
 Result := Showmodal = mrOk;
end;

procedure TvtForm.InitFields;
begin
 inherited;
 {$IfDef InsiderTest}
 g_AllowModal := 0;
 {$EndIf InsiderTest}
end;

{$IfNDef DesignTimeLibrary}
{$IfDef l3HackedVCL}
function TvtForm.NeedCancelModal: Boolean;
  {-}
begin
 Result := False;
 {$IfDef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  if Tl3BatchService.Instance.ExecuteCurrentModalWorker then
  begin
   if (ModalResult = 0) then
   begin
    Result := true;
    Exit;
   end;//ModalResult = 0
  end//seExecuteCurrentModalWorker
  else
  begin
   Result := true;
  end;//seExecuteCurrentModalWorker
 end;//g_BatchMode
 {$EndIf InsiderTest}
end;
{$EndIf l3HackedVCL}
{$EndIF DesignTimeLibrary}

function TvtForm.ShowModal: Integer;
  {-}
begin
 {$IfDef InsiderTest}
 Assert(g_AllowModal >= 0);
 if Tl3BatchService.Instance.IsBatchMode then
  if (g_AllowModal <= 0) then
   if (Application.MainForm <> nil) then
    if not Tl3BatchService.Instance.HasModalWorker then
     raise EafwTryEnterModalState.Create('Здесь надо обрабатывать модальность формы' + ClassName);
 {$EndIf InsiderTest}
 Result := inherited ShowModal;
end;

procedure TvtForm.Activate;
 var
  lMainForm : TForm;
 begin
  inherited Activate;
  if (FormStyle = fsMDIChild) then
   begin
    lMainForm := Application.MainForm;
    If (lMainForm <> nil) and (lMainForm.FormStyle = fsMDIForm) then
     l3System.Send(lMainForm, vm_MDIChildActivate, Integer(Self), 0);
   end;
 end;

procedure TvtForm.DoClose(var Action: TCloseAction);
begin
 Action := DefaultCloseAction;
 WritePlacement;
 inherited DoClose(Action);
end;

function TvtForm.DefaultCloseAction : TCloseAction;
begin
 Result := caFree;
end;

procedure TvtForm.vtCut(var Message: TMessage);
 begin
  Message.Result := Integer(Cut);
 end;

procedure TvtForm.vtCopy(var Message: TMessage);
 begin
  Message.Result := Integer(Copy);
 end;

procedure TvtForm.vtPaste(var Message: TMessage);
 begin
  Message.Result := Integer(Paste);
 end;

procedure TvtForm.vtSave(var Message: TMessage);
 begin
  Message.Result := Integer(Save);
 end;

procedure TvtForm.vtSaveAs(var Message: TMessage);
 begin
  Message.Result := Integer(SaveAs);
 end;

procedure TvtForm.vtPrint (var Message: TMessage);
 begin
  Message.Result := Integer(Print);
 end;

procedure TvtForm.vtWinSetBtn(var Message: TMessage);
 begin
  //If FShowMode <> smEdit then Exit;
  SetSpeedButton(Boolean(Message.WParam));
  Message.Result := 1;
 end;

{---------}

function  TvtForm.Cut;
begin
 Result := Boolean(l3System.Send(ActiveControl, WM_CUT, 0, 0));
end;

function  TvtForm.Copy;
begin
 Result := Boolean(l3System.Send(ActiveControl, WM_COPY, 0, 0));
end;

function  TvtForm.Paste;
begin
 Result := Boolean(l3System.Send(ActiveControl, WM_PASTE, 0, 0));
end;

function  TvtForm.Save  : boolean;
begin
 Result := False;
end;

function  TvtForm.SaveAs : boolean;
begin
 Result := False;
end;

function  TvtForm.Print : boolean;
begin
 Result := False;
end;

procedure TvtForm.SetSpeedButton(Enabled : Boolean);
begin
end;

procedure TvtForm.CMDialogKey(var Message: TCMDialogKey);
begin
 inherited;
 if (Message.CharCode = vk_Escape) and (fsModal in FormState) then
  ModalResult := mrCancel;
end;

procedure TvtForm.ReadPlacement;
begin
end;

procedure TvtForm.WritePlacement;
begin
end;

end.
