unit a2BaseSwitchDialog;

{ $Id: a2BaseSwitchDialog.pas,v 1.4 2015/04/08 13:56:29 lukyanets Exp $}

// $Log: a2BaseSwitchDialog.pas,v $
// Revision 1.4  2015/04/08 13:56:29  lukyanets
// Изолируем события
//
// Revision 1.3  2010/10/19 08:52:59  fireton
// - не теряем стек ошибки
//
// Revision 1.2  2008/04/07 10:31:07  fireton
// - внешние номера документов из диапазона
//
// Revision 1.1  2006/02/15 14:15:37  fireton
// - переключение баз и импорт/экспорт пользователей
//
// Revision 1.3  2005/03/03 12:19:47  voba
// no message
//
// Revision 1.2  2004/12/23 11:47:00  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.1  2004/03/31 12:14:01  fireton
// - initial release
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Dt_Types, l3Types, Contnrs, ExtCtrls, ComCtrls, Mask,
  ToolEdit, daInterfaces;

type
 TYesterdayBase = record
  Path: string;
  Date: string;
  DispDate: string;
 end;

 Ta2BaseSwitchForm = class(TForm, IdaProgressSubscriber)
    btnSwitch: TButton;
    btnCancel: TButton;
    rgBases: TRadioGroup;
    ProgressBar: TProgressBar;
    lblDisp: TLabel;
    edFamPath: TDirectoryEdit;
    edTablePath: TDirectoryEdit;
    Label1: TLabel;
    Label2: TLabel;
    edHomePath: TDirectoryEdit;
    Label3: TLabel;
    edLockPath: TDirectoryEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgBasesClick(Sender: TObject);
    procedure btnSwitchClick(Sender: TObject);
    procedure edHomePathChange(Sender: TObject);
 private
    FBaseWorkingDir: string;
    FFullBackupPath: string;
    FServerConfigDir: string;
    FCurBase: Integer;
    FYesterdayPath: string;
    FYesterdays: array of TYesterdayBase;
    FDefTableDir: string;
    FDefHomeDir: string;
    FDefLockDir: string;
    FSettingPaths: Boolean;
    procedure FillBasesList;
    procedure ReadBaseType;
    procedure MemorizeBaseType;
    procedure SetPaths(Index: Integer);
    procedure RestoreDefaultPaths;
 protected
  // IdaProgressSubscriber
   procedure DoProgressNotify(aState: Byte;
     aValue: Integer;
     const aMsg: AnsiString = '');
 public
    procedure DoSwitchBase;
 end;

var
  frmBaseSwitch: Ta2BaseSwitchForm;

implementation
uses
 l3Interfaces,
 l3IniFile,
 IniFiles,
 l3FileUtils,
 ddUNC2Local,
 l3Base,
 //Main,
 daDataProvider,
 Dt_Serv,

 a2Security;

const
 biCustom   = -1;
 biWork     =  0;
 biFullCopy =  1;

{$R *.dfm}

procedure CheckDatabase(const ProgressProc: IdaProgressSubscriber);
var
 lErrorFound: Boolean;
 lMess: string;
begin
 try
  GlobalDataProvider.SubscribeProgress(ProgressProc);
  with GlobalHTServer do
  begin
   CloseAllTbls(0);
   CloseAllTbls(1);
   try
    PhisicalVerifyAllTbl(0, lErrorFound, lMess);
    PhisicalVerifyAllTbl(1, lErrorFound, lMess);
   finally
    OpenClosedTbls;
    GlobalDataProvider.UnSubscribeProgress(ProgressProc);
   end;
  end;
 except
  l3System.Stack2Log('База невалидна!');
  raise;
 end;
end;

