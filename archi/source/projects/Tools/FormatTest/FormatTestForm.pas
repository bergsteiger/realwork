unit FormatTestForm;
{$DEFINE NewFormatter}
{.$DEFINE AutoFormat}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, XPMan;

type
  TForm1 = class(TForm)
    Button1: TButton;
    listFiles: TCheckListBox;
    ProgressBar1: TProgressBar;
    btnHideGood: TButton;
    BtnRestore: TButton;
    procedure btnHideGoodClick(Sender: TObject);
    procedure BtnRestoreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure listFilesDblClick(Sender: TObject);
  private
    f_AppFolder: string;
    f_ErrorCount: Integer;
    f_EtalonFolder: string;
    f_GoodFolder: string;
    f_InFolder: string;
    f_OutFolder: string;
    f_TotalCount: Integer;
   procedure ConvertOneFile(const aInFile, aOutFile: string);
   function CompareOneFile(const OutFileName, EtalonFileName: string): Boolean;
  protected
    function WorkupFile(const aFileName: String): Boolean;
    procedure LoadFiles;
    procedure ProgressProc(Status: Byte; value: Integer; const aMsg: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses
 k2TagGen, k2reader,
 evEVDReader, evEvdWriter,
 TextPara_Const,
 l3FileUtils,
 l3Stream, l3Types,  l3Base,
 ddFileIterator, ViewForm,
 dd_lcTextFormatter,
 dd_lcTypeConverter, dd_lcSourceConverter, dd_lcVASSourceCorrector,
 dd_lcTableEliminator, dd_lcsectionEliminator, ddSpaceTrimmer, dd_lcPageNumberEliminator,
 dd_lcVASCodeCorrector, dd_lcYearCodeCorrector,
 dd_lcDateNumberFormatter, dd_lcStartDocFormatter, dd_lcTitleFormatter,
 dd_lcTextStyleCorrector, dd_lcJudgeFormatter, dd_lcResolutionFormatter,
 dd_lcCityNameFormatter, ddUtils, dd_lcTextSplitter, afSourceDetector,
 ddDocReader, afTitleCollector, afStyleReplacer, afDocumentCleaner,
 afSignFormatter, ddAutoLinkFilter, ddHTInit, afTextNormalizer,
 afEmptyParaEliminator, afDoubleSpaceFilter, afAppendixFormatter,
 afTextReplacer;

procedure TForm1.btnHideGoodClick(Sender: TObject);
var
 i: Integer;
begin
 for i:= 0 to Pred(listFiles.Items.Count) do
  if listFiles.Checked[i] then
   CopyFile(ConcatDirName(f_InFolder, listFiles.Items[i]), ConcatDirName(f_GoodFolder, listFiles.Items[i]), cmDeleteSource);
 Button1.Click;
end;

procedure TForm1.BtnRestoreClick(Sender: TObject);
begin
 MoveFiles(f_GoodFolder, f_InFolder);
 Button1.Click;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 f_AppFolder:= {ExtractFileDir}ChangeFileExt(Application.ExeName, '');
 f_InFolder:= ConcatDirName(f_AppFolder, 'in');
 f_OutFolder:= ConcatDirName(f_AppFolder, 'out');
 f_GoodFolder:= ConcatDirName(f_AppFolder, 'good');
 ForceDirectories(f_OutFolder);
 ForceDirectories(f_GoodFolder);
 PureDir(f_OutFolder);
 f_EtalonFolder:= ConcatDirName(f_AppFolder, 'etalon');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 {$IFDEF AutoFormat}
 if InitBaseEngine('c:\bases\full', 'tech2') then
 begin
 {$ENDIF}
 LoadFiles;
 {$IFDEF AutoFormat}
  DoneClientBaseEngine;
 end;
 {$ENDIF}
end;

procedure TForm1.ConvertOneFile(const aInFile, aOutFile: string);
var
 l_Gen: Tk2TagGenerator;
 l_R: Tdd_lcResolutionFormatter;
 l_J: Tdd_lcJudgeFormatter;
begin
 l3System.Msg2Log(ExtractFileName(aInFile));
 l_Gen:= nil;
 try
  TevEvdStorageWriter.SetTo(l_Gen, aOutFile);
  // Для Апелляционных судов
  {$IFNDEF AutoFormat}
  Tdd_lcJudgeFormatter.SetTo(l_Gen);
  l_J:= Tdd_lcJudgeFormatter(l_Gen);
  Tdd_lcResolutionFormatter.SetTo(l_Gen);
  l_R:= Tdd_lcResolutionFormatter(l_Gen);
  Tdd_lcDateNumberFormatter.SetTo(l_Gen);
  Tdd_lcCityFormatter.SetTo(l_Gen);
  l_R.AddBodyStartNotifier(Tdd_lcCityFormatter(l_Gen));
  Tdd_lcTitleFormatter.SetTo(l_Gen);
  Tdd_lcStartDocFormatter.SetTo(l_Gen);
  Tdd_lcTextStyleCorrector.SetTo(l_Gen);
  TlcTableEliminator2.SetTo(l_Gen);
  l_R.AddBodyStartNotifier(TlcTableEliminator2(l_Gen));
  l_J.AddBodyFinishNotifier(TlcTableEliminator2(l_Gen));
  Tdd_lcSectionEliminator.SetTo(l_Gen);
  TddSpaceTrimmerFilter.SetTo(l_Gen);
  Tdd_lcTextSplitter.SetTo(l_Gen, #10);
  l_R.AddBodyStartNotifier(Tdd_lcTextSplitter(l_Gen));
  Tdd_lcPageNumberEliminator.SetTo(l_Gen, k2_idTextPara);
  Tdd_lcVASCodeCorrector.SetTo(l_Gen);
  Tdd_lcYearCodeCorrector.SetTo(l_Gen);
  Tdd_lcTypeConverter2.SetTo(l_Gen);
  Tdd_lcTypeConverter2(l_Gen).LoadSources(ConcatDirName(f_AppFolder, 'lcSourceConvertFile.dat'));
  Tdd_lcSourceConverterFilter.SetTo(l_Gen, ConcatDirName(f_AppFolder, 'lcSourceFile.dat'));
  Tdd_lcTypeConverter.SetTo(l_Gen, ConcatDirName(f_AppFolder, 'lcTypeSyno.dat'));
  Tdd_lcVASSourceCorrector.SetTo(l_Gen);
  TevEvdStorageReader.SetTo(l_Gen, aInFile);
  TevEvdStorageReader(l_Gen).Execute;
  {$ELSE}
  // Автоформат
  //TddAutoLinkFilter.SetTo(l_Gen, nil, 'c:\bases\full\garant\autolink.dat');

  TafTextReplacer.SetTo(l_Gen, #9, ' ');
  TafSignFormatter.SetTo(l_Gen);
  TafAppendixFormatter.SetTo(l_Gen);
  TafStyleRelpacer.SetTo(l_Gen);
  TafTitleCollector.SetTo(l_Gen);
  TafEmptyParaEliminator.SetTo(l_Gen);
  TafSourceDetector.SetTo(l_Gen);
  TafTextNormalizer.SetTo(l_Gen);
  Tdd_lcSectionEliminator.SetTo(l_Gen);
  TafDocumentCleaner.SetTo(l_Gen);
  TafDoubleSpaceFilter.SetTo(l_Gen);
  TafTextReplacer.SetTo(l_Gen, #10, ' ');
  TddDocReader.SetTo(l_Gen, aInFile);
  TddDocReader(l_Gen).LiteVersion:= False;
  TddDocReader(l_Gen).Execute;
  {$ENDIF}
 finally
  FreeAndNil(l_Gen);
 end;
end;

function TForm1.CompareOneFile(const OutFileName, EtalonFileName: string):
    Boolean;

var
 lStream1 : TStream;
 lStream2 : TStream;
begin
 Result:= False;
 if FileExists(OutFileName) and FileExists(EtalonFileName) then
 begin
  lStream1 := Tl3FileStream.Create(OutFileName, l3_fmRead);
  try
   lStream2 := Tl3FileStream.Create(EtalonFileName, l3_fmRead);
   try
    Result:= l3CompareStreams(lStream1, lStream2, '%');
   finally
    FreeAndNil(lStream2);
   end;
  finally
   FreeAndNil(lStream1);
  end;
 end;
end;

procedure TForm1.listFilesDblClick(Sender: TObject);
begin
 if listFiles.ItemIndex <> -1 then
 begin
  if listFiles.Checked[listFiles.ItemIndex] then
   ShowMessage('Результат совпадает с эталоном')
  else
  // Запуск внешнего сравнивателя
  with TCompareViewForm.Create(Self) do
  try
   if Execute(ConcatDirName(f_EtalonFolder, ChangeFileExt(listFiles.Items[listFiles.ItemIndex], '.evd')), //эталон
           ConcatDirName(f_InFolder, listFiles.Items[listFiles.ItemIndex]), // исходник
           ConcatDirName(f_OutFolder, ChangeFileExt(listFiles.Items[listFiles.ItemIndex], '.evd'))) then // результат
    listFiles.Checked[listFiles.ItemIndex]:= True;
  finally
   Free;
  end;
 end; 
end;

function TForm1.WorkupFile(const aFileName: String): Boolean;
var
 l_OutFile: String;
begin
 Result := True;
 l_OutFile:= ChangeFileExt(ExtractFileName(aFileName), '.evd');
 listFiles.Items.Add(ExtractFileName(aFileName));
 ConvertOneFile(aFileName, ConcatDirName(f_OutFolder, l_OutFile));
 inc(f_TotalCount);
 if CompareOneFile(ConcatDirName(f_OutFolder, l_OutFile), ConcatDirName(f_EtalonFolder, l_OutFile)) then
  listFiles.Checked[listFiles.Items.IndexOf(l_OutFile)]:= True
 else
  Inc(f_ErrorCount);
 Application.ProcessMessages;
end;

procedure TForm1.LoadFiles;
begin
 listFiles.Clear;
 f_ErrorCount:= 0;
 f_TotalCount:= 0;
 with TddFileIterator.Make(f_InFolder, {$IFNDEF AutoFormat}'*.evd'{$ELSE}'*.doc;*.docx;*.rtf'{$ENDIF}, ProgressProc) do
 try
  OnProgress:= ProgressProc;
  l3System.Msg2Log('-= Начало обработки =-');
  IterateFiles(WorkupFile);
  l3System.Msg2Log('-= Обработка завершена =-');
 finally
  Free;
 end;
 MessageDlg(Format('Закончена обработка %d файлов. Из них %d с ошибками', [f_TotalCount, f_ErrorCount]),
            mtInformation, [mbOk], 0);
end;

procedure TForm1.ProgressProc(Status: Byte; value: Integer; const aMsg: string);
begin
 case Status of
  0: begin
      ProgressBar1.Position:= 0;
      ProgressBar1.Max:= Value;
     end;
  1: ProgressBar1.Position:= Value;
  2: ProgressBar1.Position:= Value;
 end;
end;

end.
