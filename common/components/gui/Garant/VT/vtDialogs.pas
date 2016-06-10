unit vtDialogs;

// $Id: vtDialogs.pas,v 1.122 2016/05/23 12:00:38 lukyanets Exp $

// $Log: vtDialogs.pas,v $
// Revision 1.122  2016/05/23 12:00:38  lukyanets
// Ловим аномалии в шедулере
//
// Revision 1.121  2016/05/16 09:48:29  dinishev
// Делаем диалог поиска более тестируемым.
//
// Revision 1.120  2016/04/27 09:33:56  lukyanets
// Запоминаем текущий каталог сбоку
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.119  2015/04/28 15:00:00  lulin
// - рефакторим.
//
// Revision 1.118  2015/04/28 10:45:18  lulin
// - рефакторим.
//
// Revision 1.117  2015/04/27 10:51:43  lulin
// - рефакторим.
//
// Revision 1.116  2014/07/21 12:18:54  dinishev
// {Requestlink:555387560}
//
// Revision 1.115  2013/04/19 13:06:19  lulin
// - портируем.
//
// Revision 1.114  2013/04/17 14:20:20  lulin
// - портируем.
//
// Revision 1.113  2012/08/10 14:25:07  lulin
// - bug fix: не собирались библиотеки.
//
// Revision 1.112  2012/08/10 14:22:11  lulin
// - bug fix: не собирались библиотеки.
//
// Revision 1.111  2012/04/02 16:55:46  lulin
// {RequestLink:237994598}
//
// Revision 1.110  2012/02/17 13:59:20  dinishev
// Подправил vtDialogs для тестов.
//
// Revision 1.109  2012/02/17 13:11:10  dinishev
// Подправил vtDialogs для тестов.
//
// Revision 1.108  2011/06/24 13:21:02  dinishev
// Проверка на _g_BatchMode
//
// Revision 1.107  2011/06/23 12:03:48  dinishev
// [$269080484]. Поддержка Wait:XXX на уровне vtDialogs
//
// Revision 1.106  2011/04/11 10:24:58  narry
// Названия для ФАС (259885290)
//
// Revision 1.105  2011/04/04 17:03:56  lulin
// {RequestLink:259175088}.
//
// Revision 1.66  2011/01/17 19:49:38  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.65  2011/01/17 19:24:27  vkuprovich
// {RequestLink:228688553}
// В диалогах заменены элементы выбора радиокнопки на TnscFocusLabel .  Сделан светлый фон, управляющие кнопки отображаются только если нет элементов выбора..
// (только для Nemesis)
//
// Revision 1.64  2010/03/11 15:13:44  lulin
// {RequestLink:196969151}.
// - избавляемся от ненужных зависимостей от VCM.
//
// Revision 1.63  2010/03/03 16:52:37  lulin
// {RequestLink:193825692}.
//
// Revision 1.62  2010/03/03 14:50:29  lulin
// {RequestLink:193825692}.
//
// Revision 1.61  2010/03/03 14:06:35  lulin
// {RequestLink:193825692}.
//
// Revision 1.60  2010/01/21 14:39:54  oman
// - new: {RequestLink:179077332}
//
// Revision 1.59  2009/08/10 09:54:23  oman
// - fix: Не лезли надписи - {RequestLink:159354768}
//
// Revision 1.58  2009/01/27 14:46:59  oman
// - fix: Меряли не по тому шрифту (К-136252192)
//
// Revision 1.57  2009/01/21 15:57:25  lulin
// - боремся со шрифтами.
//
// Revision 1.56  2008/09/01 07:54:31  oman
// - fix: Корректируем ширину кнопки (K-112721968)
//
// Revision 1.55  2008/08/04 14:31:45  lulin
// - <K>: 103942527.
//
// Revision 1.54  2008/08/04 14:08:41  lulin
// - <K>: 104432881.
//
// Revision 1.53  2008/07/16 16:12:58  narry
// - окошко ожидания
//
// Revision 1.52  2008/07/15 09:48:32  oman
// - new: Перестриваим ширину кнопок в запросах по требованию (К-96484708)
//
// Revision 1.51  2008/07/09 16:13:27  lulin
// - <K>: 100008415.
//
// Revision 1.50  2008/07/09 12:36:59  lulin
// - чистка кода.
//
// Revision 1.49  2007/08/14 19:31:40  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.48  2007/03/20 13:38:55  lulin
// - избавляемся от лишних преобразований строк.
//
// Revision 1.47  2007/03/02 12:11:43  lulin
// - теперь родные метки работают со строками с кодировками.
//
// Revision 1.46  2007/03/02 10:07:35  lulin
// - используем "родные" метки.
//
// Revision 1.45  2007/03/01 14:16:22  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.44  2007/02/12 16:40:32  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.43  2007/01/19 09:49:14  oman
// - new: Локализация библиотек - vt (cq24078)
//
// Revision 1.42  2007/01/17 13:50:40  oman
// - new: Локализация библиотек - vt (cq24078)
//
// Revision 1.41  2006/09/06 12:18:53  oman
// - new func: Новая функция - по ButtonType вернуть ModalResult.
//
// Revision 1.40  2006/04/06 14:43:58  dinishev
// Переделка диалога с дополнительной кнопкой
//
// Revision 1.39  2006/04/05 14:24:37  dinishev
// Окно с пользовательской кнопкой
//
// Revision 1.38  2005/05/26 17:44:36  lulin
// - базовая канва вывода переехала из Эвереста в L3.
//
// Revision 1.37  2005/05/05 08:09:16  mmorozov
// new: для компонентов диалога опреден используемый алфавит;
//
// Revision 1.36  2005/04/11 09:10:16  mmorozov
// bugfix: расчет размеров для checkbox-а;
//
// Revision 1.35  2005/03/29 10:54:39  mmorozov
// change: для вывода текста используем TevCanvas;
//
// Revision 1.34  2005/02/11 10:19:10  voba
// - add procedure vtMessageDlg(aExceptMsg     : Exception)
//
// Revision 1.33  2004/11/02 16:32:42  am
// change: дописал функционал, связанный с автозакрытием
//
// Revision 1.32  2004/10/21 08:51:18  voba
// - передизайнил диалог
//
// Revision 1.31  2004/10/21 08:44:44  voba
// - передизайнил диалог
//
// Revision 1.30  2004/09/14 13:47:19  lulin
// - удален модуль Str_Man.
//
// Revision 1.29  2004/08/09 15:53:42  voba
// -add aAutoCloseInterval - возможность закрытия диалога по таймеру с возвращением результата дефолтной кнопки
//
// Revision 1.28  2004/06/01 12:12:03  migel
// - fix: проблемы с фокусом в немезис при показе модальных диалогов - подтверждений.
//
// Revision 1.27  2004/05/12 13:00:47  am
// new: _vtGetDlgBtnCaption(aBtn: TMsgDlgBtn) - возвращает _Caption кнопки, используемой в vt'шном диалоге
//
// Revision 1.26  2004/04/08 07:53:47  voba
// - почистил дерьмо за предыдущим товарищем
//
// Revision 1.25  2004/04/05 11:53:54  am
// change: заворачиваем текст чекбокса в _vtCreateMessageDialog
//
// Revision 1.24  2004/04/04 17:44:36  migel
// - fix: проблемы с фокусом.
//
// Revision 1.23  2004/03/26 12:56:13  migel
// - fix: правильно выставляем `WndParent`, чтобы окна сообщений не прятались под формы.
//
// Revision 1.22  2004/03/12 12:45:35  voba
// - rervert: изменение типа Captions.
// Господа, при исправлении чужих модулей смотрите на вопросы шире.
// Если вы хотите локализовать сообщения - исправляйте их в модуле Consts.
//
// Revision 1.21  2004/03/10 14:40:13  am
// change: добавили параметр диалогам (aTextAlign)
//
// Revision 1.20  2004/03/04 14:21:54  voba
// no message
//
// Revision 1.19  2004/02/05 14:43:39  voba
// no message
//
// Revision 1.18  2004/02/03 14:42:25  voba
// no message
//
// Revision 1.17  2004/02/03 09:43:56  voba
// -add  function vtExecuteOpenDialog
//
// Revision 1.16  2004/01/30 15:29:03  law
// - new behavior: возвращаем значение Check'а.
//
// Revision 1.15  2004/01/30 15:09:27  law
// - change: в нулевом приближение сделано рисование Check'а.
//
// Revision 1.14  2004/01/30 14:02:36  law
// - change: очищаем Checked.
//
// Revision 1.13  2004/01/30 13:37:08  law
// - new proc version: vtMessageDlg.
//
// Revision 1.12  2004/01/29 16:43:12  law
// - cleanup: вытер паразитный тип TFormClass.
//
// Revision 1.11  2003/05/23 17:38:40  voba
// no message
//
// Revision 1.10  2003/04/19 11:24:49  law
// - new file: vtDefine.inc.
//
// Revision 1.9  2003/04/16 14:12:22  voba
// no message
//
// Revision 1.8  2003/02/28 14:50:30  voba
// no message
//
// Revision 1.7  2003/02/25 14:11:49  voba
// -add func: vtExecuteSaveDialog
//
// Revision 1.6  2001/07/16 12:23:04  voba
// no message
//
// Revision 1.5  2000/12/19 15:13:49  voba
// no message
//
// Revision 1.4  2000/12/15 15:36:29  law
// - вставлены директивы Log.
//

