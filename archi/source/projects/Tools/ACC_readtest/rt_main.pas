unit rt_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Mask, ToolEdit, l3Types, l3Filer;

type
  TForm1 = class(TForm)
    deSource: TDirectoryEdit;
    Label1: TLabel;
    btnFindAttributes: TButton;
    ProgressBar: TProgressBar;
    Bevel1: TBevel;
    lblDisplay: TLabel;
    feTopicList: TFilenameEdit;
    Label2: TLabel;
    feFoundArr: TFilenameEdit;
    Label3: TLabel;
    btnCompare: TButton;
    procedure btnCompareClick(Sender: TObject);
    procedure btnFindAttributesClick(Sender: TObject);
  private
    f_Result: Tl3DOSFiler;
    procedure Disp(const aStr: AnsiString);
    procedure DoCompare;
    procedure DoFindAttributes;
    procedure ProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
    procedure DoOnSuccess(const aStr: AnsiString);
    procedure DoOnError(const aStr: AnsiString);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 l3Base,
 l3Interfaces,
 l3FileUtils,
 l3String,
 l3LongintList,
 l3StringList,
 l3Date,
 l3Chars,

 k2TagGen,
 evdWriter,
 ddHTMLReader,
 ddFileIterator,
 dd_lcAttributeParser,
 ddCSV,

 daTypes,

 dt_Const,
 dt_Types,
 dt_Sab,
 dt_LinkServ,
 dt_Doc,
 dt_Renum,
 dt_Query,
 dt_SrchQueries,
 dt_AttrSchema,

 l3LongintListPrim, l3StringListPrim;

{$R *.dfm}

const
 c_Filename = 'А03-1181-2013__20130819.htm';

procedure TForm1.btnCompareClick(Sender: TObject);
begin
 btnFindAttributes.Enabled := False;
 btnCompare.Enabled := False;
 try
  DoCompare;
 finally
  btnFindAttributes.Enabled := True;
  btnCompare.Enabled := True;
 end;
end;

procedure TForm1.btnFindAttributesClick(Sender: TObject);
begin
 btnFindAttributes.Enabled := False;
 btnCompare.Enabled := False;
 try
  DoFindAttributes;
 finally
  btnFindAttributes.Enabled := True;
  btnCompare.Enabled := True;
 end;
end;

procedure TForm1.Disp(const aStr: AnsiString);
begin
 lblDisplay.Caption := aStr;
 Application.ProcessMessages;
end;

procedure TForm1.DoCompare;
var
 I, J: Integer;
 l_DocID: Integer;
 l_TopicList: Tl3LongintList;
 l_Filer: Tl3DOSFiler;
 l_Pos: Integer;
 l_Str: Tl3WString;
 l_CSV: TddCSV;
 l_AndQ: TdtAndQuery;
 l_Date: TStDate;
 l_Q : TdtQuery;
 l_NotFoundList: Tl3StringList;
 l_FoundCount: Integer;
 l_Idx: Integer;
 l_SabCursor: ISabCursor;
