unit arDeliveryList;

interface

uses
 Classes,

 l3ProtoObject,

 csDataPipe,
 dt_Types
 ;

type
 TarDeliveryList = class(Tl3ProtoObject)
 private
  f_List: TStrings;
  f_UserID: TUserID;
  function pm_GetCount: Integer;
  function pm_GetTaskID(anIndex: Integer): String;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aUserID: TUserID);
  procedure Communicate(aPipe: TCsDataPipe);
  property Count: Integer read pm_GetCount;
  property TaskID[anIndex: Integer]: String read pm_GetTaskID; default;
 end;

implementation

uses
 SysUtils
 ;

{ TarDeliveryList }

procedure TarDeliveryList.Cleanup;
begin
 FreeAndNil(f_List);
 inherited Cleanup;
end;

procedure TarDeliveryList.Communicate(aPipe: TCsDataPipe);
var
 l_Count: Integer;
begin
 aPipe.WriteCardinal(f_UserID);
 l_Count := aPipe.ReadInteger;
 f_List.Clear;
 while l_Count > 0 do
 begin
  f_List.Add(aPipe.ReadLn);
  Dec(l_Count);
 end;
end;

constructor TarDeliveryList.Create(aUserID: TUserID);
begin
 inherited Create;
 f_UserID := aUserID;
 f_List := TStringList.Create;
end;

function TarDeliveryList.pm_GetCount: Integer;
begin
 Result := f_List.Count;
end;

function TarDeliveryList.pm_GetTaskID(anIndex: Integer): String;
begin
 Result := f_List[anIndex];
end;

end.