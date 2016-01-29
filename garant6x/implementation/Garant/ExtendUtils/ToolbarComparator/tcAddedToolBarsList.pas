unit tcAddedToolBarsList;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItemList
 ;

type
 TtcAddedToolBarsList = class(TtcItemList,
                              ItcAddedToolBarsList)
 protected
 // ItcAddedToolBarsList
  function pm_GetToolBar(Index: Integer): ItcAddedToolBar;
  function ItcAddedToolBarsList.Add = ItcAddedToolBarsList_Add;
  function ItcAddedToolBarsList_Add(const anID: Il3CString): ItcAddedToolBar;
  procedure AssignToItem(const aSource, aTarget: ItcItem); override;
 protected
  procedure AddExisting(const anItem: ItcItem); override;
  function MakeItem(const anID: Il3CString): ItcItem; override;
 public
  class function Make: ItcAddedToolBarsList;
 end;


implementation

uses
 SysUtils,
 
 tcAddedToolBar;


{ TtcAddedToolBarsList }

procedure TtcAddedToolBarsList.AddExisting(const anItem: ItcItem);
begin
 Assert(False);
end;

procedure TtcAddedToolBarsList.AssignToItem(const aSource,
  aTarget: ItcItem);
begin
 Assert(False);
end;

function TtcAddedToolBarsList.ItcAddedToolBarsList_Add(
  const anID: Il3CString): ItcAddedToolBar;
begin
 Result := Add(anID) as ItcAddedToolBar;
end;

class function TtcAddedToolBarsList.Make: ItcAddedToolBarsList;
var
 l_Instance: TtcAddedToolBarsList;
begin
 l_Instance := Create;
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

function TtcAddedToolBarsList.MakeItem(const anID: Il3CString): ItcItem;
begin
 Result := TtcAddedToolBar.Make(anID);
end;

function TtcAddedToolBarsList.pm_GetToolBar(
  Index: Integer): ItcAddedToolBar;
begin
 Result := pm_GetItem(Index) as ItcAddedToolBar;
end;

end.
