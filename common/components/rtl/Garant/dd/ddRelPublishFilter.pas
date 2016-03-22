unit ddRelPublishFilter;

{ $Id: ddRelPublishFilter.pas,v 1.18 2015/11/26 08:45:43 lukyanets Exp $ }

// $Log: ddRelPublishFilter.pas,v $
// Revision 1.18  2015/11/26 08:45:43  lukyanets
// КОнстанты переехали
//
// Revision 1.17  2014/04/11 15:30:50  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.16  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.15  2014/04/07 08:08:05  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.14  2014/03/25 14:31:53  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.13  2014/03/04 14:57:00  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.12  2013/10/28 14:34:33  dinishev
// Bug fix: смещалась ссылка при изменении справки.
//
// Revision 1.11  2013/04/15 05:59:22  narry
// Не собиралось
//
// Revision 1.10  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.9  2012/08/14 12:00:27  narry
// Неправильная ссылка на сайт (383584299)
//
// Revision 1.8  2012/07/26 04:14:52  fireton
// - "размещен на ..." не опознавалось (K 377752256)
//
// Revision 1.7  2012/07/23 08:41:54  fireton
// - нормализуем текст про опубликование (К 377752251)
//
// Revision 1.6  2012/05/30 09:05:07  fireton
// - номера статей (К 367210765)
//
// Revision 1.5  2012/05/28 09:04:08  fireton
// - bug fix (K 363575115)
//
// Revision 1.4  2012/05/28 07:39:58  fireton
// - bug fix (K 363575115)
//
// Revision 1.3  2012/05/17 10:34:47  narry
// Ссылки внутри добавляемой информации (363574319)
//
// Revision 1.2  2012/05/16 12:57:41  narry
// Ссылки внутри добавляемой информации (363574319)
//
// Revision 1.1  2011/06/23 08:02:32  fireton
// - правим справки на предмет источников опубликования
//

interface
uses
 l3Interfaces,
 l3RegEx,

 evdLeafParaFilter,

 k2Interfaces,
 k2TagGen;

type
 TddRelPublishFilterWorkResult = (wrNotFound, wrAlreadyExist, wrDidTheJob);

 TddRelPublishFilter = class(TevdLeafParaFilter)
 private
  f_Address: AnsiString;
  f_ArticleNo: Integer;
  f_ArticleNoStr: Il3CString;
  f_LinkFinish: Integer;
  f_PubText: Il3CString;
  f_NormPubText: Il3CString;
  f_REPrimary : Tl3RegularSearch;
  f_RESecondary : Tl3RegularSearch;
  f_LinkSearcher : Tl3RegularSearch;
  f_LinkStart: Integer;
  f_WorkResult: TddRelPublishFilterWorkResult;
  procedure InsertPubText(aLeaf: Tl3Variant; aFoundText: Tl3WString; const atext: AnsiString);
  function NoLinkAtPos(aLeaf: Tl3Variant; aStart, aEnd: Longint): Boolean;
  function NormalizePubText(const aStr: Tl3WString): Il3CString;
  procedure pm_SetArticleNo(const Value: Integer);
  procedure pm_SetPubText(const Value: Il3CString);
 protected
  procedure Cleanup; override;
  procedure DeleteSegments(aLeaf: Tl3Variant; aStart: Integer);
  procedure DoWritePara(aLeaf: Tl3Variant); override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure NextDoc;
  property ArticleNo: Integer read f_ArticleNo write pm_SetArticleNo;
  property PubText: Il3CString read f_PubText write pm_SetPubText;
  property WorkResult: TddRelPublishFilterWorkResult read f_WorkResult write f_WorkResult;
 end;

implementation
uses
 SysUtils,

 l3Variant,
 l3Types,
 l3Base,
 l3String,
 l3Chars,

 k2Tags, l3PrimString, Segment_Const, evHyperlink, nevNavigation, evSegLst, evdTypes, evdStyles,
 k2Types, k2Base, Hyperlink_Const, evTextParaTools, nevTools, afwNavigation, Address_Const,
 daSchemeConsts,
 Dt_LinkServ, DT_Const, Dt_ReNum;

constructor TddRelPublishFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_REPrimary := Tl3RegularSearch.Create;
 f_REPrimary.IgnoreCase := True;
 f_REPrimary.SearchPattern := '^{Текст\s.+?\s}((официально опубликован не был)|(размещ[её]н на .+)|(представлен на .+))\.?$';
 f_RESecondary := Tl3RegularSearch.Create;
 f_RESecondary.IgnoreCase := True;
 f_RESecondary.SearchPattern := '^{Текст\s.+?\s((опубликован)|(размещ[её]н)) ((в)|(на)) .+}\.?$';
 f_LinkSearcher := Tl3RegularSearch.Create;
 f_LinkSearcher.IgnoreCase := True;
 f_LinkSearcher.SearchPattern := #4'{.+}'#4'{.+}'#4;
end;

procedure TddRelPublishFilter.Cleanup;
begin
 FreeAndNil(f_REPrimary);
 FreeAndNil(f_RESecondary);
 FreeAndNil(f_LinkSearcher);
 inherited;
end;

procedure TddRelPublishFilter.DeleteSegments(aLeaf: Tl3Variant; aStart: Integer);
var
 O: InevObject;
begin
 aLeaf.QT(InevObject, O);
 O.SubRange(nil, aStart, MaxInt).Formatting.Modify(nil).DeleteSegments;
 O.SubRange(nil, aStart, MaxInt).Formatting.Modify(nil).DeleteHyperlink;
end;

procedure TddRelPublishFilter.DoWritePara(aLeaf: Tl3Variant);
var
 l_Text: Tl3WString;
 l_MP  : Tl3MatchPosition;
 l_NewText: Il3CString;
