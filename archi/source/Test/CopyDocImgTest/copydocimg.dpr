program copydocimg;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Math,
  ddFileIterator,
  l3Types,
  l3Base,
  l3FileUtils,
  ddUtils,
  vtDebug;

const
 cImageStorePath = '\\lin-store\work\CRDR\ArchiImageStore';
 cImageCachePath = '\\archi\archi\DocImagesCache';
 cTIFFImageExt = '.tif';
 cImageContainerExt = '.aic';
 MaxAvail = 64*1024;

procedure ImgCopyFileEx(Sour, Dest: TFileName; ProgressProc: Tl3ProgressProc; CopyMode: Byte =
    cmWriteOver);
var
 FromF, ToF          : Integer;
 NumRead, NumWritten : Integer;
 buf                 : Pointer;
 BufSize             : LongInt;
 FAge                : Longint;
 FAttr               : Integer;
 l_ErrStr            : string;
 TmpName             : TFileName;
 TmpLog              : Boolean;
 l_TotalWritten,
 l_FileSize          : Int64;
Begin
 TmpLog := False;
 if (Length(Dest) = 0) then
  raise Exception.Create('Не задано имя целевого файла');
 if (Length(Sour) = 0) or (Length(Dest) = 0) or not FileExists(Sour) then
  raise Exception.CreateFmt('Неверное имя файла "%s"', [Sour]);
 BufSize := Min(MaxAvail, 32 * 1024);
 l3System.GetLocalMem(buf, BufSize);
 try
   FAttr := FileGetAttr(Sour);
   FromF := FileOpen(Sour, fmShareDenyWrite);
   if (FromF < 0) then
   begin
    {$IfOpt D+}
    l3System.Msg2Log('Не могу открыть ' + Sour);
    RaiseLastOSError;
    {$Else  D+}
    raise EInOutError.Create('Не могу открыть'#13 + Sour);
    {$EndIf D+}
   end;//FromF < 0
   FAge := FileGetDate(FromF);
   try
    if ((CopyMode and cmAppend) <> 0) and FileExists(Dest) then
    begin
     ToF := FileOpen(Dest,fmOpenWrite);
     FileSeek(ToF, 0, 2);
     TmpLog := False;
    end // if ((CopyMode and cmAppend) <> 0) and FileExists(Dest) then
    else
    begin
     TmpName := ChangeFileExt(Dest, '.tmp');
     MakeDir(ExtractFilePath(Dest));
     ToF := FileCreate(TmpName);
     TmpLog := True;
    end;
    l_FileSize := GetFileSize(Sour);
    l_TotalWritten := 0;
    if Assigned(ProgressProc) then
     ProgressProc(0, 100, ExtractFileName(Sour));
    try
     repeat
      NumRead := FileRead(FromF, buf^, BufSize);
      if NumRead < 0 then
      begin
       l_ErrStr := SysErrorMessage(GetLastError);
       raise EInOutError.CreateFmt('Ошибка чтения файла %s (%s)', [Sour, l_ErrStr]);
      end; //
      NumWritten := FileWrite(ToF, buf^, NumRead);
      if NumWritten = -1 then
      begin
       l_ErrStr := SysErrorMessage(GetLastError);
       raise EInOutError.CreateFmt('Ошибка при записи в файл %s (%s)', [Dest, l_ErrStr]);
      end; // if NumWritten = -1 then
      Inc(l_TotalWritten, NumWritten);
      if Assigned(ProgressProc) and (l_FileSize <> 0) then
       ProgressProc(1, l_TotalWritten * 100 div l_FileSize);
     until (NumRead = 0) or (NumWritten <> NumRead);
     FileSetDate(ToF, FAge);
    finally
     FileClose(ToF);
     if Assigned(ProgressProc) then
      ProgressProc(2, 100);
    end;
    if l_TotalWritten <> l_FileSize then
     raise EInOutError.CreateFmt('Не совпадает размер файла %s %d <> %d', [Sour, l_FileSize, l_TotalWritten]);
    if TmpLog then
    begin
     if (CopyMode and cmNoBakCopy) <> 0 then
      DeleteFile(Dest);
     RenameFileSafe(TmpName, Dest);
    end; // if TmpLog then
    FileSetAttr(Dest,FAttr);
   finally
    FileClose(FromF);
   end;
   if (CopyMode and cmDeleteSource) <> 0 then
    DeleteFile(Sour);
 finally
  l3System.FreeLocalMem(buf);
 end;
end;

function CommitImageCacheTest: Boolean;
var
 l_FI: TddFileIterator;
 l_IterFunc: TddIterateProc;
 l_Success : Boolean;
 l_Time: Int64;
 l_Elapsed: Double;
 l_Str: AnsiString;

 function MoveOne(const aFileName: AnsiString): Boolean;
 var
  l_DestFN: AnsiString;
  l_LocalFN: AnsiString;
  l_LocTime: Int64;
  l_FSize: Int64;
  l_LocElapsed: Double;
  l_SpeedStr: AnsiString;
 begin
  Result := True;
  try
   l_LocalFN := ExtractRelativePath(IncludeTrailingBackslash(cImageCachePath), aFileName);
   l3System.Msg2Log('  > %s', [l_LocalFN]);
   l_LocTime := dbgStartTimeCounter;
   l_DestFN := ConcatDirName(cImageStorePath, l_LocalFN);
   DeleteFile(ChangeFileExt(l_DestFN, cTIFFImageExt)); // чтобы удалить те образы, которые уже есть в хранилище
   DeleteFile(ChangeFileExt(l_DestFN, cImageContainerExt)); // удалять по маске - НЕЛЬЗЯ! (слишком долго, если много файлов, ибо поиск)
   l3System.Msg2Log(dbgFinishTimeCounter(l_LocTime, '    Удаление старых копий в хранилище - %d мс'));
   l_LocTime := dbgStartTimeCounter;
   l_FSize := GetFileSize(aFileName);
   ImgCopyFileEx(aFileName, l_DestFN, nil, cmWriteOver + cmNoBakCopy{ + cmDeleteSource});
   l_LocTime := dbgGetElapsed(l_LocTime);
   l_Elapsed := l_LocTime / 1000;
   if l_Elapsed > 0 then
    l_SpeedStr := Bytes2Str(Trunc(l_FSize / l_Elapsed)) + '/сек'
   else
    l_SpeedStr := 'мгновенно';
   l3System.Msg2Log('    файл размером %s скопирован за %d мс (%s)', [Bytes2Str(l_FSize), l_LocTime, l_SpeedStr]);
  except
   on E: Exception do
   begin
    l3System.Msg2Log('Ошибка копирования файла %s (%s)', [aFileName, E.Message]);
    l_Success := False;
    Result := False;
   end;
  end;
 end;
begin
 // переливаем содержимое кэша в основное хранилище
 l_FI := TddFileIterator.Make(cImageCachePath, '*.*', nil, True);
 try
  if l_FI.Count > 0 then
  begin
   l3System.Msg2Log('Найдено: %s общим объёмом %s. Начало копирования.',
    [NumSuffix(l_FI.Count, 'документ', 'документа', 'документов'),
    Bytes2Str(l_FI.TotalSize)]);
   l_IterFunc := L2IterateFilesProc(@MoveOne);
   try
    l_Success := True;
    l_Time := dbgStartTimeCounter;
    l_FI.IterateFiles(l_IterFunc);
    if l_Success then
    begin
     l_Time := dbgGetElapsed(l_Time);
     l_Elapsed :=  l_Time / 1000; // прошедшее время в секундах
     if l_Elapsed > 0 then
      l_Str := Bytes2Str(Trunc(l_FI.TotalSize / l_Elapsed))
     else
      l_Str := 'бесконечность';
     l3System.Msg2Log('Обработка завершена, файлы скопированы со скоростью %s/сек.', [l_Str]);
     l3System.Msg2Log('Общее время обработки - %d мс', [l_Time]);
     //PureDir(cImageCachePath);
    end;
    Result := l_Success;
   finally
    FreeIterateFilesProc(l_IterFunc);
   end;
  end
  else
  begin
   l3System.Msg2Log('Кэш образов пуст, обработка не требуется.');
   Result := True;
  end;
 finally
  FreeAndNil(l_FI);
 end;
end;

begin
 CommitImageCacheTest;
end.
