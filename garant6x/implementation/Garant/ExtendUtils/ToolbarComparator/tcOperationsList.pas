unit tcOperationsList;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItemList
 ;

type
 TtcOperationsList = class(TtcItemList,
                           ItcOperationsList)
 protected
  // ItcOperationsList
  function pm_GetOperation(Index: Integer): ItcOperation;
  function ItcOperationsList.Add = ItcOperationsList_Add;
  function ItcOperationsList_Add(const anID: Il3CString): ItcOperation;
  procedure ItcOperationsList.AddExisting = ItcOperationsList_AddExisting;
  procedure ItcOperationsList_AddExisting(const anOperation: ItcOperation);
 protected
  procedure AddExisting(const anItem: ItcItem); override;
  function MakeItem(const anID: Il3CString): ItcItem; override;
 public
  class function Make: ItcOperationsList;
 end;

implementation

uses
 SysUtils,
 
 tcOperation;

{ TtcOperationsList }

procedure TtcOperationsList.AddExisting(const anItem: ItcItem);
begin
 if not Supports(anItem, ItcOperation) then
  raise Exception.Create('Native interface not supported');
 inherited AddExisting(anItem);
end;

function TtcOperationsList.ItcOperationsList_Add(const anID: Il3CString): ItcOperation;
begin
 Result := Add(anID) as ItcOperation;
end;

procedure TtcOperationsList.ItcOperationsList_AddExisting(
  const anOperation: ItcOperation);
begin
 AddExisting(anOperation);
end;

class function TtcOperationsList.Make: ItcOperationsList;
var
 l_Instance: TtcOperationsList;
begin
 l_Instance := Create;
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

function TtcOperationsList.MakeItem(const anID: Il3CString): ItcItem;
begin
 Result := TtcOperation.Make(anID);
end;

function TtcOperationsList.pm_GetOperation(Index: Integer): ItcOperation;
begin
 Result := pm_GetItem(Index) as ItcOperation;
end;

end.
