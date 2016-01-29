{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


unit DBXDBMetaData;

interface

uses
  Data.DbxMetaDataProvider, Data.DB, Datasnap.DBClient;

type

  TDBXDBMetaData = class
  private
    class function ToFieldType(DataType: Integer): TFieldType; static;
  public
    class procedure AddParams(Params: TParams; MetaDataTable: TDBXMetadataTable); static;
    class procedure AddClientDataSetFields(ClientDataSet: TClientDataSet; MetaDataTable: TDBXMetadataTable); static;
  end;


implementation

uses
  Data.DBXCommon, Data.DBXTypedTableStorage, DBXTestResStrs;

{ TDBXDBMetaData }

class function TDBXDBMetaData.ToFieldType(DataType: Integer): TFieldType;
begin
  case DataType of
    TDBXDataTypes.BooleanType:
      Result := ftBoolean;
    TDBXDataTypes.UInt8Type:
      Result := ftByte;
    TDBXDataTypes.Int8Type:
      Result := ftShortint;
    TDBXDataTypes.UInt16Type:
      Result := ftWord;
    TDBXDataTypes.Int16Type:
      Result := ftSmallint;
    TDBXDataTypes.Int32Type:
      Result := ftInteger;
    TDBXDataTypes.Int64Type:
      Result := ftLargeint;
    TDBXDataTypes.SingleType:
      Result := ftSingle;
    TDBXDataTypes.DoubleType:
      Result := ftFloat;
    TDBXDataTypes.WideStringType:
      Result := ftWideString;
    TDBXDataTypes.AnsiStringType:
      Result := ftString;
    TDBXDataTypes.DateType:
      Result := ftDate;
    TDBXDataTypes.TimeStampType:
      Result := ftTimeStamp;
    TDBXDataTypes.TimeStampOffsetType:
      Result := ftTimeStampOffset;
    TDBXDataTypes.BlobType:
      Result := ftBlob;
    TDBXDataTypes.BcdType:
      Result := ftFMTBcd;
    TDBXDataTypes.CurrencyType:
      Result := ftBcd;
    TDBXDataTypes.BytesType:
      Result := ftBytes;
    TDBXDataTypes.TimeType:
      Result := ftTime;
    TDBXDataTypes.BinaryBlobType:
      Result := ftStream;
    TDBXDataTypes.VarBytesType:
      Result := ftVarBytes;
    else
      raise TDBXError.Create(SUnexpectedMetaDataType);
  end;

end;

class procedure TDBXDBMetaData.AddClientDataSetFields(
  ClientDataSet: TClientDataSet;
  MetaDataTable: TDBXMetadataTable);
var
  Columns: TDBXColumnsTableStorage;
  FieldDef: TFieldDef;
  Ordinal: Integer;
begin
  Columns := MetaDataTable.ColumnsStorage;
  Columns.First;
  Ordinal := 0;
  ClientDataSet.Close;
  while Columns.InBounds do
  begin
    FieldDef := ClientDataSet.FieldDefs.AddFieldDef;
    FieldDef.Name := Columns.ColumnName;
    FieldDef.DisplayName := Columns.ColumnName;
    FieldDef.DataType := ToFieldType(Columns.DbxDataType);
    FieldDef.FieldNo := Ordinal;
    FieldDef.Size := Columns.Precision;

    //Midas will throw an invalid field type error if size > 65531
    if ((FieldDef.DataType = ftString) or (FieldDef.DataType = ftWideString))
     and (FieldDef.Size > 65531) then
    begin
      FieldDef.DataType := ftBlob;
      FieldDef.Size := 0;
    end;

    if Columns.DbxDataType = TDBXDataTypes.WideStringType then
    begin
      if Columns.Precision <= 0 then
        FieldDef.Size := 128  // default size (make constant)
      else
        FieldDef.Size := columns.Precision;
    end;
    Inc(Ordinal);
    Columns.Next;
  end;
  ClientDataSet.CreateDataSet;
end;

class procedure TDBXDBMetaData.AddParams(Params: TParams;
  MetaDataTable: TDBXMetadataTable);
var
  Columns: TDBXColumnsTableStorage;
  Param: TParam;
begin
  Columns := MetaDataTable.ColumnsStorage;
  Columns.First;
  Params.Clear;
  while Columns.InBounds do
  begin
    Param := TParam.Create(Params);
    Param.Name := Columns.ColumnName;
    Param.DisplayName := Columns.ColumnName;
    Param.DataType := ToFieldType(Columns.DbxDataType);
    Param.ParamType     := ptInput;
    Param.Precision     := Columns.Precision;
    Param.NumericScale  := Columns.Scale;
    Param.Size          := Columns.Precision;
    Columns.Next;
  end;
end;

end.
