unit Main;

{ $Id: Main.pas,v 1.15 2015/07/02 11:40:58 lukyanets Exp $ }
// $Log: Main.pas,v $
// Revision 1.15  2015/07/02 11:40:58  lukyanets
// ќписываем словари
//
// Revision 1.14  2014/12/12 11:48:06  fireton
// - не запускалось
//
// Revision 1.13  2011/06/09 13:13:36  fireton
// - не собиралось
//
// Revision 1.12  2010/08/03 13:21:16  voba
// - k: 229672814
//
// Revision 1.11  2010/02/04 10:29:46  narry
// - сборка под 131 версию базы
//
// Revision 1.10  2008/10/03 10:25:54  fireton
// - образом документа теперь может быть не только TIFF
//
// Revision 1.9  2008/09/15 09:05:39  voba
// no message
//
// Revision 1.8  2007/09/10 08:36:33  fireton
// - избавл€емс€ от жесткой прив€зки к ID источников опубликовани€
//
// Revision 1.7  2007/03/27 12:58:20  fireton
// - багфикс в св€зи с переходом на большие DictID
//
// Revision 1.6  2007/03/06 14:54:43  fireton
// - добавление образов периодических изданий
// - измененный формат входного файла
//
// Revision 1.5  2006/12/14 10:11:09  fireton
// - программа "отстреливаетс€" с сервера
// - галочка "закрыть по окончании"
// - мелкие украшательства
// - чистка кода
//
// Revision 1.4  2006/12/13 13:50:57  fireton
// - добавл€ем записи о страницах
// - если "ѕолучено по рассылке" уже есть, добавл€етс€ как "ѕолучено по рассылке 2"
// - ошибки пишутс€ теперь в лог программы
// - добавл€етс€ запись в логе документа
//
// Revision 1.3  2005/10/27 13:18:29  step
// добавлена возможность указывать источник опубликовани€
//
// Revision 1.2  2005/03/21 10:36:47  step
// добавлена кнопка "¬ыход"
//
// Revision 1.1  2005/03/15 17:16:14  step
// занесено в CVS
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, StdCtrls,
  ImgLoader, VConst;

type
  TformMain = class(TForm)
    edSrcFile: TEdit;
    butRun: TButton;
    prBar: TProgressBar;
    butSrcFile: TSpeedButton;
    labSrcFile: TLabel;
    labProgress: TLabel;
    OpenDialog: TOpenDialog;
    butExit: TButton;
    cbSource: TComboBox;
    labSource: TLabel;
    cbCloseOnFinish: TCheckBox;
    cbAddSource: TComboBox;
    lblAddSource: TLabel;
    procedure butSrcFileClick(Sender: TObject);
    procedure butRunClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure butExitClick(Sender: TObject);
    procedure cbSourceSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
   procedure wmLogoff(var Message: TMessage); message wm_Logoff;
  private
    f_ByMailCount: Integer;
    f_ImgLoader: TImgLoader;
    procedure DisableControls;
    procedure EnableControls;
    procedure SaveParams;
    procedure RestoreParams;
    procedure InitSourceCombo;
    procedure UpdateCombos;
  public
    { Public declarations }
  end;


var
  formMain: TformMain;

implementation

{$R *.dfm}

uses
 l3Base,
 l3Date,
 l3DateSt,
 l3String,

 IniFiles,

 daTypes,

 Ht_Const,

 Dt_Types,
 Dt_Const,
 Dt_DocImages,
 Dt_Dict,
 Dt_ATbl,
 AI_Query,
 dt_DictConst,
 dt_AttrSchema
 ;

procedure TformMain.butSrcFileClick(Sender: TObject);
begin
 with OpenDialog do
 begin
  Title := '‘айл с описанием образов';
  FileName := edSrcFile.Text;
  if Execute then
   edSrcFile.Text := FileName;
 end;
end;

procedure TformMain.butRunClick(Sender: TObject);
var
 l_Terminated: Boolean;
begin
 DisableControls;
 try
  f_ImgLoader := TImgLoader.Create;
  try
   with f_ImgLoader do
   begin
    ProgressLabel := labProgress;
    ProgressBar := prBar;
    SrcFile := edSrcFile.Text;
    ByMail := cbSource.ItemIndex < f_ByMailCount;
    DocSourceId := TDictID(cbSource.Items.Objects[cbSource.ItemIndex]);
    if ByMail and (cbAddSource.ItemIndex > 0) then
     DocSourceId2 := TDictID(cbAddSource.Items.Objects[cbAddSource.ItemIndex]);
    Execute;
   end;
  finally
   l_Terminated := f_ImgLoader.Terminated;
   FreeAndNil(f_ImgLoader);
  end;
 finally
  EnableControls;
  if l_Terminated or cbCloseOnFinish.Checked then
   Close;
 end;
end;

procedure TformMain.DisableControls;
begin
 edSrcFile.Enabled  := False;
 butSrcFile.Enabled := False;
 butRun.Enabled     := False;
 butExit.Enabled    := False;
 cbCloseOnFinish.Enabled := False;
end;

procedure TformMain.EnableControls;
begin
 edSrcFile.Enabled  := True;
 butSrcFile.Enabled := True;
 butRun.Enabled     := True;
 butExit.Enabled    := True;
 cbCloseOnFinish.Enabled := True;
end;

