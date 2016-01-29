unit afSourceDetector;
{ Находит в тексте документа атрибуты - номер, дату и исходящий орган }

// $Id: afSourceDetector.pas,v 1.5 2015/07/02 11:41:25 lukyanets Exp $

// $Log: afSourceDetector.pas,v $
// Revision 1.5  2015/07/02 11:41:25  lukyanets
// Описываем словари
//
// Revision 1.4  2014/04/29 14:06:19  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.3  2014/04/11 15:30:52  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2013/04/16 09:30:55  fireton
// - не собиралось
//
// Revision 1.1  2013/04/16 08:09:55  narry
// Автоматические форматировщики
//


interface

uses
  dd_lcTextFormatter2, k2Interfaces, Classes, k2TagGen, l3Types;

type
 TafSourceDetector = class(Tdd_lcBaseFormatter)
 private
  f_DateFound: Boolean;
  f_DateS: string;
  f_NumberFound: Boolean;
  f_SourceFound: Boolean;
  f_TitleAdded: Boolean;
  f_TypeFound: Boolean;
  function FindSource(aPara: Tl3Tag): Tdd_lcTextReaction;
  procedure GenerateTitle;
 protected
  function CheckExtractCode(aPara: Tl3Tag; out theNumber: string): Boolean;
  procedure Cleanup; override;
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
 end;

implementation

uses
  SysUtils, StrUtils, k2Tags, l3Base, k2Base, Document_Const, l3RegEx,
  TextPara_Const, evdStyles, l3LingLib, l3Chars, dt_Dict, m4DictTypes,
  m4DictScanner, daTypes, DT_Const, dt_AttrSchema, m4PhraseParser, l3DateSt;

constructor TafSourceDetector.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);

end;

function TafSourceDetector.CheckExtractCode(aPara: Tl3Tag; out theNumber:
    string): Boolean;
const
 cDelo = '(Д|дело\s*)';
 cNo   = '([\№N]\s*)';
 cNum  = '(([A-ZА-Я]\s?\d\d)|(ВАС)\s?(\-[А-Я]+\s?)?\-\s?\d+(\s?\/|\-|\\\s?)[А-Я\-0-9\\\/]+)';
 cRegExp = '({' + cDelo+cNo+'}.+\({'+cNum+'}\)$)|({'+cDelo+cNo+cNum+'?})|({'+cNo+cNum+'})|({'+cNum + '})|(^{'+cDelo+'}$)|('+cNo+')';
var
 l_Pos: Tl3MatchPosition;
 i: Integer;
begin
 Result:= False;
 theNumber:= '';
 RegSearcher.SearchPattern:= cNo+'{(\d+)}';
 if RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_Pos) then
 begin
  Result:= True;
  if RegSearcher.TagParts.Count > 0 then
  begin
   for i:= 0 to Pred(RegSearcher.TagParts.Count) do
   begin
    if i > 0 then
     theNumber:= theNumber + ' ';
    theNumber:= theNumber + RegSearcher.TagParts[i].AsString;
   end; // for i
  end
  else
   theNumber:= Copy(aPara.StrA[k2_tiText], Succ(l_Pos.StartPos), l_pos.Length);
 end; // RegSearcher.SearchInString
end;

procedure TafSourceDetector.Cleanup;
begin
 inherited;
end;

procedure TafSourceDetector.ClearParameters;
begin
 inherited;
 CheckEmptyPara:= True;
 f_SourceFound:= false;
 f_DateFound:= False;
 f_TypeFound:= False;
 f_NumberFound:= False;
 f_TitleAdded:= False;
 f_DateS:= '';
end;

function TafSourceDetector.EnableWrite(aPara: Tl3Tag): Tdd_lcTextReaction;
var
 i: Integer;
 l_Date, l_Number: String;
 l_Pos, l_Len: Integer;
 l_IsCaseCode: Boolean;
begin
 Result:= lcWrite;
 if not f_TitleAdded then
 begin
  if (aPara.StrA[k2_tiText] = '') then
   Result:= lcSkip
  else
  begin
   Result:= lcWrite;
   Result:= FindSource(aPara);
   if f_DateFound and f_NumberFound and f_SourceFound and f_TypeFound and not f_TitleAdded then
    GenerateTitle;
  end;
 end;
