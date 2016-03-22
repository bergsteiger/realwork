program StgDecorChecker;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,
  l3Base,
  l3FileUtils,
  m2COMLib,
  m3ArcCla,
  m3StorageInterfaces,
  m3DBInterfaces,
  m3DBActions,
  m3DB,
  m4DB,
  l3Interfaces,
  m4DBInterfaces,
  l3Stream,
  l3CRT,
  vtDebug,
  k2Interfaces,
  k2TagGen,
  ddNSRCGenerator,
  l3Chars,
  evSimpleTextPainter,
  evTextFormatter,
  evdEmptyRowFilter,
  evCustomNSRCWriter,
  evFontEliminator,
  evDecorStyleEliminator,
  k2Reader,
  k2EVDReaderService,
  evdNativeReaderServices,
  evdNativeWriter,
  l3Filer,
  l3Types,
  m3StorageHolderList,
  m3StorageBlock
  ;
    
const
 cFileName = 'bserv001';

var
 lDirName   : TFileName;
 lBaseName  : TFileName;
 lLogName   : TFileName;

const
 cPhaseSample = 'Check : %s';
 cPhasePercentage = '%d/%d';

var
 lPhaseStr : string;

procedure Log(const S : String);
begin
 dbgAppendToLogLN(lLogName, S);
end;

type
 TProgressor = class(Tl3Base)
 private
  lMaxCount : Longint;
 public
  procedure FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
  procedure ProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
 end;

procedure TProgressor.ProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
begin
 case aState of
  piStart : lMaxCount := aValue;
  piEnd : begin
           CRT.ReWrite(Format(cPhaseSample, ['done']));
           WriteLN;
          end;
  piCurrent :
   //if (aValue mod 500) = 0 then
   if (aValue mod 100) = 0 then
    CRT.ReWrite(Format(lPhaseStr, [aValue, lMaxCount]));
 end;
end;

procedure TProgressor.FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
begin
 CRT.ReWrite(Format(lPhaseStr, [aCurrentID, aMaxID]));
end;

const
 cPartName : array [Tm3DocPartSelector] of string = ('Main', 'Anno', 'Info', 'Object');

procedure DoCheck;

