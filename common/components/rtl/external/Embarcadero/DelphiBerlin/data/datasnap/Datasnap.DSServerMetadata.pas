{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSServerMetadata;

interface

uses
  System.Classes,
  Data.DBXCommon,
  Datasnap.DSCommonServer,
  Datasnap.DSServer,
  Datasnap.DSCommonProxy,
  Datasnap.DSMetadata,
  Datasnap.DSServerResStrs;

type
  TDSServerMetaDataProvider = class(TDSCustomMetaDataProvider)
  private
    FServer: TDSServer;
    procedure SetServer(const Value: TDSServer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HasProvider: Boolean; override;
    function GetProvider: IDSProxyMetaDataLoader; override;
  published
    property Server: TDSServer read FServer write SetServer;
  end;


implementation

{ TDSServerMetaDataProvider }

function TDSServerMetaDataProvider.GetProvider: IDSProxyMetaDataLoader;
begin
  if HasProvider then
  begin
    if csDesigning in ComponentState then
      raise TDSProxyException.CreateFmt(SNoMetaDataAtDesignTime, [FServer.Name]);
    Result := TDSProxyMetaDataLoader.Create(
      function: TDBXConnection
      var
        LProps: TDBXProperties;
      begin
        LProps := TDBXProperties.Create;
        try
          // Create in-process connection
          Result := TDSServerConnection(FServer.GetServerConnection(LProps));
        finally
          LProps.Free;
        end;
      end,
      procedure(C: TDBXConnection)
      begin
        //  Special handling for local connection (RAID 276563).  Handler will free connection.
//        TDSServerConnection(C).ServerConnectionHandler.Free
        c.Free;
      end);
  end;
end;

function TDSServerMetaDataProvider.HasProvider: Boolean;
begin
  Result := FServer <> nil;
end;

procedure TDSServerMetaDataProvider.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FServer) then
    FServer := nil;
end;

procedure TDSServerMetaDataProvider.SetServer(
  const Value: TDSServer);
begin
  if Value <> FServer then
  begin
    if Assigned(FServer) then
      FServer.RemoveFreeNotification(Self);
    FServer := Value;
    if Value <> nil then
    begin
      Value.FreeNotification(Self);
    end;
  end;
end;

end.
