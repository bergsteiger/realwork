unit bcProcessor;

{ $Id: bcProcessor.pas,v 1.2 2016/04/12 12:44:21 fireton Exp $ }

interface
uses
 l3Types,
 l3Interfaces,
 l3ProtoObject,
 k2FileGenerator,
 k2TagGen,
 bcInterfaces,
 bcReader,
 ddTypes
 ;

type
 TbcOutFormat = (bcoEVD, bcoNSRC);

// Перемывка состоит из двух фаз:
// 1. Перемывка документов в EVD, с пополнением таблицы перекодировки топиков.
// 2. Конвертация ссылок в полученном наборе EVD, без пополнения таблицы перекодировки (ссылки ставятся только на документы,
//    которые есть в таблице), формирование выходного набора документов в заданном формате.

type
 TbcPhaseOneConverter = class(Tl3ProtoObject, IbcTopicCounterProvider)
 private
  f_CurTopic: Il3CString;
  f_ErrorFolder: AnsiString;
  f_FileProgressProc: Tl3ProgressProc;
  f_Gen: Tk2TagGenerator;
  f_OnError: TddErrorEvent;
  f_Reader: TbcReader;
  f_SettingsPath: AnsiString;
  f_Writer: Tk2CustomFileGenerator;
  f_TD: IbcTopicDispatcher;
  f_TotalProgressProc: Tl3ProgressProc;
  procedure BuildPipe;
  procedure CurTopicHandler(const aTopic: Il3CString);
  procedure ErrorHandler(const aMsg: AnsiString; aLevel: Integer = 0);
  function pm_GetTopicCount: Integer;
  procedure pm_SetFileProgressProc(const Value: Tl3ProgressProc);
  procedure pm_SetOnError(const Value: TddErrorEvent);
  procedure pm_SetTotalProgressProc(const Value: Tl3ProgressProc);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aTD: IbcTopicDispatcher; const aSettingsPath: AnsiString);
  procedure Process(const aInDir, aOutDir: AnsiString; anAddMode: Boolean);
  property FileProgressProc: Tl3ProgressProc read f_FileProgressProc write pm_SetFileProgressProc;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
  property ErrorFolder: AnsiString read f_ErrorFolder write f_ErrorFolder;
  property TopicCount: Integer read pm_GetTopicCount;
  property TotalProgressProc: Tl3ProgressProc read f_TotalProgressProc write pm_SetTotalProgressProc;
 end;

procedure BCPhaseTwoProcess(const aInDir, aOutDir: AnsiString; aFormat: TbcOutFormat; const aTD: IbcTopicDispatcher;
 aErrorHandler: TddErrorEvent; aTotalProgressProc, aPerFileProgressProc: Tl3ProgressProc);

implementation
uses
 SysUtils,
 l3Base,
 l3FileUtils,
 l3Filer,
 l3String,
 l3LongintList,
 l3LongintListPrim,

 evdWriter,
 evdReader,
 evNestedDocumentEliminator,
 evSimpleTextPainter,

 ddFileIterator,
 ddNSRC_w,
 ddUtils,

 bcLinksFilter,
 bcBitmapHandleFilter,
 bcAngleBracketsFilter,
 bcCutLongParaFilter,
 bcBlueUnderlineEliminator
 ;

procedure LoadListFromFile(const aFN: AnsiString; const aList: Tl3LongintList);
var
 l_Filer: Tl3DOSFiler;
 l_Topic: Integer;
begin
 l_Filer := Tl3DOSFiler.Make(aFN);
 try
  l_Filer.Open;
  while not l_Filer.EOF do
  begin
   l_Topic := l3StrToIntDef(l3Trim(l_Filer.ReadLn), 0);
   if l_Topic > 0 then
    aList.Add(l_Topic);
  end;
 finally
  FreeAndNil(l_Filer);
 end;
end;

procedure SaveListToFile(const aFN: AnsiString; const aList: Tl3LongintList);
var
 I: Integer;
 l_Filer: Tl3DOSFiler;
begin
 l_Filer := Tl3DOSFiler.Make(aFN, l3_fmWrite);
 try
  l_Filer.Open;
  for I := 0 to aList.Hi do
   l_Filer.WriteLn(IntToStr(aList.Items[I]));
 finally
  FreeAndNil(l_Filer);
 end;
end;

constructor TbcPhaseOneConverter.Create(const aTD: IbcTopicDispatcher; const aSettingsPath: AnsiString);
begin
 inherited Create;
 f_TD := aTD;
 f_SettingsPath := aSettingsPath;
end;

