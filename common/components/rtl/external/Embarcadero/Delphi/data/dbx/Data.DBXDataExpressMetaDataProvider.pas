{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXDataExpressMetaDataProvider;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMetaDataProvider,
  Data.DBXMetaDataCommandFactory
;

type
  TDBXDataExpressMetaDataProvider = class(TDBXMetaDataProvider)
  private
    [Weak]FConnection: TDBXConnection;
  public
    constructor Create; overload;
    constructor Create(Connection: TDBXConnection); overload;
  public
    procedure Open;
    property Connection: TDBXConnection read FConnection write FConnection;
  end;

  TDBXDataExpressProviderWriteableContext = class(TDBXDataExpressProviderContext)
  private
    FTransaction: TDBXTransaction;
  public
    function CreateTableStorage(const CollectionName: string;
      const Columns: TDBXValueTypeArray): TDBXTable; override;
    function CreateRowStorage(const CollectionName: string;
      const Columns: TDBXValueTypeArray): TDBXTableRow; override;
    procedure StartTransaction; override;
    procedure StartSerializedTransaction; override;
    procedure Commit; override;
    procedure Rollback; override;
  end;

implementation

uses
  Data.DBXMetaDataWriter,
  Data.DBXMetaDataReader,
  Data.DBXMetaDataWriterFactory,
  Data.DBXDBReaders
;


  { TDBXDataExpressMetaDataProvider }

constructor TDBXDataExpressMetaDataProvider.Create;
begin
  inherited;
end;

constructor TDBXDataExpressMetaDataProvider.Create(Connection: TDBXConnection);
begin
  inherited Create;
  FConnection := Connection;
end;

procedure TDBXDataExpressMetaDataProvider.Open;
var
  NewWriter: TDBXMetaDataWriter;
  Context: TDBXDataExpressProviderContext;
  Reader: TDBXMetaDataReader;
begin
  if FConnection.ConnectionProperty[TDBXPropertyNames.DriverName] = 'Odbc' then
    NewWriter := TDBXMetaDataWriterFactory.CreateWriter('Odbc')
  else
    NewWriter := TDBXMetaDataWriterFactory.CreateWriter(FConnection.ProductName);

  Context := TDBXDataExpressProviderWriteableContext.Create;
  Context.Connection := FConnection;

  Context.UseAnsiStrings := TDBXProviderContext.UseAnsiString(FConnection.ProductName);

  Context.RemoveIsNull := True;

  NewWriter.Context := Context;
  Reader := NewWriter.MetaDataReader;
  Reader.Context := Context;
  Reader.Version := FConnection.ProductVersion;
  SetWriter(NewWriter);
end;

{ TDBXDataExpressProviderWriteableContext }

function TDBXDataExpressProviderWriteableContext.CreateTableStorage(const CollectionName: string; const Columns: TDBXValueTypeArray): TDBXTable;
begin
  Result := TDBXMemoryTable.Create;
  Result.DBXTableName := CollectionName;
  Result.Columns := Columns;
end;

function TDBXDataExpressProviderWriteableContext.CreateRowStorage(const CollectionName: string; const Columns: TDBXValueTypeArray): TDBXTableRow;
var
  Storage: TDBXTable;
begin
  Storage := CreateTableStorage(CollectionName, Columns);
  Storage.Insert;
  Storage.Post;
  Result := Storage;
end;

procedure TDBXDataExpressProviderWriteableContext.StartTransaction;
begin
  FTransaction := FConnection.BeginTransaction;
end;

procedure TDBXDataExpressProviderWriteableContext.StartSerializedTransaction;
begin
  FTransaction := FConnection.BeginTransaction(TDBXIsolations.Serializable);
end;

procedure TDBXDataExpressProviderWriteableContext.Commit;
begin
  FConnection.CommitFreeAndNil(FTransaction);
end;

procedure TDBXDataExpressProviderWriteableContext.Rollback;
begin
  FConnection.RollbackFreeAndNil(FTransaction);
end;

end.


