{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXInformixMetaDataWriter;

interface

uses
  Data.DBXCommonTable,
  Data.DBXMetaDataWriter,
  Data.DBXPlatform,
  System.SysUtils;

type
  TDBXInformixCustomMetaDataWriter = class(TDBXBaseMetaDataWriter)
  protected
    procedure MakeSqlCreateKey(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable); override;
    procedure MakeSqlCreateForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow; const ForeignKeyColumns: TDBXTable); override;
    procedure MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow); override;
  end;

  TDBXInformixMetaDataWriter = class(TDBXInformixCustomMetaDataWriter)
  public
    constructor Create;
    procedure Open; override;
  protected
    function GetSqlAutoIncrementKeyword: string; override;
    function GetSqlRenameTable: string; override;
    function IsSchemasSupported: Boolean; override;
    function IsMultipleStatementsSupported: Boolean; override;
    function IsDescendingIndexConstraintsSupported: Boolean; override;
  end;

implementation

uses
  Data.DBXInformixMetaDataReader,
  Data.DBXMetaDataNames;

procedure TDBXInformixCustomMetaDataWriter.MakeSqlCreateKey(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
begin
  MakeSqlAlterTablePrefix(Buffer, Index);
  Buffer.Append(TDBXSQL.Add);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Constraint);
  Buffer.Append(TDBXSQL.Space);
  if Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean(False) then
  begin
    Buffer.Append(TDBXSQL.Primary);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Key);
  end
  else 
    Buffer.Append(TDBXSQL.Unique);
  MakeSqlCreateIndexColumnList(Buffer, IndexColumns);
  MakeSqlConstraintName(Buffer, Index);
end;

procedure TDBXInformixCustomMetaDataWriter.MakeSqlCreateForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow; const ForeignKeyColumns: TDBXTable);
begin
  MakeSqlAlterTablePrefix(Buffer, ForeignKey);
  Buffer.Append(TDBXSQL.Add);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Constraint);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlForeignKeySyntax(Buffer, ForeignKey, ForeignKeyColumns);
  MakeSqlConstraintName(Buffer, ForeignKey);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXInformixCustomMetaDataWriter.MakeSqlDropSecondaryIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow);
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
  MakeSqlIdentifier(Buffer, Original.Value[TDBXIndexesIndex.IndexName].GetWideString(NullString));
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

constructor TDBXInformixMetaDataWriter.Create;
begin
  inherited Create;
  Open;
end;

procedure TDBXInformixMetaDataWriter.Open;
begin
  if FReader = nil then
    FReader := TDBXInformixMetaDataReader.Create;
end;

function TDBXInformixMetaDataWriter.GetSqlAutoIncrementKeyword: string;
begin
  Result := 'IDENTITY';
end;

function TDBXInformixMetaDataWriter.GetSqlRenameTable: string;
begin
  Result := 'RENAME TABLE :SCHEMA_NAME.:TABLE_NAME TO :NEW_SCHEMA_NAME:NEW_TABLE_NAME';
end;

function TDBXInformixMetaDataWriter.IsSchemasSupported: Boolean;
begin
  Result := True;
end;

function TDBXInformixMetaDataWriter.IsMultipleStatementsSupported: Boolean;
begin
  Result := False;
end;

function TDBXInformixMetaDataWriter.IsDescendingIndexConstraintsSupported: Boolean;
begin
  Result := False;
end;

end.