var
 lDB : Im3DB;

 function DoDoc(const aDoc: Im3DBDocumentPart; const anIndex: Tm3DBStreamIndex): Boolean;

  function GetDocStreamForRead: IStream;
  var
   l_Doc : Im3DBDocument;
   l_DocPart : Im3DBDocumentPart;
  begin//GetDocStreamForRead
   Result := nil;
   l_Doc := lDB.GetDocument(anIndex.rID);
   if (l_Doc <> nil) then
   begin
    l_DocPart := l_Doc.GetVersion;
    if (l_DocPart <> nil) then
    begin
     Result := l_DocPart.Open(m3_saRead, anIndex.rPart, anIndex.rIdx);
     // - открываем в переменной части
    end;//l_DocPart <> nil
   end;//l_Doc <> nil
   if (Result = nil) then
    Result := aDoc.Open(m3_saRead, anIndex.rPart, anIndex.rIdx);
    // - открываем в постоянной части
  end;//GetDocStreamForRead

  function GetDocStreamForWrite: IStream;
  var
   l_Doc : Im3DBDocument;
   l_DocPart : Im3DBDocumentPart;
  begin//GetDocStreamForWrite
   Result := nil;
   l_Doc := lDB.GetDocument(anIndex.rID);
   if (l_Doc <> nil) then
   begin
    l_DocPart := l_Doc.GetVersion;
    if (l_DocPart <> nil) then
    begin
     Result := l_DocPart.Open(m3_saReadWrite, anIndex.rPart, anIndex.rIdx);
     // - открываем в переменной части
    end;//l_DocPart <> nil
   end;//l_Doc <> nil
  end;//GetDocStreamForWrite

  function CheckDoc: Boolean;
  const
   cCodePage = CP_OEMLite;
  var
   l_S : IStream;
   l_EvdReader: Tk2CustomFileReader;
   l_G : Tk2TagGenerator;
   l_W : TddNSRCGenerator;
   l_F : Tl3CustomFiler;
   l_FontEliminator : TevFontEliminator;
   l_DecorStyleEliminator : TevDecorStyleEliminator;
   l_NeedCorrect : Boolean;
  begin//CheckDoc
   Result := true;
   try
    l_S := GetDocStreamForRead;
    if (l_S <> nil) then
     try
      m2COMSeek(l_S, 0, STREAM_SEEK_SET);
      if (m2COMGetSize(l_S) > 0) then
      begin
       l_EvdReader := Tk2EVDReaderService.Instance.GetReader;
       try
        l_G := nil;
        try
         l_W := TddNSRCGenerator.SetTo(l_G);
         l_W.InternalHandle := anIndex.rID;
         l_W.CodePage:= cCodePage;
         l_W.SilentErrors := true;
         l_W.NeedOutDecorInfo := true;
         l_W.NeedCorrect := false;

         l_W.ExportDirectory:= ExtractFilePath(ParamStr(0));
         //l_W.OnError:= ErrorEvent;
         //l_W.LinkPathListner(Self);

         TevSimpleTextPainter.SetTo(l_G);
         TevCustomTextFormatter(l_G).CodePage:= cCodePage;

         l_FontEliminator := TevFontEliminator.SetTo(l_G);
         l_FontEliminator.DocID := anIndex.rID;
         l_FontEliminator.NeedCorrect := false;
         l_DecorStyleEliminator := TevDecorStyleEliminator.SetTo(l_G);
         l_DecorStyleEliminator.DocID := anIndex.rID;
         l_DecorStyleEliminator.NeedCorrect := false;
         TevdEmptyRowFilter.SetTo(l_G);

         l_EvdReader.Generator := l_G;
         try
          l_F := Tl3CustomFiler.Create;
          try
           l_F.Mode := l3_fmRead;
           l_F.COMStream := l_S;
           try
            l_EvdReader.Filer := l_F;
            l_EvdReader.Execute;
            l_NeedCorrect := l_W.NeedCorrect OR
                             l_FontEliminator.NeedCorrect OR
                             l_DecorStyleEliminator.NeedCorrect;
            if l_NeedCorrect then
            begin
             dbgAppendToLogLn(ChangeFileExt(ParamStr(0), '.num.corr'), IntToStr(anIndex.rID));
             l_NeedCorrect := l_FontEliminator.NeedCorrect OR
                              l_DecorStyleEliminator.NeedCorrect;
             if l_NeedCorrect then                 
              Result := false;
            end;//l_NeedCorrect
           finally
            l_F.COMStream := nil;
           end;//try..finally
          finally
           FreeAndNil(l_F);
          end;//try..finally
         finally
          l_EvdReader.Generator := nil;
         end;//try..finally
        finally
         FreeAndNil(l_G);
        end;//try..finally
       finally
        FreeAndNil(l_EvdReader);
       end;//try..finally
      end;//m2COMGetSize(l_S) > 0
     finally
      l_S := nil;
     end;//try..finally
   except
    on E : Exception do
    begin
     Log(Format('Exception on doc: %d(%s) "%s"', [anIndex.rId, cPartName[anIndex.rPart], E.Message]));
     Result := true;
    end;//on E : Exception
   end;//try..except
  end;//CheckDoc

  procedure CorrectDoc;
  var
   l_S : IStream;
   l_OutStream : IStream;
   l_EvdReader: Tk2CustomFileReader;
   l_G : Tk2TagGenerator;
   l_InFiler : Tl3CustomFiler;
   l_OutFiler : Tl3CustomFiler;
   l_FontEliminator : TevFontEliminator;
   l_DecorStyleEliminator : TevDecorStyleEliminator;
   l_NeedCorrect : Boolean;
   l_W : TevdNativeWriter;
  begin//CorrectDoc
   try
    l_S := GetDocStreamForRead;
    if (l_S <> nil) then
     try
      m2COMSeek(l_S, 0, STREAM_SEEK_SET);
      l_OutStream := GetDocStreamForWrite;
      try
       l_EvdReader := Tk2EVDReaderService.Instance.GetReader;
       try
        l_G := nil;
        try
         l_OutFiler := Tl3CustomFiler.Create;
         try
          l_OutFiler.Mode := l3_fmWrite;
          l_OutFiler.COMStream := l_OutStream;
          try
           l_W := TevdNativeWriter.Create;
           try
            l_W.Binary := true;
            l_W.SetRefTo(l_G);
            l_W.Filer := l_OutFiler;
           finally
            FreeAndNil(l_W);
           end;//try..finally
           l_FontEliminator := TevFontEliminator.SetTo(l_G);
           l_FontEliminator.DocID := anIndex.rID;
           l_FontEliminator.NeedCorrect := false;
           l_DecorStyleEliminator := TevDecorStyleEliminator.SetTo(l_G);
           l_DecorStyleEliminator.DocID := anIndex.rID;
           l_DecorStyleEliminator.NeedCorrect := false;
           TevdEmptyRowFilter.SetTo(l_G);

           l_EvdReader.Generator := l_G;
           try
            l_InFiler := Tl3CustomFiler.Create;
            try
             l_InFiler.Mode := l3_fmRead;
             l_InFiler.COMStream := l_S;
             try
              l_EvdReader.Filer := l_InFiler;
              l_EvdReader.Execute;
              l_NeedCorrect := l_FontEliminator.NeedCorrect OR
                               l_DecorStyleEliminator.NeedCorrect;
              if l_NeedCorrect then
              begin
               dbgAppendToLogLn(ChangeFileExt(ParamStr(0), '.num.corrected'), IntToStr(anIndex.rID));
              end;//l_NeedCorrect
             finally
              l_InFiler.COMStream := nil;
             end;//try..finally
            finally
             FreeAndNil(l_InFiler);
            end;//try..finally
           finally
            l_EvdReader.Generator := nil;
           end;//try..finally
          finally
           l_OutFiler.COMStream := nil;
          end;//try..finally
         finally
          FreeAndNil(l_OutFiler);
         end;//try..finally
        finally
         FreeAndNil(l_G);
        end;//try..finally
       finally
        FreeAndNil(l_EvdReader);
       end;//try..finally
      finally
       l_OutStream := nil;
      end;//try..finally
     finally
      l_S := nil;
     end;//try..finally
   except
    on E : Exception do
    Log(Format('Exception on doc: %d(%s) "%s"', [anIndex.rId, cPartName[anIndex.rPart], E.Message]));
   end;//try..except
  end;//CorrectDoc

 begin//DoDoc
  Result := true;
  if not CheckDoc then
   CorrectDoc;
 end;//DoDoc

