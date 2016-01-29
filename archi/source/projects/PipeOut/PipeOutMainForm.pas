unit PipeOutMainForm;
{$I ProjectDefine.inc}
{.$DEFINE DocAnno}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExportPipe, ExtCtrls, Mask, VConst,
  ToolEdit, {XPMan,<- кривая отрисовка} vtSpin, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze,
  dtIntf, dt_Sab,
  AppEvnts, CheckLst, ddCmdLineUtils;

type
  TPipeOutCmdLine = class(TddBaseCmdLine)
  private
   f_Field: string;
   f_Folder: string;
   f_Format: string;
   f_How: string;
   f_Images: string;
   f_Split: string;
   f_Template: string;
   f_what: string;
  protected
   procedure Init; override;
  public
   property Field: string read f_Field;
   property Folder: string read f_Folder;
   property Format: string read f_Format;
   property what: string read f_what;
   property How: string read f_How;
   property Images: string read f_Images;
   property Split: string read f_Split;
   property Template: string read f_Template;
  end;

  TPipeOutForm = class(TForm)
    GoButton: TButton;
    AllProgressBar: TProgressBar;
    Label1: TLabel;
    Label7: TLabel;
    labelBaseFolder: TLabel;
    groupWhat: TGroupBox;
    groupHow: TGroupBox;
    Label8: TLabel;
    dirDestinationFolder: TDirectoryEdit;
    comboSplitType: TComboBox;
    spinPartSize: TvtSpinEdit;
    Label10: TLabel;
    cbUpdate: TCheckBox;
    labelMessage: TLabel;
    Label2: TLabel;
    editDocFileMask: TEdit;
    ComboFileFormat: TComboBox;
    AppEvents: TApplicationEvents;
    comboWhat: TComboBox;
    checkDetails: TCheckListBox;
    ProgressCurrent: TProgressBar;
    cbPaginateImages: TCheckBox;
    procedure AppEventsIdle(Sender: TObject; var Done: Boolean);
    procedure GoButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure checkDetailsClickCheck(Sender: TObject);
    procedure comboSplitTypeChange(Sender: TObject);
    procedure comboWhatChange(Sender: TObject);
  private
    f_AddControl1: TControl;
    f_AddControl2: TControl;
    f_AutoRun: Boolean;
    f_CmdLine: TPipeOutCmdLine;
    f_DatabasePath: AnsiString;
    { Private declarations }
    f_Pipe: TExportPipe;
    f_ServerHostName: Shortstring;
    f_ServerPort: Integer;
    f_Password: string;
    f_UserName: string;
    procedure ClearAdditionalControls;
    procedure CreateListControls;
    procedure CreateOneDocControls;
    procedure CreateQueryControls;
    function GetNumbersFileName: string;
    procedure InsertAddionalControls;
    procedure LoadSettings;
    procedure ParseDatabasePart;
    procedure ParseFolderPart;
    procedure ParseFormatPart;
    procedure ParseParamString;
    procedure ParseSplitMethodPart;
    procedure ParseImageSplitMethodPart;
    procedure ParseTemplatePart;
    procedure ParseUserPart;
    procedure ParseWhatDetailsPart;
    procedure ParseWhatPart;
    procedure ProgressorUpdate(Sender: TObject; aTotalPercent: Integer);
    procedure QueryChange(Sender: TObject);
    procedure SaveSettings;
    procedure ShowHelp;
    procedure wmLogoff(var Message: TMessage); message wm_Logoff;
  protected
  public
    property NumbersFileName: string read GetNumbersFileName;
    { Public declarations }
  end;

var
  PipeOutForm: TPipeOutForm;


implementation

{$R *.DFM}

Uses
   dt_Serv, D_Pass,
   evTextFormatter,
   l3Base, l3Filer, l3Memory, l3IniFile, l3Stream, l3Parser, l3Types, l3FileUtils, l3Date,
   dt_Types, ht_dll, dt_Const,
   {$IFDEF DocAnno}
   ddHTMLAnno,
   {$ENDIF}
   ddUtils, ddHTInit, ddProgressObj, daTypes,
   ddAnnotations, ddExternalObjects, csUserRequestManager, dt_Doc,
   dt_Renum, DT_LinkServ, FileCtrl, StrUtils, Dt_Query, SavedQuery, DT_AskList, ddClientBaseEngine,
   dd_lcRelatedSearcher, DateUtils, ddCmdLineDlg, dt_ListUtils,
   dt_QueryParamsResolver,

   daDataProviderParams,
   ncsServiceProviderParams,
   htDataProviderParams,
   ddPipeOutInterfaces,

   m3StgMgr
   ;

