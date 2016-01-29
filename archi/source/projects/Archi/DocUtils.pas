unit DocUtils;

{$Include l3Define.inc}

interface

uses
 l3Base, l3Types,
 DT_Types, DT_Const, DT_Doc, dtIntf,
 DocIntf,
 l3LongintList
 ;

//procedure duLoadAndSaveDoc(aFamID : TFamilyID; aDocID  : TDocID);

function  EraseSpecialParaWithHyperlinks(aDocument : TarCustomDocument; aDocList: Tl3LongintList; aParaStyleID: Integer): Boolean;

procedure ReplaceReferences(aFamID : TFamilyID; aDocList : ISab;
                            aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID);
  overload;
procedure ReplaceReferences(aFamID : TFamilyID; aDocList : ISab;
                            const aReplaceArr : array of TReplaceDocPair);
  overload;
implementation

{$INCLUDE ProjectDefine.inc}

uses
 l3Interfaces,
 
 k2Interfaces, 
 k2Tags,

 afwNavigation,
 
 evInternalInterfaces,
 evTypes,
 evIntf, 
 evSearch,
 evParaTools,
 evFacadeSelection,

 nevNavigation,

 nevTools;

{
procedure duLoadAndSaveDoc(aFamID : TFamilyID; aDocID  : TDocID);
var
 lSprID : TDocID;
begin
 with TarDocument.CreateParam(aFamID, aDocID) do
 try
  //LoadText;
  TextSource.FakeSaveText;
  lSprID := DocData.Card^.Related;
 finally
  Free;
 end;

 if lSprID > 0 then
  with TarDocument.CreateParam(aFamID, lSprID) do
  try
   //LoadText;
   TextSource.FakeSaveText;
  finally
   Free;
  end;
end;
}

type
 TidsHyperlinkSearcher = class(TevCustomHyperlinkSearcher)
 private
  f_DocList : Tl3LongintList;
  f_StyleID : Integer;

  procedure SetDocList(aValue : Tl3LongintList);
 protected
  procedure Cleanup; override;
  function DoHyperlinkSearch(const aHLink : IevHyperLink): Bool; override;
 public
  function DoCheckText(aPara : Tl3Variant;
                       aText       : Tl3CustomString;
                       const aSel  : TevPair;
                       out theSel : TevPair): Bool;
   override;
 public
  property StyleID: Integer
   read f_StyleID                            
   write f_StyleID;

   property DocList : Tl3LongintList
   read f_DocList
   write SetDocList;
 end;

 TidsDeleteParaReplacer = class(TevBaseReplacer)
 private                                                
 protected
  function  ReplaceFunc(const aView : InevView;
                        const Container : InevOp;
                        const aBlock    : InevRange): Bool; override;
 public
 end;

{ TddHyperlinkSearcher }

function TidsHyperlinkSearcher.DoCheckText(aPara : Tl3Variant;
                                           aText       : Tl3CustomString;
                                           const aSel  : TevPair;
                                           out theSel  : TevPair): Bool;
begin
 Result := False;
 if inherited DoCheckText(aPara, aText, aSel, theSel) then
 begin
  with aPara.Attr[k2_tiStyle] do
   if IsValid and (AsLong = f_StyleID) then
   begin
    theSel.rStart := 0;
    theSel.rFinish := aText.Len;
    Result := True;
   end;
 end;//inherited DoCheckText
end;

// start class TevHyperlinkSearcher
procedure TidsHyperlinkSearcher.SetDocList(aValue : Tl3LongintList);
begin
 l3Set(f_DocList, aValue);
end;

procedure TidsHyperlinkSearcher.Cleanup;
  {-}
begin
 l3Free(f_DocList);
 inherited;
end;

function TidsHyperlinkSearcher.DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
  //override;
  {-}
var
 lCurAddr : TevAddress;
 l_Index  : Integer;
begin
  Result := false;
  if (aHLink.AddressList.Count = 0) then Exit;
  for l_Index := 0 to Pred(aHLink.AddressList.Count) do
  begin
   lCurAddr := aHLink.AddressList[l_Index];
   if f_DocList.IndexOf(aHLink.AddressList[l_Index]{$IfDef XE4}.rTafwAddress{$EndIf}.DocID) > -1 then
   begin
    Result := True;
    Break;
   end;//(lCurAddr.DocID = DocID) or (DocID < 0)
  end;//for I
end;

{ TidsHyperlinkReplacer }

