unit g2nGrinder;

{ $Id: g2nGrinder.pas,v 1.3 2015/04/27 09:19:00 fireton Exp $ }

interface
uses
 l3Types,
 l3ProtoObject,
 l3IniFile,

 ddFileIterator;

type
 Tg2nGrinder = class(Tl3ProtoObject)
 private
  f_DocTitle: string;
  f_Errors: Integer;
  f_Iterator: TddFileIterator;
  f_OutDir: string;
  f_Ini   : Tl3IniFile;
  procedure FileProgressProc(aState: Byte; aValue: Long; const aMsg: AnsiString = '');
  procedure DoGetDocID(out theDocID: Integer);
  procedure DoGetTitle(out theTitle: string);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aInDir, aOutDir: string; aProgressProc: Tl3ProgressProc);
  procedure Execute;
  property Errors: Integer read f_Errors write f_Errors;
 end;

implementation
uses
 SysUtils,
 
 l3Base,
 l3Filer,
 l3FileUtils,

 k2TagGen,
 k2Reader,

 evdWriter,
 evSimpleTextPainter,

 ddRTFReader,
 ddNSRC_w,

 g2nHeaderGenerator,
 g2nPicObjIDProvider;

constructor Tg2nGrinder.Create(const aInDir, aOutDir: string; aProgressProc: Tl3ProgressProc);
begin
 inherited Create;
 f_Iterator := TddFileIterator.Make(aInDir, '*.rtf', FileProgressProc);
 f_Iterator.OnProgress := aProgressProc;
 f_Ini := Tl3IniFile.Create;
 f_Ini.Section := 'Preferences';
 f_OutDir := aOutDir;
end;

procedure Tg2nGrinder.Cleanup;
begin
 FreeAndNil(f_Iterator);
 FreeAndNil(f_Ini);
 inherited;
end;

procedure Tg2nGrinder.DoGetDocID(out theDocID: Integer);
begin
 theDocID := f_Ini.ReadParamIntDef('NextDocID', 50000);
 f_Ini.WriteParamInt('NextDocID', theDocID + 1);
end;

procedure Tg2nGrinder.DoGetTitle(out theTitle: string);
begin
 theTitle := f_DocTitle;
end;

procedure Tg2nGrinder.Execute;
var
 l_G: Tk2TagGenerator;
 l_InFiler: Tl3DOSFiler;
 l_OutFiler: Tl3DOSFiler;

 procedure RebuildPipe;
 begin
  FreeAndNil(l_G);
  {}
  TddNSRCGenerator.SetTo(l_G);
  TddNSRCGenerator(l_G).Filer := l_OutFiler;
  TddNSRCGenerator(l_G).ExportDirectory := f_OutDir;

  {
  TevdNativeWriter.SetTo(l_G);
  TevdNativeWriter(l_G).Binary := False;
  TevdNativeWriter(l_G).Filer := l_OutFiler;
  {}
  TevSimpleTextPainter.SetTo(l_G);
  Tg2nHeaderGenerator.SetTo(l_G);
  Tg2nHeaderGenerator(l_G).OnGetDocID := DoGetDocID;
  Tg2nHeaderGenerator(l_G).OnGetTitle := DoGetTitle;
  Tg2nPicObjIDProvider.SetTo(l_G);
  Tg2nPicObjIDProvider(l_G).OnGetDocID := DoGetDocID;
  {}
  TddRTFReader.SetTo(l_G);
  TddRTFReader(l_G).EnablePictures := True;
  TddRTFReader(l_G).Filer := l_InFiler;
 end;

 function l_DoOne(const aFileName: AnsiString): Boolean;
 var
  l_Str: string;
  l_Idx: Integer;
  l_OutName: string;
 begin
  if l_OutFiler.Opened then
   l_OutFiler.Close;
  l_InFiler.FileName := aFilename;
  l_Str := ExtractFileName(aFileName);
  l_OutName := ConcatDirName(f_OutDir, ChangeFileExt(l_Str, {'.evd'}'.nsr'));
  l_OutFiler.FileName := l_OutName;
  l_Idx := Pos('_Текст.rtf', l_Str);
  if l_Idx > 0 then
   f_DocTitle := Copy(l_Str, 1, l_Idx-1)
  else
   f_DocTitle := '';
  l_OutFiler.Open;
  try
   Tk2CustomFileParser(l_G).Execute;
  except
   on E: Exception do
   begin
    l3System.Msg2Log('ОШИБКА: файл %s не преобразован: %s', [aFilename, E.Message]);
    RebuildPipe;
    DeleteFile(l_OutName);
    Inc(f_Errors);
   end;
  end;
  Result := True;
 end;
var
 l_IterFunc: TddIterateProc;
begin
 l_IterFunc := L2IterateFilesProc(@l_DoOne);
 try
  l_G := nil;
  f_Errors := 0;
  l_InFiler := Tl3DOSFiler.Create;
  try
   l_OutFiler := Tl3DOSFiler.Create;
   try
    l_OutFiler.Mode := l3_fmWrite;
    try
     RebuildPipe;
     l3System.Str2Log('');
     l3System.Msg2Log('Запуск перемывки %d файлов ГОСТ', [f_Iterator.Count]);
     f_Iterator.IterateFiles(l_IterFunc);
     l3System.Msg2Log('Работа завершена');
    finally
     FreeAndNil(l_G);
    end;
   finally
    FreeAndNil(l_OutFiler);
   end;
  finally
   FreeAndNil(l_InFiler);
  end;
 finally
  FreeIterateFilesProc(l_IterFunc);
 end;
end;

procedure Tg2nGrinder.FileProgressProc(aState: Byte; aValue: Long; const aMsg: AnsiString = '');
begin
 // TODO -cMM: Tg2nGrinder.FileProgressProc default body inserted
end;

end.