procedure TPipeOutForm.AppEventsIdle(Sender: TObject; var Done: Boolean);
begin
 UserRequestManager.ProcessNotifyList;
 if f_AutoRun and g_BaseEngine.IsStarted then
 begin
  AppEvents.OnIdle:= nil;
  GoButtonClick(Self);
  Close;
 end
end;

procedure TPipeOutForm.GoButtonClick(Sender: TObject);
var
 l_Progressor : TddProgressObject;
 l_SQ: TSavedQuery;
 l_Q: TdtQuery;
 l_DocSab: ISab;
 l_ParamResolver: TdtQueryParamsResolver;

begin
 { Сборка трубы из отдельного компонента  }
 l_ParamResolver := nil;
 try
  GoButton.Enabled:= False;
  try
   Application.ProcessMessages;
   l_Progressor := TddProgressObject.Create;
   try
    l_Progressor.OnUpdate := ProgressorUpdate;
    f_Pipe:= TExportPipe.Create;
    try
     f_Pipe.Progressor := l_Progressor;
     f_Pipe.OutFileType:= TepSupportFileType(comboFileFormat.ItemIndex);
     f_Pipe.Family:= 1;
     if comboWhat.ItemIndex = 1 then
      f_Pipe.AllPartsDivideBy([])
     else
      case comboSplitType.ItemIndex of
       0: f_Pipe.AllPartsDivideBy([]);
       1: f_Pipe.AllPartsDivideBy([edbTopic]);
       2: f_Pipe.AllPartsDivideBy([edbAccGroup]);
       3: f_Pipe.AllPartsDivideBy([edbSize]);
      else
       Assert(False)
      end;
     f_Pipe.ExportDocument:= checkDetails.Checked[0];
     f_Pipe.ExportReferences:= checkDetails.Checked[1];
     f_Pipe.ExportAnnotation := checkDetails.Checked[4];
     f_Pipe.ExportDocImage := checkDetails.Checked[2];
     f_Pipe.ImagesByPages := cbPaginateImages.Checked;
     f_Pipe.UpdateFiles:= cbUpdate.Checked;
     f_Pipe.FileMask[edpDocument]   := l3CStr(editDocFileMask.Text);
     f_Pipe.FileMask[edpReference]  := l3CStr('rel_'+ editDocFileMask.Text);
     f_Pipe.FileMask[edpAnnotation] := l3CStr('anno_'+ editDocFileMask.Text);
     f_Pipe.OutputFileSize:= spinPartSize.AsInteger*1024;
     f_Pipe.OnlyStructure := checkDetails.Checked[6];
     f_Pipe.FormulaAsPicture:= checkDetails.Checked[8];
     case comboWhat.ItemIndex of  // все документы
      0: // Все
       begin
        l_DocSab := MakeSab(DocumentServer.FileTbl);
        l_DocSab.SelectAll;
        l_DocSab.ValuesOfKey(fId_Fld);
        f_Pipe.DocSab := l_DocSab;
        l_DocSab := nil;
       end;
      1: // Документ
       begin
         f_Pipe.MakeSingleDocSab(StrToIntDef(TComboBox(f_AddControl1).Text, 0), TCheckBox(f_AddControl2).Checked);
       end;
      2: // Список
       begin
        f_Pipe.DocSab := dt_ListUtils.LoadDocNumbers(TFileNameEdit(f_AddControl1).Text);
       end;
      3: // Запрос
       begin
        l_SQ:= TSavedQuery.CreateFromFile(TFilenameEdit(f_AddControl1).Text);
        try
         l_Q:= l_SQ.MakeQuery;
         try
          l_ParamResolver := TdtQueryParamsResolver.Create(l_Q, ExtractFileName(l_SQ.FileName), TCheckBox(f_AddControl2).Checked);
          f_Pipe.Query:= l_Q;
         finally
          FreeAndNil(l_Q);
         end;
        finally
         FreeAndNil(l_SQ);
        end;
       end;
     end; // case comboWhat.ItemIndex
 {$IFDEF DocAnno}
    with TddHTMLAnnotationPipe.Create(nil, 'doclist.lst') do
    try
     Pipe.Family:= CurrentFamily;
     Pipe.Diapason:= Diapason;
     Pipe.ExportDirectory:= dirDestinationFolder.Text{l_ExportFolder};
     ForceDirectories(Pipe.ExportDirectory);
     Pipe.Progressor := l_Progressor;
     Execute;
    finally
     Free;
    end;
 {$ELSE}
     //f_Pipe.StandaloneRef:= False;
     f_Pipe.ExportEmpty := not f_Pipe.ExportDocument;
     f_Pipe.ExportKW:= False;
     f_Pipe.ExportEditions:= checkDetails.Checked[3];
     f_Pipe.KWFileName:= 'garant.kw';
     f_Pipe.ExportDirectory:= dirDestinationFolder.Text;
     try
      f_Pipe.Execute;
      if Assigned(l_ParamResolver) then
       l_ParamResolver.SaveLastExecParams;
     except
      on E: Exception do
       l3System.Msg2Log('Ошибка экспорта %s', [E.Message]);
     end;
 {$ENDIF}
    finally
     l3Free(f_Pipe);
    end; {Pipe.Create}
    Label1.Caption:= SysUtils.Format('Экспорт завершен за %s', [l_Progressor.TotalElapsedTimeAsString]);
    l3System.Msg2Log(Label1.Caption);
   finally
    FreeAndNil(l_Progressor);
   end;
  finally
   GoButton.Enabled:= True;
  end;
 finally
  l3Free(l_ParamResolver);
 end;
