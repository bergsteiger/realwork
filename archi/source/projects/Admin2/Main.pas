unit Main;

{ $Id: Main.pas,v 1.15 2012/10/26 18:32:33 lulin Exp $}

// $Log: Main.pas,v $
// Revision 1.15  2012/10/26 18:32:33  lulin
// {RequestLink:406489593}
//
// Revision 1.14  2012/09/07 08:55:21  fireton
// - TnscStatusBar превратился в тыкву, пользуемся TnscOldStatusBar (K 390582424)
//
// Revision 1.13  2011/10/04 13:59:50  fireton
// - неверный typecast приводил к неверному отображению пользователей в группах
//
// Revision 1.12  2011/09/15 14:09:57  fireton
// - переделка редактора диапазонов
//
// Revision 1.11  2011/06/01 14:22:02  fireton
// - новые типы диапазонов DocID
//
// Revision 1.10  2010/11/19 12:25:40  fireton
// - редактируем диапазон ВАС
//
// Revision 1.9  2010/10/27 10:40:06  fireton
// - статистика импорта пользователей
//
// Revision 1.8  2010/10/26 08:17:38  fireton
// - переносим часть операций на главную форму
//
// Revision 1.7  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.6  2006/12/06 13:45:15  fireton
// - удаление l3Control из uses
// - поддержка "отстрела" с сервера
// - импорт и экспорт пользователей теперь совместимы
//
// Revision 1.5  2006/12/01 15:30:02  fireton
// - отображение пути к текущей базе в строке статуса
// - инструмент переключения баз задизаблен, если подключились не через серверный конфиг
//
// Revision 1.4  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.3  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.2  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,

  vcmBase,
  vcmInterfaces,
  vcmMainForm,
  vcmBaseMenuManager,
  vcmMenuManager,
  vcmComponent,
  vcmBaseEntities,
  vcmEntities,

  StdRes, ComCtrls, vtStatusBar,

  VConst,
  a2Base,
  a2bMain,
  a2Interfaces,
  a2InExUserDlg,

  l3InterfacedComponent;

type
  TMainForm = class(TvcmMainForm)
   zMain: TPanel;
   Entities: TvcmEntities;
    nscStatusBar1: TvtStatusBar;
   procedure vcmMainFormInit;
    procedure enFileopExitExecute(var aParams: IvcmExecuteParams);
    procedure enToolsopBaseSwitchExecute(var aParams: IvcmExecuteParams);
    procedure enToolsopBaseSwitchTest(const aParams: IvcmTestParams);
    procedure enToolsopSupervisorPasswordExecute(
      var aParams: IvcmExecuteParams);
    procedure enToolsopSupervisorPasswordTest(
      const aParams: IvcmTestParams);
    procedure enToolsopDocIDRangeEditExecute(
      var aParams: IvcmExecuteParams);
    procedure enExportImportopExportExecute(
      var aParams: IvcmExecuteParams);
    procedure enExportImportopImportExecute(
      var aParams: IvcmExecuteParams);
  private
    { Private declarations }
    f_BO : Ia2MainForm;
    procedure wmLogoff(var Message: TMessage); message wm_Logoff;
  public
    { Public declarations }
  protected
    // internal methods
   procedure RegisterModules;
    override;
    {* - регистрирует все модули приложения. }
   procedure RegisterFormSetFactories; override;
    {* - регистрирует все модули приложения. }
  end;

var
  MainForm: TMainForm;

implementation

uses
 modAdministration,
 fsAdministration,

 l3Base,
 l3Interfaces,
 l3String,

 vcmEntityForm,
 vcmExternalInterfaces,

 DT_CONST,

 a2BaseSwitchDialog,
 a2ChangePasswordDlg,
 a2DocIDRangeEditor, vcmContainerForm;

{$R *.dfm}

procedure TMainForm.RegisterFormSetFactories;
begin
 inherited;
 RegisterFormSetFactory(TfsAdmin);
end;

procedure TMainForm.RegisterModules;
  //override;
  {* - регистрирует все модули приложения. }
begin
 inherited;
 RegisterModule(TmoAdmin);
end;

procedure TMainForm.vcmMainFormInit;
var
 l_BO: Ta2bMain;
