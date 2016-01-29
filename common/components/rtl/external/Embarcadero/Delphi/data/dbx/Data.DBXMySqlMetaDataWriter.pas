{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMySqlMetaDataWriter;

interface

uses
  Data.DBXCommonTable,
  Data.DBXMetaDataReader,
  Data.DBXMetaDataWriter,
  Data.DBXPlatform,
  System.SysUtils;
type
  TDBXMySqlCustomMetaDataWriter = class(TDBXBaseMetaDataWriter)
  protected
    procedure MakeSqlDataType(const Buffer: TStringBuilder; const DataType: TDBXDataTypeDescription; const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s); override;
    function CanCreateIndexAsKey(const Index: TDBXTableRow; const IndexColumns: TDBXTable): Boolean; override;
    procedure MakeSqlCreateIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable); override;
    procedure MakeSqlDropIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow); override;
    procedure MakeSqlDropForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow); override;
    procedure MakeSqlColumnTypeCast(const Buffer: TStringBuilder; const Column: TDBXTable); override;
  private
    function UnicodeSpecificationRequired(const ColumnRow: TDBXTableRow): Boolean;
    function HasAutoIncrementColumn(const Index: TDBXTableRow): Boolean;
    function FindCastType(const Column: TDBXTableRow): string;
  end;

  TDBXMySqlMetaDataWriter = class(TDBXMySqlCustomMetaDataWriter)
  public
    constructor Create;
    procedure Open; override;
  protected
    function GetSqlAutoIncrementKeyword: string; override;
    function IsCatalogsSupported: Boolean; override;
    function IsSchemasSupported: Boolean; override;
    function GetAlterTableSupport: Integer; override;
    function GetSqlRenameTable: string; override;
  end;

implementation

uses
  Data.DBXCommon,
  Data.DBXMetaDataNames,
  Data.DBXMySqlMetaDataReader;

procedure TDBXMySqlCustomMetaDataWriter.MakeSqlDataType(const Buffer: TStringBuilder; const DataType: TDBXDataTypeDescription; const ColumnRow: TDBXTableRow; const Overrides: TDBXInt32s);
begin
  inherited MakeSqlDataType(Buffer, DataType, ColumnRow, Overrides);
  case DataType.DbxDataType of
    TDBXDataTypes.AnsiStringType,
    TDBXDataTypes.WideStringType:
      if UnicodeSpecificationRequired(ColumnRow) then
        Buffer.Append(' CHARACTER SET utf8');
    TDBXDataTypes.Int8Type,
    TDBXDataTypes.Int16Type,
    TDBXDataTypes.Int32Type,
    TDBXDataTypes.Int64Type,
    TDBXDataTypes.UInt8Type,
    TDBXDataTypes.UInt16Type,
    TDBXDataTypes.UInt32Type,
    TDBXDataTypes.UInt64Type:
      if ColumnRow.Value[TDBXColumnsIndex.IsUnsigned].GetBoolean(False) then
        Buffer.Append(' unsigned');
  end;
end;

function TDBXMySqlCustomMetaDataWriter.UnicodeSpecificationRequired(const ColumnRow: TDBXTableRow): Boolean;
var
  CustomReader: TDBXMySqlCustomMetaDataReader;
  DefaultIsUnicode: Boolean;
  UnicodeRequested: Boolean;
begin
  CustomReader := TDBXMySqlCustomMetaDataReader(FReader);
  DefaultIsUnicode := CustomReader.DefaultCharSetUnicode;
  UnicodeRequested := ColumnRow.Value[TDBXColumnsIndex.IsUnicode].GetBoolean(DefaultIsUnicode);
  Result := UnicodeRequested;
end;

function TDBXMySqlCustomMetaDataWriter.CanCreateIndexAsKey(const Index: TDBXTableRow; const IndexColumns: TDBXTable): Boolean;
begin
  Result := False;
end;