end;

procedure TPipeOutForm.FormCreate(Sender: TObject);
var
 l_Proc: TGetLoginPasswordProc;
 i: Integer;
 l_DParams: TdaDataProviderParams;
 l_OK : Boolean;
 l_SParams: TncsServiceProviderParams;
begin
 (*if Tm3StorageManager.UseSplitted then
  Caption:= Caption + ' (с поддержкой кусочного хранилища)';
 Caption:= Caption + ' (с поддержкой NSRC+)';
 i:= ComboFileFormat.Items.IndexOf('NSRC');
 if i <> -1 then
  ComboFileFormat.Items[i]:= 'NSRC+';
 *) 
 {$IFDEF OnlySpr}
 Caption:= Caption + ' (только справки)';
 {$ENDIF}
 comboWhat.ItemIndex:= -1;
 Label7.Caption:= GetProgramVersion;
 comboFileFormat.ItemIndex:= 3;
 LoadSettings;
 // теперь можно выливать справки отдельно от документов
 //checkDetails.ItemEnabled[1]:= False;
 //checkDetails.Checked[1]:= True;
 f_CmdLine := TPipeOutCmdLine.Create();
 ResetSelfLog(5000000);
 ParseParamString;
 l_OK := False;
 if f_AutoRun then
 begin
  l3System.ShowObjectsWindow:= False;
  // зачитываем значения из инишника
  MakeParams(l_SParams, l_DParams);
  InitStationAndServerConfig;
  try
   if (f_UserName = '') and (l_SParams.Login = '') then // если нет данных ни в инишнике, ни в командной строке
    f_UserName := 'guest';

   if f_UserName <> '' then
   begin
    l_SParams.Login := f_UserName;
    l_SParams.Password := f_Password;
   end;

   if f_ServerHostName <> '' then
   begin
    l_SParams.StandAlone := False;
    l_SParams.ServerHostName := f_ServerHostName;
    l_SParams.ServerPort := f_ServerPort;
   end
   else
   if f_DatabasePath <> '' then
   begin
    l_SParams.StandAlone := True;
    l_SParams.IsDeveloper := True;
    l_DParams.ChangeBasePath(f_DatabasePath);
   end;

   l_OK := InitBaseEngine(l_SParams, l_DParams, True {QuietMode}, nil, False, False, True, True {AbsolutelyQuiet});
  finally
   FreeAndNil(l_SParams);
   FreeAndNil(l_DParams);
  end;
 end
 else
  l_OK := InitBaseEngine();

 if l_OK then
 begin
  labelBaseFolder.Caption:= 'База:'#10+ MinimizeName(g_BaseEngine.GetFamilyPath(CurrentFamily),
                                                   labelBaseFolder.Canvas,
                                                   labelBaseFolder.ClientWidth);
  UserRequestManager.wmLogoff := WM_CLOSE;
 end
 else
 begin
  l3System.Msg2Log('Не удалось подключиться к базе данных');
  ExitCode:= 1;
  DoneClientBaseEngine(True);
  Application.Terminate;
 end;