begin
 Dispatcher.ModuleOperation(mop_Admin_OpenUsersList, vcmParams(nil, Self as IvcmContainer));
 l_BO := Ta2bMain.Create;
 try
  f_BO := l_BO;
 finally
  FreeAndNil(l_BO);
 end;
end;

procedure TMainForm.WMLogoff(var Message: TMessage);
begin
 gSilentClose := True;
 Close;
end;

procedure TMainForm.enFileopExitExecute(var aParams: IvcmExecuteParams);
begin
  if MessageDlg(l3CStr('Вы хотите завершить работу?'), mtConfirmation, [mbYes,mbNo]) = mrYes then
   g_Dispatcher.CloseAllWindows;
end;

procedure TMainForm.enToolsopBaseSwitchExecute(var aParams: IvcmExecuteParams);
var
 l_Form: Ta2BaseSwitchForm;
begin
 Application.CreateForm(Ta2BaseSwitchForm, l_Form);
 try
  l_Form.ShowModal;
 finally
  l3Free(l_Form);
 end;
end;

procedure TMainForm.enToolsopBaseSwitchTest(const aParams: IvcmTestParams);
begin
 aParams.Op.Flag[vcm_ofEnabled] := f_BO.IsConfiguredThroughServer;
end;

procedure TMainForm.enToolsopSupervisorPasswordExecute(var aParams: IvcmExecuteParams);
var
 Dlg: TChangePasswordDlg;
begin
 Dlg := TChangePasswordDlg.Create(Self);
 try
  Dlg.Caption := 'Пароль SUPERVISOR-а';
  if Dlg.ShowModal = mrOK then
  begin
   f_BO.ChangeSupervisorPassword(Dlg.Password);
  end;
 finally
  l3Free(Dlg);
 end;
end;

procedure TMainForm.enToolsopSupervisorPasswordTest(
  const aParams: IvcmTestParams);
begin
 aParams.Op.Flag[vcm_ofEnabled] := f_BO.IsSupervisor;
end;

procedure TMainForm.enToolsopDocIDRangeEditExecute(
  var aParams: IvcmExecuteParams);
begin
 with TDocIDRangeEditor.Create(Self) do
 try
  ShowModal;
 finally
  Free;
 end;
end;

procedure TMainForm.enExportImportopExportExecute(var aParams: IvcmExecuteParams);
var
 l_Filename: string;
 l_Region: Integer;
begin
 if ChooseFileAndRegionForExport(l_Filename, l_Region) then
 begin
  Application.MainForm.Cursor := crHourGlass;
  try
   f_BO.ExportUsers(l_FileName, l_Region);
   Application.MainForm.Cursor := crDefault;
   MessageDlg(l3CStr('Экспорт завершен.'), mtInformation);
  finally
   Application.MainForm.Cursor := crDefault;
  end;
 end;
end;
procedure TMainForm.enExportImportopImportExecute(var aParams: IvcmExecuteParams);
var
 l_Filename: string;
 l_Region: Integer;
 l_Form: IvcmEntityForm;
 l_SDS: Ia2sdsAdmin;
 l_Added, l_Changed: Integer;
 l_Msg: Il3CString;
begin
 if ChooseFileAndRegionForImport(l_Filename, l_Region) then
 try
  Screen.Cursor := crHourGlass;
  try
   f_BO.ImportUsers(l_FileName, l_Region, l_Added, l_Changed);
   Screen.Cursor := crDefault;
   if HasForm(vcm_ztAny, True, @l_Form) then
    if Supports(l_Form.FormSet.DataSource, Ia2sdsAdmin, l_SDS) then
     l_SDS.RefreshTree(nil);
   l_Msg := l3CStr('Импорт завершен.');

   if (l_Added = 0) and (l_Changed = 0) then
    l_Msg := l3Cat(l_Msg, ' Изменений нет.')
   else
   begin
    if l_Added > 0 then
     l_Msg := l3Cat(l_Msg, Format(#13#10'Добавлено: %d', [l_Added]));
    if l_Changed > 0 then
     l_Msg := l3Cat(l_Msg, Format(#13#10'Изменено : %d', [l_Changed]));
   end;
   MessageDlg(l_Msg, mtInformation);
  finally
   Screen.Cursor := crDefault;
  end;
 except
  on E: EAdminError do
  begin
   l3System.Stack2Log(E.Message);
   MessageDlg(l3CStr(E.Message), mtError);
  end;
 end;
end;

end.
