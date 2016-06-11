{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXOdbcMetaDataWriter;

interface

uses
  Data.DBXCommonTable,
  Data.DBXMetaDataReader,
  Data.DBXMetaDataWriter,
  Data.DBXPlatform;

type
  TDBXOdbcCustomMetaDataWriter = class(TDBXBaseMetaDataWriter)
  end;

  TDBXOdbcMetaDataWriter = class(TDBXOdbcCustomMetaDataWriter)
  protected
    function IsSchemasSupported: Boolean; override;
  public
    constructor Create;
    procedure Open; override;
  end;

implementation

uses
  Data.DBXCommon,
  Data.DBXOdbcMetaDataReader,
  Data.DBXMetaDataNames,
  System.SysUtils;

constructor TDBXOdbcMetaDataWriter.Create;
begin
  inherited Create;
  Open;
end;

function TDBXOdbcMetaDataWriter.IsSchemasSupported: Boolean;
begin
  Result := FReader.SchemasSupported;
end;

procedure TDBXOdbcMetaDataWriter.Open;
begin
  if FReader = nil then
    FReader := TDBXOdbcMetaDataReader.Create;
end;

end.
