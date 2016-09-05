unit dd_lcCaseCodeGenerator;
{ Создание номера судебного дела на основе анализа текста документа }

{$I ddDefine.inc}

interface

uses
 k2Types, k2TagFilter, k2Interfaces,
 l3RegEx, l3Types, evdBufferedFilter, l3Variant,
 DT_TblCache, DT_TblCacheDef, dt_Types;

type
 TlcCaseCodeGenerator = class(Tk2TagFilter)
 private
  f_Cache: TCacheDirectAddAttrData;
  f_CaseCode: AnsiString;
  f_CodeType: TDNType;
  f_DocID: TDocID;
  f_Searcher: Tl3RegularSearch;
 protected
    {internal methods}
  procedure CloseStream(NeedUndo: Boolean); override;
  procedure OpenStream; override;
 public
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
        {-}
  procedure StartChild(TypeID: Tl3VariantDef); override;
 end;

type
 TlcBufferedCaseCodeGenerator = class(TevdBufferedFilter)
 private
  f_CaseCode: AnsiString;
  f_CodeType: TDNType;
  f_DocID: TDocID;
  f_NeedCaseCode: Boolean;
  f_Searcher: Tl3RegularSearch;
 protected
    {internal methods}
  procedure CloseStream(NeedUndo: Boolean); override;
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
      override;
    // internal methods
  function NeedStartBuffering(aID : Integer): Boolean; override;
  procedure OpenStream; override;
 public
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure CloseStructure(NeedUndo: Boolean); override;
        {-}
  procedure StartChild(TypeID: Tl3VariantDef); override;
 end;

implementation

uses
 TextPara_Const, k2Tags, l3Base, l3PrimString, Document_Const,
 NumAndDate_Const, daSchemeConsts, StrUtils, k2Base;

type
 TDocRec = packed record
  DocID: TDocID;
  CaseCode: TNumberStr;
 end;

procedure TlcCaseCodeGenerator.AddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
var
 l_Pos: Tl3MatchPosition;
 l_Date: Integer;
 l_LDocID: TDocID;
 l_LSubID: TSubID;
 l_Type: Integer;
 l_Rem: AnsiString;
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_DocID:= Value.AsInteger
 else
 if CurrentType.IsKindOf(k2_typNumAndDate) then// выдергиваем номера документа
 begin
  case AtomIndex of
   k2_tiType: f_CodeType:= TDNType(Value.AsInteger);
   k2_tiNumber: if f_CodeType = dnLawCaseNum then
     f_CaseCode:= Value.AsString.AsString;
  end; // case
 end
 else
 if (f_CaseCode = '') and CurrentType.IsKindOf(k2_typTextPara) and (AtomIndex = k2_tiText) then
 begin
  if f_Searcher.SearchInString(Value.AsString.AsWStr, l_Pos) then
  begin
   if f_Searcher.TagParts.ItemW[0].SLen >= 8 then
   begin
    f_CaseCode:= f_Searcher.TagParts[0].AsString;
    l_Date:= 0;
    l_Type:= Ord(dnLawCaseNum);
    l_LDocID := 0;
    l_LSubID := 0;
    f_Cache.AddRecord([f_DocID, l_Date, f_CaseCode, l_Type, l_LDocID, l_LSubID]);
   end;
  end;
 end;
end;

procedure TlcCaseCodeGenerator.CloseStream(NeedUndo: Boolean);
begin
 f_Cache.Save;
 l3Free(f_Cache);
 l3Free(f_Searcher);
 inherited;
end;

procedure TlcCaseCodeGenerator.OpenStream;
begin
 inherited;
 f_Searcher:= Tl3RegularSearch.Create;
 f_Searcher.SearchPattern:= 'дел\w+ [N№]\s?{[АA][\w\/\\\-_\(\)]+}';
 f_Cache:= TCacheDirectAddAttrData.Create(CurrentFamily, ctDateNum);
end;

procedure TlcCaseCodeGenerator.StartChild(TypeID: Tl3VariantDef);
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  f_CaseCode:= '';
end;

procedure TlcBufferedCaseCodeGenerator.AddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
var
 l_Pos: Tl3MatchPosition;
 l_Date: Integer;
 l_Type: Integer;
 l_Rem: AnsiString;
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_DocID:= Value.AsInteger
 else
 if CurrentType.IsKindOf(k2_typNumAndDate) then// выдергиваем номера документа
 begin
  case AtomIndex of
   k2_tiType: f_CodeType:= TDNType(Value.AsInteger);
   k2_tiNumber: if f_CodeType = dnLawCaseNum then
     f_CaseCode:= Value.AsString.AsString;
  end; // case
 end
 else
 if (f_CaseCode = '') and CurrentType.IsKindOf(k2_typTextPara) and (AtomIndex = k2_tiText) then
 begin
  if f_Searcher.SearchInString(Value.AsString.AsWStr, l_Pos) then
  begin
   if f_Searcher.TagParts.ItemW[0].SLen >= 8 then
   begin
    f_CaseCode:= f_Searcher.TagParts[0].AsString;
    f_NeedCaseCode:= true;
   end;
  end;
 end;
end;

procedure TlcBufferedCaseCodeGenerator.CloseStream(NeedUndo: Boolean);
begin
 l3Free(f_Searcher);
 inherited;
end;

procedure TlcBufferedCaseCodeGenerator.CloseStructure(NeedUndo: Boolean);
begin
 inherited;
 if f_NeedCaseCode and (SkipLevel = 2) then
  StopBufferingAndFlush(NeedUndo, TopObject[0], False);
end;

procedure TlcBufferedCaseCodeGenerator.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer;
    aNeedCloseBracket : Boolean);
var
 l_DNs, l_DN: Tl3Variant;
 i: Integer;
begin
 if f_NeedCaseCode then
 begin
  if aLeaf.Attr[k2_tiNumAndDates].IsValid  then
  begin
   l_DNs:= aLeaf.Attr[k2_tiNumAndDates];
   l_DN:= k2_typNumANDDate.MakeTag.AsObject;
   l_DN.IntA[k2_tiType]:= Ord(dnLawCaseNum);
   l_DN.StrA[k2_tiNumber]:= f_CaseCode;
   l_DNs.AddChild(l_DN);
  end; 
 end;
 inherited;
end;

function TlcBufferedCaseCodeGenerator.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -k2_idDocument;
end;

procedure TlcBufferedCaseCodeGenerator.OpenStream;
begin
 inherited;
 f_Searcher:= Tl3RegularSearch.Create;
 f_Searcher.SearchPattern:= 'дел\w+ [N№]\s?{[АA][\w\/\\\-_\(\)]+}';
end;

procedure TlcBufferedCaseCodeGenerator.StartChild(TypeID: Tl3VariantDef);
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  f_CaseCode:= '';
  f_NeedCaseCode:= False;
 end;
end;



end.
