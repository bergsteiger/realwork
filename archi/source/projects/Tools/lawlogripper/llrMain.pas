unit llrMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ToolEdit, Mask, ComCtrls, ExtCtrls,

  l3LongintList,
  l3RegEx,

  ddFileIterator,
  ddAppConfigTypes,
  ddAppConfig;

type
  TForm1 = class(TForm)
    pnlButtons: TPanel;
    ProgressBar: TProgressBar;
    pnlControls: TPanel;
    btnStart: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    f_Aborted: Boolean;
    f_AllGzips: TddFileIterator;
    f_Node: TddCustomConfigNode;
    f_ReTopic: Tl3RegularSearch;
    f_REFilename: Tl3RegularSearch;
    f_Topics: Tl3LongintList;
    procedure FindGzipFiles;
    function LoadTopicNumbers: Boolean;
    function ProcessOneLogfile(const aFilename: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 l3Types,
 l3Base,
 l3FileUtils,
 ddAppConfigStrings,
 ddAppConfigConst,
 afwVCL, l3LongintListPrim, l3Stream, l3Parser, l3PrimString, StrUtils;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
 l_C: TddContainerConfigItem;
 l_FNC: TddFileNameConfigItem;
begin
 AfwHackControlFont(Self);
 ddAppConfiguration:= TddAppConfiguration.Create();
 with ddAppConfiguration do
 begin
  f_Node:= AddNode('General', 'Настройки');
  l_C := AddContainerGroup('SearchMode', 'Режим поиска') as TddContainerConfigItem;
   l_C.AddCase('Файл с топиками');
    l_FNC := TddFileNameConfigItem.Make('SourceFile', 'Исходный файл с топиками');
    l_FNC.FilterMask := 'Текстовые файлы (*.txt)|*.txt';
    l_C.Add(l_FNC);
   l_C.AddCase('Одиночный топик');
    l_C.Add(TddStringConfigItem.Create('SourceTopic', 'Номер топика', ddEmptyValue));
  CloseGroup;
  
  AddFolderNameItem('LogsFolder', 'Папка с логами NSRCSPY');
  AddFolderNameItem('GzipFolder', 'Папка с исходными GZIP');
  AddFolderNameItem('DestinationFolder', 'Папка для скопированных GZIP');
  Load;
  f_Node.CreateFrame(pnlControls, 0);
  f_Node.SetControlValues(False);
 end;
 f_REFilename := Tl3RegularSearch.Create;
 f_REFilename.SearchPattern := 'Обработка.+\\\d+{\\.+\.gz} начата';
 f_RETopic := Tl3RegularSearch.Create;
 f_RETopic.SearchPattern := 'Начался документ № {\d+}';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 l3Free(ddAppConfiguration);
 l3Free(f_REFilename);
 l3Free(f_RETopic);
 l3Free(f_Topics);
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
 f_Node.GetControlValues;
 ddAppConfiguration.Save;
 btnStart.Enabled:= False;
 try
  FindGzipFiles;
 finally
  btnStart.Enabled:= True;
 end;
end;

procedure TForm1.FindGzipFiles;
var
 l_FI: TddFileIterator;
 l_Total: Integer;
 l_Topic: Integer;
begin
 if f_Topics = nil then
  f_Topics := Tl3LongintList.MakeSorted;
 f_Topics.Clear;
 case ddAppConfiguration.AsInteger['SearchMode'] of
  0: if not LoadTopicNumbers then
      Exit;
  1: begin
      l_Topic := StrToIntDef(Trim(ddAppConfiguration.AsString['SourceTopic']), 0);
      if l_Topic > 0 then
       f_Topics.Add(l_Topic)
      else
       Exit;
     end;
 end;
 l_Total := f_Topics.Count;
 f_AllGzips := TddFileIterator.Make(ddAppConfiguration.AsString['GzipFolder'], '*.gz');
 try
  f_AllGzips.WithSubDir := True;
  f_AllGzips.LoadFiles;
  l_FI := TddFileIterator.Make(ddAppConfiguration.AsString['LogsFolder'], 'nsrcspy.log*.*');
  try
   l_FI.LoadFiles;
   ProgressBar.Max := l_FI.TotalSize;
   ProgressBar.Position := 0;
   l_FI.IterateFiles(ProcessOneLogfile);
  finally
   l3Free(l_FI);
  end;
  if f_Topics.Count = 0 then
   MessageDlg('Найдены все топики.', mtInformation, [mbOK], 0)
  else
   MessageDlg(Format('Найдено %d топиков из %d.', [l_Total-f_Topics.Count, l_Total]), mtWarning, [mbOK], 0);
 finally
  l3Free(f_AllGzips);
 end;
end;

function TForm1.LoadTopicNumbers: Boolean;
var
 l_FS: Tl3FileStream;
 l_Parser: Tl3Parser;
 l_Topic: Integer;
begin
 Result := False;
 if FileExists(ddAppConfiguration.AsString['SourceFile']) then
 begin
  l_FS := Tl3FileStream.Create(ddAppConfiguration.AsString['SourceFile'], l3_fmRead);
  try
   l_Parser := Tl3Parser.Create(nil);
   try
    l_Parser.CheckFloat := false;
    l_Parser.CheckFiler.Stream := l_FS;
    l_Parser.NextTokenSp;
    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      try
       l_Topic := l_Parser.TokenInt; {- 100000};
       f_Topics.Add(l_Topic);
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
   l3Free(l_FS);
  end;
  Result := f_Topics.Count > 0;
 end
 else
  MessageDlg('Файл не найден: '+ddAppConfiguration.AsString['SourceFile'], mtError, [mbOk], 0);
end;

function TForm1.ProcessOneLogfile(const aFilename: string): Boolean;
var
 l_TS: Tl3TextStream;
 l_Str: string;
 l_Filename: string;
 l_RealFilename: string;
 l_Topic: Longint;
 l_MP: Tl3MatchPosition;
 l_TIdx: Integer;
 I: Integer;
begin
 l_TS := Tl3TextStream.Create(aFilename, l3_fmRead);
 try
  while not (l_TS.IsEof or f_Aborted or (f_Topics.Count = 0)) do
  begin
   l_Str := l_TS.GetLine;
   ProgressBar.StepBy(Length(l_Str)+2);
   Application.ProcessMessages;
   if f_REFilename.SearchInString(PChar(l_Str), 0, Length(l_Str), l_MP) then
    l_Filename := f_REFilename.TagParts[0].AsString
   else
    if f_ReTopic.SearchInString(PChar(l_Str), 0, Length(l_Str), l_MP) then
    begin
     l_Topic := StrToIntDef(f_ReTopic.TagParts[0].AsString, 0);
     if (l_Topic <> 0)  then
     begin
      l_TIdx := f_Topics.IndexOf(l_Topic);
      if l_TIdx <> -1 then
      begin
       for I := 0 to f_AllGzips.FileList.Count-1 do
        if l3IsSameFileName(l_Filename, f_AllGzips.FileList[I]) then
        begin
         CopyFile(f_AllGzips.FileList[I],
                  ConcatDirName(ddAppConfiguration.AsString['DestinationFolder'], IntToStr(l_Topic)+'.gz'),
                  cmNoBakCopy);
         f_Topics.Delete(l_TIdx);
        end;
      end;
     end;
    end;
  end;
 finally
  l3Free(l_TS);
 end;
 if f_Topics.Count = 0 then
  f_Aborted := True;
 Result := not f_Aborted;
end;

procedure TForm1.btnCancelClick(Sender: TObject);
begin
 if btnStart.Enabled then
  Close
 else
  f_Aborted:= True;
end;

end.
