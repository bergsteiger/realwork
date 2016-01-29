unit tcChangedToolBarsList;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItemList
 ;

type
 TtcChangedToolBarsList = class(TtcItemList,
                                ItcChangedToolBarsList)
 protected
 // ItcChangedToolBarsList
  function pm_GetToolBar(Index: Integer): ItcChangedToolBar;
  function ItcChangedToolBarsList.Add = ItcChangedToolBarsList_Add;
  function ItcChangedToolBarsList_Add(const anID: Il3CString): ItcChangedToolBar;
  procedure AssignToItem(const aSource, aTarget: ItcItem); override;
 protected
  procedure AddExisting(const anItem: ItcItem); override;
  function MakeItem(const anID: Il3CString): ItcItem; override;
 public
  class function Make: ItcChangedToolBarsList;
 end;

implementation

uses
 SysUtils,
 
 tcChangedToolBar
 ;

{ TtcChangedToolBarsList }

procedure TtcChangedToolBarsList.AddExisting(const anItem: ItcItem);
begin
 Assert(False);
end;

procedure TtcChangedToolBarsList.AssignToItem(const aSource,
  aTarget: ItcItem);
begin
 Assert(False);
end;

class function TtcChangedToolBarsList.Make: ItcChangedToolBarsList;
var
 l_Instance: TtcChangedToolBarsList;
begin
 l_Instance := Create;
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

function TtcChangedToolBarsList.MakeItem(const anID: Il3CString): ItcItem;
begin
 Result := TtcChangedToolBar.Make(anID);
end;

function TtcChangedToolBarsList.pm_GetToolBar(
  Index: Integer): ItcChangedToolBar;
begin
 Result := pm_GetItem(Index) as ItcChangedToolBar;
end;

function TtcChangedToolBarsList.ItcChangedToolBarsList_Add(
  const anID: Il3CString): ItcChangedToolBar;
begin
 Result := Add(anID) as ItcChangedToolBar;
end;

end.
