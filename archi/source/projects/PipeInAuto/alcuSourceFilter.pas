unit alcuSourceFilter;
{ Фильтрует документы по принаджлежности к исходящим органам }



interface

uses
 evdBufferedFilter,
 k2Interfaces,
 l3LongintList, Classes, k2TagGen, l3Types, ddTypes;

type
 TalcuSourceDocFilter = class(TevdChildBufferedFilter)
 private
  f_AllowedSources: TStrings;
  f_OnError: TddErrorEvent;
 protected
        {* - Функция, определяющая тип Тегов, для которых будет выполняться буферизация.}
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
 public
    // public methods
  constructor Create(aChildID: Integer; aSources: Tl3LongintList; anOwner: Tk2TagGeneratorOwner =
      nil); reintroduce;
  procedure Cleanup; override;
  procedure ExpandSources(aSources: Tl3LongintList);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aChildID: Long; aSources: Tl3LongintList):
      Pointer; overload;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

implementation

uses
 SysUtils,
 l3Variant,
 k2Tags,
 l3Base,

 daTypes,
 daSchemeConsts,

 DT_Types, DT_Const, dt_AttrSchema,
 dtIntf, dt_Sab, DT_Dict;


{TevdChildBufferedFilter}
constructor TalcuSourceDocFilter.Create(aChildID: Integer; aSources: Tl3LongintList; anOwner:
    Tk2TagGeneratorOwner = nil);
begin
 Inherited Create(aChildID, anOwner);
 f_AllowedSources:= TStringList.Create;
 ExpandSources(aSources);
end;

procedure TalcuSourceDocFilter.Cleanup;
begin
 l3Free(f_AllowedSources);
 inherited;
end;

procedure TalcuSourceDocFilter.ExpandSources(aSources: Tl3LongintList);
var
 l_Sab: ISab;
 l_List: Tl3LongintList;
 i: Integer;
begin
 if aSources <> nil then
 begin
  l_List:= Tl3LongintList.MakeSorted;
  try
   l_List.Assign(aSources);
   l_Sab := GetExpandDictIDValueSab(da_dlSources, l_List);
   l_List.Clear;
   dtCopyValuesSabToList(l_Sab, l_List);
   f_AllowedSources.Clear;
   for i:= 0 to l_List.Hi do
    f_AllowedSources.Add(DictServer(CurrentFamily).Dict[da_dlSources].GetFullDictItemName(l_List.Items[i], False));
  finally
   L3Free(l_List);
   l_Sab := nil;
  end;
 end;
end;

function TalcuSourceDocFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
var
 i: Integer;
 l_S: Tl3Tag;
begin
 Result := true;
 if aLeaf.Attr[k2_tiSources].IsValid then
 begin
  for i:= 0 to Pred(aLeaf.Attr[k2_tiSources].ChildrenCount) do
  begin
   if f_AllowedSources.IndexOf(Trim(aLeaf.Attr[k2_tiSources].Child[i].StrA[k2_tiName])) = -1 then
   begin
    Result:= False;
    if Assigned(f_OnError) then
     f_Onerror('Неверный Исх.орган "'+ aLeaf.Attr[k2_tiSources].Child[i].StrA[k2_tiName] + '"')
    else
     l3System.Msg2Log('Неверный Исх.орган "%s"', [aLeaf.Attr[k2_tiSources].Child[i].StrA[k2_tiName]]);
    break;
   end;
  end;
 end;
end;

class function TalcuSourceDocFilter.SetTo(var theGenerator: Tk2TagGenerator; aChildID: Long;
    aSources: Tl3LongintList): Pointer;
  {-}
var
 l_Filter : TevdChildBufferedFilter;
begin
 l_Filter := Create(aChildID, aSources, nil);
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