procedure Ta2BaseSwitchForm.DoSwitchBase;
var
 NewFamilyPath: string;
 Success: Boolean;
 IniFN, TmpIniFN: string;
 Cfg: TCfgList;

 procedure RollBack;
 begin
  GlobalDone;
  CopyFile(TmpIniFN, IniFN, cmDeleteSource);
  GlobalInit;
  MessageDlg('Не удалось переключить базу. Произведен возврат на '+#13+#10+'текущую.', mtWarning, [mbOK], 0);
 end;

 procedure WritePathToCfg(ID, aPath: string);
 var
  sTmp: string;
 begin
  sTmp := aPath;
  if Pos('%', sTmp) = 0 then
   sTmp := UNCName2IP(sTmp);
  if sTmp = '' then
   raise Exception.Create('Неправильный путь.');
  Cfg.WriteParamStr(ID, sTmp);  
 end;
 
begin
 IniFN := FServerConfigDir+'ServerConfig.ini';
 TmpIniFN := FServerConfigDir+'ServerConfig.ini.tmp';
 CopyFile(IniFN, TmpIniFN);
 {
 if MainForm.FExplorerWin <> nil then
  FreeAndNil(MainForm.FExplorerWin);
 } 
 GlobalDone;
 try
  Cfg := TCfgList.Create(FServerConfigDir+'ServerConfig.ini');
  try
   Cfg.Section := 'FamilyConst';
   NewFamilyPath := UNCName2IP(edFamPath.Text);
   if NewFamilyPath = '' then
    raise Exception.Create('Сервер, недоступен (FamilyPath).');
   Cfg.WriteParamStr('FamilyPath', NewFamilyPath);
   Cfg.Section := 'BaseDocPath';
   WritePathToCfg('TablePath', edTablePath.Text);
   WritePathToCfg('HomeDirPath', edHomePath.Text);
   WritePathToCfg('LockPath', edLockPath.Text);
  finally
   l3Free(Cfg);
  end;
  GlobalInit;
  CheckDatabase(Self);
  DeleteFile(TmpIniFN);
  FCurBase := rgBases.ItemIndex;
  MemorizeBaseType;
  MessageDlg('База успешно переключена.', mtInformation, [mbOK], 0);
 except
  on E: Exception do
  begin
   MessageDlg(E.Message, mtError, [mbOK], 0);
   RollBack;
  end;
 end;
end;

procedure Ta2BaseSwitchForm.FillBasesList;
var
 SR: TSearchRec;
 X: Integer;
 I: Integer;
 F: TextFile;
begin
 FYesterdays := nil;
 I := 0;
 if not DirExists(FYesterdayPath) then
  Exit;
 X := FindFirst(FYesterdayPath+'*', faDirectory, SR);
 while X = 0 do
 begin
  if (SR.Name[1] <> '.') and (DirExists(FYesterdayPath+SR.Name+'\garant')) then
  begin
   SetLength(FYesterdays, I+1);
   with FYesterdays[I] do
   begin
    Date := SR.Name;
    Path := FYesterdayPath+SR.Name;
    try
     AssignFile(F, FYesterdayPath+SR.Name+'\Date Of Base.txt');
     Reset(F);
     Readln(F, DispDate);
     CloseFile(F);
    except
     DispDate := SR.Name;
    end;
    DispDate := 'Базу GARANT за '+DispDate;
    rgBases.Items.Add(DispDate);
   end;
   Inc(I);
  end;
  X := FindNext(SR);
 end;
end;

procedure Ta2BaseSwitchForm.FormCreate(Sender: TObject);
var
 AutoServerPath: string;
 Ini: TIniFile;
begin
 StationConfig.Section:='ServerConfig';
 AutoServerPath:=StationConfig.ReadParamStrDef('AutomationServerPath','');
 if AutoServerPath <> '' then
 begin
  AutoServerPath := IncludeTrailingPathDelimiter(AutoServerPath);
  Ini := TIniFile.Create(AutoServerPath+'AutoPipeServer.ini');
  try
   FFullBackupPath := Ini.ReadString('Autoload', 'FullBackupDir', '');
   FYesterdayPath := Ini.ReadString('Autoload', 'YesterdayDir', '');
  finally
   Ini.Free;
  end;
  if FFullBackupPath <> '' then
   FFullBackupPath := IncludeTrailingPathDelimiter(FFullBackupPath);
  if FYesterdayPath <> '' then
   FYesterdayPath := IncludeTrailingPathDelimiter(FYesterdayPath);
 end;
 FBaseWorkingDir := StationConfig.ReadParamStrDef('BaseWorkingDir','');
 if FBaseWorkingDir <> '' then
  FBaseWorkingDir := IncludeTrailingPathDelimiter(FBaseWorkingDir);
 FServerConfigDir := StationConfig.ReadParamStrDef('ServerConfigINI','');
 if FServerConfigDir <> '' then
 begin
  FServerConfigDir := ExtractFilePath(FServerConfigDir);
  FServerConfigDir := IncludeTrailingPathDelimiter(FServerConfigDir);
 end;
 StationConfig.section := 'BaseSwitch';
 FDefTableDir := StationConfig.ReadParamStrDef('DefTableDir','MAIN');
 FDefHomeDir := StationConfig.ReadParamStrDef('DefHomeDir','HOMES');
 FDefLockDir := StationConfig.ReadParamStrDef('DefLockDir','SHARE');
 FillBasesList;
end;

procedure Ta2BaseSwitchForm.FormShow(Sender: TObject);
begin
 Height := 110+20*rgBases.Items.Count;
 ReadBaseType;
end;

procedure Ta2BaseSwitchForm.ReadBaseType;
var
 I: Integer;
 SBaseType: string;
 Cfg: TCfgList;
begin
 Cfg := TCfgList.Create;
 FCurBase := -1;
 try
  Cfg.Section := 'BaseSwitch';
  SBaseType := Cfg.ReadParamStrDef('BaseType','O');
  case SBaseType[1] of
   'C' : FCurBase := biCustom;
   'O' : FCurBase := biWork;
   'F' : FCurBase := biFullCopy;
   'Y' :
    begin
     Delete(SBaseType, 1,1);
     I := 0;
     while I < Length(FYesterdays)-1 do
     begin
      if FYesterdays[I].Date = SBaseType then
      begin
       FCurBase := I+biFullCopy+1;
       Break;
      end;
      Inc(I);
     end;
    end;
  end;
 finally
  l3Free(Cfg);
 end;
 Cfg := TCfgList.Create(FServerConfigDir+'ServerConfig.ini');
 FSettingPaths := True;
 try
  Cfg.Section := 'FamilyConst';
  edFamPath.Text := Cfg.ReadParamStrDef('FamilyPath',FBaseWorkingDir);
  Cfg.Section := 'BaseDocPath';
  edTablePath.Text := Cfg.ReadParamStrDef('TablePath','%FamilyPath%\'+FDefTableDir);
  edHomePath.Text := Cfg.ReadParamStrDef('HomeDirPath','%FamilyPath%\'+FDefHomeDir);
  edLockPath.Text := Cfg.ReadParamStrDef('LockPath','%FamilyPath%\'+FDefLockDir);
 finally
  FSettingPaths := False;
  l3Free(Cfg);
 end;
 rgBases.ItemIndex := FCurBase;
 //btnSwitch.Enabled := False;
end;

procedure Ta2BaseSwitchForm.rgBasesClick(Sender: TObject);
begin
 {btnSwitch.Enabled := rgBases.ItemIndex <> FCurBase;}
 if rgBases.ItemIndex <> -1 then
  SetPaths(rgBases.ItemIndex);
end;

procedure Ta2BaseSwitchForm.btnSwitchClick(Sender: TObject);
begin
 DoSwitchBase;
 ModalResult := mrOK;
end;

procedure Ta2BaseSwitchForm.MemorizeBaseType;
var
 Cfg : TCfgList;
 S: string;
begin
 Cfg := TCfgList.Create;
 try
  Cfg.Section := 'BaseSwitch';
  case FCurBase of
   biCustom:   S := 'C';
   biWork:     S := 'O';
   biFullCopy: S := 'F';
  else
   // yesterdays bases
   S := 'Y'+FYesterdays[FCurBase-biFullCopy-1].Date;
  end;
  Cfg.WriteParamStr('BaseType',S);
 finally
  l3Free(Cfg);
 end;
end;

procedure Ta2BaseSwitchForm.SetPaths(Index: Integer);
begin
 FSettingPaths := True;
 try
  RestoreDefaultPaths;
  case Index of
   biWork:     edFamPath.Text := FBaseWorkingDir;
   biFullCopy: edFamPath.Text := FFullBackupPath;
  else
   ;//edTablePath 
  end;
 finally
  FSettingPaths := False;
 end;
end;

procedure Ta2BaseSwitchForm.RestoreDefaultPaths;
begin
 edFamPath.Text := FBaseWorkingDir;
 edTablePath.Text := '%FamilyPath%\'+FDefTableDir+'\';
 edHomePath.Text := '%FamilyPath%\'+FDefHomeDir+'\';
 edLockPath.Text := '%FamilyPath%\'+FDefLockDir+'\';
end;

procedure Ta2BaseSwitchForm.edHomePathChange(Sender: TObject);
begin
 if not FSettingPaths then
  rgBases.ItemIndex := biCustom;
end;

procedure Ta2BaseSwitchForm.DoProgressNotify(aState: Byte; aValue: Integer;
  const aMsg: AnsiString);
begin
 case aState of
  piStart:
   begin
    with ProgressBar do
    begin
     Visible := True;
     Max := aValue;
     Position := 0;
    end;
    lblDisp.Caption := aMsg;
    btnSwitch.Enabled := False;
    btnCancel.Enabled := False;
   end;
  piCurrent:
   begin
    ProgressBar.Position := aValue;
    if aMsg <> '' then
     lblDisp.Caption := aMsg;
   end;
  piEnd:
   begin
    ProgressBar.Visible := False;
    lblDisp.Caption := '';
    btnSwitch.Enabled := True;
    btnCancel.Enabled := True;
   end;
 end;
 Application.ProcessMessages;
end;

end.
