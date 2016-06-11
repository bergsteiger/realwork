{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXSybaseASAMetaDataWriter;

interface

uses
  Data.DBXCommonTable,
  Data.DBXMetaDataWriter,
  Data.DBXPlatform,
  System.SysUtils;

type
  TDBXSybaseASACustomMetaDataWriter = class(TDBXBaseMetaDataWriter)
  protected
    procedure MakeSqlNullable(const Buffer: TStringBuilder; const Column: TDBXTableRow); override;
    procedure MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow); override;
  end;

  TDBXSybaseASAMetaDataWriter = class(TDBXSybaseASACustomMetaDataWriter)
  public
    constructor Create;
    procedure Open; override;
  protected
    function IsCatalogsSupported: Boolean; override;
    function IsSchemasSupported: Boolean; override;
    function IsSerializedIsolationSupported: Boolean; override;
    function IsMultipleStatementsSupported: Boolean; override;
    function IsDDLTransactionsSupported: Boolean; override;
    function IsDescendingIndexConstraintsSupported: Boolean; override;
    function GetSqlAutoIncrementKeyword: string; override;
    function GetSqlRenameTable: string; override;
  end;

implementation

uses
  Data.DBXMetaDataNames,
  Data.DBXSybaseASAMetaDataReader;

procedure TDBXSybaseASACustomMetaDataWriter.MakeSqlNullable(const Buffer: TStringBuilder; const Column: TDBXTableRow);
begin
  if not Column.Value[TDBXColumnsIndex.IsNullable].GetBoolean(True) then
  begin
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.cNot);
  end;
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Nullable);
end;

procedure TDBXSybaseASACustomMetaDataWriter.MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow);
var
  Original: TDBXTableRow;
begin
  Original := Index.OriginalRow;
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Index);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlIdentifier(Buffer, Original.Value[TDBXIndexesIndex.SchemaName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Dot);
  MakeSqlIdentifier(Buffer, Original.Value[TDBXIndexesIndex.TableName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Dot);
  MakeSqlIdentifier(Buffer, Original.Value[TDBXIndexesIndex.IndexName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

constructor TDBXSybaseASAMetaDataWriter.Create;
begin
  inherited Create;
  Open;
end;

procedure TDBXSybaseASAMetaDataWriter.Open;
begin
  if FReader = nil then
    FReader := TDBXSybaseASAMetaDataReader.Create;
end;

function TDBXSybaseASAMetaDataWriter.IsCatalogsSupported: Boolean;
begin
  Result := False;
end;

function TDBXSybaseASAMetaDataWriter.IsSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXSybaseASAMetaDataWriter.IsSerializedIsolationSupported: Boolean;
begin
  Result := False;
end;

function TDBXSybaseASAMetaDataWriter.IsMultipleStatementsSupported: Boolean;
begin
  Result := False;
end;

function TDBXSybaseASAMetaDataWriter.IsDDLTransactionsSupported: Boolean;
begin
  Result := False;
end;

function TDBXSybaseASAMetaDataWriter.IsDescendingIndexConstraintsSupported: Boolean;
begin
  Result := False;
end;

function TDBXSybaseASAMetaDataWriter.GetSqlAutoIncrementKeyword: string;
begin
  Result := 'DEFAULT AUTOINCREMENT';
end;

function TDBXSybaseASAMetaDataWriter.GetSqlRenameTable: string;
begin
  Result := 'ALTER TABLE :SCHEMA_NAME.:TABLE_NAME RENAME :NEW_TABLE_NAME';
end;

end.
