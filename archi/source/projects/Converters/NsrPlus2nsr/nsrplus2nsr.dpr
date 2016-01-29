program nsrplus2nsr;  

{ Преобразование NSRC+ в классический NSRC}

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ddFileIterator,
  l3FileUtils,
  l3Filer,
  ddNsrc_r,
  l3Base,
  ddNsrc_w,
  evdSchema,
  evTextFormatter,
  ddNSRCConst,
  l3Parser,
  DT_types,
  AnnoTopic_Const,
  Document_Const,
  DateUtils,
  ddNSRCSubList,
  L3String,
  evNSRCConst,
  L3Chars;

{$R versioninfo.res} // включаем Version Info

type
 TNSRCPlusReader1 = class(TCustomNSRCReader)
 private
 protected
 public
  procedure Read; override;
 end;

procedure WriteHelp;
begin
 Writeln('Nsrc+ to Nsrc Converter');
 Writeln;
 Writeln('Usage:');
 Writeln('nsrplus2nsr <SrcFolder> <DestFolder>');
 Writeln('                ^            ^');
 Writeln('                |            `-- destination Folder for NSRC files');
 Writeln('                `--------------- source Folder with NSRC+ files');
 Writeln;
end;


var
 gSrc, gDest: String;
 gReader: TCustomNSRCReader;
 gWriter: TddNSRCGenerator;
 gFormatter: TevTextFormatter;
 gInFiler,
 gOutFiler: Tl3DOSFiler;

function ReadParameters: Boolean;
begin
 Result:= False;
 if ParamCount = 2 then
 begin
  gSrc:= ParamStr(1);
  gDest:= ParamStr(2);
  if DirectoryExists(gSrc) then
  begin
   if DirectoryExists(gDest) then
    PureDir(gDest)
   else
    ForceDirectories(gDest);
   Result:= True;
  end;
 end;
end;

function ConvertFile(const aFileName: String): Boolean;
begin
 Result:= False;
 Write(aFileName + '...');
 try
  gInFiler.Filename:= aFilename;
  gOutFiler.Filename:= ConcatDirname(gDest, ExtractFileName(aFileName));
  gReader.Execute;
  Result:= not gReader.AbortLoading;
 finally
  Writeln('done');
 end;
end;

procedure CreateObjects;
begin
 greader:= {TCustomNSRCReader}TNSRCPlusReader1.Create(nil);
 gReader.NotFilterGroups:= True;
 gReader.StrictFormat:= False;
 gInFiler:= Tl3DOSFiler.Create();
 gOutFiler:= Tl3DOSFiler.Create;
 gWriter:= TddNSRCGenerator.Create;
 gWriter.CodePage:= CP_KeepExisting;
 gWriter.NotFilterGroups:= True;
 gFormatter:= TevTextFormatter.Create;
 gFormatter.CodePage:= CP_OEMLIte;//CP_KeepExisting;
 gReader.Filer:= gInFiler;
 gWriter.Filer:= gOutFiler;
 gReader.generator:= gFormatter;
 gFormatter.Generator:= gWriter;
end;

procedure DestroyObjects;
begin
 l3Free(gReader);
 l3Free(gWriter);
 l3Free(gFormatter);
 l3Free(gInFiler);
 l3Free(gOutFiler);
end;




procedure ConvertFolder;
var
 l_S: TDateTime;
begin
 CreateObjects;
 try
  l_S:= Now;
  with TddFileIterator.Make(gSrc, '*.nsr') do
  try
   IterateFiles(ConvertFile);
  finally
   l3System.Msg2Log('%d сек', [secondsBetween(Now, l_S)]);
   Free;
  end;
 finally
  DestroyObjects;
 end;
end;

procedure TNSRCPlusReader1.Read;
var
 S: String;
 l_S: Tl3String;
 l_TableStarted: Integer;
 l_DocStarted: Boolean;
 l_Subs:  TddNSRCSubList;
 l_FontPos: Integer;

 procedure lp_FlushTable;
 begin
  if (l_TableStarted = 0) then
   gFormatter.PrevTable:= nil;
  gWriter.ClearPP;
 end;