function TidsDeleteParaReplacer.ReplaceFunc(const aView : InevView;
                                            const Container : InevOp;
                                            const aBlock    : InevRange): Bool;
begin
 Result := evDeleteBlockEX(aView, Container, aBlock);
end;


function EraseSpecialParaWithHyperlinks(aDocument : TarCustomDocument; aDocList: Tl3LongintList; aParaStyleID: Integer): Boolean;
var
 l_HLSearcher: TidsHyperlinkSearcher;
 l_HLReplacer: TidsDeleteParaReplacer;
{$IFNDEF ARCHI_OLD_EVEREST}
 l_Document   : InevPara;
{$ENDIF ARCHI_OLD_EVEREST}
begin
 l_HLSearcher:= TidsHyperlinkSearcher.Create(nil);
 try
  l_HLSearcher.Options:= l_HLSearcher.Options+[ev_soReplace, ev_soReplaceAll];
  l_HLSearcher.DocList := aDocList;
  l_HLSearcher.StyleID:= aParaStyleID;
  l_HLReplacer:= TidsDeleteParaReplacer.Create(nil);
  try
   l_HLReplacer.Options:= l_HLSearcher.Options;
   try
{$IFDEF ARCHI_OLD_EVEREST}
    evReplaceInPara(aDocument.TextSource.Document, l_HLSearcher, l_HLReplacer);
{$ELSE}
    if aDocument.TextSource.Document.QT(InevPara, l_Document) then
     evReplaceInPara(l_Document, l_HLSearcher, l_HLReplacer);
{$ENDIF ARCHI_OLD_EVEREST}
    Result:= True;
   except
    Result:= False;
   end;
  finally
   l3Free(l_HLReplacer);
  end;
 finally
  l3Free(l_HLSearcher);
 end;
end;

// замена в таблицах
//проблема: бывают ссылки, адреса которых не попали в таблицу
procedure ReplaceReferences(aFamID : TFamilyID; aDocList : ISab;
                            aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID);
begin
 DocumentServer(aFamID).ChangeDestDoc(aSearchHLDocID, aReplaceHLDocID, cAnySubId, nil, aDocList);
end;

procedure ReplaceReferences(aFamID : TFamilyID; aDocList : ISab;
                            const aReplaceArr : array of TReplaceDocPair);
begin
 DocumentServer(aFamID).ChangeDestDoc(aReplaceArr, aDocList);
end;

//HyperLinkTbl.ChangeDestAddr(const aRelaceArr : array of TReplaceDocPair;
//                                      const aSourDocs: ISab = nil);

(*
поиск/замена в тексте
procedure ReplaceReferences(aDocument : TarDocument; aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID);
var
 fHLinkSearcher             : TarHyperlinkSearcher;
 fHLinkReplacer             : TarHyperLinkReplacer;

begin
 fHLinkSearcher := TarHyperlinkSearcher.Create(Self);
 fHLinkSearcher.OnHyperlinkSearch := HLinkSearcherHyperlinkSearch;

 fHLinkReplacer := TarHyperLinkReplacer.Create(Self);
 fHLinkReplacer.OnHyperlinkReplace := HLinkReplacerHyperlinkReplace;
 fHLinkReplacer.OnFinishReplace  := evntFinishReplace;


 fHLinkSearcher.SearchAddr := DestHLinkRec(aSearchHLDocID, -1);
 LastSrchRec.Searcher := fHLinkSearcher;

 fHLinkReplacer.ReplaceAddr := DestHLinkRec(aReplaceHLDocID, -1);
 LastSrchRec.Replacer := fHLinkReplacer;

 //LastSrchRec.Operation := 1;

 LastSrchRec.SFlags := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];

 LastSrchRec.Searcher.Options := LastSrchRec.SFlags;
 LastSrchRec.Replacer.Options := LastSrchRec.SFlags;

 try
 (FEditor As TevEditor).Find(LastSrchRec.Searcher, LastSrchRec.Replacer, LastSrchRec.SFlags);
 except
  on EevSearchFailed do;
 end;
end;

end;

procedure ReplaceReferences(aFamID : TFamilyID; aDocID  : TDocID; aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID);
var
 lDoc : TarDocument;
begin
 lDoc := TarDocument.CreateParam(aFamID, aDocID);
 try
  ReplaceReferences(lDoc, aSearchHLDocID, aReplaceHLDocID);
 finally
  l3Free(lDoc);
 end;
end;
*)
end.
