unit npbAttributesFilter;

{
 <a:AccGroups>
 <a:Groups>
 <a:Classes>
 <a:Prefix>
 <a:ServiceInfo>
 <a:Subs>
 <a:LogRecords>
 <a:Stages>
 <a:Checks>
 <p:SortDate>
 <p:RelExternalHandle
 <p:Priority 
 <p:PriceLevel 
 <p:ContentsLevel6
 <p:ContentsLevel5
 <a:SysLogRecords>
 <a:KeyWords>
<a:LinkedDocuments> 
<p:Urgency v="1"/>
<p:MaxSubID
}

interface

uses
  k2TagTerminator,

  l3Types,
  l3Variant,

  k2Types,
  k2TagFilter,
  k2TagGen,
  k2Tags,
  k2Prim
  ;

type
 TnpbAttributesFilter = class(Tk2TagFilter)
 private
  function FilterDocumentAttributes(AtomIndex: Long): Boolean;
  function TagToSkip(aTagID: Integer): Boolean;
 protected
  f_Attr: Array of Integer;
  procedure CloseStructure(NeedUndo: Bool); override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
        {-}
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
        {-}
  class function SetTo(var theGenerator: TnpbAttributesFilter; const Attributes: Array of Integer):
      Pointer; overload;
        {* - начать вложеный тег. }
  procedure StartChild(TypeID: Tl3VariantDef); override;
        {-}
  procedure StartTag(TagID: Long); override;
 end;

 TnpbAttributesFilterEx = class(TnpbAttributesFilter)
 protected
  procedure CloseStructure(NeedUndo: Bool); override;
 public
        {-}
  procedure StartTag(TagID: Long); override;
 end;

implementation

uses
 document_const, l3Base;

constructor TnpbAttributesFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
end;

procedure TnpbAttributesFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_ValidAtom: Boolean;
begin
 l_ValidAtom:= True;
 if CurrentType.IsKindOf(k2_typDocument) then
  l_ValidAtom:= FilterDocumentAttributes(AtomIndex);
 if l_ValidAtom then
  inherited AddAtomEx(AtomIndex, Value);
end;

function TnpbAttributesFilter.FilterDocumentAttributes(AtomIndex: Long): Boolean;
begin
 Result:= not (AtomIndex in [{k2_tiInternalHandle, k2_tiRelExternalHandle, k2_tiShortName,} k2_tiPriority,
                             k2_tiPriceLevel, {k2_tiType,} k2_tiContentsLevel6, k2_tiContentsLevel5,
                             k2_tiUrgency, k2_tiMaxSubID, k2_tiSortDate]);
end;

procedure TnpbAttributesFilter.CloseStructure(NeedUndo: Bool);
begin
 if TopObject[0].IsProp and TagToSkip(TopObject[0].AsProp.TagIndex) then
 (*
 if TopObject[0].IsProp and (TopObject[0].AsProp.TagIndex in [k2_tiAccGroups, k2_tiGroups, k2_tiClasses, k2_tiPrefix, k2_tiServiceInfo, k2_tiSubs,
                    k2_tiLogRecords, k2_tiStages, k2_tiChecks, k2_tiSysLogRecords, k2_tiKeyWords,
                    k2_tiLinkedDocuments, k2_tiMDPPageID, k2_tiAlarms]) then *)
  DecSkipTags;
 inherited CloseStructure(NeedUndo);
end;

class function TnpbAttributesFilter.SetTo(var theGenerator: TnpbAttributesFilter; const Attributes:
    Array of Integer): Pointer;
var
 l_Filter : TnpbAttributesFilter;
 i: Integer;
 l_Attr: Array of Integer;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
  SetLength(l_Filter.f_Attr, Length(Attributes));
  for i:= 0 to High(Attributes) do
   l_Filter.f_Attr[i]:= Attributes[i];
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TnpbAttributesFilter.StartChild(TypeID: Tl3VariantDef);
begin
 inherited StartChild(TypeID);
end;

procedure TnpbAttributesFilter.StartTag(TagID: Long);
begin
 if TagToSkip(TagID) then
 (*if TagID in f_Attr [k2_tiAccGroups, k2_tiGroups, k2_tiClasses, k2_tiPrefix, k2_tiServiceInfo, k2_tiSubs,
                    k2_tiLogRecords, k2_tiStages, k2_tiChecks, k2_tiSysLogRecords, k2_tiKeyWords,
                    k2_tiLinkedDocuments, k2_tiMDPPageID, k2_tiAlarms] then *)
  IncSkipTags;
 inherited StartTag(TagID);
end;

function TnpbAttributesFilter.TagToSkip(aTagID: Integer): Boolean;
var
 i: Integer;
begin
 Result := False;
 for i:= Low(f_Attr) to High(f_Attr) do
  if aTagID = f_Attr[i] then
  begin
   Result:= True;
   break
  end
end;

procedure TnpbAttributesFilterEx.CloseStructure(NeedUndo: Bool);
begin
 if TopObject[0].IsProp and (TopObject[0].AsProp.TagIndex in [k2_tiAccGroups, k2_tiGroups, k2_tiPrefix, k2_tiServiceInfo, k2_tiSubs,
                    k2_tiLogRecords, k2_tiStages, k2_tiChecks, k2_tiSysLogRecords, k2_tiKeyWords,
                    k2_tiLinkedDocuments, k2_tiMDPPageID, k2_tiAlarms, k2_tiPublishedIn, k2_tiActiveIntervals]) then
  DecSkipTags;
 inherited CloseStructure(NeedUndo);
end;

procedure TnpbAttributesFilterEx.StartTag(TagID: Long);
begin
 if TagID in [k2_tiAccGroups, k2_tiGroups, k2_tiPrefix, k2_tiServiceInfo, k2_tiSubs,
                    k2_tiLogRecords, k2_tiStages, k2_tiChecks, k2_tiSysLogRecords, k2_tiKeyWords,
                    k2_tiLinkedDocuments, k2_tiMDPPageID, k2_tiAlarms, k2_tiPublishedIn, k2_tiActiveIntervals] then
  IncSkipTags;
 inherited StartTag(TagID);
end;

end.
