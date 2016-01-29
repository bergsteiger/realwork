{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXTransportFilter;

interface

uses
  Data.DBXCommon,
  Data.DBXJSON,
  Data.DBXTransport,
  System.SysUtils;

type
  
  /// <summary> Implements TCP communication where use can insert filters to process (compress, encrypt) the byte flow 
  /// 
  /// </summary>
  TDBXFilterSocketChannel = class(TDbxChannel)
  public
    function HasLeftover: Boolean; virtual;
    
    /// <summary> Constructor with socket id
    ///  
    /// </summary>
    constructor Create; overload;
    
    /// <summary> Constructor when id and filter list are known
    ///  
    /// </summary>
    /// <param name="list">- filter list</param>
    constructor Create(const List: TTransportFilterCollection); overload;
    
    /// <summary> Releases filter list objects, if owned
    /// </summary>
    destructor Destroy; override;
    
    /// <summary> Returns true if filters are defined
    ///  
    /// </summary>
    /// <returns>true if filters are present</returns>
    function HasFilters: Boolean; virtual;
    
    /// <summary> Reads byte[], implements handshake protocol
    /// </summary>
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    
    /// <summary> Write data, implements handshake protocol
    /// </summary>
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    procedure Close; override;
    procedure Open; override;
  protected
    function GetFlag: Integer; virtual;
    
    /// <summary> Sets the delegate channel value
    ///  
    /// </summary>
    /// <param name="channel">DbxChannel instance, never null</param>
    procedure SetChannel(const Channel: TDbxChannel); virtual;
    
    /// <summary> Filter list setter
    ///  
    /// </summary>
    /// <param name="filters">filter list, never null</param>
    procedure SetFilterList(const Filters: TTransportFilterCollection); virtual;
    function GetChannelInfo: TDBXChannelInfo; override;
    function GetDBXProperties: TDBXProperties; override;
    procedure SetDBXProperties(const Properties: TDBXProperties); override;
    ///<summary>Specifies if there is an open connection or not.</summary>
    ///<returns>False if connection is active, True if connection is not active.</returns>
    function IsConnectionLost: Boolean; override;
  private
    function ConsumeLeftover(const Data: TArray<Byte>; const Offset: Integer; const Len: Integer): Integer;
    procedure SetLeftover(const Data: TArray<Byte>; const Offset: Integer);
    
    /// <summary> Returns the JSONObject representing the filter parameters
    ///  
    /// </summary>
    /// <param name="onlyPublicKeyCryptographs">boolean - true if the list should consists 
    ///    of public key cryptograph filters</param>
    /// <returns>JSONObject, never null</returns>
    function FilterParameters(const OnlyPublicKeyCryptographs: Boolean): TJSONObject;
    
    /// <summary> Restores the client (usually) filter list from the server byte array.
    /// </summary>
    /// <remarks> 
    ///  Performs merge is the list exists
    ///   
    /// </remarks>
    /// <param name="data">server byte array</param>
    /// <param name="pos">position to start parsing</param>
    /// <returns>true if the filter list was properly restored</returns>
    function RestoreFilterList(const Data: TArray<Byte>; const Pos: Integer): Boolean;
    
    /// <summary> Fills the buffer with expected number of bytes
    ///   
    /// </summary>
    /// <param name="buffer">data to be filled</param>
    /// <param name="offset">from position</param>
    /// <param name="count">expected number of bytes</param>
    /// <returns>false if the operation cannot be completed - no more data are available</returns>
    function FillBuffer(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Boolean;
    
    /// <summary> Creates the JSON message associated with the filter id and parameters
    ///  
    ///  The regular filters are to be encrypted by the public key cryptographs if
    ///  present.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <param name="onlyPublickKeyCryptographs">: boolean - true if only the public key
    ///    cryptograph filters are to be sent</param>
    function SendFilterParameters(const OnlyPublickKeyCryptographs: Boolean): Integer;
    
    /// <summary> Reads and set the confederate filter parameters
    ///  
    /// </summary>
    /// <param name="publicKeyEncrypted">: true if the filter parameters were encrypted</param>
    function ReceiveAndSetConfederateFilterParameters(const PublicKeyEncrypted: Boolean): Integer;
    
    /// <summary> Returns filtered data
    ///  
    /// </summary>
    /// <param name="data">: byte[] raw data</param>
    /// <param name="count">: size of raw data</param>
    /// <param name="onlyPublikKeyCryptographs">: boolean - true if only the public key 
    ///    cryptographs filters are to be used</param>
    /// <returns>: byte[] processed data to be written</returns>
    function FilterDataRead(const Data: TArray<Byte>; const Count: Integer; const OnlyPublikKeyCryptographs: Boolean): TArray<Byte>;
    
    /// <summary> Filters clear data
    ///  
    /// </summary>
    /// <param name="data">: byte[] byte array of raw data</param>
    /// <param name="count">: number of bytes to processed</param>
    /// <param name="onlyPublikKeyCryptographs">: boolean - true if only the public key 
    ///    cryptographs filters are to be used for filtering</param>
    /// <returns>: byte array of processed data</returns>
    function FilterDataWrite(const Data: TArray<Byte>; const Count: Integer; const OnlyPublikKeyCryptographs: Boolean): TArray<Byte>;
  public
    /// <summary>Used internally to indicate that no decision on the filter status
    ///   of the byte stream has been made yet.</summary>
    class var Pendant: Integer;
    class var Filtered: Integer;
    class var Regular: Integer;
  private
    
    /// <summary> Filter list, from DSServerTransport
    /// </summary>
    FFilterList: TTransportFilterCollection;
    
    /// <summary> True if filter list is owned by the instance. 
    /// </summary>
    /// <remarks> 
    ///  
    ///  This is true usually for client instances where filters are created by handshake protocol.
    /// </remarks>
    FOwnFilterList: Boolean;
    
    /// <summary> data buffer used by the handshake protocol
    /// </summary>
    FHeaderData: TArray<Byte>;
    
    /// <summary>DbxChannel delegate instance.</summary>
    /// <remarks>It should be instantiated before any other DbxChannel API is called.
    ///          The instance assumes ownership, so it will be freed on destroy.
    /// </remarks>
    FDelegate: TDbxChannel;
    
    /// <summary> Status flag:
    ///  PENDANT: no decision; REGULAR: "as is" byte stream; FILTERED: filtered byte stream
    /// </summary>
    FFilterFlag: Integer;
    FLeftover: TArray<Byte>;
    FLeftoverPos: Integer;
  public
    property Flag: Integer read GetFlag;
    
    /// <summary> Sets the delegate channel value
    ///  
    /// </summary>
    property Channel: TDbxChannel read FDelegate write SetChannel;
    
    /// <summary> Filter list setter
    ///  
    /// </summary>
    property FilterList: TTransportFilterCollection write SetFilterList;
  end;

implementation

uses
  Data.DBXPlatform,
  Data.DBXClientResStrs,
  System.Classes
;

function TDBXFilterSocketChannel.GetFlag: Integer;
begin
  Result := FFilterFlag;
end;

function TDBXFilterSocketChannel.HasLeftover: Boolean;
begin
  Result := FLeftover <> nil;
end;

function TDBXFilterSocketChannel.IsConnectionLost: Boolean;
begin
  Result := Assigned(FDelegate) and FDelegate.ConnectionLost;
end;

function TDBXFilterSocketChannel.ConsumeLeftover(const Data: TArray<Byte>; const Offset: Integer;
  const Len: Integer): Integer;
var
  Size: Integer;
begin
  Size := Length(FLeftover) - FLeftoverPos;
  if Size > Len then
    Size := Len;
  TDBXPlatform.CopyByteArray(FLeftover, FLeftoverPos, Data, Offset, Size);
  FLeftoverPos := FLeftoverPos + Size;
  if FLeftoverPos >= Length(FLeftover) then
  begin
    FLeftoverPos := 0;
    FLeftover := nil;
  end;
  Result := Size;
end;

procedure TDBXFilterSocketChannel.SetLeftover(const Data: TArray<Byte>; const Offset: Integer);
begin
  FLeftover := Data;
  FLeftoverPos := Offset;
end;

function TDBXFilterSocketChannel.FilterParameters(const OnlyPublicKeyCryptographs: Boolean): TJSONObject;
var
  JsonObj, Params: TJSONObject;
  I, J: Integer;
  Filter: TTransportFilter;
  Pair: TJSONPair;
  FilterName: TJSONString;
  ParamNames: TDBXStringArray;
  Val: string;
begin
  JsonObj := TJSONObject.Create;
  if (FFilterList <> nil) and (FFilterList.Count > 0) then
    for I := 0 to FFilterList.Count - 1 do
    begin
      Filter := TTransportFilter(FFilterList.GetFilter(I));
      if Filter.PublicKeyCryptograph = OnlyPublicKeyCryptographs then
      begin
        Pair := TJSONPair.Create;
        JsonObj.AddPair(Pair);
        FilterName := TJSONString.Create(Filter.Id);
        Pair.JsonString := FilterName;
        Params := TJSONObject.Create;
        Pair.JsonValue := Params;
        ParamNames := Filter.Parameters;
        if (ParamNames <> nil) and (Length(ParamNames) > 0) then
          for J := 0 to Length(ParamNames) - 1 do
          begin
            Pair := TJSONPair.Create;
            Pair.JsonString := TJSONString.Create(ParamNames[J]);
            Val := Filter.GetParameterValue(ParamNames[J]);
            if not Val.IsEmpty then
              Pair.JsonValue := TJSONString.Create(Val)
            else 
              Pair.JsonValue := TJSONNull.Create;
            Params.AddPair(Pair);
          end;
      end;
    end;
  Result := JsonObj;
end;

function TDBXFilterSocketChannel.RestoreFilterList(const Data: TArray<Byte>; const Pos: Integer): Boolean;
var
  FilterCreated: Boolean;
  Obj: TJSONObject;
  I: Integer;
  Pair: TJSONPair;
  FilterName: string;
  Filter: TTransportFilter;
  Params: TJSONObject;
  J: Integer;
  ParamName: string;
  Value: TJSONValue;
  ParamValue: string;
begin
  FilterCreated := False;
  if FFilterList = nil then
  begin
    FFilterList := TTransportFilterCollection.Create;
    FOwnFilterList := True;
  end;
  Obj := TJSONObject.Create;
  if Obj.Parse(Data, Pos) <= 0 then
  begin
    Obj.Free;
    Exit(False);
  end;
  for i := Obj.Size - 1 downto 0 do
  begin
    Pair := Obj.Get(I);
    FilterName := Pair.JsonString.Value;
    Filter := TTransportFilter(FFilterList.GetFilter(FilterName));
    if Filter = nil then
    begin
      Filter := TTransportFilterFactory.CreateFilter(FilterName);
      if Filter = nil then
      begin
        Obj.Free;
        raise TDBXError.Create(0, Format(SFilterNotRegistered, [FilterName]));
      end;
      FilterCreated := True;
    end;
    Filter.ServerInstance := False;
    Filter.FilterCollection := FFilterList;
    Filter.StartHandshake;
    Params := TJSONObject(Pair.JsonValue);
    for j := 0 to Params.Size - 1 do
    begin
      Pair := Params.Get(J);
      ParamName := Pair.JsonString.Value;
      Value := Pair.JsonValue;
      if Value.Null then
        ParamValue := NullString
      else 
        ParamValue := (TJSONString(Value)).Value;
      if not Filter.SetConfederateParameter(ParamName, ParamValue) then
      begin
        Obj.Free;
        raise TDBXError.Create(0, Format(SInvalidFilterParameter, [Filter.Id,ParamName,ParamValue]));
      end;
    end;
    if FilterCreated then
      FFilterList.AddFilter(Filter);
  end;
  Obj.Free;
  Result := True;
end;

constructor TDBXFilterSocketChannel.Create;
begin
  Pendant := 0;
  Filtered := 1;
  Regular := -1;
  inherited Create;
  SetLength(FHeaderData,TTransportFilterTools.HeaderLen);
  FFilterFlag := Pendant;
  FOwnFilterList := False;
end;

constructor TDBXFilterSocketChannel.Create(const List: TTransportFilterCollection);
begin
  Pendant := 0;
  Filtered := 1;
  Regular := -1;
  Create;
  FilterList := List;
end;

procedure TDBXFilterSocketChannel.SetChannel(const Channel: TDbxChannel);
begin
  FDelegate := Channel;
end;

destructor TDBXFilterSocketChannel.Destroy;
var
  I: Integer;
begin
  if FOwnFilterList then
  begin
    if FFilterList <> nil then
    begin
      for I := FFilterList.Count - 1 downto 0 do
        FFilterList.GetItem(I).DisposeOf;
      FreeAndNil(FFilterList);
    end;
  end;
  if FDelegate <> nil then
  begin
    FDelegate.Free;
    FDelegate := nil;
  end;
  inherited Destroy;
end;

procedure TDBXFilterSocketChannel.SetFilterList(const Filters: TTransportFilterCollection);
var
  Filter, SourceFilter: TTransportFilter;
  UserParametersName: TDBXStringArray;
  I, J: Integer;
begin
  if FOwnFilterList and (FFilterList <> nil) then
    FFilterList.Free;
  FFilterList := TTransportFilterCollection.Create;
  FOwnFilterList := True;
  for I := 0 to Filters.Count - 1 do
  begin
    SourceFilter := Filters.GetFilter(I);
    Filter := TTransportFilterFactory.CreateFilter(SourceFilter.Id);
    UserParametersName := SourceFilter.UserParameters;
    for J := 0 to Length(UserParametersName) - 1 do
      Filter.SetParameterValue(UserParametersName[J], SourceFilter.GetParameterValue(UserParametersName[J]));
    FFilterList.AddFilter(Filter);
  end;
end;

function TDBXFilterSocketChannel.HasFilters: Boolean;
begin
  Result := (FFilterList <> nil) and (FFilterList.Count <> 0);
end;

function TDBXFilterSocketChannel.FillBuffer(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Boolean;
var
  Len: Integer;
  Size: Integer;
begin
  Len := 0;
  while Len < Count do
  begin
    Size := FDelegate.Read(Buffer, Offset + Len, Count - Len);
    if Size = -1 then
      Exit(False);
    Len := Len + Size;
  end;
  Assert(Len=Count);
  Result := True;
end;

function TDBXFilterSocketChannel.Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer;
var
  PkcFiltersPresent: Boolean;
  ConsistentSize, ReadCount: Integer;
  FilteredBuffer, FilteredData: TArray<Byte>;
begin
  if FFilterFlag = Pendant then
  begin
    if not FillBuffer(FHeaderData, 0, TTransportFilterTools.HeaderLen) then
      Exit(-1);
    if TTransportFilterTools.IsFilterQuery(FHeaderData) then
    begin
      if HasFilters then
      begin
        FFilterFlag := Filtered;
        FFilterList.StartHandshake;
        PkcFiltersPresent := TTransportFilterTools.HasPublicKeyCryptography(FFilterList);
        if PkcFiltersPresent then
        begin
          if SendFilterParameters(True) < 0 then
            Exit(-1);
          if not FillBuffer(FHeaderData, 0, TTransportFilterTools.HeaderLen) then
            Exit(-1);
          if ReceiveAndSetConfederateFilterParameters(False) < 0 then
            Exit(-1);
        end;
        if SendFilterParameters(False) < 0 then
          Exit(-1);
        if not FillBuffer(FHeaderData, 0, TTransportFilterTools.HeaderLen) then
          Exit(-1);
        if ReceiveAndSetConfederateFilterParameters(PkcFiltersPresent) < 0 then
          Exit(-1);
        if not FFilterList.HandshakeComplete then
          Exit(-1);
      end
      else 
      begin
        FFilterFlag := Regular;
        if FDelegate.Write(TTransportFilterTools.NoFilter(FHeaderData), 0, TTransportFilterTools.HeaderLen) < 0 then
          Exit(-1);
        Exit(FDelegate.Read(Buffer, Offset, Count));
      end;
    end
    else 
    begin
      if HasFilters then
        Exit(-1);
      FFilterFlag := Regular;
      TDBXPlatform.CopyByteArray(FHeaderData, 0, Buffer, Offset, TTransportFilterTools.HeaderLen);
      ReadCount := FDelegate.Read(Buffer, Offset + TTransportFilterTools.HeaderLen, Count - TTransportFilterTools.HeaderLen);
      if ReadCount < 0 then
        Exit(-1);
      Exit(TTransportFilterTools.HeaderLen + ReadCount);
    end;
  end;
  if FFilterFlag = Filtered then
  begin
    if HasLeftover then
      Exit(ConsumeLeftover(Buffer, Offset, Count));
    // get the filtered data byte length
    if not FillBuffer(FHeaderData, 0, TTransportFilterTools.HeaderLen) then
      Exit(-1);
    ConsistentSize := TTransportFilterTools.DecodeDataLen(FHeaderData);
    if ConsistentSize < 0 then
      Exit(-1);
    // read the filtered data
    SetLength(FilteredBuffer,ConsistentSize);
    if not FillBuffer(FilteredBuffer, 0, ConsistentSize) then
      Exit(-1);
    // filter the data
    Assert(Length(FilteredBuffer) = ConsistentSize);
    FilteredData := FilterDataRead(FilteredBuffer, ConsistentSize, False);
    // cache the un-filtered data
    SetLeftover(FilteredData, 0);
    // consume what you can
    Exit(ConsumeLeftover(Buffer, Offset, Count));
  end;
  Result := FDelegate.Read(Buffer, Offset, Count);
end;

function TDBXFilterSocketChannel.SendFilterParameters(const OnlyPublickKeyCryptographs: Boolean): Integer;
var
  JsonBytes, JsonLen: TArray<Byte>;
  JsonFilters: TJSONObject;
  ByteSize: Integer;
begin
  SetLength(JsonLen,5);
  try
    JsonFilters := FilterParameters(OnlyPublickKeyCryptographs);
    try
      ByteSize := JsonFilters.EstimatedByteSize;
      SetLength(JsonBytes,ByteSize);
      ByteSize := JsonFilters.ToBytes(JsonBytes, 0);
    finally
      JsonFilters.Free;
    end;
    if not OnlyPublickKeyCryptographs then
    begin
      JsonBytes := FilterDataWrite(JsonBytes, ByteSize, True);
      ByteSize := Length(JsonBytes);
      TTransportFilterTools.EncodeDataLength(JsonLen, ByteSize);
    end
    else 
      TTransportFilterTools.EncodePublicKeyLength(JsonLen, ByteSize);
    if FDelegate.Write(JsonLen, 0, 5) < 0 then
      Exit(-1);
    Exit(FDelegate.Write(JsonBytes, 0, ByteSize));
  except
    on Err: TDBXError do
    begin
    end;
  end;
  Result := -1;
end;

function TDBXFilterSocketChannel.Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer;
var
  FilteredData: TArray<Byte>;
  I: Integer;
  Filter: TTransportFilter;
  HasPublicKeyFilter: Boolean;
begin
  if Count = 0 then
    Exit(0);
  if FFilterFlag = Pendant then
  begin
    if FDelegate.Write(TTransportFilterTools.FilterQuery(FHeaderData), 0, TTransportFilterTools.HeaderLen) < 0 then
      Exit(-1);
    if FillBuffer(FHeaderData, 0, TTransportFilterTools.HeaderLen) then
    begin
      HasPublicKeyFilter := (not TTransportFilterTools.HasNoFilter(FHeaderData)) and
                             TTransportFilterTools.HasPublicKey(FHeaderData);

      if not HasPublicKeyFilter then
      begin
        if FFilterList <> nil then
        begin
          //throw an exception if there is a public key encryption filter (such as RSA)
          //on the client but not the server.
          for I := FFilterList.Count - 1 downto 0 do
          begin
            Filter := TTransportFilter(FFilterList.GetFilter(I));
            if Filter.PublicKeyCryptograph = true then
              raise TDBXError.Create(0, Format(SNoMatchingFilter, [Filter.Id]));
          end;
        end;
      end;

      if TTransportFilterTools.HasNoFilter(FHeaderData) then
        FFilterFlag := Regular
      else 
      begin
        FFilterFlag := Filtered;
        if HasPublicKeyFilter then
        begin
          if ReceiveAndSetConfederateFilterParameters(False) < 0 then
            Exit(-1);
          if SendFilterParameters(True) < 0 then
            Exit(-1);
          if not FillBuffer(FHeaderData, 0, TTransportFilterTools.HeaderLen) or (ReceiveAndSetConfederateFilterParameters(True) < 0) then
            Exit(-1);
        end
        else 
        begin
          if ReceiveAndSetConfederateFilterParameters(False) < 0 then
            Exit(-1);
        end;
        if SendFilterParameters(False) < 0 then
          Exit(-1);
        if not FFilterList.HandshakeComplete then
          Exit(-1);
      end;
    end
    else 
      Exit(-1);
  end;
  if FFilterFlag = Filtered then
  begin
    Assert(Offset = 0);
    FilteredData := FilterDataWrite(Buffer, Count, False);
    TTransportFilterTools.EncodeDataLength(FHeaderData, Length(FilteredData));
    if FDelegate.Write(FHeaderData, 0, TTransportFilterTools.HeaderLen) = -1 then
      Exit(-1);
    Exit(FDelegate.Write(FilteredData, 0, Length(FilteredData)));
  end;
  Result := FDelegate.Write(Buffer, Offset, Count);
end;

function TDBXFilterSocketChannel.ReceiveAndSetConfederateFilterParameters(const PublicKeyEncrypted: Boolean): Integer;
var
  FilterByteLen: Integer;
  FilterBytes: TArray<Byte>;
begin
  FilterByteLen := TTransportFilterTools.DecodeDataLen(FHeaderData);
  if FilterByteLen < 0 then
    Exit(-1);
  SetLength(FilterBytes,FilterByteLen);
  if not FillBuffer(FilterBytes, 0, FilterByteLen) then
    Exit(-1);
  if PublicKeyEncrypted then
    FilterBytes := FilterDataRead(FilterBytes, FilterByteLen, True);
  if not RestoreFilterList(FilterBytes, 0) then
    Exit(-1);
  Result := 0;
end;

function TDBXFilterSocketChannel.FilterDataRead(const Data: TArray<Byte>; const Count: Integer; const OnlyPublikKeyCryptographs: Boolean): TArray<Byte>;
var
  ProcessedData: TArray<Byte>;
  Filter: TTransportFilter;
  I: Integer;
begin
  SetLength(ProcessedData,Count);
  TDBXPlatform.CopyByteArray(Data, 0, ProcessedData, 0, Count);
  for I := 0 to FFilterList.Count - 1 do
  begin
    Filter := FFilterList.GetFilter(I);
    if Filter.PublicKeyCryptograph = OnlyPublikKeyCryptographs then
      ProcessedData := Filter.ProcessOutput(ProcessedData);
  end;
  Result := ProcessedData;
end;

function TDBXFilterSocketChannel.FilterDataWrite(const Data: TArray<Byte>; const Count: Integer;
  const OnlyPublikKeyCryptographs: Boolean): TArray<Byte>;
var
  ProcessedData: TArray<Byte>;
  Filter: TTransportFilter;
  I: Integer;
begin
  SetLength(ProcessedData,Count);
  TDBXPlatform.CopyByteArray(Data, 0, ProcessedData, 0, Count);
  for I := 0 to FFilterList.Count - 1 do
  begin
    Filter := TTransportFilter(FFilterList.GetFilter(I));
    if Filter.PublicKeyCryptograph = OnlyPublikKeyCryptographs then
      ProcessedData := Filter.ProcessInput(ProcessedData);
  end;
  Result := ProcessedData;
end;

procedure TDBXFilterSocketChannel.Close;
begin
  FDelegate.Close;
end;

function TDBXFilterSocketChannel.GetChannelInfo: TDBXChannelInfo;
begin
  Result := FDelegate.ChannelInfo;
end;

procedure TDBXFilterSocketChannel.Open;
begin
  FDelegate.Open;
end;

function TDBXFilterSocketChannel.GetDBXProperties: TDBXProperties;
begin
  Result := FDelegate.DBXProperties;
end;

procedure TDBXFilterSocketChannel.SetDBXProperties(const Properties: TDBXProperties);
var
  JsonFilters: string;
begin
  FDelegate.DBXProperties := Properties;
  JsonFilters := Properties[TDBXPropertyNames.Filters];
  if JsonFilters.Length > 0 then
  begin
    FFilterList := TTransportFilterCollection.FromJSON(JsonFilters);
    FOwnFilterList := True;
  end;
end;

end.