procedure TbcPhaseOneConverter.BuildPipe;
begin
 f_Writer := TevdNativeWriter.SetTo(f_Gen);
 TevdNativeWriter(f_Writer).Binary := True;
 TbcBitmapHandleFilter.SetTo(f_Gen, f_TD);
 TbcBlueUnderlineEliminator.SetTo(f_Gen);
 TevNestedDocumentEliminator.SetTo(f_Gen);
 f_Reader := TbcReader(TbcReader.SetTo(f_Gen, f_SettingsPath, f_TD, ErrorHandler));
 f_Reader.OnCurTopic := CurTopicHandler;
 f_Reader.ErrorFolder := ErrorFolder;
end;

procedure TbcPhaseOneConverter.Cleanup;
begin
 f_TD := nil;
 FreeAndNil(f_Gen);
 inherited;
end;

procedure TbcPhaseOneConverter.CurTopicHandler(const aTopic: Il3CString);
begin
 // l3System.Msg2Log('# %s', [l3Str(aTopic)]);
 f_CurTopic := aTopic;
end;

procedure TbcPhaseOneConverter.ErrorHandler(const aMsg: AnsiString; aLevel: Integer = 0);
var
 l_Str: AnsiString;
begin
 l_Str := Format('Топик %s : %s', [l3Str(f_CurTopic), aMsg]);
 if Assigned(f_OnError) then
  f_OnError(l_Str, aLevel)
 else
  l3System.Msg2Log(l_Str);
end;

function TbcPhaseOneConverter.pm_GetTopicCount: Integer;
begin
 if f_Gen <> nil then
  Result := f_Reader.TopicCount
 else
  Result := 0; 
end;

procedure TbcPhaseOneConverter.pm_SetFileProgressProc(const Value: Tl3ProgressProc);
begin
 f_FileProgressProc := Value;
 FreeAndNil(f_Gen);
end;

procedure TbcPhaseOneConverter.pm_SetOnError(const Value: TddErrorEvent);
begin
 f_OnError := Value;
 FreeAndNil(f_Gen);
end;

procedure TbcPhaseOneConverter.pm_SetTotalProgressProc(const Value: Tl3ProgressProc);
begin
 f_TotalProgressProc := Value;
 FreeAndNil(f_Gen);
end;

procedure TbcPhaseOneConverter.Process(const aInDir, aOutDir: AnsiString; anAddMode: Boolean);
var
 l_FI: TddFileIterator;
 l_TopicsFileName: AnsiString;
 l_IterFunc: TddIterateProc;

 function ConvertOne(const aFileName: AnsiString): Boolean;
 var
  l_OutFN : AnsiString;
  l_BaseFN: AnsiString;
  l_Filer: Tl3DOSFiler;
  l_Idx: Integer;
  l_OldCount: Integer;
 begin
  Result := True;
  l3System.Msg2Log('Обработка файла %s', [aFileName]);
  l_BaseFN := ChangeFileExt(ExtractFileName(aFileName), '');
  l_OutFN := ConcatDirName(aOutDir, l_BaseFN + '.evd');
  l_Idx := 0;
  while FileExists(l_OutFN) do
  begin
   Inc(l_Idx);
   l_OutFN := ConcatDirName(aOutDir, Format('%s_%d.evd', [l_BaseFN, l_Idx]));
  end;
  l_Filer := Tl3DOSFiler.Make(aFileName, l3_fmRead, False);
  try
   f_Reader.Filer := l_Filer;
   f_Reader.CurrentFile := Copy(aFilename, Length(aInDir) + 2, MaxInt);
   if Assigned(f_FileProgressProc) then
   begin
    l_Filer.Indicator.NeedProgressProc := True;
    l_Filer.Indicator.OnProgressProc := f_FileProgressProc;
   end;
  finally
   FreeAndNil(l_Filer);
  end;
  l_Filer := Tl3DOSFiler.Make(l_OutFN, l3_fmWrite, False);
  try
   f_Writer.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;
  l_OldCount := f_Reader.TopicCount;
  f_Reader.Execute;
  if f_Reader.TopicCount = l_OldCount then // не было преобразовано ни одного топика, удаляем пустой файл
   DeleteFile(l_OutFN);
 end;

