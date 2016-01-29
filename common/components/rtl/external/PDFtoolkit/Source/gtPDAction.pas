{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
unit gtPDAction;

interface

uses
  PDTypes, PDApis, SysUtils, PDDestination;

type
  THackDest = class(TPDDestination)

  end;

  TPDAction = class
  private
    FDestination: TPDDestination;
    function GetType: Shortint;
    procedure SetActionType(const Value: Shortint);
    function GetDestination: TPDDestination;
    function GetHandle: TPDActionHandle;
    procedure SetHandle(const Value: TPDActionHandle);
  protected
    FActionHandle: TPDActionHandle;
    property Destination: TPDDestination read GetDestination;
  public
    constructor Create; overload;
    constructor Create(aHandle: Cardinal); overload;
    destructor Destroy; override;
    property ActionType: Shortint read GetType write SetActionType;
    property ActionHandle: TPDActionHandle read GetHandle write SetHandle;
  end;

var
  E: Exception;
implementation

{ TPDAction }

constructor TPDAction.Create;
begin
  FActionHandle := 0;
  FDestination := nil;
end;

constructor TPDAction.Create(aHandle: Cardinal);
begin
  FActionHandle := aHandle;
  FDestination := nil;
end;

destructor TPDAction.Destroy;
begin
  FreeAndNil(FDestination);
  inherited;
end;

function TPDAction.GetDestination: TPDDestination;
begin
  if not Assigned(FDestination) then
  begin
    FDestination := TPDDestination.Create(actionGetDestination(FActionHandle), False);
//    THackDest(FDestination).FDestinationHandle := actionGetDestination(FActionHandle);
    if THackDest(FDestination).FDestinationHandle = 0 then
    begin
      FDestination.Free;
      FDestination := nil;
    end;
  end;
  Result := FDestination;
end;

function TPDAction.GetHandle: TPDActionHandle;
begin
  Result := FActionHandle;
end;

function TPDAction.GetType: Shortint;
begin
  Result := (actionGetType(FActionHandle));
end;

procedure TPDAction.SetActionType(const Value: Shortint);
begin
  actionSettype(FActionHandle, (Value));
end;

procedure TPDAction.SetHandle(const Value: TPDActionHandle);
begin
  FActionHandle := Value;
end;

end.
