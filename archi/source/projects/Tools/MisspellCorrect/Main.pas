unit Main;

{ $Id: Main.pas,v 1.3 2012/02/29 10:15:49 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.3  2012/02/29 10:15:49  lulin
// CheckFiler
//
// Revision 1.2  2011/05/24 15:08:12  fireton
// - небольшие исправления утилиты
//
// Revision 1.1  2010/05/07 14:21:26  fireton
// - initial
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit, 
  afwControlPrim, afwBaseControl, afwControl, vtCombo, vtDateEdit;

type
  TMainForm = class(TForm)
    btCopy: TButton;
    FileMeter: TvtW95Meter;
    FilesMeter: TvtW95Meter;
    lbFile: TLabel;
    lbFiles: TLabel;
    OvcController: TOvcController;
    lbNum: TLabel;
    btStop: TButton;
    edBaseDir: TDirectoryEdit;
    pnStatus: TPanel;
    btStat: TSpeedButton;
    lbPercent: TLabel;
    btHideFileMeter: TSpeedButton;
    Label1: TLabel;
    edTopicListFN: TFilenameEdit;
    lblTopicListFN: TLabel;
    procedure btCopyClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btStatClick(Sender: TObject);
    procedure btHideFileMeterClick(Sender: TObject);
    procedure FilesMeterSetStr(const aStr: String);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
    function  pm_GetBaseDir: String;
    procedure pm_SetBaseDir(const aValue: String);
      {-}
    procedure FilesProcessed(aCurrentID: Long);
      {-}
    procedure FilesProcessedEx(aCurrentID : Long;
                               aMaxID     : Long;
                               aTime      : TDateTime);
      {-}
    procedure DoBeforeIndexLoad(aSender: TObject);
      {-}
    procedure DoBeforeSort(aSender: TObject);
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
  l3Interfaces,
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
  m3StorageInterfaces,
  m3StorageElementIDList,

  ddMisspellCorrect,

  evdReader,
  evdWriter,
  evEvdRd,


  D_MEMUSG
  ;

// start class TMainForm

const
 cBaseDir = 'm:\base.full\garant';
 //cBaseDir = '\\ARCHI2\Archi\fullbase.archi\garant\';

function LoadDocNumbers(const aFileName: string): Im3StorageElementIDList;
var
 lStream : Tl3FileStream;
 lTmpStream : Tl3MemoryStream;
 l_Parser    : Tl3Parser;
 l_CurNum    : Integer;

begin
 Result := nil;
 if FileExists(aFileName) then
 begin
  lStream := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   l_Parser := Tl3Parser.Create;
   try
    l_Parser.CheckFloat := False;
    l_Parser.CheckFiler.Stream := lStream;
    l_Parser.NextTokenSp;
    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      if Result = nil then
       Result := Tm3StorageElementIDList.MakeI;
      try
       l_CurNum := l_Parser.TokenInt;
       Result.Add(l_CurNum);
      except
      end;
     end;
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   l3Free(lStream);
  end;
 end;
end;

procedure TMainForm.btCopyClick(Sender: TObject);
var
 l_Total : TDateTime;
 l_TopicListFiler: Tl3DOSFiler;

 procedure DoIndex;
 var
  l_Name     : string;
  l_Reader   : TevCustomEvdReader;
  l_Writer   : TevdCustomNativeWriter;
  l_Filter   : TddMisspellCorrectFilter;
  l_OutFiler : Tm3DBFiler;
  l_InFiler  : Tl3CustomFiler;
  l_DocID    : Integer;
  l_Doc      : Im3DBDocument;
  l_SRString : Tl3WString;
 begin//DoIndex
  l3System.MessageLevel := cMisspellReportCategory;
  l_Name := ConcatDirName(BaseDir, 'bserv001');
  f_DB := Tm3DB.Make(l_Name,
                     Yield,
                     FileMeter.ProgressProc_ev,
                     FilesMeter.ProgressProc_ev,
                     FilesProcessed,
                     FilesProcessedEx);

  try
   l_InFiler := Tl3CustomFiler.Create;
   try
    l_InFiler.Mode := l3_fmRead;
    l_Reader := TevCustomEvdReader.Create;
    try
     l_Reader.Filer := l_InFiler;
     l_Filter := TddMisspellCorrectFilter.Create;
     try
      l_Reader.Generator := l_Filter;
      l_Writer := TevdCustomNativeWriter.Create;
      try
       l_Filter.Generator := l_Writer;
       l_Writer.Binary := True;
       l_OutFiler := Tm3DBFiler.Create(f_DB);
       try
        l_OutFiler.Mode := l3_fmWrite;
        l_Writer.Filer := l_OutFiler;

        while not (l_TopicListFiler.EOF or f_Stopped) do
        begin
         l_SRString := l_TopicListFiler.Readln;
         l_DocID := ddParsePairsString(l_SRString, l_Filter);
         if l_DocID >= 0 then
         begin
          l_Doc := f_DB.GetDocument(l_DocID);
          l_InFiler.Handle := l_DocID;
          l_InFiler.COMStream := l_Doc.Open(m3_saRead, m3_dsMain);
          l_OutFiler.Handle := l_DocID;
          l_OutFiler.PartSelector := m3_dsMain;
          l_OutFiler.Index := 0;
          l_OutFiler.Open;
          try
           l3System.Msg2Log(Format('Документ #%d', [l_DocID]));
           l_Reader.Execute;
          finally
           l_InFiler.COMStream := nil;
           l_OutFiler.Close;
          end;
         end;
        end;

       finally
        FreeAndNil(l_OutFiler);
       end;
      finally
       FreeAndNil(l_Writer);
      end;
     finally
      FreeAndNil(l_Filter);
     end;
    finally
     FreeAndNil(l_Reader);
    end;
   finally
    FreeAndNil(l_InFiler);
   end;
  finally
   f_DB := nil;
  end;//try..finally
 end;//DoIndex

begin
 if FileExists(edTopicListFN.FileName) then
 begin
  l_TopicListFiler := Tl3DOSFiler.Make(edTopicListFN.FileName, l3_fmRead, False);
  try
   l_TopicListFiler.Open;
   try
    //g_AllowRaiseAbort := true;
    f_Stopped := false;
    f_InProcess := true;
    btCopy.Enabled := false;
    btStop.Enabled := true;
    try
     l_Total := 0;
     try
      DoIndex;
      if f_Stopped then
       pnStatus.Caption := 'Обработка прервана пользователем ' + TimeToStr(l_Total)
      else
       pnStatus.Caption := 'Обработка завершена ' + TimeToStr(l_Total);
     finally
      f_InProcess := false;
     end;//try..finally
    finally
     btCopy.Enabled := true;
     btStop.Enabled := false;
    end;//try..finally
    if f_NeedClose then Close;
   finally
    l_TopicListFiler.Close;
   end;
  finally
    FreeAndNil(l_TopicListFiler);
  end;
 end;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := true;
 if (f_DB <> nil) then
  f_DB.Stop;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 BaseDir := cBaseDir;
end;

function TMainForm.pm_GetBaseDir: String;
  {-}
begin
 Result := edBaseDir.Text;
end;

procedure TMainForm.pm_SetBaseDir(const aValue: String);
  {-}
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

procedure TMainForm.btStatClick(Sender: TObject);
begin
 MemoryUsageDlg.ShowModal;
end;

procedure TMainForm.btHideFileMeterClick(Sender: TObject);
begin
 FileMeter.Visible := not btHideFileMeter.Down;
end;

procedure TMainForm.FilesProcessed(aCurrentID: Long);
  {-}
begin
 with l3System do
  pnStatus.Caption := Format('local: %d global: %d objects: %d/%d',
                             [LocalMemUsed, GlobalMemUsed, ObjectCount, ObjectMemUsed]);
end;

procedure TMainForm.FilesProcessedEx(aCurrentID : Long;
                                     aMaxID     : Long;
                                     aTime      : TDateTime);
  {-}
begin
 lbPercent.Caption := IntToStr(FilesMeter.Percent) +
                               '% ' +
                               TimeToStr(aTime);
 if (FilesMeter.Percent > 0) then
  lbPercent.Caption := lbPercent.Caption +
                       ' расчетное время ' + TimeToStr((aTime) * 100 / FilesMeter.Percent);
end;

procedure TMainForm.DoBeforeIndexLoad(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Идёт расстановка разделов';
end;

procedure TMainForm.DoBeforeSort(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Расстановка разделов завершена';
end;
  
procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbNum.Caption := aStr;
end;

end.