const
 WS  = AllWhiteSpace;
 WS1 = AllWhiteSpace-[#32];
begin { Read1 }
 Filer.CodePage:= CodePage;
 StopLoading:= False;
 Warning:= True;
 Parser.WhiteSpace:= WS1;
 DocStarted:= False;
 l_Subs:= nil;
 l_S:= Tl3String.Make(CodePage);
 try
  TokenReaded:= False;
  l_TableStarted:= 0;
  Parser.NextTokenSp;
  while (not Filer.EOF) do
  begin
   Parser.WhiteSpace:= WS;
    if (l_TableStarted = 0) then
     Parser.WhiteSpace:= WS1;
    if not TokenReaded then
    begin
      while (Parser.TokenChar <> chrStartToken) and not Filer.EOF do
      begin
       if Parser.TokenChar = ';' then
       begin
        l_S.AsString:= Parser.TokenChar;
        l_S.Append(Filer.Readln);
        gWriter.LS(l_S.AsString);
       end
       else
       if (Parser.TokenType = l3_ttEOL) then
        if l_TableStarted > 0 then
         WriteEmptyParagraph(l_Subs)
        else
        begin
         lp_FlushTable;
         gWriter.LS('')
        end
       {else
       begin
        l_S.Assign(Parser.TokenLongString);
        l_S.JoinWith(Filer.Readln);
        gWriter.LS(l_S.AsString);
       end};
       Parser.NextTokenSp;
      end; // while (Parser.TokenChar <> chrStartToken) and not Filer.EOF
      Parser.NextTokenSp;
    end // not TokenReaded
    else
      TokenReaded:= False;

    if not Filer.EOF then
    begin
     if (Parser.TokenSymbolIs(kwdTOPIC) or
        Parser.TokenSymbolIs(kwdObjTOPIC) or
        Parser.TokenSymbolIs(kwdFlashTOPIC) or
        Parser.TokenSymbolIs(kwdAnnoTOPIC)) then
     begin
      Parser.WhiteSpace:= WS;
      if Parser.TokenSymbolIs(kwdAnnoTOPIC) then
       StartDocument(k2_typAnnoTopic)
      else
       if Parser.TokenSymbolIs(kwdObjTOPIC) then
        StartDocument(k2_typDocument, dtObject)
       else
        if Parser.TokenSymbolIs(kwdFlashTopic) then
         StartDocument(k2_typDocument, dtFlash)
        else
         StartDocument(k2_typDocument);
      CheckDocHeader;
      gWriter.ClearPPBetweenDoc;
     end
     else
     if Parser.TokenSymbolIs(kwdTABLE) then
     begin
      Parser.WhiteSpace:= WS;
      Inc(l_TableStarted);
      TranslateTable;
     end
     else
     if (l_TableStarted > 0) and Parser.TokenSymbolIs(kwdSub) then
     begin
      Parser.WhiteSpace:= WS;
      TranslateSub;
     end
     else
     if (Parser.TokenSymbolIs(kwdSTYLE) or
         Parser.TokenSymbolIs(kwdSTYLEA)) then
     begin
      if (l_TableStarted > 0) then
      begin
       Parser.WhiteSpace:= WS;
       TranslateStyle(Parser.TokenSymbolIs(kwdSTYLEA))
      end
      else
      begin
       lp_FlushTable;
       l_S.AsString:= chrStartToken;
       l_S.JoinWith(Parser.TokenLongString);
       l_S.Append(Filer.Readln);
       l_FontPos:= Pos('H', l_S.AsString);
       if l_FontPos > 0 then
        gWriter.LS(Copy(l_S.AsString, 1, Pred(l_FontPos)))
       else
        gWriter.LS(l_S.AsString);
       Parser.NextTokenSP;
       while not Filer.EOF and (Parser.TokenChar <> chrStartToken) do
       begin
        if Parser.TokenType = l3_ttEOL then
         WriteEmptyParagraph(l_Subs)
        else
        begin
         l_S.Assign(Parser.TokenLongString);
         l_S.Append(Filer.Readln);
         gWriter.LS(l_S.AsString);
        end;
        Parser.NextTokenSP;
       end;
      end
     end
     else
     if Parser.TokenSymbolIs(kwdTABLEEND) then
     begin
      Dec(l_TableStarted);
      TranslateTableEnd;
     end
     else
     if Parser.TokenSymbolIs(kwdROW) then
       TranslateRow
     else
     if Parser.TokenSymbolIs(kwdROWEND) then
       TranslateRowEnd
     else
     if Parser.TokenSymbolIs(kwdCELL) then
     begin
      Parser.WhiteSpace:= WS;
      TranslateCell
     end
     else
     if Parser.TokenSymbolIs(kwdCELLEND) then
       TranslateCellEnd
     else
     if Parser.TokenSymbolIs(kwdDivision) then
     begin
      Parser.WhiteSpace:= WS;
      TranslateDivision
     end
     else
     if Parser.TokenSymbolIs(kwdLeftIndent) then
      TranslateLeftIndent
     else
     if Parser.TokenSymbolIs(kwdZoom) then
      Filer.Readln
     else
     // прокидываем напрямую в файлер
     begin
      lp_FlushTable;
      gFormatter.ClearObjects;
      l_S.AsString:= chrStartToken;
      l_S.JoinWith(Parser.TokenLongString);
      l_S.Append(Filer.Readln);
      l3Replace(l_S.AsWStr, [ev_NSRCSoftEnter], cc_SoftEnter);
      gWriter.LS(l_S.AsString);
      TokenReaded:= False;
     end; // if..then
//     if not TokenReaded then
//      Parser.NextTokenSp;
    end // not EOF
  end; // while not EOF
  CheckDocumentEnd;
  FinalizeDocument;
  gWriter.LS(';');
 finally
  l3Free(l_S);
 end; // try..finally
end;


begin
 if ReadParameters then
  ConvertFolder
 else
  WriteHelp;
end.