begin
 l_TopicsFileName := ConcatDirName(aOutDir, 'doclist.txt');
 if f_Gen = nil then
 begin
  BuildPipe;
  if anAddMode then
  begin
   if FileExists(l_TopicsFileName) then
    LoadListFromFile(l_TopicsFileName, f_Reader.TopicList)
   else
   begin
    l3System.Msg2Log('Не могу дополнить результат, не найден doclist.txt - очищаю папку результата');
    anAddMode := False;
   end;
  end;
 end;

 if not anAddMode then
 begin
  f_Reader.TopicList.Clear;
  PureDir(aOutDir);
 end;

 l_FI := TddFileIterator.Make(aInDir, '*.t??', f_TotalProgressProc, True);
 try
  if l_FI.Count = 0 then
  begin
   l3System.Msg2Log('В указанной директории не найден ни один файл (*.t??)');
   Exit;
  end;
  l3System.Msg2Log('Начало конвертации %d файлов в директории %s', [l_FI.Count, aInDir]);
  l_IterFunc := L2IterateFilesProc(@ConvertOne);
  try
   l_FI.IterateFiles(l_IterFunc);
  finally
   FreeIterateFilesProc(l_IterFunc);
  end;
  l3System.Msg2Log('Обработка завершена. Преобразовано %s.', [NumSuffix(f_Reader.TopicCount, 'документ', 'документа', 'документов')]);
 finally
  FreeAndNil(l_FI);
 end;
 SaveListToFile(l_TopicsFileName, f_Reader.TopicList);
end;

procedure BCPhaseTwoProcess(const aInDir, aOutDir: AnsiString; aFormat: TbcOutFormat; const aTD: IbcTopicDispatcher;
 aErrorHandler: TddErrorEvent; aTotalProgressProc, aPerFileProgressProc: Tl3ProgressProc);
var
 l_Writer: Tk2CustomFileGenerator;
 l_Reader: TevdNativeReader;
 l_OutExt: AnsiString;

 function ProcessOne(const aFileName: AnsiString): Boolean;
 var
  l_OutFN : AnsiString;
  l_BaseFN: AnsiString;
  l_Filer: Tl3DOSFiler;
  l_Idx: Integer;
 begin
  Result := True;
  l_BaseFN := ChangeFileExt(ExtractFileName(aFileName), '');
  l_OutFN := ConcatDirName(aOutDir, l_BaseFN + l_OutExt);
  l_Filer := Tl3DOSFiler.Make(aFileName, l3_fmRead, False);
  try
   l_Reader.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;
  l_Filer := Tl3DOSFiler.Make(l_OutFN, l3_fmWrite, False);
  try
   if Assigned(aPerFileProgressProc) then
   begin
    l_Filer.Indicator.NeedProgressProc := True;
    l_Filer.Indicator.OnProgressProc := aPerFileProgressProc;
   end;
   l_Writer.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;
  l_Reader.Execute;
 end;

var
 l_FI: TddFileIterator;
 l_Gen: Tk2TagGenerator;
 l_IterFunc: TddIterateProc;
begin
 l_Gen := nil;
 try
  case aFormat of
   bcoEVD:
    begin
     l_Writer := TevdNativeWriter.SetTo(l_Gen);
     l_OutExt := '.evd';
    end;
   bcoNSRC:
    begin
     l_Writer := TddNSRCGenerator.SetTo(l_Gen);
     TddNSRCGenerator(l_Writer).ExportDirectory := aOutDir;
     TevSimpleTextPainter.SetTo(l_Gen);
     TbcCutLongParaFilter.SetTo(l_Gen);
     l_OutExt := '.nsr';
    end;
  end; // case
  TbcAngleBracketsFilter.SetTo(l_Gen, aTD);
  TbcLinksFilter.SetTo(l_Gen, aTD, aErrorHandler);
  l_Reader := TevdNativeReader.SetTo(l_Gen);
  l_FI := TddFileIterator.Make(aInDir, '*.evd', aTotalProgressProc);
  try
   l_IterFunc := L2IterateFilesProc(@ProcessOne);
   try
    l_FI.IterateFiles(l_IterFunc);
   finally
    FreeIterateFilesProc(l_IterFunc);
   end;
  finally
   FreeAndNil(l_FI);
  end;
 finally
  FreeAndNil(l_Gen);
 end;
end;

