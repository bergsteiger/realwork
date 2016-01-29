unit NameSpellMain;

{ $Id: NameSpellMain.pas,v 1.2 2014/10/08 13:07:43 lukyanets Exp $ }

// $Log: NameSpellMain.pas,v $
// Revision 1.2  2014/10/08 13:07:43  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.1  2011/07/07 05:56:36  narry
// Утилита исправления названий и текстов (271757472)
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit, 
  afwControlPrim, afwBaseControl, afwControl, XPMan, ComCtrls,
  l3LongintList, m3StorageElementIDList,
  m3StorageInterfaces, DT_Sab;

type
  TMainForm = class(TForm)
    btWork: TButton;
    btStop: TButton;
    pnStatus: TPanel;
    lbPercent: TLabel;
    Progress: TProgressBar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edBaseDir: TDirectoryEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditLogin: TEdit;
    EditPassword: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    fileMisspells: TFilenameEdit;
    Label2: TLabel;
    comboWhat: TComboBox;
    lblTopicListFN: TLabel;
    edTopicListFN: TFilenameEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btWorkClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure comboWhatChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
    f_Start: TDateTime;
    f_Topics: Tl3LongintList;
    function  pm_GetBaseDir: String;
    procedure pm_SetBaseDir(const aValue: String);
      {-}
    procedure DoBeforeIndexLoad(aSender: TObject);
      {-}
    procedure DoBeforeSort(aSender: TObject);
    procedure ErrorFound(const aDescription: String; aCategory: Integer = 0);
    procedure TotalProgress(aState     : Byte; aValue     : Long; const aMsg : String = '');
      {-}
    procedure Yield(aSender: TObject);
      {-}
  public
    { Public declarations }
    property BaseDir: String
      read pm_GetBaseDir
      write pm_SetBaseDir;
      {-}
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  l3InternalInterfaces,
  l3Base,
  l3Filer,
  l3FileUtils,
  l3Parser,
  l3Stream,
  l3Memory,

  k2Types,
  k2Tags,
  k2TagGen,
  k2StackGenerator,

  m3DB,
  m3DBActions,

  evdReader,
  evdWriter,
  evEvdRd,

  evInfoFilter, ddUtils, L3Math, StrUtils, dd_lcParticipantEraser,
  ddMisspellCorrect, SewerPipe, ddImportPipeKernel, ddHTInit, DT_Const,
  DT_Types, DT_LinkServ, dt_ListUtils;



procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_Topics);
 SaveSettings(Self);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 LoadSettings(Self);
 f_Topics := Tl3LongintList.Create();
 comboWhatChange(Self);
end;

procedure TMainForm.btWorkClick(Sender: TObject);
var
 l_Total : TDateTime;

 procedure DoWork;
 var
  l_Filter : Tk2TagGenerator;
  l_Range  : Im3DBRange;
  l_EPipe  : TSewerPipe;
  l_D      : TDiapasonRec;
 begin//DoWork
   l_EPipe:= TSewerPipe.Create(nil);
   try
    l_EPipe.Family:= CurrentFamily;
    l_Filter:= nil;
    TddImportPipeFilter.SetTo(l_Filter, CurrentFamily);
    TddImportPipeFilter(l_Filter).AddNewToLog:= True;
    try
     TddMisspellCorrectFilterEx.SetTo(l_Filter, fileMisspells.Text, 0, ErrorFound);
     Tdd_lcParticipantEraserFilter.SetTo(l_Filter, 1, ErrorFound);
     l_EPipe.Writer:= l_Filter;
     l_EPipe.ExportDocument:= True;
     l_EPipe.TotalProgressProc:= TotalProgress;
     pnStatus.Caption := 'Исправление документов...';
     if comboWhat.ItemIndex = 0 then
      l_D.Typ:= tdAll
     else
     begin
      l_D.List := LoadDocNumbers(edTopicListFN.Text).ExtractHTSab;
      l_D.Typ:= tdNumList;
     end;
     l_D.ExternalFormat := False;
     l_EPipe.Diapason:= l_D;
     try
      l_EPipe.Execute;
     finally
      if comboWhat.ItemIndex = 1 then
       dtFreeSab(l_D.List);
     end;
     MessageDlg('Исправление завершено', mtInformation, [mbOK], 0);
    finally
     FreeAndNil(l_Filter);
    end;
   finally
    FreeAndNil(l_EPipe);
   end;
 end;//DoWork

begin
 f_Stopped := false;
 f_InProcess := true;
 btWork.Enabled := false;
 btStop.Enabled := true;
 Progress.Visible:= True;
 try
  l_Total := 0;
  try
   if InitBaseEngine(BaseDir, editLogin.Text, editPassword.Text) then
   try
    l3System.Msg2Log('Начало обработки');
    DoWork;
    if f_Stopped then
     l3System.Msg2Log('Обработка прервана пользователем')
    else
     l3System.Msg2Log('Обработка завершена');
   finally
    DoneClientBaseEngine;
   end;
  finally
   f_InProcess := false;
  end;//try..finally
 finally
  btWork.Enabled := true;
  btStop.Enabled := false;
  Progress.Visible:= False;
 end;//try..finally
 pnStatus.Caption:= '';
 lbPercent.Caption:= '';
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := true;
 if (f_DB <> nil) then
  f_DB.Stop;
end;

procedure TMainForm.comboWhatChange(Sender: TObject);
begin
 edTopicListFN.Visible  := comboWhat.ItemIndex = 1;
 lblTopicListFN.Visible := edTopicListFN.Visible;
end;

function TMainForm.pm_GetBaseDir: String;
  {-}
begin
 Result := edBaseDir.Text;
end;

procedure TMainForm.pm_SetBaseDir(const aValue: String);
begin
 edBaseDir.Text := aValue;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f_InProcess then begin
  if (MessageDlg('Вы хотите прервать обработку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
   f_NeedClose := true;
   f_Stopped := true;
   if (f_DB <> nil) then
    f_DB.Stop;
  end;
  CanClose := false;
 end;//f_InProcess
end;

procedure TMainForm.DoBeforeIndexLoad(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Идёт преобразование документов';
end;

procedure TMainForm.DoBeforeSort(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Преобразование документов завершено';
end;

procedure TMainForm.ErrorFound(const aDescription: String; aCategory: Integer =
    0);
begin
 case aCategory of
  0: l3System.Msg2Log('Исправлена опечатка - %s', [aDescription]); // Опечатки
  1: l3System.Msg2Log('Удалены участники - %s', [aDescription]); // Участники
 end;
end;

procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

procedure TMainForm.TotalProgress(aState: Byte; aValue: Long; const aMsg: String = '');
begin
 case aState of
  0:
   begin
    Progress.Max:= aValue;
    Progress.Position:= 0;
    lbPercent.Caption := Format('Приступаем к обработке %d документов', [aValue]);
   end;
  1:
   begin
    Progress.Position:= aValue;
    if l3MulDiv(Progress.Position, 100, Progress.Max) > 0 then
     lbPercent.Caption := Format('Обработано %d из %d, осталось %s',
       [Progress.Position, Progress.Max, CalcLeftTime(Progress.Max, Progress.Position, f_Start, Now)])
    else
     lbPercent.Caption:= Format('Обработано %d документов из %d',  [Progress.Position, Progress.Max]);
   end;
  2:
   begin
    Progress.Position:= Progress.Max;
    lbPercent.Caption:= 'Обработка завершена';
   end;
 end;
end;

end.