procedure TDBXMySqlCustomMetaDataWriter.MakeSqlCreateIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow; const IndexColumns: TDBXTable);
begin
  if not Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean(False) then
    inherited MakeSqlCreateIndex(Buffer, Index, IndexColumns)
  else 
  begin
    MakeSqlAlterTablePrefix(Buffer, Index);
    Buffer.Append(TDBXSQL.Add);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Primary);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Key);
    Buffer.Append(TDBXSQL.Space);
    MakeSqlCreateIndexColumnList(Buffer, IndexColumns);
    Buffer.Append(TDBXSQL.Semicolon);
    Buffer.Append(TDBXSQL.Nl);
  end;
end;

function TDBXMySqlCustomMetaDataWriter.HasAutoIncrementColumn(const Index: TDBXTableRow): Boolean;
var
  CatalogName: string;
  SchemaName: string;
  TableName: string;
  ColumnsTable: TDBXTable;
  HasAutoIncrement: Boolean;
begin
  CatalogName := Index.Value[TDBXIndexesIndex.CatalogName].GetWideString(NullString);
  SchemaName := Index.Value[TDBXIndexesIndex.SchemaName].GetWideString(NullString);
  TableName := Index.Value[TDBXIndexesIndex.TableName].GetWideString(NullString);
  ColumnsTable := FReader.FetchColumns(CatalogName, SchemaName, TableName);
  HasAutoIncrement := False;
  while ColumnsTable.Next do
  begin
    if ColumnsTable.Value[TDBXColumnsIndex.IsAutoIncrement].AsBoolean then
    begin
      HasAutoIncrement := True;
      break;
    end;
  end;
  ColumnsTable.Close;
  ColumnsTable.Free;
  Result := HasAutoIncrement;
end;

procedure TDBXMySqlCustomMetaDataWriter.MakeSqlDropIndex(const Buffer: TStringBuilder; const Index: TDBXTableRow);
begin
  if Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean then
  begin
    if HasAutoIncrementColumn(Index) then
      Exit;
  end;
  MakeSqlAlterTablePrefix(Buffer, Index);
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  if Index.Value[TDBXIndexesIndex.IsPrimary].GetBoolean then
  begin
    Buffer.Append(TDBXSQL.Primary);
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.Key);
  end
  else 
  begin
    Buffer.Append(TDBXSQL.Index);
    Buffer.Append(TDBXSQL.Space);
    MakeSqlIdentifier(Buffer, Index.Value[TDBXIndexesIndex.IndexName].AsString);
  end;
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

procedure TDBXMySqlCustomMetaDataWriter.MakeSqlDropForeignKey(const Buffer: TStringBuilder; const ForeignKey: TDBXTableRow);
begin
  MakeSqlAlterTablePrefix(Buffer, ForeignKey);
  Buffer.Append(TDBXSQL.Drop);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Foreign);
  Buffer.Append(TDBXSQL.Space);
  Buffer.Append(TDBXSQL.Key);
  Buffer.Append(TDBXSQL.Space);
  MakeSqlIdentifier(Buffer, ForeignKey.Value[TDBXForeignKeysIndex.ForeignKeyName].AsString);
  Buffer.Append(TDBXSQL.Semicolon);
  Buffer.Append(TDBXSQL.Nl);
end;

function TDBXMySqlCustomMetaDataWriter.FindCastType(const Column: TDBXTableRow): string;
var
  TypeName: string;
  DataType: TDBXDataTypeDescription;
  DbType: Integer;
