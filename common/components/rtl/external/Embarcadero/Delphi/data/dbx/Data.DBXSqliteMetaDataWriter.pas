{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXSqliteMetaDataWriter;

interface

uses
  Data.DBXCommonTable, Data.DBXMetaDataWriter, System.SysUtils;

type
  TDBXSqliteCustomMetaDataWriter = class(TDBXBaseMetaDataWriter)
  protected
    function IsSchemasSupported: Boolean; override;
    procedure MakeSqlCreateKey(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable); override;
  end;

  TDBXSqliteMetaDataWriter = class(TDBXSqliteCustomMetaDataWriter)
  public
    constructor Create;
    procedure Open; override;
  end;

implementation

uses
  Data.DBXCommon, Data.DBXSqliteMetaDataReader, Data.DbxSqliteResStrs;

{ TDBXSqliteCustomMetaDataWriter }

function TDBXSqliteCustomMetaDataWriter.IsSchemasSupported: Boolean;
begin
  Result := False;
end;

procedure TDBXSqliteCustomMetaDataWriter.MakeSqlCreateKey(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
var
  DBXError: TDBXError;
begin
  DBXError := TDBXError.Create(1, SNotSupported);
  raise DBXError;
end;

{ TDBXSqliteMetaDataWriter }

constructor TDBXSqliteMetaDataWriter.Create;
begin
  inherited Create;
  Open;
end;

procedure TDBXSqliteMetaDataWriter.Open;
begin
  if FReader = nil then
    FReader := TDBXSqliteMetaDataReader.Create;
end;

end.