(*
procedure BCProcessDir(const aInDir, aOutDir: AnsiString; aDoAdd: Boolean);
var
 I: Integer;
 f_Gen: Tk2TagGenerator;
 f_TD : IbcTopicDispatcher;
 f_TDPath: AnsiString;
 l_SettingsPath: AnsiString;
 f_Writer: Tk2CustomFileGenerator;
 l_OutExt: AnsiString;
 l_FI: TddFileIterator;

 l_OutDir: AnsiString;
 l_SourceDir: AnsiString;
 l_ExistTopics: Tl3LongintList;
 l_TopicsFileName: AnsiString;
 f_Reader: TbcReader;

 function ConvertOne(const aFileName: AnsiString): Boolean;
 var
  l_OutFN : AnsiString;
  l_BaseFN: AnsiString;
  l_Filer: Tl3DOSFiler;
  l_Idx: Integer;
 begin
  Result := True;
  l3System.Msg2Log('Обработка файла %s', [aFileName]);
  l_BaseFN := ChangeFileExt(ExtractFileName(aFileName), '');
  l_OutFN := ConcatDirName(l_OutDir, l_BaseFN + l_OutExt);
  l_Idx := 0;
  while FileExists(l_OutFN) do
  begin
   Inc(l_Idx);
   l_OutFN := ConcatDirName(l_OutDir, Format('%s_%d%s', [l_BaseFN, l_Idx, l_OutExt]));
  end;
  l_Filer := Tl3DOSFiler.Make(aFileName, l3_fmRead, False);
  try
   f_Reader.Filer := l_Filer;
   f_Reader.CurrentFile := Copy(aFilename, Length(l_SourceDir) + 2, MaxInt);
   l_Filer.Indicator.NeedProgressProc := True;
   l_Filer.Indicator.OnProgressProc := DoPerFileProgress;
  finally
   FreeAndNil(l_Filer);
  end;
  l_Filer := Tl3DOSFiler.Make(l_OutFN, l3_fmWrite, False);
  try
   f_Writer.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;
  f_Reader.Execute;
 end;

begin
 l_OutDir := deResult.Text;

 if not f_RunFromCmdLine then
  l3System.Str2Log('');

 l_TopicsFileName := ConcatDirName(l_OutDir, 'doclist.txt');
 l_ExistTopics := Tl3LongintList.MakeSorted;
 try
  if cbAppendResult.Checked then
  begin
   if FileExists(l_TopicsFileName) then
    LoadListFromFile(l_TopicsFileName, l_ExistTopics)
   else
   begin
    l3System.Msg2Log('Не могу дополнить результат, не найден doclist.txt - очищаю папку результата');
    PureDir(l_OutDir);
   end;
  end
  else
   PureDir(l_OutDir);
  {
  l_FI := TddFileIterator.MakeFolders(deSource.Text, '_result', DoProgress, True);
  try
   for I := 0 to l_FI.Count-1 do
    PureDir(l_Fi.FileList[I]);
  finally
   FreeAndNil(l_FI);
  end;
  }

  btnDoThings.Enabled := False;
  Update;
  l_FI := TddFileIterator.Make(l_SourceDir, '*.t??', DoProgress, True);
  try
   if l_FI.Count = 0 then
   begin
    ShowError('В указанной директории не найден ни один файл (*.t??)');
    Exit;
   end;
   l3System.Msg2Log('Начало конвертации %d файлов в директории %s', [l_FI.Count, l_SourceDir]);
   InitDB;
   try
    f_TDPath := ExtractFilePath(ParamStr(0)) + 'BELCONTD';
    f_TD := TbcTopicDispatcher.Make(f_TDPath);

    l_SettingsPath := ExtractFilePath(ParamStr(0)) + 'belacon.dat';

    f_Gen := nil;
    try
     case rgFormat.ItemIndex of
      0:
       begin
        f_Writer := TevdNativeWriter.SetTo(f_Gen);
        l_OutExt := '.evd';
       end;
      1:
       begin
        f_Writer := TddNSRCGenerator.SetTo(f_Gen);
        TddNSRCGenerator(f_Writer).ExportDirectory := l_OutDir;
        TevSimpleTextPainter.SetTo(f_Gen);
        TbcCutLongParaFilter.SetTo(f_Gen);
        l_OutExt := '.nsr';
       end;
     end;
     TbcAngleBracketsFilter.SetTo(f_Gen, f_TD);

     TbcBitmapHandleFilter.SetTo(f_Gen, f_TD);
     TevNestedDocumentEliminator.SetTo(f_Gen);
     f_Reader := TbcReader(TbcReader.SetTo(f_Gen, l_SettingsPath, f_TD, l_ExistTopics, ErrorHandler));
     f_Reader.OnCurTopic := CurTopicHandler;
     f_Reader.ErrorFolder := ConcatDirName(l_OutDir, '_errors');
     l_IterFunc := L2IterateFilesProc(@ConvertOne);
     try
      l_FI.IterateFiles(l_IterFunc);
     finally
      FreeIterateFilesProc(l_IterFunc);
     end;
     l3System.Msg2Log('Обработка завершена. Преобразовано %s.', [NumSuffix(f_Reader.TopicCount, 'документ', 'документа', 'документов')]);
    finally
     FreeAndNil(f_Gen);
     f_Reader := nil;
    end;
   finally
    f_TD := nil;
    DoneDB;
   end;
  finally
   btnDoThings.Enabled := True;
   FreeAndNil(l_FI);
  end;
  SaveListToFile(l_TopicsFileName, l_ExistTopics);
 finally
  FreeAndNil(l_ExistTopics);
 end;
end;
*)

end.