begin
  TypeName := Column.Value[TDBXColumnsIndex.TypeName].AsString;
  DataType := FindDataType(TypeName, Column, nil);
  DbType := DataType.DbxDataType;
  case DbType of
    TDBXDataTypes.AnsiStringType,
    TDBXDataTypes.WideStringType:
      Result := TDBXSQL.Char + TDBXSQL.OpenParen + IntToStr(Column.Value[TDBXColumnsIndex.Precision].AsInt64) + TDBXSQL.CloseParen;
    TDBXDataTypes.SingleType,
    TDBXDataTypes.DoubleType,
    TDBXDataTypes.BcdType:
      Result := TDBXSQL.Decimal;
    TDBXDataTypes.TimeStampType:
      Result := TDBXSQL.Datetime;
    TDBXDataTypes.TimeType:
      Result := TDBXSQL.Time;
    TDBXDataTypes.DateType:
      Result := TDBXSQL.Date;
    TDBXDataTypes.BooleanType,
    TDBXDataTypes.Int8Type,
    TDBXDataTypes.Int16Type,
    TDBXDataTypes.Int32Type,
    TDBXDataTypes.Int64Type:
      Result := TDBXSQL.Signed;
    TDBXDataTypes.BytesType,
    TDBXDataTypes.VarBytesType:
      Result := TDBXSQL.Binary + TDBXSQL.OpenParen + IntToStr(Column.Value[TDBXColumnsIndex.Precision].AsInt64) + TDBXSQL.CloseParen;
    else
      Result := NullString;
  end;
end;

procedure TDBXMySqlCustomMetaDataWriter.MakeSqlColumnTypeCast(const Buffer: TStringBuilder; const Column: TDBXTable);
var
  Original: TDBXTableRow;
  NewType, OldType, TypeName: string;
begin
  Original := Column.OriginalRow;
  OldType := FindCastType(Original);
  NewType := FindCastType(Column);
  if NewType.IsEmpty or (NewType = OldType) then
    MakeSqlIdentifier(Buffer, Original.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString))
  else 
  begin
    TypeName := Column.Value[TDBXColumnsIndex.TypeName].AsString;
    if (TypeName = TDBXSQL.FYear) then
    begin
      Buffer.Append(TDBXSQL.FYear);
      Buffer.Append(TDBXSQL.OpenParen);
      Buffer.Append(TDBXSQL.Makedate);
      Buffer.Append(TDBXSQL.OpenParen);
    end;
    Buffer.Append(TDBXSQL.Cast);
    Buffer.Append(TDBXSQL.OpenParen);
    MakeSqlIdentifier(Buffer, Original.Value[TDBXColumnsIndex.ColumnName].GetWideString(NullString));
    Buffer.Append(TDBXSQL.Space);
    Buffer.Append(TDBXSQL.cAs);
    Buffer.Append(TDBXSQL.Space);
    MakeSqlDataType(Buffer, Column.Value[TDBXColumnsIndex.TypeName].AsString, Column);
    Buffer.Append(TDBXSQL.CloseParen);
    if (TypeName = TDBXSQL.FYear) then
    begin
      Buffer.Append(TDBXSQL.Comma);
      Buffer.Append(1);
      Buffer.Append(TDBXSQL.CloseParen);
      Buffer.Append(TDBXSQL.CloseParen);
    end;
  end;
end;

constructor TDBXMySqlMetaDataWriter.Create;
begin
  inherited Create;
  Open;
end;

procedure TDBXMySqlMetaDataWriter.Open;
begin
  if FReader = nil then
    FReader := TDBXMySqlMetaDataReader.Create;
end;

function TDBXMySqlMetaDataWriter.GetSqlAutoIncrementKeyword: string;
begin
  Result := 'auto_increment primary key';
end;

function TDBXMySqlMetaDataWriter.IsCatalogsSupported: Boolean;
begin
  Result := True;
end;

function TDBXMySqlMetaDataWriter.IsSchemasSupported: Boolean;
begin
  Result := False;
end;

function TDBXMySqlMetaDataWriter.GetAlterTableSupport: Integer;
begin
  Result := TDBXAlterTableOperation.DropColumn or TDBXAlterTableOperation.AddColumn or TDBXAlterTableOperation.DropDefaultValue or TDBXAlterTableOperation.ChangeDefaultValue or TDBXAlterTableOperation.RenameTable;
end;

function TDBXMySqlMetaDataWriter.GetSqlRenameTable: string;
begin
  Result := 'RENAME TABLE :SCHEMA_NAME.:TABLE_NAME TO :NEW_SCHEMA_NAME.:NEW_TABLE_NAME';
end;

end.
