unit tcToolBarsList;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItemList
 ;

type
 TtcToolBarsList = class(TtcItemList,
                         ItcToolBarsList)
 protected
 // ItcToolBarsList
  function pm_GetToolBar(Index: Integer): ItcToolbar;
  function ItcToolBarsList.Add = ItcToolBarsList_Add;
  function ItcToolBarsList_Add(const anID: Il3CString): ItcToolBar;
  procedure ItcToolBarsList.AddExisting = ItcToolBarsList_AddExisting;
  procedure ItcToolBarsList_AddExisting(const aToolBar: ItcToolBar);
  procedure AssignToItem(const aSource, aTarget: ItcItem); override;
 protected
  procedure AddExisting(const anItem: ItcItem); override;
  function MakeItem(const anID: Il3CString): ItcItem; override;
 public
  class function Make: ItcToolBarsList;
 end;

implementation

uses
 SysUtils,
 
 tcToolBar;

{ TtcToolBarsList }

procedure TtcToolBarsList.AddExisting(const anItem: ItcItem);
begin
 if not Supports(anItem, ItcToolBar) then
  raise Exception.Create('Native interface not supported');
 inherited AddExisting(anItem);
end;

procedure TtcToolBarsList.AssignToItem(const aSource, aTarget: ItcItem);
var
 l_Source: ItcToolBar;
 l_Target: ItcToolBar;
 l_IDX: Integer;
begin
 inherited AssignToItem(aSource, aTarget);
 if Supports(aSource, ItcToolBar, l_Source) and
    Supports(aTarget, ItcToolBar, l_Target) then
 begin
  l_Target.Editable := l_Source.Editable;
  for l_IDX := 0 to l_Source.ChildToolBars.Count - 1 do
   l_Target.ChildToolBars.AddExisting(l_Source.ChildToolBars.ToolBar[l_IDX]);
  for l_IDX := 0 to l_Source.Operations.Count - 1 do
   l_Target.Operations.AddExisting(l_Source.Operations.Operation[l_IDX]);
 end;
end;

function TtcToolBarsList.ItcToolBarsList_Add(
  const anID: Il3CString): ItcToolBar;
begin
 Result := Add(anID) as ItcToolBar;
end;

procedure TtcToolBarsList.ItcToolBarsList_AddExisting(
  const aToolBar: ItcToolBar);
begin
 AddExisting(aToolBar);
end;

class function TtcToolBarsList.Make: ItcToolBarsList;
var
 l_Instance: TtcToolBarsList;
begin
 l_Instance := Create;
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

function TtcToolBarsList.MakeItem(const anID: Il3CString): ItcItem;
begin
 Result := TtcToolBar.Make(anID);
end;

function TtcToolBarsList.pm_GetToolBar(Index: Integer): ItcToolbar;
begin
 Result := pm_GetItem(Index) as ItcToolBar;
end;

end.