end;

procedure TPipeOutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeAndNil(f_CmdLine);
 if not GoButton.Enabled then
 begin
  f_Pipe.AbortExport;
  Action := caNone;
  ExitCode:= 2;
 end
 else
 begin
  if comboWhat.ItemIndex = 1 then
   if TComboBox(f_AddControl1).Items.IndexOf(TComboBox(f_AddControl1).Text) = -1 then
    TComboBox(f_AddControl1).Items.Add(TComboBox(f_AddControl1).Text);
  SaveSettings;
  DoneClientBaseEngine(True);
 end;
end;

procedure TPipeOutForm.ProgressorUpdate(Sender: TObject; aTotalPercent: Integer);
begin
 with TddProgressObject(Sender) do
 begin
  labelMessage.Caption:= Caption;
  with AllProgressBar do
  begin
   Max := 100;
   Position := TotalPercent;
  end; // with AllProgressBar
  with ProgressCurrent do
  begin
   Max := 100;
   Position := Percent;
  end; // with ProgressCurrent
  Label1.Caption:= Format('Потрачено : %-35s Осталось: %s', [TotalElapsedTimeAsString, TotalRemainingTimeAsString]);
 end; // with TddProgressObject(Sender)
 Application.ProcessMessages;
end;

procedure TPipeOutForm.checkDetailsClickCheck(Sender: TObject);
begin
 //checkDetails.Checked[1]:= True;
 comboFileFormat.Enabled := checkDetails.Checked[0] or checkDetails.Checked[1] or checkDetails.Checked[4];
 dirDestinationFolder.Enabled := checkDetails.Checked[0] or checkDetails.Checked[2] or checkDetails.Checked[1] or checkDetails.Checked[4];
 editDocFileMask.Enabled := checkDetails.Checked[0] or checkDetails.Checked[1] or checkDetails.Checked[4];
 Label8.Enabled := checkDetails.Checked[0] or checkDetails.Checked[1] or checkDetails.Checked[4];
 comboSplitType.Enabled := checkDetails.Checked[0] or checkDetails.Checked[1] or checkDetails.Checked[4];
 spinPartSize.Enabled := checkDetails.Checked[0];
 checkDetails.ItemEnabled[7] := checkDetails.Checked[0];
 checkDetails.ItemEnabled[6] := checkDetails.Checked[0];
end;

procedure TPipeOutForm.ClearAdditionalControls;
begin
 if f_AddControl1 <> nil then
 begin
  groupWhat.RemoveControl(f_AddControl1);
  FreeAndNil(f_AddControl1);
 end;
 if f_AddControl2 <> nil then
 begin
  groupWhat.RemoveControl(f_AddControl2);
  FreeAndNil(f_AddControl2);
 end;
end;

procedure TPipeOutForm.comboSplitTypeChange(Sender: TObject);
begin
 spinPartSize.Visible := comboSplitType.ItemIndex = 3;
 label10.Visible := comboSplitType.ItemIndex = 3;
end;

procedure TPipeOutForm.comboWhatChange(Sender: TObject);
begin
 // В зависимости от выбранного элемента формируем доп элементы
 ClearAdditionalControls;
 case comboWhat.ItemIndex of
  1: CreateOneDocControls;
  2: CreateListControls;
  3: CreateQueryControls;
 end;
 InsertAddionalControls;
end;

procedure TPipeOutForm.CreateListControls;
begin
 f_AddControl1:= TFilenameEdit.Create(groupWhat);
 f_AddControl1.Name:= 'fileDocList';
 TFilenameEdit(f_AddControl1).Filter:= 'Файлы списка номеров (*.lst, *.txt)|*.txt;*.lst';
 TFilenameEdit(f_AddControl1).Text:= '';
end;

procedure TPipeOutForm.CreateOneDocControls;
begin
 f_AddControl1:= TComboBox.Create(groupWhat);
 f_AddControl1.Name:= 'comboNumbers';
 TComboBox(f_AddControl1).Text:= '';
 f_AddControl2:= TCheckBox.Create(groupWhat);
 f_AddControl2.Name:= 'checkIsGarant';
 TCheckBox(f_AddControl2).Caption:= 'Номер Гаранта';
end;