{$Include vtDefine.inc }
{$IfDef Nemesis}
 {.$If Defined(InsiderTest) OR not Defined(nsTest)}
  !!! http://mdp.garant.ru/pages/viewpage.action?pageId=259175088&focusedCommentId=259888226#comment-259888226
 {.$IfEnd}
{$EndIf Nemesis}
{ $IMPORTEDDATA ON}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Dialogs,
  Forms,
  Controls,

  l3Interfaces,
  l3VCLStrings,
  vtDialogsRes,

  l3StringIDEx

  {$IfDef Nemesis}
  ,
  nscFocusLabel
  {$EndIf Nemesis}
  ;

 const
  vtDefaultOpenDlgOptions = [ofHideReadOnly,ofPathMustExist,ofEnableSizing];
  vtDefaultSaveDlgOptions = [ofOverwritePrompt,ofHideReadOnly,ofEnableSizing];

 const
  vt_mrCustomButton = mrYesToAll + 1000; //Константа для дополнительной кнопке в диалоге


 type
  TvtCurtainMsg = TForm; //TThread;
  PInteger = ^Integer;
  TFileDlgMode = (fdmSave, fdmOpen);
  TWaitDlgCanCloseProc = procedure (var aCanClose: Boolean) of object;

  TSaveOpenDialogExecutor = function (const aDlg : TOpenDialog; aFileDlgMode : TFileDlgMode): Boolean;

 function vtInputQuery(const ACaption : AnsiString;
                       const APrompt  : AnsiString;
                       var Value      : AnsiString;
                       aMaxLength     : Integer = 255;
                       aShowCounter   : Boolean = false): Boolean;

 function vtExecuteOpenDialog(var aFileName: AnsiString; var aFilterIndex : Integer;
                       aFilter : AnsiString = '';
                       aOptions : TOpenOptions = vtDefaultOpenDlgOptions): Boolean;
   overload;

 function vtExecuteOpenDialog(var aFileName: AnsiString;
                       aFilter : AnsiString = '';
                       aOptions : TOpenOptions = vtDefaultOpenDlgOptions): Boolean;
   overload;

 function vtExecuteSaveDialog(var aFileName: AnsiString; var aFilterIndex : Integer;
                       aFilter : AnsiString = '';
                       aOptions : TOpenOptions = vtDefaultSaveDlgOptions): Boolean;
  overload;

 function vtExecuteSaveDialog(var aFileName: AnsiString;
                       aFilter : AnsiString = '';
                       aOptions : TOpenOptions = vtDefaultSaveDlgOptions): Boolean;
  overload;

 {Message}
 function vtCreateMessageDialog(const aMsg     : Il3CString;
                                aDlgType       : TMsgDlgType = mtInformation;
                                aButtons       : TMsgDlgButtons = [mbOK];
                                aDefaultButton : TMsgDlgBtn = mbOk;
                                aCancelButton  : TMsgDlgBtn = mbCancel;
                                aFormClass     : TFormClass = nil;
                                aTextAlign     : TAlignment = taCenter;
                                aWndParent     : HWnd = HWnd(0);
                                const aBtnText : AnsiString = ''): TForm;
   overload;
   {-}
 function vtCreateMessageDialog(const aMsg     : Il3CString;
                                const aCheck   : Il3CString;
                                aDlgType       : TMsgDlgType;
                                aButtons       : TMsgDlgButtons;
                                aDefaultButton : TMsgDlgBtn;
                                aCancelButton  : TMsgDlgBtn;
                                aFormClass     : TFormClass;
                                aTextAlign     : TAlignment;
                                aWndParent     : HWnd;
                                aAutoCloseInterval : Integer;  // время до автоматического закрытия формы в секундах
                                const aBtnText : AnsiString;
                                aChoices       : Tl3CustomStrings;
                                ResetButtonWidth: Boolean
                                ): TForm;
   overload;
   {-}
 function vtMessageDlg(const aMsg     : Il3CString;
                       aDlgType       : TMsgDlgType = mtCustom; //mtInformation;
                       aButtons       : TMsgDlgButtons = [mbOK];
                       aHelpCtx       : Longint = 0;
                       aDefaultButton : TMsgDlgBtn = mbOk;
                       aCancelButton  : TMsgDlgBtn = mbCancel;
                       aTextAlign     : TAlignment = taCenter;
                       aWndParent     : HWnd = HWnd(0);
                       const aBtnText : AnsiString = ''): Integer;
   overload;
   {-}
 function vtMessageDlg(const aMsg     : Il3CString;
                       const aCheck   : Il3CString;
                       out Checked    : Boolean;
                       aDlgType       : TMsgDlgType = mtCustom; //mtInformation;
                       aButtons       : TMsgDlgButtons = [mbOK];
                       aHelpCtx       : Longint = 0;
                       aDefaultButton : TMsgDlgBtn = mbOk;
                       aCancelButton  : TMsgDlgBtn = mbCancel;
                       aTextAlign     : TAlignment = taCenter;
                       aWndParent     : HWnd = HWnd(0);
                       const aBtnText : AnsiString = '';
                       aChoices       : Tl3CustomStrings = nil;
                       ResetButtonsWidth: Boolean = False): Integer;
   overload;
   {-}

 procedure vtMessageDlg(aExceptMsg     : Exception);
   overload;
   {-}

 function vtMessageDlgLock(const aMsg     : Il3CString;
                           aDlgType       : TMsgDlgType = mtCustom;
                           aButtons       : TMsgDlgButtons = [mbOK];
                           aHelpCtx       : Longint = 0;
                           aDefaultButton : TMsgDlgBtn = mbOk;
                           aCancelButton  : TMsgDlgBtn = mbCancel): Integer;

