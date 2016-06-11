{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Controls.Model;

interface

uses
  System.Generics.Collections, System.Rtti, System.Classes, FMX.Presentation.Messages;

const
  MM_BASE = $1600;
  MM_GETDATA = MM_BASE + 1;
  MM_DATA_CHANGED = MM_BASE + 2;
  MM_USER = $1700;

type

{ TDataModel }

  /// <summary>Key-value pair where the key is a string and the value is an instance of TValue. Used for sending data
  // to presentation layer.</summary>
  TDataRecord = TPair<string, TValue>;

  /// <summary>Class that contains a dictionary of key-value pairs and may be used as model by an instance of
  /// <c>TPresentedControl</c> with supporting a sending a notification via messaging.</summary>
  TDataModel = class(TMessageSender)
  public type
    TDataSource = TDictionary<string, TValue>;
  private
    [Weak] FOwner: TComponent;
    FDataSource: TDataSource;
    function GetData(const Index: string): TValue;
    procedure SetData(const Index: string; const Value: TValue);
    procedure RemoveData(const Index: string);
  public
    /// <summary>Allows to specify <c>Owner</c></summary>
    /// <remarks>Invokes default constructor without params.</remarks>
    constructor Create(const AOwner: TComponent); overload; virtual;
    /// <summary>Destroys existed <c>DataSource</c></summary>
    destructor Destroy; override;
  public
    /// <summary>Component that is responsible for destroying this data model once the data model is no longer
    /// necessary.</summary>
    property Owner: TComponent read FOwner;
    /// <summary><para>Value on the data model for the specified key.</para><para>Use it for sending any kind of data to
    /// presentation layer without creating custom model class.</para></summary>
    /// <remarks><para>Automatically sends notifcation message with id <c>MM_DATA_CHANGED</c> to receiver with information
    /// about key and value through using <c>TDataRecord</c>.</para><para>When we request value from model, Model
    /// sends request about it to presentation layer. If layer doesn't specify value (nil value), model gets value
    /// from DataSource</para><para>If value is nil, model will remove this key-value pair from <c>DataSource</c></para></remarks>
    property Data[const Key: string]: TValue read GetData write SetData;
    /// <summary>Dictionary of key-value pairs that are the data that the data model contains. Can be nil, if Model
    /// doesn't have any datas.</summary>
    property DataSource: TDataSource read FDataSource;
  end;

  /// <summary>Class reference of TDataModel.</summary>
  TDataModelClass = class of TDataModel;

implementation

uses
  System.SysUtils, FMX.Consts {$IFDEF MACOS}, Macapi.CoreFoundation{$ENDIF};

{ TDataModel }

constructor TDataModel.Create(const AOwner: TComponent);
begin
  FOwner := AOwner;
  Create;
end;

destructor TDataModel.Destroy;
begin
  FDataSource.Free;
  inherited;
end;

function TDataModel.GetData(const Index: string): TValue;
var
  DataRecord: TDataRecord;
  TrimmedIndex: string;
begin
  TrimmedIndex := Index.Trim.ToLower;
  DataRecord := TDataRecord.Create(TrimmedIndex, TValue.Empty);
  SendMessageWithResult<TDataRecord>(MM_GETDATA, DataRecord);
  if DataRecord.Value.IsEmpty and (FDataSource <> nil) then
    FDataSource.TryGetValue(TrimmedIndex, Result)
  else
    Result := DataRecord.Value;
end;

procedure TDataModel.RemoveData(const Index: string);
begin
  if FDataSource <> nil then
  begin
    FDataSource.Remove(Index);
    if FDataSource.Count = 0 then
      FreeAndNil(FDataSource);
  end;
end;

procedure TDataModel.SetData(const Index: string; const Value: TValue);
var
  DataRecord: TDataRecord;
  TrimmedIndex: string;
begin
  TrimmedIndex := Index.Trim.ToLower;
  if TrimmedIndex.IsEmpty then
    raise EArgumentException.Create(SDataModelKeyEmpty);

  if FDataSource = nil then
    FDataSource := TDictionary<string, TValue>.Create;
  if Value.IsEmpty then
    RemoveData(TrimmedIndex)
  else
    FDataSource.AddOrSetValue(TrimmedIndex, Value);

  DataRecord := TDataRecord.Create(TrimmedIndex, Value);
  SendMessage<TDataRecord>(MM_DATA_CHANGED, DataRecord);
end;

end.