procedure TPipeOutForm.CreateQueryControls;
begin
 f_AddControl1:= TFilenameEdit.Create(groupWhat);
 f_AddControl1.Name:= 'fileQuery';
 TFilenameEdit(f_AddControl1).Filter:= 'Файлы поисковых запросов (*.sqr)|*.sqr';
 TFilenameEdit(f_AddControl1).Text:= '';
 TFilenameEdit(f_AddControl1).OnChange:= QueryChange;
 TFilenameEdit(f_AddControl1).ShowHint:= True;

 f_AddControl2:= TCheckBox.Create(groupWhat);
 f_AddControl2.Name := 'ParametrizedQuery';
 TCheckBox(f_AddControl2).Caption := 'Подставлять даты';
end;

function TPipeOutForm.GetNumbersFileName: string;
begin
 Result := ChangeFileExt(Application.ExeName, '.numbers');
end;

procedure TPipeOutForm.InsertAddionalControls;
begin
 if f_AddControl1 <> nil then
 begin
  f_AddControl1.Left:= 160;
  f_AddControl1.Top:= 16;
  if f_AddControl2 <> nil then
   f_AddControl1.Width:= 297 div 2
  else
   f_AddControl1.Width:= 297;
  groupWhat.InsertControl(f_AddControl1);
  if (f_AddControl1 is TComboBox) and FileExists(NumbersFileName) then
   TComboBox(f_AddControl1).Items.LoadFromFile(NumbersFileName);

 end; // f_AddControl1 <> nil
 if f_AddControl2 <> nil then
 begin
  f_AddControl2.Left:= 160 + 297 div 2 + 8;
  f_AddControl2.Top:= 16;
  f_AddControl2.Width:= 297 div 2 - 8;
  groupWhat.InsertControl(f_AddControl2);
 end; // f_AddControl1 <> nil
end;

procedure TPipeOutForm.LoadSettings;
begin
 ddUtils.LoadSettings(Self);
 comboWhatChange(Self);
 checkDetailsClickCheck(Self);
 ComboSplitTypeChange(self);
{
 with TCfgList.Create() do
 try
  Section := 'Network';
  ReadParamStr('ServerName', f_ServerHostName);
  if f_ServerHostName = '' then
   ReadParamStr('ServerName', f_ServerHostName);
  ReadParamInt('Serverport', f_ServerPort);
 finally
  Free;
 end;
} 
end;

procedure TPipeOutForm.ParseDatabasePart;
begin
 if f_CmdLine.BaseRoot <> '' then
  f_DatabasePath := f_CmdLine.BaseRoot;
 if f_CmdLine.ServerHostName <> '' then
  f_ServerHostName := f_CmdLine.ServerHostName;
 if f_CmdLine.ServerPort > 0 then
  f_ServerPort := f_CmdLine.ServerPort;
end;

procedure TPipeOutForm.ParseFolderPart;
begin
  if f_CmdLine.Folder <> '' then
   dirDestinationFolder.Text:= f_CmdLine.Folder;
end;

procedure TPipeOutForm.ParseFormatPart;
begin
{ '/F:E|N|T|R|H|K - формат экспорта'#10+
 '  E - Эверест'#10+
 '  N - NSRC'#10+
 '  T - текст'#10+
 '  R - rich text format'#10+
 '  H - html'#10+
 '  K - текстовый Эверест'#10+
}
 ComboFileFormat.ItemIndex:= 3;
  if f_CmdLine.Format <> '' then
   case Upcase(f_CmdLine.Format[1]) of
    'E': ComboFileFormat.ItemIndex:= 0;
    'K': ComboFileFormat.ItemIndex:= 1;
    'T': ComboFileFormat.ItemIndex:= 2;
    'N': ComboFileFormat.ItemIndex:= 3;
    'R': ComboFileFormat.ItemIndex:= 4;
    'H': ComboFileFormat.ItemIndex:= 5;
   end; // case Upcase(l_Param[1])
end;

procedure TPipeOutForm.ParseParamString;

var
 l_Param: string;
begin
 f_AutoRun:= (ParamCount > 0) and not f_CmdLine.NeedHelp;
 if f_AutoRun or f_CmdLine.NeedHelp then
 begin
  if f_CmdLine.NeedHelp then
  begin
   ShowHelp;
   exit;
  end
  else
  begin
   ParseWhatPart;
   ParseWhatDetailsPart;
   ParseDatabasePart;
   ParseUserPart;
   ParseTemplatePart;
   ParseFormatPart;
   ParseFolderPart;
   ParseSplitMethodPart;
   ParseImageSplitMethodPart;
  end;
 end;