{----------}

 function vtShowCurtainMessage(const aMsg : Il3CString;
                               aDlgType   : TMsgDlgType = mtInformation;
                               aButtons   : TMsgDlgButtons = [mbOK];
                               aHelpCtx   : Longint = 0) : TvtCurtainMsg;

 function vtGetCurtainMessageModalResult(aDlg : TvtCurtainMsg) : Integer;
 procedure vtCloseCurtainMessage(var aDlg: TvtCurtainMsg);


 procedure vtShowWaitMessage(aMessage: AnsiString; WaitDlgCanClose: TWaitDlgCanCloseProc);

 procedure vtSetSaveOpenDialogExecutor(anExecutor: TSaveOpenDialogExecutor);

 procedure vtShowMemoBox(const aCaption, aMsg: AnsiString);

implementation

uses
  Graphics,
  StdCtrls,
  ExtCtrls,
  Consts,

  l3Base,
  l3MinMax,
  l3FileUtils,
  l3String,
  l3Chars,
  l3WinControlCanvas,
  l3FormCanvas,
  l3Math,
  l3BatchService,

  afwVCL,
  {$IFDEF nsTest}
  afwAnswer,
  seModalSupport,
  {$ENDIF nsTest}

  vtInterfaces,
  vtLabel,

  vtDialogsResEx
  ;

var
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  ButtonNames: array[TMsgDlgBtn] of AnsiString = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help' {$IfDef XE}, '???'{$EndIf});

const
  cCustomButtonName = 'Custom';
  cMsgDlgBtnOrder : array[TMsgDlgBtn] of TMsgDlgBtn =
   (mbYes, mbAll, mbYesToAll, mbNo, mbNoToAll, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbHelp{$IfDef XE}, mbClose{$EndIf});


var
  ButtonWidths : array[TMsgDlgBtn] of integer;  // initialized to zero

procedure vtShowMemoBox(const aCaption, aMsg: AnsiString);
var
 l_Form: TForm;
 l_Button: TButton;
 l_Memo: TMemo;
const
 cBorder = 5;
begin
 l_Form := TForm.Create(nil);
 try
  l_Form.Position := poMainFormCenter;
  l_Form.Width := 600;
  l_Form.Height := 450;
  l_Form.Caption := aCaption;
  l_Form.BorderStyle := bsDialog;
  l_Button := TButton.Create(l_Form);
  l_Button.Top := l_Form.ClientHeight - l_Button.Height - cBorder;
  l_Button.Left := (l_Form.ClientWidth - l_Button.Width) div 2;
  l_Button.ModalResult := mrCancel;
  l_Button.Caption := 'Закрыть';
  l_Button.Cancel := True;

  l_Memo := TMemo.Create(l_Form);
  l_Memo.Parent := l_Form;
  l_Memo.SetBounds(cBorder, cBorder, l_Form.ClientWidth - 2*cBorder, l_Button.Top - cBorder);
  l_Memo.ReadOnly := True;
  l_Memo.Lines.Text := aMsg;
  l_Button.Parent := l_Form;

  l_Form.ShowModal;
 finally
  FreeAndNil(l_Form);
 end;
end;

function DefaultSaveOpenDialogExecutor(const aDlg : TOpenDialog; aFileDlgMode : TFileDlgMode): Boolean;
begin
 Result := aDlg.Execute;
end;

var
 g_SaveOpenDialogExecutor: TSaveOpenDialogExecutor = DefaultSaveOpenDialogExecutor;

procedure vtSetSaveOpenDialogExecutor(anExecutor: TSaveOpenDialogExecutor);
begin
 if Assigned(anExecutor) then
  g_SaveOpenDialogExecutor := anExecutor
 else
  g_SaveOpenDialogExecutor := DefaultSaveOpenDialogExecutor;
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

type
  TMessageForm = class(TForm)
  private
    f_WndParent: HWnd;
    f_CloseTimer : TTimer;
    f_CloseInterval : Integer;
    f_DefaultButton : TMsgDlgBtn;
    f_AutoCloseButton : TButton;
    f_AutoCloseCaption : AnsiString;
    procedure HelpButtonClick(Sender: TObject);
    procedure evntOnCloseTimer(Sender: TObject);
    procedure UpdateAutoCloseButton;
    procedure evntOnClickFocusLabel(Sender: TObject);
  protected
    procedure CreateParams(var aParams: TCreateParams); override;
    procedure WndProc(var aMessage: TMessage); override;
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    constructor CreateNewEx(aWndParent: HWnd; AOwner: TComponent; Dummy: Integer = 0);

    procedure SetCloseInterval(aCloseInterval : Integer);
    procedure SetAutoCloseButton(const Value: TButton);
  end;

  TLockMessageForm = class(TMessageForm)
  private
    procedure CloseQueryEventHandler(Sender: TObject;var CanClose: Boolean);
  public
  end;

procedure TMessageForm.CreateParams(var aParams: TCreateParams);
begin
 inherited;
 if (GetWindowLong(Application.Handle, GWL_EXSTYLE) and not(WS_EX_TOOLWINDOW) <> 0) then
  aParams.WndParent := f_WndParent;
end;

procedure TMessageForm.WndProc(var aMessage: TMessage);
const
 WM_REACTIVATE_FORM = WM_USER+$0900;
 //
 function IsActivateAppMessage: Boolean;
 begin
  Result := ((aMessage.Msg = WM_ACTIVATEAPP) and TWMActivateApp(aMessage).Active);
 end;
 function IsReactivateFormMessage: Boolean;
 begin
  Result := ((aMessage.Msg = WM_REACTIVATE_FORM) and (GetActiveWindow <> Handle));
 end;
 //
 function IsSetCursorByLeftButtonMessage: Boolean;
 begin
  Result := ((aMessage.Msg = WM_SETCURSOR) and (aMessage.LParamHi = WM_LBUTTONDOWN) and not(IsWindowEnabled(Handle)));
 end;
 //
 function HasFormModalState: Boolean;
 begin
  Result := ((fsModal in FormState) and IsWindowEnabled(Handle) and IsWindowVisible(Handle));
 end;
 //