begin
 if FileExists(feTopicList.FileName) then
 begin
  if FileExists(feFoundArr.FileName) then
  begin
   Disp('Загрузка данных...');
   l_TopicList := Tl3LongintList.MakeSorted;
   l_NotFoundList := Tl3StringList.MakeSorted;
   try
    l_FoundCount := 0;
    // загрузим список топиков из выборки
    l_Filer := Tl3DOSFiler.Make(feTopicList.FileName);
    try
     l_Filer.Open;
     while not l_Filer.EOF do
     begin
      l_Str := l_Filer.ReadLn;
      l3FindChar(cc_Tab, l_Str);
      l_Str := l3Trim(l_Str);
      l_DocID := l3StrToIntDef(l_Str, -1);
      if l_DocID >= 0 then
       l_TopicList.Add(l_DocID);
     end;
    finally
     FreeAndNil(l_Filer);
    end;
 
    l_CSV := TddCSV.Create(5);
    try
     l_CSV.CodePage := CP_ANSI;
     l_CSV.Load(feFoundArr.FileName);
     ProgressProc(piStart, l_CSV.RowCount, 'Поиск по атрибутам в базе данных');
     for I := 0 to l_CSV.RowCount-1 do
     begin
      l_AndQ := TdtAndQuery.Create;
      try
       l_Q := TdtDictQuery.Create(da_dlSources, l_CSV.AsInteger(I, 1));
       l_AndQ.AddQueryF(l_Q);
       l_Q := TdtDictQuery.Create(da_dlTypes, l_CSV.AsInteger(I, 2));
       l_AndQ.AddQueryF(l_Q);
       l_Q := TdtDateNumQuery.Create(0, 0, l_CSV.AsString(I, 3), dnLawCaseNum);
       l_AndQ.AddQueryF(l_Q);
       l_Date := l_CSV.AsInteger(I, 4);
       l_Q := TdtDateNumQuery.Create(l_Date, l_Date, '', dnPublish);
       l_AndQ.AddQueryF(l_Q);
       if not l_AndQ.IsEmpty then
       begin
        Inc(l_FoundCount);
        l_SabCursor := l_AndQ.FoundList.MakeSabCursor([fId_Fld]);
        if l_SabCursor.Count > 1 then
         l3System.Msg2Log('По %s найдено несколько документов в базе!', [l3Str(l_CSV.Value[I, 0])]);
        for J := 0 to l_SabCursor.Count - 1 do
        begin
         l_DocID := PDocID(l_SabCursor.GetItem(J))^;
         l_DocID := LinkServer(CurrentFamily).Renum.GetExtDocID(l_DocID);
         l_Idx := l_TopicList.IndexOf(l_DocID);
         if l_Idx >= 0 then
          l_TopicList.Delete(l_Idx);
        end;
        l_SabCursor := nil;
       end
       else
        l_NotFoundList.Add(l_CSV.Value[I, 0]);
      finally
       FreeAndNil(l_AndQ);
      end;
      ProgressProc(piCurrent, I);
     end;
    finally
     FreeAndNil(l_CSV);
    end;
    l_Filer := Tl3DOSFiler.Make(ExtractFilePath(feFoundArr.FileName)+'#compare.txt', l3_fmWrite);
    try
     l_Filer.Open;
     l_Filer.WriteLn(Format('Найдено документов в базе: %d', [l_FoundCount]));
     l_Filer.WriteLn(Format('Не найдено документов в базе: %d', [l_NotFoundList.Count]));
     l_Filer.WriteLn(Format('Не обнаружено документов из выборки: %d', [l_TopicList.Count]));
     if l_NotFoundList.Count > 0 then
     begin
      l_Filer.WriteLn('');
      l_Filer.WriteLn('Список ненайденных в базе:');
      for I := 0 to l_NotFoundList.Count-1 do
       l_Filer.WriteLn('  ' + l3Str(l_NotFoundList.ItemC[I]))
     end;
     if l_TopicList.Count > 0 then
     begin
      l_Filer.WriteLn('');
      l_Filer.WriteLn('Список не обнаруженных документов из выборки:');
      for I := 0 to l_TopicList.Count-1 do
       l_Filer.WriteLn(Format('  %d', [l_TopicList.Items[I]]));
     end;
    finally
     FreeAndNil(l_Filer);
    end;
   finally
    FreeAndNil(l_NotFoundList);
    FreeAndNil(l_TopicList);
   end;
  end
  else
   MessageDlg('Неверно указан файл с найденными атрибутами!', mtError, [mbOk], 0);
 end
 else
  MessageDlg('Неверно указан файл со списком топиков!', mtError, [mbOk], 0);
end;

procedure TForm1.DoFindAttributes;
var
 l_G: Tk2TagGenerator;
 l_FI: TddFileIterator;
 l_InFiler: Tl3DOSFiler;
 l_InDir: AnsiString;
 l_Stub: TddIterateProc;
 l_AS : Tdd_lcAttributeScaner;

 function DoOneFile(const aFilename: AnsiString): Boolean;
 begin
  Result := True;
  l_InFiler.FileName := aFilename;
  l_AS.CurFile := ExtractFileName(aFilename);
  l_InFiler.Open;
  try
   TddHTMLReader(l_G).Execute;
  finally
   l_InFiler.Close;
  end;
 end;

begin
 l_InDir := deSource.Text;
 if not DirectoryExists(l_InDir) then
 begin
  MessageDlg('Неверно указана директория!', mtError, [mbOk], 0);
  Exit;
 end;
 l_FI := TddFileIterator.Make(deSource.Text, '*.htm', ProgressProc);
 try
  f_Result := Tl3DOSFiler.Make(ConcatDirName(l_InDir, '#found.csv'), l3_fmWrite);
  try
   f_Result.Open;
   l_InFiler := Tl3DOSFiler.Create;
   try
    l_InFiler.Mode := l3_fmRead;
    l_G := nil;
    try
     l_AS := Tdd_lcAttributeScaner.SetTo(l_G);
     l_AS.OnSuccessScan := DoOnSuccess;
     l_AS.OnCannotScan := DoOnError;
     l_AS.UseFilename := True;
     TddHTMLReader.SetTo(l_G);
     TddHTMLReader(l_G).Filer := l_InFiler;
     l3System.Str2Log('');
     l3System.Msg2Log('Обработка файлов в папке %s', [l_InDir]);
     l_Stub := L2IterateFilesProc(@DoOneFile);
     try
      l_FI.IterateFiles(l_Stub);
     finally
      FreeIterateFilesProc(l_Stub);
     end;
    finally
     FreeAndNil(l_G);
    end;
   finally
    FreeAndNil(l_InFiler);
   end;
  finally
   FreeAndNil(f_Result);
  end;
 finally
  FreeAndNil(l_FI);
 end;
end;

procedure TForm1.DoOnError(const aStr: AnsiString);
begin
 l3System.Msg2Log(aStr);
end;

procedure TForm1.DoOnSuccess(const aStr: AnsiString);
begin
 f_Result.WriteLn(aStr);
end;

procedure TForm1.ProgressProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 case aState of
  piStart:
   begin
    ProgressBar.Position := 0;
    ProgressBar.Max := aValue;
    lblDisplay.Caption := aMsg;
   end;
  piCurrent: if ProgressBar.Position = aValue then
              Exit
             else
              ProgressBar.Position := aValue;
  piEnd    : ProgressBar.Position := ProgressBar.Max;
 end;
 Application.ProcessMessages;
end;

end.