end;

procedure TPipeOutForm.ParseSplitMethodPart;
var
 l_Num: Integer;
begin
{ '/D:N|D|S<partsize>|M - способ разделения документов. По умолчанию все документы в один файл'#10+
 '  N - не разделять'#10+
 '  D - каждый документ отдельно'#10+
 '  S<partsize> - по размеру <partsize> кбайт'#10+
 '  M - по группе доступа');
}
 comboSplitType.ItemIndex:= 0;
 comboSplitTypeChange(self);
  if f_CmdLine.Split <> '' then
  begin
   case Upcase(f_CmdLine.Split[1]) of
    'D':
     begin
      comboSplitType.ItemIndex := 1;
     end;
    'M':
     begin
      comboSplitType.ItemIndex := 2;
     end;
    'S':
     begin
      comboSplitType.ItemIndex := 3;
      l_Num:= StrToIntDef(Copy(f_CmdLine.Split, 2, MaxInt), 0);
      if l_Num > 0 then
       spinPartSize.AsInteger:= l_Num;
     end;
   end; // case
   comboSplitTypeChange(self);
  end;
end;

procedure TPipeOutForm.ParseImageSplitMethodPart;
begin
{'/G:P|S - способ экспорта графических образов. По умолчанию постранично'#10+
 '  P - каждая страница в одном файле'#10+
 '  S - многостраничый TIFF'}
 cbPaginateImages.Checked:= True;
  if f_CmdLine.Images <> '' then
   case Upcase(f_CmdLine.Images[1]) of
    'P': cbPaginateImages.Checked:= True;
    'S': cbPaginateImages.Checked:= False;
   end; // case
end;

procedure TPipeOutForm.ParseTemplatePart;
begin
 editDocFileMask.Text:= 'document';
  if f_CmdLine.Template <> '' then
   editDocFileMask.Text:= f_CmdLine.Template;
end;

procedure TPipeOutForm.ParseUserPart;
begin
 f_UserName:= f_CmdLine.User;
 f_Password:= f_CmdLine.Password;
end;

procedure TPipeOutForm.ParseWhatDetailsPart;
begin
 if f_CmdLine.How <> '' then
 begin
  checkDetails.Checked[0]:= AnsiContainsText(f_CmdLine.How, 'D');
  checkDetails.Checked[1]:= AnsiContainsText(f_CmdLine.How, 'R');
 end
 else
 begin
  // по умолчанию
  checkDetails.Checked[0]:= True;
  checkDetails.Checked[1]:= True;
 end;
 checkDetails.Checked[2]:= AnsiContainsText(f_CmdLine.How, 'G');
 checkDetails.Checked[3]:= AnsiContainsText(f_CmdLine.How, 'E');
 checkDetails.Checked[4]:= AnsiContainsText(f_CmdLine.How, 'A');
 checkDetails.Checked[5]:= AnsiContainsText(f_CmdLine.How, 'H');
 checkDetails.Checked[6]:= AnsiContainsText(f_CmdLine.How, 'S');
 checkDetails.Checked[7]:= AnsiContainsText(f_CmdLine.How, 'N');
 checkDetails.Checked[8]:= AnsiContainsText(f_CmdLine.How, 'P');

 checkDetailsClickCheck(Self);
end;

procedure TPipeOutForm.ParseWhatPart;
var
 l_Param: string;
 l_Num: Integer;
 l_ExtNum: Boolean;
 l_StartPos: Integer;
