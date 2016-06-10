unit bcAngleBracketsFilter;

interface
uses
 l3RegEx,
 l3Variant,
 evdLeafParaFilter,
 k2TagGen,
 bcInterfaces;

type
 TbcAngleBracketsFilter = class(TevdLeafParaFilter)
 private
  f_RE: Tl3RegularSearch;
  f_TD: IbcTopicDispatcher;
 protected
  procedure Cleanup; override;
  procedure DoWritePara(aLeaf: Tl3Variant); override;
 public
  constructor Create; reintroduce;
  class function SetTo(var theGenerator: Tk2TagGenerator; const aTD: IbcTopicDispatcher): Pointer; overload;
 end;

implementation
uses
 SysUtils,
 l3Interfaces,
 l3Base,
 l3String,
 k2Tags,
 evdTypes,
 evdStyles,

 Hyperlink_Const,
 Address_Const, nevTools;

const
 cRegexp = '(\s+)?\<{\c[\d\c]+}\>';

constructor TbcAngleBracketsFilter.Create;
begin
 inherited Create(nil);
 f_RE := Tl3RegularSearch.Create;
 f_RE.SearchPattern := cRegexp;
end;

procedure TbcAngleBracketsFilter.Cleanup;
begin
 FreeAndNil(f_RE);
 inherited;
end;

procedure TbcAngleBracketsFilter.DoWritePara(aLeaf: Tl3Variant);
var
 I: Integer;
 l_MP: Tl3MatchPosition;
 l_DocID: Longword;
 l_Hyperlinks: Tl3Variant;
 l_HyperLink, l_Addr: Tl3Variant;
 l_Obj: InevObject;
 l_Point: InevPoint;
 l_Str: Il3CString;
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  l_Hyperlinks := nil;
  while f_RE.SearchInString(aLeaf.PCharLenA[k2_tiText], l_MP) do
  begin
   l_DocID := f_TD.GetTopic(f_RE.TagParts.ItemW[0]);
   if (l_DocID > 0) and aLeaf.Attr[k2_tiStyle].IsValid and (aLeaf.IntA[k2_tiStyle] = ev_saTxtNormalOEM) then
   begin
    if l_Hyperlinks = nil then
     l_Hyperlinks := aLeaf.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil);
    l_HyperLink := k2_typHyperlink.MakeTag.AsObject;
    l_HyperLink.IntW[k2_tiStart, nil] := l_MP.StartPos + 1;
    l_HyperLink.IntW[k2_tiFinish, nil] := l_MP.StartPos + 3;
    l_Addr := k2_typAddress.MakeTag.AsObject;
    l_Addr.IntW[k2_tiDocID, nil] := l_DocID;
    l_HyperLink.AddChild(l_Addr);
    l_Hyperlinks.AddChild(l_Hyperlink);
    l_Str := l3Cat([l3CStr(l3Copy(aLeaf.PCharLenA[k2_tiText], 0, l_MP.StartPos)),
                    l3CStr(' ->'),
                    l3CStr(l3Copy(aLeaf.PCharLenA[k2_tiText], l_MP.EndPos))]);
    aLeaf.PCharLenW[k2_tiText, nil] := l_Str.AsWStr;
   end
   else
   begin
    aLeaf.QT(InevObject, l_Obj);
    l_Point := l_Obj.MakePoint;
    l_Point.PositionW := l_MP.StartPos;
    l_Point.Text.Modify.DeleteString(nil, l_MP.EndPos - l_MP.StartPos);
   end;
  end;
 end;
 inherited;
end;

class function TbcAngleBracketsFilter.SetTo(var theGenerator: Tk2TagGenerator; const aTD: IbcTopicDispatcher): Pointer;
var
 l_Filter : TbcAngleBracketsFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.f_TD := aTD;
  //l_Filter.f_OnError := aOnError;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