end;

function TafSourceDetector.FindSource(aPara: Tl3Tag): Tdd_lcTextReaction;
var
 i: Integer;
 lFDIProcStub : Tm4FoundDictItemProc;
 l_Reaction: Tdd_lcTextReaction;

 function lFoundDictItem(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 var
  l_FoundStr: string;
 begin
  Result := True;
  //l3System.Msg2Log(DictServer(CurrentFamily).Dict[TdaDictionaryType(aDictItemID.rDictionaryID)].GetShortName(aDictItemID.rID));
  case aDictItemID.rDictionaryID of
   cDateDictID :
    if not f_DateFound then
    begin
     f_Date := aDictItemID.rID;
     f_DateS:= l3DateToStr(f_Date, 'd mmmm yyyy'+cc_SoftSpace+'г.');
     f_DateFound:= True;
     l_Reaction:= lcSkip;
    end;

   cNumDictID :
    if not f_NumberFound then
    begin
     f_Number := Copy(aPara.StrA[k2_tiText], Succ(aSegment.rOffs), aSegment.rLen);
     f_NumberFound:= True;
     l_Reaction:= lcSkip;
    end;
   (*
   cLawcaseNumDictID :
    begin
    end;

   cGostDictID :
    begin
    end;
   cShortNameDictID :
    if l_FoundShort.rIntDocID = 0 then
    begin
     //l_FoundShort := ddFillALDocRecFromExtDocID(aDictItemID.rID);
    end;
   cSkippiesDictID     : ; // пропускаем, не разрывая цепочку
   //cCodexKeywordsDictID: ; // пропускаем, не разрывая цепочку -- наверное, так не надо делать

   cStopWordsDictID:
    begin
    end;

   cCodexDictID    : WorkOutCodex(aDictItemID.rID, aSegment.rOffs, aSegment.rLen);
   cCodexAbbrDictID: WorkOutCodexAbbr(aSegment);
   cCodexSpecials  :
    case aDictItemID.rID of
     cs_Further:
      begin
       WorkoutChain;
       l_FurtherSeg := aSegment;
      end;
    end;
   *)
  else
   if aDictItemID.rDictionaryID > 0 then
   case TdaDictionaryType(aDictItemID.rDictionaryID) of
     da_dlSources:
      if not f_SourceFound then
      begin
       f_Source:= DictServer(CurrentFamily).Dict[TdaDictionaryType(aDictItemID.rDictionaryID)].GetShortName(aDictItemID.rID);
       f_SourceFound:= True;
       l_Reaction:= lcSkip;
      end;
     da_dlTypes  :
      if not f_TypeFound then
      begin
       f_Type:= DictServer(CurrentFamily).Dict[TdaDictionaryType(aDictItemID.rDictionaryID)].GetShortName(aDictItemID.rID);
       f_TypeFound:= True;
       l_Reaction:= lcSkip;
      end;
   end;
  end;
 end;


begin
 l_Reaction:= lcWrite;
 if not f_TitleAdded then
 begin
  lFDIProcStub := L2FoundDictItemProc(@lFoundDictItem);
  try
   DoParsePhrase(aPara.PCharLenA[k2_titext], DictServer(CurrentFamily).DictScanner, lFDIProcStub);
  finally
   FreeFoundDictItemProc(lFDIProcStub);
  end;
 end;
 Result:= l_Reaction;
end;

procedure TafSourceDetector.GenerateTitle;
var
 l_Title: String;
begin
 Generator.StartChild(k2_idTextPara);
 try
  Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
  l_Title:= Format('%s %s от %s №'+cc_SoftSpace+'%s', [f_Type, mlmaRusDeclensionStr(f_Source, rdRodit),
                                                       mlmaRusDeclensionStr(f_DateS, rdRodit), f_Number]);
  Generator.AddStringAtom(k2_tiText, l_Title);
 finally
  Generator.Finish();
 end;
 f_TitleAdded:= True;
end;

end.
