unit tcItemList;

interface

uses
 l3Interfaces,
 l3CacheableBase,

 tcInterfaces
 ;

type
 TtcItemList = class(Tl3CacheableBase,
                     ItcItemList)
 private
  f_List: Il3StringsEx;
 protected
  // ItcItemList
  function pm_GetCount: Integer;
  function pm_GetItem(Index: Integer): ItcItem;
  function Add(const anID: Il3CString): ItcItem;
  procedure AddExisting(const anItem: ItcItem); virtual;
 protected
  procedure Cleanup; override;
  function MakeItem(const anID: Il3CString): ItcItem; virtual; abstract;
  procedure AssignToItem(const aSource, aTarget: ItcItem); virtual;
 public
  constructor Create; reintroduce;
 end;

implementation

uses
 SysUtils,

 l3VCLStrings,
 l3StringListPrim;

{ TtcItemList }

function TtcItemList.Add(const anID: Il3CString): ItcItem;
var
 l_Index: Integer;
begin
 l_Index := f_List.IndexOf(anID);
 if l_Index = -1 then
 begin
  Result := MakeItem(anID);
  Result._AddRef;
  f_List.AddObject(anID, TObject(Pointer(Result)));
 end
 else
  Result := pm_GetItem(l_Index);
end;

procedure TtcItemList.AddExisting(const anItem: ItcItem);
var
 l_Index: Integer;
begin
 l_Index := f_List.IndexOf(anItem.ID);
 if l_Index = -1 then
 begin
  anItem._AddRef;
  f_List.AddObject(anItem.ID, TObject(Pointer(anItem)));
 end
 else
  AssignToItem(anItem, pm_GetItem(l_Index));
end;

procedure TtcItemList.AssignToItem(const aSource, aTarget: ItcItem);
begin
 aTarget.Caption := aSource.Caption;
end;

procedure TtcItemList.Cleanup;
var
 l_IDX: Integer;
begin
 if Assigned(f_List) then
 begin
  for l_IDX := 0 to f_List.Count - 1 do
  begin
   pm_GetItem(l_IDX)._Release;
   f_List.Objects[l_IDX] := nil;
  end;
 end; 
 f_List := nil;
 inherited Cleanup;
end;

constructor TtcItemList.Create;
var
 l_Strings: Tl3Strings;
begin
 inherited Create;
 l_Strings := Tl3Strings.MakeSorted;
 try
  f_List := l_Strings;
 finally
  FreeAndNil(l_Strings);
 end;
end;

function TtcItemList.pm_GetCount: Integer;
begin
 Result := f_List.Count;
end;

function TtcItemList.pm_GetItem(Index: Integer): ItcItem;
begin
 Result := ItcItem(Integer(f_List.Objects[Index]));
end;

end.
