{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetadataCommon;

interface

uses
  Data.DBXJSON;

type
  
  /// <summary> Class to delegate the setting of the Invocation Metadata.
  /// </summary>
  /// <remarks> This is done so that the logic
  ///  can be completely removed from the DBXJSonConnectionHandler instance, as this will not
  ///  compile for dotnet, due to the fact that dotnet does not include DBXJSONReflect.
  /// </remarks>
  TInvocationMetadataDelegate = class
  public
    
    /// <summary> Sets the metaData into threadvar field indirectly
    /// </summary>
    /// <remarks> Note that this will take possession of (and immediately free) the passed in JSONObject)
    /// </remarks>
    /// <param name="metaData">The metadata to set</param>
    class procedure StoreMetadata(var MetaData: TJSONObject); static;
    
    /// <summary> If the passed in connection handler is an instance of DBXJSonConnectionHandler then
    ///  this method will write out the metadata from this instance.
    /// </summary>
    /// <remarks> This will be done, for example,
    ///  when not running in in-process mode, and needing to pass the metadata from the server back
    ///  to the DataSnap service.
    /// </remarks>
    /// <param name="connectionHandler">The connection handler to use</param>
    class procedure WriteMetadata(const ConnectionHandler: TObject); static;
    
    /// <summary> Clears the metadata if not running in-process
    /// </summary>
    /// <param name="connectionHandler">the connection handler to use to determine if this is running in-process</param>
    class procedure ClearMetadata(const ConnectionHandler: TObject); static;
  end;

implementation

uses
  Data.DBXMessageHandlerJSonCommon,
  Data.DBXPlatform, Data.DBXJSONReflect;

const
  // Must match field name in TDSInvocationMetadata
  cQueryParamsFieldName = 'FQueryParams';

class procedure TInvocationMetadataDelegate.StoreMetadata(var MetaData: TJSONObject);
var
  UnMarshal: TJSONUnMarshal;
  MarshalObj: TObject;
  LReverter: TReverterEvent;
begin
  if MetaData <> nil then
  begin
    UnMarshal := TJSONUnMarshal.Create;
    // Register reverter to unmarshal TStringList.
    LReverter := TReverterEvent.Create;
    LReverter.TypeObjectReverter := StringListReverter;
    UnMarshal.RegisterReverter(TDSInvocationMetadata, cQueryParamsFieldName, LReverter);
    try
      MarshalObj := UnMarshal.Unmarshal(MetaData);
      if MarshalObj is TDSInvocationMetadata then
        SetInvocationMetadata(TDSInvocationMetadata(MarshalObj));
    finally
      UnMarshal.Free;
      MetaData.Free;
    end;
  end;
end;

class procedure TInvocationMetadataDelegate.WriteMetadata(const ConnectionHandler: TObject);
var
  MetaDataObj: TDSInvocationMetadata;
  Marshal: TJSONMarshal;
  MetaData: TJSONValue;
  LConverter: TConverterEvent;
begin
  if ConnectionHandler is TDBXJSonConnectionHandler then
  begin
    MetaDataObj := GetInvocationMetadata(False);
    if MetaDataObj <> nil then
    begin
      Marshal := TJSONMarshal.Create;
      // Register converter to marshal TStringList.
      LConverter := TConverterEvent.Create;
      LConverter.TypeObjectConverter := StringListConverter;
      Marshal.RegisterConverter(TDSInvocationMetadata, cQueryParamsFieldName, LConverter);
      MetaData := nil;
      try
        MetaData := Marshal.Marshal(MetaDataObj);
        (TDBXJSonConnectionHandler(ConnectionHandler)).WriteMetadataData(TJSONObject(MetaData), False);
      finally
        MetaData.Free;
        Marshal.Free;
      end;
    end;
  end;
end;

class procedure TInvocationMetadataDelegate.ClearMetadata(const ConnectionHandler: TObject);
begin
  if ConnectionHandler is TDBXJSonConnectionHandler then
    ClearInvocationMetadata();
end;

end.