begin
 if (not(csDesigning in ComponentState) and (GetWindowLong(Application.Handle, GWL_EXSTYLE) and not(WS_EX_TOOLWINDOW) <> 0)) then
 begin
  if (IsActivateAppMessage and HasFormModalState) then
  begin
   aMessage.Result := 0;
   PostMessage(Handle, WM_REACTIVATE_FORM, 0, 0);
   Exit;
  end
  else
   if IsSetCursorByLeftButtonMessage then
   begin
    with Screen do
     if (ActiveForm <> nil) then
      with ActiveForm do
       if (Handle <> HWND(0)) then
       begin
        PostMessage(Handle, WM_REACTIVATE_FORM, 0, 0);
        aMessage.Result := 0;
        Exit;
       end;
   end
   else
    if IsReactivateFormMessage then
    begin
     aMessage.Result := 0;
     SetActiveWindow(Handle);
     Exit;
    end;
 end;
 //
 inherited;
end;

constructor TMessageForm.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
 inherited CreateNew(AOwner);
 afwHackControlFont(Self);
end;

constructor TMessageForm.CreateNewEx(aWndParent: HWnd; AOwner: TComponent; Dummy: Integer);
begin
 f_WndParent := aWndParent;
 if (f_WndParent = HWnd(0)) then
  f_WndParent := GetActiveWindow;
 //
 CreateNew(AOwner, Dummy);
end;

procedure TMessageForm.SetCloseInterval(aCloseInterval : Integer);
begin
 if Assigned(f_CloseTimer) then
  f_CloseTimer.Free;
  
 if aCloseInterval > 0 then
 begin
  f_CloseTimer := TTimer.Create(Self);
  f_CloseTimer.Interval := 1000;
  f_CloseInterval := aCloseInterval;
  f_CloseTimer.OnTimer := evntOnCloseTimer;
  UpdateAutoCloseButton;
 end;
end;

procedure TMessageForm.evntOnCloseTimer(Sender: TObject);
begin
 dec(f_CloseInterval);
 UpdateAutoCloseButton;
 if f_CloseInterval <= 0 then
  ModalResult := vtGetDlgBtnResult(f_DefaultButton);
end;

procedure TMessageForm.evntOnClickFocusLabel(Sender: TObject);
begin
  ModalResult := vtGetDlgBtnResult(f_DefaultButton);
end;

procedure TMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TLockMessageForm.CloseQueryEventHandler(Sender: TObject;var CanClose: Boolean);
 begin
  CanClose := (GetKeyState(VK_SHIFT) < 0) and (GetKeyState(VK_CONTROL) < 0);
 end;


type
 TWaitMessageForm = class(TMessageForm)
 private
  f_OnCanCloseEvent: TWaitDlgCanCloseProc;
  procedure pm_SetOnCanCloseEvent(const aValue: TWaitDlgCanCloseProc);
 protected
  procedure _OnCloseTimer(aSender: TObject);
 published
  property OnCanCloseEvent: TWaitDlgCanCloseProc read f_OnCanCloseEvent write pm_SetOnCanCloseEvent;
 end;


function vtCreateMessageDialog(const aMsg     : Il3CString;
                               aDlgType       : TMsgDlgType = mtInformation;
                               aButtons       : TMsgDlgButtons = [mbOK];
                               aDefaultButton : TMsgDlgBtn = mbOk;
                               aCancelButton  : TMsgDlgBtn = mbCancel;
                               aFormClass     : TFormClass = nil;
                               aTextAlign     : TAlignment = taCenter;
                               aWndParent     : HWnd = HWnd(0);
                               const aBtnText : AnsiString = ''): TForm;
begin
 Result := vtCreateMessageDialog(aMsg, nil, aDlgType, aButtons,
                                 aDefaultButton, aCancelButton, aFormClass,
                                 aTextAlign, aWndParent, 0, aBtnText, nil, False);
end;

const
 cCheckName = 'Check';
 cChoicesName = 'Choices';

type
  TUnframedRadioGroup = class(TRadioGroup)
  protected
    procedure Paint; override;
  end;//TUnframedRadioGroup

procedure TUnframedRadioGroup.Paint;
begin
end;

function vtCreateMessageDialog(const aMsg     : Il3CString;
                               const aCheck   : Il3CString;
                               aDlgType       : TMsgDlgType;
                               aButtons       : TMsgDlgButtons;
                               aDefaultButton : TMsgDlgBtn;
                               aCancelButton  : TMsgDlgBtn;
                               aFormClass     : TFormClass;
                               aTextAlign     : TAlignment;
                               aWndParent     : HWnd;
                               aAutoCloseInterval : Integer;
                               const aBtnText : AnsiString;
                               aChoices       : Tl3CustomStrings;
                               ResetButtonWidth: Boolean
                               ): TForm;
  //overload;
  {-}
type
 TMessageFormClass = class of TMessageForm;
const
  mcHorzMargin      = 8;
  mcVertMargin      = 8;
  mcHorzSpacing     = 10;
  mcVertSpacing     = 10;
  mcButtonWidth     = 50;
  mcButtonHeight    = 14;
  mcButtonSpacing   = 4;
  mcCheckSquareSize = 20;
  mcButtonAdditionWidth = 14;

  cGarant2011BackColor = $00F9F8FA;
  {* - светлый цвет фона
   http://mdp.garant.ru/pages/viewpage.action?pageId=228688486&focusedCommentId=228692478#comment-228692478
  }

var
  HorzMargin       : Integer;

 function lpLeftForCheck(aText : Boolean = False) : Integer;
 {* - возращает значение Left для checkbox-а. }
 begin//lpLeftForCheck
  Result := 0;
  if aText then
   Inc(Result, mcCheckSquareSize);
  Inc(Result, HorzMargin);
 end;//lpLeftForCheck

 procedure lp_CheckButtonsWidth(ResetButtonWidth: Boolean);
 var
  l_IDX: TMsgDlgBtn;
 begin
  if ResetButtonWidth then
   for l_IDX := Low(cMsgDlgBtnOrder) to High(cMsgDlgBtnOrder) do
    ButtonWidths[cMsgDlgBtnOrder[l_IDX]] := 0;
 end;

var
  l_Label : TvtLabel;
  lCanvas : Tl3WinControlCanvas;

 function ChoicesWidth: Integer;
 var
  l_Index : Integer;
  l_DX    : Integer;
 begin//ChoicesWidth
  Result := l_Label.Width;
  l_DX := lCanvas.LP2DP(lCanvas.TextExtent(l3PCharLen('W'))).X * 3;
  for l_Index := 0 to Pred(aChoices.Count) do
   Result := Max(Result, lCanvas.LP2DP(lCanvas.TextExtent(aChoices.ItemW[l_Index])).X + l_DX);
 end;//ChoicesWidth

 function ChoicesHeight: Integer;
 begin
  Result := lCanvas.Canvas.TextHeight('W') * 2;
 end;

var
  DialogUnits      : TPoint;
  VertMargin       : Integer;
  HorzSpacing      : Integer;
  VertSpacing      : Integer;
  ButtonWidth      : Integer;
  ButtonHeight     : Integer;
  ButtonSpacing    : Integer;
  ButtonCount      : Integer;
  ButtonGroupWidth : Integer;
  IconTextWidth    : Integer;
  IconTextHeight   : Integer;
  X                : Integer;
  I                : Integer;
  ALeft            : Integer;
  B                : TMsgDlgBtn;
  DefaultButton    : TMsgDlgBtn;
  CancelButton     : TMsgDlgBtn;
  IconID           : PChar;
  TextRect         : TRect;
  lCheckTextRect   : TRect;
  lBtn             : TButton;
  lCaption         : Il3CString;
  l_NewBtnWidth    : Integer;
  l_CustomBTN      : Boolean;
  l_PrevIconTextHeight : Integer;
  l_FS                 : TFontStyles;
  {$IfDef Nemesis}
  l_FocusLabel     : TnscFocusLabel;
  {$EndIf Nemesis}
  l_NeedButtons    : Boolean;
  l_HasChoices     : Boolean;
