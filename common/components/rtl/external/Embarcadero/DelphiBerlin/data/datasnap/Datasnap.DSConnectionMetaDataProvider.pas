{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSConnectionMetaDataProvider;

interface

uses
  Datasnap.DSCommonProxy, Datasnap.DSMetaData, Data.SqlExpr, System.Classes;

type
  TDSConnectionMetaDataProvider = class(TDSCustomMetaDataProvider)
  private
    [Weak]FConnection: TSQLConnection;
    procedure SetConnection(const Value: TSQLConnection);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HasProvider: Boolean; override;
    function GetProvider: IDSProxyMetaDataLoader; override;
  published
    property SQLConnection: TSQLConnection read FConnection write SetConnection;
  end;

implementation

uses
  Data.DBXCommon;

{ TDSConnectionMetaDataProvider }

function TDSConnectionMetaDataProvider.GetProvider: IDSProxyMetaDataLoader;
var
  LOpen: Boolean;
begin
  if HasProvider then
  begin
    Result := TDSProxyMetaDataLoader.Create(
      function: TDBXConnection
      begin
        LOpen := FConnection.DBXConnection <> nil;
        FConnection.Open;
        Result := FConnection.DBXConnection;
      end,
      procedure(C: TDBXConnection)
      begin
        if LOpen then
          FConnection.Close;
      end);
  end
  else
    Result := nil;
end;

function TDSConnectionMetaDataProvider.HasProvider: Boolean;
begin
  Result := FConnection <> nil;
end;

procedure TDSConnectionMetaDataProvider.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FConnection) then
    FConnection := nil;
end;

procedure TDSConnectionMetaDataProvider.SetConnection(
  const Value: TSQLConnection);
begin
  if Value <> FConnection then
  begin
    if Assigned(FConnection) then
      FConnection.RemoveFreeNotification(Self);
    FConnection := Value;
    if Value <> nil then
    begin
      Value.FreeNotification(Self);
    end;
  end;
end;

end.
