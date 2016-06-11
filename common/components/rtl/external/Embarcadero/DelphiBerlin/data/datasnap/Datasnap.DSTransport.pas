{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSTransport;

interface

uses
  Data.DBXMessageHandlerCommon,
  Data.DBXTransport,
  Datasnap.DSCommonServer;

type
  TDSJSONProtocolHandlerFactory = class
  public
    constructor Create(const ATransport: TDSServerTransport);
    destructor Destroy; override;
    function CreateProtocolHandler(const Channel: TDbxChannel): TDBXProtocolHandler;
  private
    FTransport: TDSServerTransport;
  end;

implementation

uses
  Data.DBXMessageHandlerJSonServer,
  Data.DBXCommon,
  Data.DBXStream;

constructor TDSJSONProtocolHandlerFactory.Create(const ATransport: TDSServerTransport);
begin
  inherited Create;
  FTransport := ATransport;
end;

destructor TDSJSONProtocolHandlerFactory.Destroy;
begin
  inherited Destroy;
end;

function TDSJSONProtocolHandlerFactory.CreateProtocolHandler(const Channel: TDbxChannel): TDBXProtocolHandler;
var
  DbxStreamReader: TDBXJSonStreamReader;
  DbxStreamWriter: TDBXJSonStreamWriter;
  DbxRowBuffer: TDBXRowBuffer;
  DbxNewContext: TDBXContext;
  Complete: Boolean;
  InputHandler: TDBXJSonServerInputConnectionHandler;
  OutputHandler: TDBXJSonServerOutputConnectionHandler;
  ServerConHandler: TDSServerConnectionHandler;
begin
  DbxStreamReader := TDBXJSonStreamReader.Create;
  DbxStreamWriter := TDBXJSonStreamWriter.Create;
  DbxStreamReader.ReadBufferSize := FTransport.BufferKBSize * 1024;
  DbxStreamWriter.WriteBufferSize := FTransport.BufferKBSize * 1024;
  DbxRowBuffer := TDBXRowBuffer.Create;
  DbxRowBuffer.MinBufferSize := DbxStreamWriter.CalcRowBufferSize;
  DbxRowBuffer.Client := False;
  DbxRowBuffer.DbxStreamReader := DbxStreamReader;
  DbxRowBuffer.DbxStreamWriter := DbxStreamWriter;
  DbxNewContext := FTransport.DbxContext;
  Complete := False;
  try
    DbxStreamReader.DbxContext := DbxNewContext;
    DbxStreamReader.DbxChannel := Channel;
    DbxStreamReader.Open;
    DbxStreamWriter.DbxChannel := Channel;
    DbxStreamWriter.Open;
    Complete := True;
  finally
    if not Complete then
    begin
      DbxStreamReader.Free;
      DbxStreamReader.Close;
      DbxStreamReader.Free;
      DbxStreamWriter.Close;
      if Channel <> nil then
      begin
        Channel.Close;
        Channel.Free;
      end;
    end;
  end;
  OutputHandler := TDBXJSonServerOutputConnectionHandler.Create(DbxNewContext, DbxStreamReader, DbxStreamWriter, DbxRowBuffer);
  ServerConHandler := TDSServerConnectionHandler.Create(DbxNewContext, OutputHandler, Channel);
  ServerConHandler.Server := FTransport.Server;
  ServerConHandler.Transport := FTransport;
  FTransport.AddConnection(ServerConHandler);
  InputHandler := TDBXJSonServerInputConnectionHandler.Create(DbxNewContext, True, ServerConHandler, DbxStreamReader, DbxStreamWriter, DbxRowBuffer);
  InputHandler.NextOwnedHandler := ServerConHandler;
  ServerConHandler.NextOwnedHandler := OutputHandler;
  Result := TDBXJSonServerProtocolHandler.Create(InputHandler);
end;

end.
