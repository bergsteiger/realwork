unit bcLinksFilter;

interface
uses
 l3Base,
 l3RegEx,
 l3Variant,

 k2TagGen,
 evdBufferedFilter,

 ddTypes,

 bcInterfaces
 ;

type
 TbcLinksFilter = class(TevdChildBufferedFilter)
 private
  f_OnError: TddErrorEvent;
  f_RE: Tl3RegularSearch;
  f_TD: IbcTopicDispatcher;
  procedure Report(const aMsg: AnsiString);
 protected
  procedure Cleanup; override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
 public
  constructor Create; reintroduce;
  class function SetTo(var theGenerator: Tk2TagGenerator; const aTD: IbcTopicDispatcher; aOnError: TddErrorEvent = nil): Pointer; overload;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

implementation
uses
 l3Interfaces,
 l3String,
 SysUtils,
 k2Tags,
 Address_Const,
 Hyperlink_Const, l3StringListPrim;

const
 cNumSearchPattern = '(text\.asp((\?)|(\%3f))RN\=(\%3c)?{\c(\d|\c|_)+})|({\c(\d|\c|_)+}\.htm)|(^BCLINK\:({[\d\c]+}\s)+)';

constructor TbcLinksFilter.Create;
begin
 inherited Create(k2_idHyperlink);
 f_RE := Tl3RegularSearch.Create;
 f_RE.SearchPattern := cNumSearchPattern;
end;

procedure TbcLinksFilter.Cleanup;
begin
 FreeAndNil(f_RE);
 f_TD := nil;
 inherited;
end;

procedure TbcLinksFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 I: Integer;
 l_MP: Tl3MatchPosition;
 l_URL: Tl3WString;
 l_Addr: Tl3Variant;
 l_DocID: Longword;
 l_LinkIsValid: Boolean;
begin
 if aLeaf.Attr[k2_tiUrl].IsValid then
 begin
  l_URL := aLeaf.Attr[k2_tiURL].AsWStr;
  if f_RE.SearchInString(l_URL, l_MP) then
  begin
   l_LinkIsValid := False;
   for I := 0 to f_RE.TagParts.Count - 1 do
   begin
    if (f_RE.TagParts.ItemW[0].SLen in [8..15]) then
     l_DocID := f_TD.GetTopic(f_RE.TagParts.ItemW[I]) // получаем только те топики, что есть в базе
    else
     l_DocID := 0;
    if l_DocID <> 0 then
    begin
     l_Addr := k2_typAddress.MakeTag.AsObject;
     l_Addr.IntA[k2_tiDocID] := l_DocID;
     aLeaf.AddChild(l_Addr);
     l_LinkIsValid := True;
    end;
   end;
   if not l_LinkIsValid then
    Exit; // если среди топиков не было ни одного валидного
  end
  else
  begin
   if (l_URL.SLen > 0) and (l_URL.S[0] <> '#') then // ссылки на якоря внутри самого дока не рапортуем - их слишком много
    Report(Format('неизвестный формат URL: %s', [l3Str(l_URL)]));
   Exit; // вообще выкидываем гиперлинк из потока
  end;
  aLeaf.AttrW[k2_tiURL, nil] := nil;
 end
 else
  if aLeaf.ChildrenCount = 0 then // если нет уже проставленных адресов
   Exit; // вообще выкидываем гиперлинк из потока
 inherited DoFlushBuffer(aLeaf, aTagId, aNeedCloseBracket);
end;

procedure TbcLinksFilter.Report(const aMsg: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg);
end;

class function TbcLinksFilter.SetTo(var theGenerator: Tk2TagGenerator; const aTD: IbcTopicDispatcher; aOnError:
 TddErrorEvent = nil): Pointer;
var
 l_Filter : TbcLinksFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.f_TD := aTD;
  l_Filter.f_OnError := aOnError;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