begin
 lp_CheckButtonsWidth(ResetButtonWidth);
 try
  if (aFormClass = nil) then
   aFormClass := TMessageForm;

  if aFormClass.InheritsFrom(TMessageForm) then
   Result := TMessageFormClass(aFormClass).CreateNewEx(aWndParent, Application)
  else
   Result := aFormClass.CreateNew(Application);

  l_NewBtnWidth := 0;
  l_CustomBTN := aBtnText <> '';
  l_HasChoices := (aChoices <> nil) AND (aChoices.Count > 1); // VK. условие часто используется в коде

  with Result do
  begin
   lCanvas := Tl3FormCanvas.Create(Result);
   try
    lCanvas.Font.AssignFont(Font);
    BiDiMode := Application.BiDiMode;
    BorderStyle := bsDialog;
    lCanvas.BeginPaint;
    try
     DialogUnits := GetAveCharSize(Canvas);
     HorzMargin := l3MulDiv(mcHorzMargin, DialogUnits.X, 4);
     VertMargin := l3MulDiv(mcVertMargin, DialogUnits.Y, 8);
     HorzSpacing := l3MulDiv(mcHorzSpacing, DialogUnits.X, 4);
     VertSpacing := l3MulDiv(mcVertSpacing, DialogUnits.Y, 8);
     ButtonWidth := l3MulDiv(mcButtonWidth, DialogUnits.X, 4);
     for B := Low(cMsgDlgBtnOrder) to High(cMsgDlgBtnOrder) do
     begin
      if (cMsgDlgBtnOrder[B] in aButtons) then
      begin
       if (ButtonWidths[cMsgDlgBtnOrder[B]] = 0) then
       begin
        SetRectEmpty(TextRect);
        lCaption := vtGetDlgBtnCaption(cMsgDlgBtnOrder[B]);
        lCanvas.DrawText(lCaption.AsWStr,
                         TextRect,
                         DT_CALCRECT   or
                         DT_LEFT       or
                         DT_SINGLELINE or
                         DrawTextBiDiModeFlagsReadingOnly);
        with TextRect do
         ButtonWidths[cMsgDlgBtnOrder[B]] := Right - Left + mcButtonAdditionWidth;
       end;//ButtonWidths[cMsgDlgBtnOrder[B]] = 0
       if (ButtonWidths[cMsgDlgBtnOrder[B]]) > ButtonWidth then
        ButtonWidth := ButtonWidths[cMsgDlgBtnOrder[B]];
      end;//cMsgDlgBtnOrder[B] in aButtons
     end;//for b..

     if l_CustomBTN then //Если нужна пользовательская кнопка, то высчитываем её ширину.
     begin
      SetRectEmpty(TextRect);
      lCanvas.DrawText(l3PCharLen(aBtnText),
                       TextRect,
                       DT_CALCRECT   or
                       DT_LEFT       or
                       DT_SINGLELINE or
                       DrawTextBiDiModeFlagsReadingOnly);
      with TextRect do
       l_NewBtnWidth := Right - Left + mcButtonAdditionWidth;
     end;//l_CustomBTN

     if (aAutoCloseInterval > 0) then
     begin
      SetRectEmpty(TextRect);
      lCaption := l3Fmt(' ()%d', [aAutoCloseInterval]);
      lCanvas.DrawText(lCaption.AsWStr,
                       TextRect,
                       DT_CALCRECT   or
                       DT_LEFT       or
                       DT_SINGLELINE or
                       DrawTextBiDiModeFlagsReadingOnly);
      ButtonWidth := ButtonWidth + TextRect.Right - TextRect.Left;
     end;//aAutoCloseInterval > 0

     ButtonHeight := l3MulDiv(mcButtonHeight, DialogUnits.Y, 8);
     ButtonSpacing := l3MulDiv(mcButtonSpacing, DialogUnits.X, 4);
     SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
     l_FS := lCanvas.Font.Style;
     try
      if l_HasChoices then
       lCanvas.Font.Style := lCanvas.Font.Style + [fsBold];
      lCanvas.DrawText(l3PCharLen(aMsg),
                       TextRect,
                       DT_EXPANDTABS or
                       DT_CALCRECT   or
                       DT_WORDBREAK  or
                       DrawTextBiDiModeFlagsReadingOnly);
     finally
      lCanvas.Font.Style := l_FS;
     end;//try..finally
     IconID := IconIDs[aDlgType];
     IconTextWidth := TextRect.Right;
     IconTextHeight := TextRect.Bottom;
     if (IconID <> nil) then
     begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
     end;//IconID <> nil
     ButtonCount := 0;
     for B := Low(cMsgDlgBtnOrder) to High(cMsgDlgBtnOrder) do
       if cMsgDlgBtnOrder[B] in aButtons then Inc(ButtonCount);
     ButtonGroupWidth := 0;
     if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1) + l_NewBtnWidth;

     SetRect(lCheckTextRect,
             lpLeftForCheck(True),
             0,
             Screen.Width div 2,
             0);
     if (aCheck = nil) then
      l3FillChar(lCheckTextRect, SizeOf(lCheckTextRect), 0)
     else
      lCanvas.DrawText(aCheck.AsWStr,
                       lCheckTextRect,
                       DT_EXPANDTABS or
                       DT_CALCRECT   or
                       DT_WORDBREAK  or
                       DrawTextBiDiModeFlagsReadingOnly);
     lCheckTextRect.Left := lpLeftForCheck;
     ClientWidth := Max(Max(IconTextWidth, ButtonGroupWidth),
      lCheckTextRect.Right)+ HorzMargin * 2;
     ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
       VertMargin * 2;
     Left := (Screen.Width div 2) - (Width div 2);
     Top := (Screen.Height div 2) - (Height div 2);
     if (aDlgType <> mtCustom) then
      Caption := vtGetDlgCaption(aDlgType)
     else
      Caption := Application.Title;
     if (IconID <> nil) then
      with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;//with TImage.Create(Result)
     l_Label := TvtLabel.Create(Result);
     with l_Label do
     begin
       Alignment := aTextAlign;
       Name := 'Message';
       Parent := Result;
       WordWrap := True;
       CCaption := aMsg;
       BoundsRect := TextRect;
       BiDiMode := Result.BiDiMode;
       Font.Charset := RUSSIAN_CHARSET;
       if l_HasChoices then
        Font.Style := Font.Style + [fsBold];
       ALeft := IconTextWidth - TextRect.Right + HorzMargin;
       if UseRightToLeftAlignment then
         ALeft := Result.ClientWidth - ALeft - Width;
       SetBounds(ALeft, VertMargin,
         TextRect.Right, TextRect.Bottom);
     end;//with l_Label
    {$IfDef Nemesis}
     // VK в диалогах нового стиля если имеются aChoices, то кнопки aButtons не отображаются
     l_NeedButtons := NOT l_HasChoices;
     Result.Color := cGarant2011BackColor;
     if l_HasChoices then
     begin
      for I := 0 to aChoices.Count-1 do
      begin
        l_FocusLabel := TnscFocusLabel.Create(Result);
        with l_FocusLabel do
        begin
         Parent := Result;
         Name := cChoicesName + IntToStr(I);
         Font.Charset := RUSSIAN_CHARSET;
         CCaption := l3CStr(aChoices[I] As Tl3CustomString);
         Left := l_Label.Left + HorzMargin;
         Top := l_Label.Top  + l_Label.Height + (I + 1) * ChoicesHeight;
         ShowHint := true;
         with Font do
         begin
          Size := 12;
          Style := [fsUnderline];
          Color := clBlue;
         end;//with Font
         HighlightColor := clBlue;
         Hyperlink := true;
         Cursor := crHandPoint;
         AutoWidth := true;
         TabStop := true;
         if aFormClass.InheritsFrom(TMessageForm) then
           OnClick := TMessageForm(Result).evntOnClickFocusLabel;
         if Result.Width < Left + Width then
          Result.Width := Left + Width;
        end;//with TnscFocusLabel.Create(Result)
      end;//for I..
      IconTextHeight := Max(IconTextHeight, l_Label.Top + (aChoices.Count+1)*ChoicesHeight);
      Result.Height  := Result.Height + (aChoices.Count+1)*ChoicesHeight;
     end;
    {$Else}
     l_NeedButtons := true;
     if l_HasChoices then
     begin
      with TUnframedRadioGroup.Create(Result) do
      begin
       Name := cChoicesName;
       Caption := '';
       Parent := Result;
       Font.Charset := RUSSIAN_CHARSET;
       Items.Assign(aChoices);
       ItemIndex := 0;
       Ctl3D := false;
       SetBounds(l_Label.Left, l_Label.Top + l_Label.Height, ChoicesWidth, 12 + (aChoices.Count * (lCanvas.LP2DP(lCanvas.TextExtent(l3PCharLen('W'))).Y * 3 div 2)));
       l_PrevIconTextHeight := IconTextHeight;
       IconTextHeight := Max(IconTextHeight, Top + Height - VertSpacing - VertMargin);
       Result.Height := Result.Height + (IconTextHeight - l_PrevIconTextHeight);
       if Result.Width < Left + Width + VertMargin then
        Result.Width := Left + Width + VertMargin;
      end;//with TUnframedRadioGroup.Create(Result)
     end;//aChoices <> nil..
    {$EndIf}

     if (aDefaultButton <> mbOk) and (aDefaultButton in aButtons) then
      DefaultButton := aDefaultButton
     else
     if mbOk in aButtons then
      DefaultButton := mbOk
     else
     if mbYes in aButtons then
      DefaultButton := mbYes
     else
      DefaultButton := mbRetry;

     if (Result is TMessageForm) then
     begin
      TMessageForm(Result).f_DefaultButton := DefaultButton;
      if (aAutoCloseInterval > 0) then
        TMessageForm(Result).SetCloseInterval(aAutoCloseInterval);
     end;//Result is TMessageForm..

     if (aCancelButton <> mbCancel) and (aCancelButton in aButtons) then
      CancelButton := aCancelButton
     else
     if mbCancel in aButtons then
      CancelButton := mbCancel
     else
     if mbNo in aButtons then
      CancelButton := mbNo
     else
      CancelButton := mbOk;

     //X := (ClientWidth - ButtonGroupWidth) div 2;
     X := (ClientWidth - ButtonGroupWidth) - HorzMargin;

     if l_NeedButtons then
     begin
      for B := Low(cMsgDlgBtnOrder) to High(cMsgDlgBtnOrder) do
       if cMsgDlgBtnOrder[B] in aButtons then
       begin
        lBtn := TButton.Create(Result);
        with lBtn do
        begin
         Name := ButtonNames[cMsgDlgBtnOrder[B]];
         Parent := Result;
         Caption := l3Str(vtGetDlgBtnCaption(cMsgDlgBtnOrder[B]));
         ModalResult := vtGetDlgBtnResult(cMsgDlgBtnOrder[B]);
         Font.Charset := RUSSIAN_CHARSET;
         if (cMsgDlgBtnOrder[B] = DefaultButton) then
         begin
          Default := True;
          ActiveControl := lBtn;
          TMessageForm(Result).SetAutoCloseButton(lBtn);
         end;//cMsgDlgBtnOrder[B] = DefaultButton
         if (cMsgDlgBtnOrder[B] = CancelButton) then
          Cancel := True;
         SetBounds(X, IconTextHeight + VertMargin + VertSpacing, ButtonWidth, ButtonHeight);
         Inc(X, ButtonWidth + ButtonSpacing);
         if (cMsgDlgBtnOrder[B] = mbHelp) then
          OnClick := TMessageForm(Result).HelpButtonClick;
        end;//with lBtn
       end;//cMsgDlgBtnOrder[B] in aButtons

      if l_CustomBTN then //Пользовательская кнопка
      begin
       lBtn := TButton.Create(Result);
       with lBtn do
       begin
        Name := cCustomButtonName;
        Parent := Result;
        Caption := aBtnText;
        ModalResult := vt_mrCustomButton;
        Font.Charset := RUSSIAN_CHARSET;
        SetBounds(X, IconTextHeight + VertMargin + VertSpacing, l_NewBtnWidth, ButtonHeight);
       end;//with lBtn
      end;//l_CustomBTN
     end
     else
     begin
      Result.Height  := Result.Height - VertSpacing - ButtonHeight;
     end;

     if not l3IsNil(aCheck) then
     begin
      with TCheckBox.Create(Result) do
      begin
       {$IfDef Delphi7}
        WordWrap := true;
       {$EndIf}
        Name := cCheckName;
        Parent := Result;
        Caption := l3Str(aCheck);
        Checked := false;
        Font.Charset := RUSSIAN_CHARSET;
        if l_NeedButtons then
          Top := IconTextHeight + VertMargin + 2 * VertSpacing + ButtonHeight
        else
          Top := IconTextHeight + VertMargin + VertSpacing;

        SetBounds(lpLeftForCheck,
                  Top,
                  Result.ClientWidth - 2 * HorzMargin,
                  lCheckTextRect.Bottom);
        BiDiMode := Result.BiDiMode;
        Result.Height := Result.Height + Height + VertSpacing;
      end;//with TCheckBox.Create(Result)
     end;//not l3IsNil(aCheck)
    finally
     lCanvas.EndPaint;
    end;//try..finally
   finally
    l3Free(lCanvas);
   end;//try..finally
  end;//with Result
 finally
  lp_CheckButtonsWidth(ResetButtonWidth);
 end;