procedure TformMain.RestoreParams;
var
 l_IniFile: TIniFile;
begin
 l_IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
 try
  edSrcFile.Text := l_IniFile.ReadString('Files', 'Source', '');
 finally
  FreeAndNil(l_IniFile);
 end;
end;

procedure TformMain.SaveParams;
var
 l_IniFile: TIniFile;
begin
 if (edSrcFile.Text <> '') {or (edLogFile.Text <> '')} then
 begin
  l_IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
   l_IniFile.WriteString('Files', 'Source', edSrcFile.Text);
  finally
   FreeAndNil(l_IniFile);
  end;
 end;
end;

procedure TformMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 SaveParams;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
 RestoreParams;
 InitSourceCombo;
end;

procedure TformMain.butExitClick(Sender: TObject);
begin
 Close;
end;

procedure TformMain.InitSourceCombo;
const
 c_BadId = 0;
var
// l_FiltSources: TFilteredData;
 l_CSList: TStringList;
 l_ByMailList: TStringList;
 l_Query: TSelectionQuery;
 l_IsNonperiodic: Byte;
 I: Integer;
 l_SourceId: DWORD;
 l_Name: string;
 l_NumStr: string;
 l_DateStr: string;
 l_ShortName: TCorSrcShortName;
begin
 l_CSList := TStringList.Create;
 l_ByMailList:= TStringList.Create;
 try
  //DictServer.Family := CurrentFamily;

  // строим список источников опубликовани€
  l_Query := TSelectionQuery.Create(DictServer(CurrentFamily).Tbl[da_dlCorSources]);
//  l_Query := TSelectionQuery.Create(LinkServer(CurrentFamily).Attribute[atPublisheds]);
  with l_Query do
  try
   SortedBy([dtNameFld]);
   Open([dtIDFld, dtNameFld]);
   while not Eof do
   begin
    if FieldAsLongWord[dtIDFld] <> c_BadId then
     l_CSList.AddObject(FieldAsString[dtNameFld], Pointer(FieldAsLongWord[dtIDFld]));
    l_Query.Next;
   end;
   Close;
  finally
   FreeAndNil(l_Query);
  end;

  l_SourceId := 0;

  // ищем элемент словар€ "получено по рассылке"
  l_Query := TSelectionQuery.Create(DictServer(CurrentFamily).Tbl[da_dlCorSources]);
  with l_Query do
  try
   l3StringToArray(l_ShortName, SizeOf(l_ShortName), '@');
   AddFilter(csShName_fld, EQUAL, l_ShortName);
   Open([csID_fld]);
   if RecordCount > 0 then
    l_SourceID := FieldAsLongWord[csID_fld];
   Close;
  finally
   l3Free(l_Query);
  end;

  // строим список источников "получено по рассылке"
  l_Query := TSelectionQuery.Create(DictServer(CurrentFamily).Tbl[da_dlPublisheds]);
  with l_Query do
  try
   AddFilter(piSourFld, EQUAL, l_SourceId);
   SortedBy([dtIDFld]);
   Open([piIDFld, piSDateFld, piEDateFld, piNumberFld]);
   while not Eof do
   begin
    if FieldAsLongWord[piIDFld] <> c_BadId then
    begin
     l_NumStr := FieldAsString[piNumberFld];
     if l_Numstr <> '' then
      l_NumStr := ' є'+l_NumStr;
     if FieldAsLongWord[piSDateFld] <> 0 then
      l_DateStr := ' ('+l3DateToStr(TStDate(FieldAsLongWord[piSDateFld]))+
          '-'+l3DateToStr(TStDate(FieldAsLongWord[piEDateFld]))+')'
     else
      l_DateStr := '';
     l_Name := 'ѕолучено по рассылке'+l_NumStr+l_DateStr;
     l_ByMailList.AddObject(l_Name, Pointer(FieldAsLongWord[piIDFld]));
    end;
    l_Query.Next;
   end;
   Close;
  finally
   FreeAndNil(l_Query);
  end;

  l_CSList.Sort;
  l_ByMailList.Sort;
  with cbSource do
  begin
   Clear;
   Items.AddStrings(l_ByMailList);
   Items.AddStrings(l_CSList);
   ItemIndex := 0;
  end;

  with cbAddSource do
  begin
   Clear;
   Items.Add('<не нужен>');
   Items.AddStrings(l_ByMailList);
   ItemIndex := 0;
  end;

  f_ByMailCount := l_ByMailList.Count;

  UpdateCombos;

 finally
  l3Free(l_CSList);
  l3Free(l_ByMailList);
 end;
end;

procedure TformMain.UpdateCombos;
begin
 cbAddSource.Enabled := cbSource.ItemIndex < f_ByMailCount;
 lblAddSource.Enabled := cbAddSource.Enabled;
end;

procedure TformMain.wmLogoff(var Message: TMessage);
begin
 if Assigned(f_ImgLoader) then
  f_ImgLoader.Terminated := True
 else
  Close;
end;

procedure TformMain.cbSourceSelect(Sender: TObject);
begin
 UpdateCombos;
end;

procedure TformMain.FormShow(Sender: TObject);
begin
 if cbSource.Items.Count = 0 then
 begin
  MessageDlg('¬ базе не найден ни один источник опубликовани€. ƒобавьте их в јрхивариусе.', mtError, [mbOK], 0);
  Close;
 end;
end;

end.
