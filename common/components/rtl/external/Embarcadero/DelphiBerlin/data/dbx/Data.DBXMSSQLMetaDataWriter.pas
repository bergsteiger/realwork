{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXMSSQLMetaDataWriter;

interface

uses
  Data.DBXCommonTable,
  Data.DBXMetaDataWriter,
  Data.DBXPlatform,
  System.SysUtils;

type
  TDBXMsSqlCustomMetaDataWriter = class(TDBXBaseMetaDataWriter)
  protected
    procedure MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow); override;
  end;

  TDBXMsSqlMetaDataWriter = class(TDBXMsSqlCustomMetaDataWriter)
  public
    constructor Create;
    procedure Open; override;
  protected
    function IsSerializedIsolationSupported: Boolean; override;
    function GetSqlAutoIncrementKeyword: string; override;
    function GetSqlAutoIncrementInserts: string; override;
    function GetSqlRenameTable: string; override;
    function IsCatalogsSupported: Boolean; override;
    function IsSchemasSupported: Boolean; override;
    function IsMultipleStatementsSupported: Boolean; override;
  end;

implementation

uses
  Data.DBXMetaDataNames,
  Data.DBXMsSqlMetaDataReader;

procedure TDBXMsSqlCustomMetaDataWriter.MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow);
var
  Version: string;
  Original: TDBXTableRow;
begin
  Version := FReader.Version;
  if Version >= '09.00.0000' then
    inherited MakeSqlDropSecondaryIndex(Buffer, Index)
  else 
  begin
    Original := Index.OriginalRow;
    Buffer.Append(TDBXSQL.Drop);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Index);
    Buffer.Append(TDBXSQL.Space);
    MakeSqlIdentifier(Buffer, Original.Value[TDBXIndexesIndex.TableName].GetWideString(NullString));
    Buffer.Append(TDBXSQL.Dot);
    MakeSqlIdentifier(Buffer, Original.Value[TDBXIndexesIndex.IndexName].GetWideString(NullString));
    Buffer.Append(TDBXSQL.Semicolon);
    Buffer.Append(TDBXSQL.Nl);
  end;
end;

constructor TDBXMsSqlMetaDataWriter.Create;
begin
  inherited Create;
  Open;
end;

procedure TDBXMsSqlMetaDataWriter.Open;
begin
  if FReader = nil then
    FReader := TDBXMsSqlMetaDataReader.Create;
end;

function TDBXMsSqlMetaDataWriter.GetSqlAutoIncrementKeyword: string;
begin
  Result := 'IDENTITY';
end;

function TDBXMsSqlMetaDataWriter.GetSqlAutoIncrementInserts: string;
begin
  Result := 'IDENTITY_INSERT';
end;

function TDBXMsSqlMetaDataWriter.GetSqlRenameTable: string;
begin
  Result := 'EXEC sp_rename '':SCHEMA_NAME.:TABLE_NAME'', '':NEW_TABLE_NAME'', ''OBJECT''';
end;

function TDBXMsSqlMetaDataWriter.IsCatalogsSupported: Boolean;
begin
  Result := True;
end;

function TDBXMsSqlMetaDataWriter.IsSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXMsSqlMetaDataWriter.IsSerializedIsolationSupported: Boolean;
begin
  Result := False;
end;

function TDBXMsSqlMetaDataWriter.IsMultipleStatementsSupported: Boolean;
begin
  Result := True;
end;

end.
