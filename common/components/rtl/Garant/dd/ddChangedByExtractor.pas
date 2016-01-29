unit ddChangedByExtractor;

{ Преобразование текста в заголовке документа, начинающегося с фразы "(с изменениями от" и до ")" в отдельный абзац }

{ $Id: ddChangedByExtractor.pas,v 1.12 2014/04/29 14:06:17 lulin Exp $ }

// $Log: ddChangedByExtractor.pas,v $
// Revision 1.12  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.11  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.10  2012/01/11 10:27:20  narry
// Возврат к обработке через хранилище
//
// Revision 1.9  2011/12/29 08:13:53  narry
// Утилита удаления текста об изменениях (325261080)
//
// Revision 1.8  2011/10/13 08:43:31  narry
// Накопившиеся изменения
//
// Revision 1.7  2011/10/06 13:06:03  narry
// Борьба с пустыми строками
//
// Revision 1.6  2011/09/27 06:36:55  narry
// Еще раз про мягкий перенос (280858795)
//
// Revision 1.5  2011/09/23 09:31:27  narry
// Не заменялся #10 на #29
//
// Revision 1.4  2011/08/12 11:39:35  narry
// Мягкий перенос заменить на пробел (278840689)
//
// Revision 1.3  2011/06/24 07:18:41  narry
// Написать утилиту, которая выделит текст с датами изменений в отдельный абзац (255979284)
//
// Revision 1.2  2011/06/24 04:44:30  narry
// Написать утилиту, которая выделит текст с датами изменений в отдельный абзац (255979284)
//
// Revision 1.1  2011/06/23 13:32:25  narry
// Написать утилиту, которая выделит текст с датами изменений в отдельный абзац (255979284)
//

{$DEFINE UseRegEx}
{.$DEFINE CorrectStyle}

interface

uses
  evdLeafParaFilter, k2Interfaces, l3Types, k2Types, k2TagFilter, l3RegEx,
  k2tagGen, l3Interfaces;

type
 TddDocStatus = (dd_dsChanged, dd_dsAbsent, dd_dsNotFinished, dd_dsIDAbsent);
 TddDocStatusEvent = procedure (DocID: Integer; DocStatus: TddDocStatus) of object;
 TddChangedByFilter = class(TevdLeafParaFilter, Il3DocIDSource)
 private
  f_Changed: Boolean;
  f_DocID: Integer;
  f_OnDocumentStatus: TddDocStatusEvent;
  f_ParaToFilter: Integer;
  f_RegEx: Tl3RegularSearch;
  procedure ReplaceDoubleSoftEnter(aLeaf: Tl3Tag);
 protected
  procedure cleanup; override;
  procedure DoDocumentWork(aDocStatus: TddDocStatus);
  procedure DoWritePara(aLeaf: Tl3Tag); override;
        {-}
  function ParaTypeForFiltering: Long; override;
  function pm_GetDocID: Integer;
  procedure pm_SetDocID(aValue: Integer);
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure StartChild(TypeID: Long); override;
  property DocID: Integer read pm_GetDocID write pm_SetDocID;
 published
  property OnDocumentStatus: TddDocStatusEvent read f_OnDocumentStatus write
      f_OnDocumentStatus;
 end;

implementation

uses
  Document_Const, k2Tags, StrUtils, TextPara_Const, evdStyles, Math, SysUtils,
  l3String, l3Chars, evParaTools, evTextParaTools, NevTools, evTypes, evSearch,
  l3PrimString, l3Base;

const
 {$IFDEF UseRegEx}
 cReplaceTextStart = '\(с\s+изменениями\s+от\s+{.+}\)';
 {$ELSE}
 cReplaceTextStart = '(с изменениями от';
 cReplaceTextFinish = ')';
 {$ENDIF}

constructor TddChangedByFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_RegEx := Tl3RegularSearch.Create();
 f_RegEx.IgnoreCRLF:= True;
 f_RegEx.IgnoreCase:= True;
 f_RegEx.SearchPattern:= cReplaceTextStart;
end;

procedure TddChangedByFilter.cleanup;
begin
 inherited;
 FreeAndNil(f_Regex);
end;

procedure TddChangedByFilter.DoDocumentWork(aDocStatus: TddDocStatus);
begin
 if Assigned(f_OnDocumentStatus) then f_OnDocumentStatus(f_DocID, aDocStatus);
end;

procedure TddChangedByFilter.DoWritePara(aLeaf: Tl3Tag);
var
 l_Text, l_NewText: AnsiString;
 l_Start, l_Finish: Integer;
 l_NewStart, l_NewFinish: Integer;
 l_Style: Integer;
 l_TextPara: InevTextPara;
 {$IFDEF UseRegEx}
 l_Pos: Tl3MatchPosition;
 l_SimpleText: Tl3WString;
 {$ENDIF}