var
 lProgressor : TProgressor;
begin
 lProgressor := TProgressor.Create;
 try
  lDB := Tm3DB.MakeExclusive(ConcatDirName(lDirName, lBaseName),
                      //cbMakeCopy.Checked AND cbFromOld.Checked,
                      nil,//Yield,
                      nil,//FileMeter.ProgressProc_ev,
                      lProgressor.ProgressProc,//FilesMeter.ProgressProc_ev,
                      nil,//FilesProcessed,
                      nil //
                      //lProgressor.FilesProcessedExProc//FilesProcessedEx
                      );
  try
   lDB.Start(m3_saReadWrite);
//   lDB.Start(m3_saRead);
   try
    lPhaseStr := Format(cPhaseSample, [cPhasePercentage]);
    try
     lDB.AllFiles.IterateF(m3L2DocumentAction(@DoDoc), [m3_dsMain, m3_dsAnno]);
    except
     on E : Exception do
     writeln('Exceptions : '+ E.Message);
    end;
   finally
    lDB.Finish;
   end;//try..finally
   Tm3StorageHolderList.DropAll;
   lDB.Update;
  finally
   lDB := nil;
  end;//try..finally   

 finally  
  l3Free(lProgressor); 
 end;//try..finally  

end;

var
(* lCheckForEmpty : boolean = false;
 lCheckForBroken : boolean = false;*)
 lParamStr : String;
 I : integer;
begin
 for I := 1 to ParamCount do
 begin
  lParamStr := ParamStr(I);
(*  if lParamStr = '/e' then
   lCheckForEmpty := True
  else
   if lParamStr = '/b' then
    lCheckForBroken := True
   else*)
    lBaseName := lParamStr;
 end;

 //если ничего не включили, то делаем все
(* if not (lCheckForEmpty or lCheckForBroken) then
 begin
  lCheckForEmpty := True;
  lCheckForBroken := True;
 end;*)

 if lBaseName = '' then lBaseName := cFileName;
 lDirName := ExtractDirName(ExpandFileName(lBaseName));
 lBaseName := ExtractOnlyFileName(lBaseName);
 if lBaseName = '' then lBaseName := cFileName;
 WriteLN('Storage : ', ConcatDirName(lDirName, lBaseName));

 lLogName := ChangeFileExt(ConcatDirName(lDirName, lBaseName),'.result');

 DoCheck;

 Writeln('All done. Press <Enter>');
 ReadLN;

end.