begin
 l_Text := aLeaf.PCharLenA[k2_tiText];
 if f_REPrimary.SearchInString(l_Text, l_MP) then
  InsertPubText(aLeaf, f_REPrimary.TagParts[0].AsWStr, 'опубликован ')
 else
  if f_RESecondary.SearchInString(l_Text, l_MP) then
  begin
   if l3Pos(NormalizePubText(f_RESecondary.TagParts[0].AsWStr), f_NormPubText.AsWStr) >= 0 then
    f_WorkResult := wrAlreadyExist
   else
    InsertPubText(aLeaf, f_RESecondary.TagParts[0].AsWStr, ', ');
  end;
 inherited;
end;

procedure TddRelPublishFilter.InsertPubText(aLeaf: Tl3Variant; aFoundText: Tl3WString; const
    atext: AnsiString);
var
 l_NewText: Il3CString;
 l_Start, l_Finish: Integer;
 l_DotPos: Integer;
 l_Addr: Tl3Tag;
 l_Seg: Tl3Tag;
 l_DocID, l_SubID: Integer;
begin
 // Нужно удалить все ссылки после aFoundText
 DeleteSegments(aLeaf, aFoundText.SLen);
 if f_address = '' then
 begin
  l_NewText := l3Cat([l3CStr(aFoundText), l3CStr(aText), f_PubText, f_ArticleNoStr]);
  aLeaf.PCharLenA[k2_tiText] := Tl3PCharLen(l_NewText.AsWStr);
 end
 else
 begin
  l_NewText := l3Cat([l3CStr(aFoundText), l3CStr(aText)]);
  l_Start:= l_NewText.AsWStr.SLen + f_LinkStart;
  l_Finish:= l_NewText.AsWStr.SLen + f_LinkFinish;
  l_NewText:= l3Cat([l_Newtext, f_Pubtext, f_ArticleNoStr]);
  aLeaf.PCharLenA[k2_tiText] := Tl3PCharLen(l_NewText.AsWStr);
  if NoLinkAtPos(aLeaf, l_Start, l_Finish) then
  begin
   l_DotPos:= Pos('.', f_Address);
   if l_DotPos = 0 then
   begin
    l_DocID:= strToIntDef(f_Address, 0);
    l_SubId:= 0;
   end
   else
   begin
    l_DocID:= strToIntDef(Copy(f_Address, 1, Pred(l_DotPos)), 0);
    l_SubID:= strToIntDef(Copy(f_Address, Succ(l_DotPos), maxInt), 0);
   end;
   if l_DocID <> 0 then
   begin
    l_DocID:= Linkserver(CurrentFamily).Renum.ConvertExternalDocNumberToInternal(l_DocID);
    with aLeaf.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil) do
    begin
     l_Seg := k2_typHyperLink.MakeTag.AsObject;
     l_Seg.IntA[k2_tiStart]  := l_Start;
     l_Seg.IntA[k2_tiFinish] := l_Finish;

     l_Addr := k2_typAddress.MakeTag.AsObject;
     l_Addr.IntA[k2_tiDocID] := l_DocID;
     l_Addr.IntA[k2_tiSubID] := l_SubID;
     l_Seg.AddChild(l_Addr);

     AddChild(l_Seg);
    end; // aLeaf.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, ev_slHyperlinks], nil)
   end; // l_DocID <> 0
  end; // NoLinkAtPos(aLeaf, l_Start, l_Finish)
 end;
 f_WorkResult := wrDidTheJob;
end;

procedure TddRelPublishFilter.NextDoc;
begin
 f_WorkResult := wrNotFound;
end;

function TddRelPublishFilter.NoLinkAtPos(aLeaf: Tl3Variant; aStart, aEnd: Longint): Boolean;
var
 l_Layer: Tl3Variant;
begin
 l_Layer := aLeaf.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil);
 Result := evIsSegmentsLayerEmpty(aLeaf, aLeaf.AsObject, aStart, aEnd);
end;

function TddRelPublishFilter.NormalizePubText(const aStr: Tl3WString): Il3CString;
begin
 Result := l3Upper(aStr);
 l3Replace(Result, cc_NonReadable + [cc_SoftSpace], ' ');
 l3Replace(Result, ['№'], 'N');
end;

procedure TddRelPublishFilter.pm_SetArticleNo(const Value: Integer);
begin
 f_ArticleNo := Value;
 if f_ArticleNo > 0 then
  f_ArticleNoStr := l3Cat([l3CStr(' '), l3CStr(IntToStr(f_ArticleNo))])
 else
  f_ArticleNoStr := nil;
end;

procedure TddRelPublishFilter.pm_SetPubText(const Value: Il3CString);
var
 l_MP  : Tl3MatchPosition;
begin
 f_PubText := Value;
 f_LinkStart:= -1;
 f_LinkFinish:= -1;
 f_Address:= '';
 if f_LinkSearcher.SearchInString(f_PubText.AsWStr, l_MP) then
 begin
  // Удалить оформление ссылки
  l3Delete(f_PubText, l_MP.StartPos, l_MP.Length);
  // вставить TagParts[0]
  l3Insert(f_PubText, l_MP.StartPos, f_LinkSearcher.TagParts[0].AsString);
  // Запомнить начало-конец
  f_LinkStart:= l_MP.StartPos + 1;
  f_LinkFinish:= f_LinkStart + f_LinkSearcher.TagParts[0].AsWStr.SLen - 1;
  f_Address:= f_LinkSearcher.TagParts[1].AsString;
 end;
 f_NormPubText := NormalizePubText(f_PubText.AsWStr);
end;

end.