end;

function vtMessageDlg(const aMsg     : Il3CString;
                      const aCheck   : Il3CString;
                      out Checked    : Boolean;
                      aDlgType       : TMsgDlgType = mtCustom; //mtInformation;
                      aButtons       : TMsgDlgButtons = [mbOK];
                      aHelpCtx       : Longint = 0;
                      aDefaultButton : TMsgDlgBtn = mbOk;
                      aCancelButton  : TMsgDlgBtn = mbCancel;
                      aTextAlign     : TAlignment = taCenter;
                      aWndParent     : HWnd = HWnd(0);
                      const aBtnText : AnsiString = '';
                      aChoices       : Tl3CustomStrings = nil;
                      ResetButtonsWidth: Boolean = False): Integer;
  //overload;
  {-}

var
 I            : Integer;
 {$IfDef Nemesis}
 l_FocusLabel : TnscFocusLabel;
 {$EndIf Nemesis}
 l_Check      : TComponent;
 {$IfDef InsiderTest}
 l_Answer : Integer;
 {$EndIf InsiderTest}
begin
 {$IFDEF InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  l_Answer := Tl3BatchService.Instance.PopAnswer;
  if l_Answer <> mrNone then
  begin
   TafwBatchService.Instance.SignalWasDialog;
   Result := l_Answer;
   Exit;
  end; // if l_Answer <> mrNone then
  if ((aButtons = [mbOK]) OR (aButtons = [mbYes])) AND
     ((aChoices = nil) OR (aChoices.Count <= 0)) then
  begin
   if (aButtons = [mbYes]) then
    Result := mrYes
   else
    Result := mrOk;
   Exit;
  end;//aButtons = [mbOK]
 end; // if g_BatchMode then
 {$ENDIF InsiderTest}
 with vtCreateMessageDialog(aMsg, aCheck, aDlgType, aButtons, aDefaultButton,
                            aCancelButton, TFormClass(nil), aTextAlign,
                            aWndParent, 0, aBtnText, aChoices, ResetButtonsWidth) do
  try
   Checked := false;
   HelpContext := aHelpCtx;
   Position := poScreenCenter;
   Result := ShowModal;
   if (Result in [mrOk, mrYes]) AND (aChoices <> nil) AND (aChoices.Count > 1) then
    {$IfDef Nemesis}
     for I := 0 to aChoices.Count-1 do
     begin
      l_FocusLabel := TnscFocusLabel(FindComponent(cChoicesName + IntToStr(I)));
      if (l_FocusLabel <> nil) and (ActiveControl = l_FocusLabel) then begin
       Result := - (I+1);
       Break;
      end;
     end;
    {$Else}
     Result := -((FindComponent(cChoicesName) As TUnframedRadioGroup).ItemIndex + 1);
    {$EndIf}

   if not l3IsNil(aCheck) then
   begin
    // - здесь надо вытащить значение CheckBox'а
    l_Check := FindComponent(cCheckName);
    if (l_Check <> nil) then
     Checked := (l_Check As TCheckBox).Checked;
   end;//not l3IsNil(aCheck)
  finally
   Free;
  end;//try..finally
end;

function vtMessageDlg(const aMsg     : Il3CString;
                      aDlgType       : TMsgDlgType = mtCustom;
                      aButtons       : TMsgDlgButtons = [mbOK];
                      aHelpCtx       : Longint = 0;
                      aDefaultButton : TMsgDlgBtn = mbOk;
                      aCancelButton  : TMsgDlgBtn = mbCancel;
                      aTextAlign     : TAlignment = taCenter;
                      aWndParent     : HWnd = HWnd(0);
                      const aBtnText : AnsiString = ''): Integer;
  //overload;
  {-}
var
 l_Checked : Boolean;
begin
 Result := vtMessageDlg(aMsg, nil, l_Checked, aDlgType, aButtons, aHelpCtx,
                        aDefaultButton, aCancelButton, aTextAlign, aWndParent,
                        aBtnText);
end;

procedure vtMessageDlg(aExceptMsg : Exception);
begin
 vtMessageDlg(l3CStr(aExceptMsg.Message), mtError);
end;

function vtMessageDlgLock(const aMsg    : Il3CString;
                          aDlgType      : TMsgDlgType = mtCustom;
                          aButtons      : TMsgDlgButtons = [mbOK];
                          aHelpCtx      : Longint = 0;
                         aDefaultButton : TMsgDlgBtn = mbOk;
                         aCancelButton  : TMsgDlgBtn = mbCancel): Integer;
 begin
   With vtCreateMessageDialog(aMsg, aDlgType, aButtons, aDefaultButton, aCancelButton, TLockMessageForm) as TLockMessageForm do
    try
      HelpContext := aHelpCtx;
      OnCloseQuery := CloseQueryEventHandler;
      Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
 end;

type
 TInputQueryForm = class(TForm)
 private
  fEdit          : TEdit;
  fCounter       : TvtLabel;
  fShowCounter   : Boolean;
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
  procedure InitForm(const ACaption, APrompt: AnsiString; var Value: AnsiString;
                     aMaxLength : Integer; aShowCounter : Boolean);
  procedure TextEditChange(Sender: TObject);

 end;//TInputQueryForm

procedure TInputQueryForm.TextEditChange(Sender: TObject);
var
 l : Integer;
begin
 if fShowCounter then
 begin
  l := Length(FEdit.Text);
  if (l = 0) then
   fCounter.Caption := ''
  else
   fCounter.Caption := Format('%d/%d',[l, FEdit.MaxLength]);
 end;//fShowCounter
end;

procedure TInputQueryForm.InitForm(const ACaption, APrompt: AnsiString; var Value: AnsiString;
                                   aMaxLength : Integer; aShowCounter : Boolean);
 var
  Prompt: TvtLabel;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;

 begin
  {$IfDef InsiderTest}
  g_AllowModal := 0;
  {$EndIf InsiderTest}
  fShowCounter   := aShowCounter;
  Canvas.Font := Font;
  DialogUnits := GetAveCharSize(Canvas);
  BorderStyle := bsSizeable;
  Caption := ACaption;
  ClientWidth := l3MulDiv(180, DialogUnits.X, 4);
  ClientHeight := l3MulDiv(63, DialogUnits.Y, 8);
  With Constraints do
   begin
    MinWidth  := Width;
    MinHeight := Height;
    MaxHeight := Height;
   end;
  AutoSize := False;
  Position := poScreenCenter;
  Prompt := TvtLabel.Create(Self);
  with Prompt do
  begin
    Parent := Self;
    AutoSize := True;
    Left := l3MulDiv(8, DialogUnits.X, 4);
    Top := l3MulDiv(8, DialogUnits.Y, 8);
    Caption := APrompt;
  end;//with Prompt

  fCounter := TvtLabel.Create(Self);
  with fCounter do
  begin
    Parent := Self;
    AutoSize := True;
    Left := l3MulDiv(8, DialogUnits.X, 4);
    Top := l3MulDiv(55, DialogUnits.Y, 8) - Height;
    //Caption := '';
  end;//with fCounter

  fEdit := TEdit.Create(Self);
  with fEdit do
  begin
    Parent := Self;
    Left := Prompt.Left;
    Top := l3MulDiv(19, DialogUnits.Y, 8);
    Width := l3MulDiv(164, DialogUnits.X, 4);
    MaxLength := aMaxLength;
    Text := Value;
    SelectAll;
    Anchors := [akLeft, akTop, akRight];
    OnChange := TextEditChange;
    TextEditChange(Self);
  end;//with fEdit
  ButtonTop := l3MulDiv(41, DialogUnits.Y, 8);
  ButtonWidth := l3MulDiv(50, DialogUnits.X, 4);
  ButtonHeight := l3MulDiv(14, DialogUnits.Y, 8);
  with TButton.Create(Self) do
  begin
    Parent := Self;
    Caption := SMsgDlgOK;
    ModalResult := mrOk;
    Default := True;
    SetBounds(l3MulDiv(38+30, DialogUnits.X, 4), ButtonTop, ButtonWidth, ButtonHeight);
    Anchors := [akBottom, akRight];
  end;
  with TButton.Create(Self) do
  begin
    Parent := Self;
    Caption := SMsgDlgCancel;
    ModalResult := mrCancel;
    Cancel := True;
    SetBounds(l3MulDiv(122{92}, DialogUnits.X, 4), ButtonTop, ButtonWidth, ButtonHeight);
    Anchors := [akBottom, akRight];
  end;
 end;

function vtInputQuery(const ACaption : AnsiString;
                      const APrompt  : AnsiString;
                      var Value      : AnsiString;
                      aMaxLength     : Integer = 255;
                      aShowCounter   : Boolean = false): Boolean;
 var
  Form: TInputQueryForm;

 begin
  Result := False;
  Form := TInputQueryForm.CreateNew(Application);
  try
   With Form do
    begin
     InitForm(ACaption, APrompt, Value, aMaxLength, aShowCounter);
     if ShowModal = mrOk then
     begin
      Value := fEdit.Text;
      Result := True;
     end;
    end;
  finally
   Form.Free;
  end;
end;

function vtExecuteSaveDialogPrim(
             var aFileName: AnsiString;
             var aFilterIndex : Integer;
                 aFilter : AnsiString;
                 aOptions : TOpenOptions; aFileDlgMode : TFileDlgMode): Boolean;
var
 aDlg : TOpenDialog;
begin
 if aFilter = '' then
  aFilter := str_vtDefaultOpenDlgFilter.AsStr;
 Result := False;
 case aFileDlgMode of
  fdmSave : aDlg := TSaveDialog.Create(Application.MainForm);
  fdmOpen : aDlg := TOpenDialog.Create(Application.MainForm);
 else
  exit;
 end;
 with aDlg do
  try
   InitialDir := ExtractDirName(aFileName);
   FileName := ExtractFileName(aFileName);
   FilterIndex := aFilterIndex;
   Filter := aFilter;
   Options := aOptions;
   Result := g_SaveOpenDialogExecutor(aDlg, aFileDlgMode);
   If not Result then Exit;

   aFilterIndex := FilterIndex;
   If aFilterIndex < 1 then aFilterIndex := 1;
   aFileName := FileName;
   aFileName := l3AddExtByFilterIndex(aFileName, Filter, aFilterIndex);
  finally
   Free;
  end;

end;

function vtExecuteSaveDialog(var aFileName: AnsiString; var aFilterIndex : Integer;
                             aFilter : AnsiString = '';
                             aOptions : TOpenOptions = vtDefaultSaveDlgOptions): Boolean;
begin
 Result := vtExecuteSaveDialogPrim(aFileName, aFilterIndex, aFilter, aOptions, fdmSave);
end;

function vtExecuteSaveDialog(var aFileName: AnsiString;
                             aFilter : AnsiString = '';
                             aOptions : TOpenOptions = vtDefaultSaveDlgOptions): Boolean;
var
 lFilterIndex : Integer;
begin
 lFilterIndex := 0;
 Result := vtExecuteSaveDialog(aFileName, lFilterIndex, aFilter, aOptions);
end;

function vtExecuteOpenDialog(var aFileName: AnsiString; var aFilterIndex : Integer;
                       aFilter : AnsiString = '';
                       aOptions : TOpenOptions = vtDefaultOpenDlgOptions): Boolean; overload;
begin
 Result := vtExecuteSaveDialogPrim(aFileName, aFilterIndex, aFilter, aOptions, fdmOpen);
end;

function vtExecuteOpenDialog(var aFileName: AnsiString;
                       aFilter : AnsiString = '';
                       aOptions : TOpenOptions = vtDefaultOpenDlgOptions): Boolean; overload;
var
 lFilterIndex : Integer;
begin
 lFilterIndex := 0;
 Result := vtExecuteOpenDialog(aFileName, lFilterIndex, aFilter, aOptions);
end;

procedure vtShowWaitMessage(aMessage: AnsiString; WaitDlgCanClose: TWaitDlgCanCloseProc);
begin
 with TWaitMessageForm(vtCreateMessageDialog(l3CStr(aMessage), nil,
                              mtInformation,
                              [],
                              mbOk,
                              mbCancel,
                              TWaitMessageForm,
                              taCenter,
                              HWnd(0),
                              5, '', nil, False)) do
 begin
  OnCanCloseEvent:= WaitDlgCanClose;
  ShowModal;
  Free;
 end;
end;

function vtShowCurtainMessage(const aMsg: Il3CString; aDlgType: TMsgDlgType = mtInformation;
         aButtons: TMsgDlgButtons = [mbOK]; aHelpCtx: Longint = 0) : TvtCurtainMsg;
 begin
  Result := vtCreateMessageDialog(aMsg, aDlgType, aButtons{, TvtMessageForm});
  With Result do
   begin
    FormStyle := fsStayOnTop;
    Show;
   end;
 end;

function vtGetCurtainMessageModalResult(aDlg : TvtCurtainMsg) : Integer;
 begin
  try
   Result := aDlg.ModalResult;
  except
   Result := 0;
  end;
 end;

procedure vtCloseCurtainMessage(var aDlg: TvtCurtainMsg);
 begin
  l3Free(aDlg);
 end;

procedure TMessageForm.SetAutoCloseButton(const Value: TButton);
begin
 f_AutoCloseButton := Value;
 f_AutoCloseCaption := Value.Caption;
 if f_CloseInterval > 0 then
  UpdateAutoCloseButton; 
end;

procedure TMessageForm.UpdateAutoCloseButton;
begin
 if (f_AutoCloseButton <> nil) then
 begin
  f_AutoCloseButton.Caption := f_AutoCloseCaption;
  if f_CloseInterval > 0 then
   f_AutoCloseButton.Caption := f_AutoCloseButton.Caption + ' (' + IntToStr(f_CloseInterval) + ')';
 end;
end;

procedure TWaitMessageForm.pm_SetOnCanCloseEvent(const aValue: TWaitDlgCanCloseProc);
begin
 f_OnCanCloseEvent := aValue;
 f_CloseTimer.OnTimer:= _OnCloseTimer;
end;

procedure TWaitMessageForm._OnCloseTimer(aSender: TObject);
var
 l_CanClose: Boolean;
begin
 l_CanClose:= False;
 if Assigned(f_OnCanCloseEvent) then
  f_OnCanCloseEvent(l_CanCLose);
 if l_CanClose then
  Close;
end;
 
{$IfNDef DesignTimeLibrary}
{$IfDef l3HackedVCL}
function TInputQueryForm.NeedCancelModal: Boolean;
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

end.