begin
  l_Style:= aLeaf.IntA[k2_tiStyle];
  if l_Style = ev_saTxtHeader1 then
  begin
{$IFDEF UseRegEx}
   l_SimpleText:= aLeaf.PAnsiCharLenA[k2_tiText];
   if f_RegEx.SearchInString(l_SimpleText, l_Pos) then
   begin
     l_NewText:= f_RegEx.TagParts[0].AsString;
     l_Start:= l_Pos.StartPos;
     l_Finish:= l_Pos.EndPos;
     l_NewText:= AnsiReplaceStr(l_NewText, cc_HardSpace+cc_SoftEnter, #29);
     l_NewText:= AnsiReplaceStr(l_NewText, cc_SoftEnter+cc_HardSpace, #29);
     l_NewText:= AnsiReplaceStr(l_NewText, cc_SoftEnter, #29);
     if aLeaf.QT(InevTextPara, l_textPara) then
     begin
      evDir_DeleteText(l_TextPara, l_Start, l_Finish-l_Start+1);
      ReplaceDoubleSoftEnter(aLeaf);
      l_text:= aLeaf.StrA[k2_tiText];
      l_Start:= Length(l_Text);
      while (l_Start > 0) and (l_Text[l_Start] in [cc_HardSpace, cc_SoftEnter]) do Dec(l_Start);
      if l_Start > 0 then
       evDir_DeleteText(l_TextPara, l_Start, Length(l_Text)-l_Start);
     end;
     if not l3EmptyOrAllCharsInCharSet(aLeaf.PAnsiCharLenA[k2_tiText], [cc_HardSpace, cc_SoftEnter]) then // Не нужно создавать пустой абзац
      inherited;
     {$IFNDEF CorrectStyle}
     Generator.StartChild(k2_idTextPara);
     try
      Generator.AddIntegerAtom(k2_tiStyle, ev_saChangesInfo);
      Generator.AddStringAtom(k2_tiText, l_NewText);
     finally
      Generator.Finish;
     end;
     {$ENDIF}
     if not f_Changed then
     begin
      DoDocumentWork(dd_dsChanged);
      f_Changed:= True;
     end; // not f_Changed
   end // f_RegEx.SearchInString
   else
   begin
    inherited;
   // DoDocumentWork(dd_dsAbsent);
   end
{$ELSE}
   l_Text:= aLeaf.StrA[k2_tiText];
   l_Text:= AnsiReplaceStr(l_text, cc_SoftSpace, ' ');
   l_Start:= Pos(cReplaceTextStart, l_Text);
   if l_Start <> 0 then
   begin
    l_Finish:= PosEx(cReplaceTextFinish, l_Text, l_Start + Length(cReplaceTextStart));
    if l_Finish <> 0 then
    begin
     l_Text:= aLeaf.StrA[k2_tiText];
     l_NewStart:= l_Start+Length(cReplaceTextStart);
     l_NewFinish:= l_Finish-l_NewStart-Length(cReplaceTextFinish);
     l_NewText:= Trim(Copy(l_Text, l_NewStart, l_NewFinish+1));
     l_NewText:= AnsiReplaceStr(l_NewText, cc_HardSpace+cc_SoftEnter, #29);
     l_NewText:= AnsiReplaceStr(l_NewText, cc_SoftEnter+cc_HardSpace, #29);
     l_NewText:= AnsiReplaceStr(l_NewText, cc_SoftEnter, #29);
     if aLeaf.QT(InevTextPara, l_textPara) then
     begin
      evDir_DeleteText(l_TextPara, Pred(l_Start), l_Finish-l_Start+1);
      ReplaceDoubleSoftEnter(aLeaf);
      l_text:= aLeaf.StrA[k2_tiText];
      l_Start:= Length(l_Text);
      while (l_Start > 0) and (l_Text[l_Start] in [cc_HardSpace, cc_SoftEnter]) do Dec(l_Start);
      if l_Start > 0 then
       evDir_DeleteText(l_TextPara, l_Start, Length(l_Text)-l_Start);
     end;
     if not l3EmptyOrAllCharsInCharSet(aLeaf.PAnsiCharLenA[k2_tiText], [cc_HardSpace, cc_SoftEnter]) then // Не нужно создавать пустой абзац
      inherited;
     Generator.StartChild(k2_idTextPara);
     try
      Generator.AddIntegerAtom(k2_tiStyle, ev_saChangesInfo);
      Generator.AddStringAtom(k2_tiText, l_NewText);
     finally
      Generator.Finish;
     end;
     DoDocumentWork(dd_dsChanged);
    end
    else
    begin
     inherited;
     DoDocumentWork(dd_dsNotFinished);
    end
   end
   else
   begin
    inherited;
    DoDocumentWork(dd_dsAbsent);
   end
{$ENDIF}
  end //l_Style = ev_saTxtHeader1
  else
   inherited;
end;

function TddChangedByFilter.ParaTypeForFiltering: Long;
begin
 Result := k2_idTextPara;
end;

function TddChangedByFilter.pm_GetDocID: Integer;
begin
 Result:= f_DocID;
end;

procedure TddChangedByFilter.pm_SetDocID(aValue: Integer);
begin
 f_DocID:= aValue;
end;

procedure TddChangedByFilter.StartChild(TypeID: Long);
begin
 inherited StartChild(TypeID);
 if CurrentType.InheritsFrom(k2_idDocument) then
  f_Changed:= False;
end;


procedure TddChangedByFilter.ReplaceDoubleSoftEnter(aLeaf: Tl3Tag);
const
 cOpt = [ev_soNoException, ev_soNoProgress, ev_soReplaceAll];
var
 l_nevPara: InevPara;
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  if aLeaf.QT(InevPara, l_nevPara) then
  try
   l_Searcher:= TevBMTextSearcher.Make(cc_SoftEnter+cc_SoftEnter, cOpt);
   try
    l_Replacer:= TevTextReplacer.Make(cc_SoftEnter, cOpt);
    try
     EvReplaceInPara(l_nevPara, l_Searcher, l_Replacer);
    finally
     l_Replacer:= nil;
    end;//try..finally
   finally
    l_Searcher:= nil;
   end;//try..finally
  finally
   l_Nevpara:= nil;
  end;//try..finally
 end;//aLeaf.Attr[k2_tiText].IsValid
 inherited;
end;
end.