begin
 comboWhat.ItemIndex:= 0;
 comboWhatChange(self);
  if f_CmdLine.What <> '' then
  begin
   case Upcase(f_CmdLine.What[1]) of
    'L':
     begin
      comboWhat.ItemIndex:= 2;
      comboWhatChange(self);
      TFilenameEdit(f_AddControl1).Text:= Copy(f_CmdLine.What, 2, Length(f_CmdLine.What));
     end;
    'D':
     begin
      l_Param:= f_CmdLine.What;
      if f_CmdLine.What[2] = '#' then
      begin
       Delete(l_Param, 1, 2);
       l_ExtNum:= False;
      end
      else
      begin
       Delete(l_Param, 1, 1);
       l_ExtNum:= True;
      end; // f_CmdLine.What[2] = '#'
      l_Num:= StrToIntdef(l_Param, 0);
      if l_Num > 0 then
      begin
       comboWhat.ItemIndex:= 1;
       comboWhatChange(self);
       TComboBox(f_AddControl1).Text:= l_Param;
       TCheckBox(f_AddControl2).Checked:= l_ExtNum;
      end
     end;
    'P',
    'Q':
     begin
      comboWhat.ItemIndex:= 3;
      comboWhatChange(self);
      if Upcase(f_CmdLine.What[1]) = 'P' then
      begin
       l_StartPos := 3;
       if Upcase(f_CmdLine.What[2]) <> 'Q' then
       begin
        comboWhat.ItemIndex:= 0;
        comboWhatChange(self);
        Exit;
       end;
      end
      else
       l_StartPos := 2;
      TFilenameEdit(f_AddControl1).Text:= Copy(f_CmdLine.What, l_StartPos, Length(f_CmdLine.What));
      TCheckBox(f_AddControl2).Checked := Upcase(f_CmdLine.What[1]) = 'P';
     end;
   end; // case
  end // f_CmdLine.What <> ''
end;

procedure TPipeOutForm.QueryChange(Sender: TObject);
var
 l_SQ: TSavedQuery;
begin
 if FileExists(TFilenameEdit(f_AddControl1).Text) then
 begin
  With TSavedQuery.CreateFromFile(TFilenameEdit(f_AddControl1).Text) do
  try
   TFilenameEdit(f_AddControl1).Hint:= Name;
  finally
   Free;
  end;
 end
 else
  TFilenameEdit(f_AddControl1).Hint:= '';
end;


procedure TPipeOutForm.SaveSettings;
var
 i: Integer;
begin
 if comboWhat.ItemIndex = 1 then
 begin
  with TComboBox(f_AddControl1).Items do
  begin
   i:= Pred(Count);
   while i > 0 do
   begin
    if Strings[i] = '' then
     Delete(i);
    Dec(i);
   end;
   SaveToFile(NumbersFileName);
  end;
 end;
 ddUtils.SaveSettings(Self)
end;

procedure TPipeOutForm.ShowHelp;
begin
 ShowCmdHelpMessage('Использование PipeOut2.exe', f_CmdLine.HelpText);
end;


procedure TPipeOutForm.wmLogoff(var Message: TMessage);
begin
 if f_Pipe <> nil then
  f_Pipe.AbortExport;
 while f_Pipe <> nil do;
 Close;
end;

procedure TPipeOutCmdLine.Init;
begin
 inherited Init;
 AddString('W', 'Что экспортировать. По умолчанию все документы'#10 +
 '  A - все документы'#10 +
 '  L<filename> - список документов из файла <filename>. Для внутренних номеров первая строка должна содержать #'#10 +
 '  D[#]<ID> - один документ с номером <ID>, # означает, что номер внутренний'#10 +
 '  [P]Q<filename>] - поисковый запрос из файла <filename>, P означает подстановку дат', '<A|L<filename>|D[E]<ID>|[P]Q<filename>', f_what);
 AddString('H', 'Детализация экспорта. По умолчанию Документы и Справки'#10+
 '  D - документы'#10+
 '  R - справки (всегда, когда выбраны документы)'#10+
 '  G - графические образы'#10+
 '  E - редакции документов'#10+
 '  A - аннотации'#10+
 '  H - только заголовки документов'#10+
 '  S - только структура документов'#10+
 '  N - анонсы'#10+
 '  P - формулы как картинки', '[D][R][G][E][A][H][S][N][P]', f_How);
 AddString('T', 'шаблон имени файла документов', '<filemask>', f_Template);
 AddString('F', 'формат экспорта:'#10+
 '  E - Эверест'#10+
 '  N - NSRC'#10+
 '  T - текст'#10+
 '  R - rich text format'#10+
 '  H - html'#10+
 '  K - текстовый Эверест', 'E|N|T|R|H|K', f_Format);
 AddString('P', 'папка для экспорта', '<folder>', f_Folder);
 AddString('D', 'Способ разделения документов. По умолчанию все документы в один файл'#10+
 '  N - не разделять'#10+
 '  D - каждый документ отдельно'#10+
 '  S<partsize> - по размеру <partsize> кбайт'#10+
 '  M - по группе доступа', 'N|D|S<partsize>|M', f_Split);
 AddString('G', 'Способ экспорта графических образов. По умолчанию постранично'#10+
 '  P - каждая страница в одном файле'#10+
 '  S - многостраничый TIFF', 'P|S', f_Images);

end;

end.


