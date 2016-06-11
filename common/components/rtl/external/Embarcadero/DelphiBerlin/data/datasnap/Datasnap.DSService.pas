{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSService;

interface

uses
  System.Classes,
  System.JSON,
  Data.DBXCommon,
  Data.DbxDatasnap,
  System.Generics.Collections,
  DataSnap.DSCommonServer,
  System.SysUtils,
  IPPeerAPI;

const
    REQUEST_DELIMITER = '/';
    REQUEST_PARAM_DELIMITER = '?';
    REST_CONTEXT = 'rest';
    JSON_CONTEXT = 'json' deprecated 'use rest';
    CACHE_CONTEXT = 'cache';

type

  /// <summary>Represents the filter parameter range type.</summary>
  TParamRange = set of 0..64;

  /// <summary>Converts any type to JSON, based on filter parameters. Any
  /// request filter needs to register with the RequestFilter factory, in order
  /// to be used within requests. The filter is configurable in the request,
  /// based on parameter values.</summary>
  TDSRequestFilter<T> = class
    strict private
      FName: string;
      FRange: TParamRange;
      FOnResult: Boolean;
      FTypeName: string;

    protected
      constructor Create(const TypeName: string); virtual;

    public
      destructor Destroy; override;

      ///  <summary>Changes the parameter value</summary>
      ///  <param name="ParamName">Filter parameter</param>
      ///  <param name="ParamValue">Parameter value, as string</param>
      ///  <return>true if the parameter exists and the value is valid</return>
      function SetParameterValue(ParamName: string; ParamValue: string): Boolean; virtual;
      ///  <summary>Returns true if the filter accepts the given parameter</summary>
      ///  <param name="ParamName">parameter name</param>
      ///  <return>true if the parameter exists</return>
      function HasParameter(const ParamName: string): Boolean; virtual;
      ///  <summary>Returns true if the value can be converted to JSON</summary>
      ///  <param name="Value">value to be converted</param>
      ///  <return>true if the value can be converted</return>
      function CanConvert(Value: T): Boolean; virtual; abstract;
      ///  <summary>Returns the JSON value</summary>
      ///  <param name="Value">value to be converted</param>
      ///  <param name="IsLocal">true for an in-process value (controls the life-cycle)</param>
      ///  <return>JSON value</return>
      function ToJSON(Value: T; IsLocal: Boolean): TJSONValue; virtual; abstract;

    public
      property Name: string read FName write FName;
      property TypeName: string read FTypeName;
      property Range: TParamRange read FRange write FRange;
      property OnResult: Boolean read FOnResult write FOnResult;
  end;

  /// <summary>Represents the specialized filter for DBX values.</summary>
  TDBXRequestFilter = class(TDSRequestFilter<TDBXValue>)
    public
      ///  <summary>Clone current instance</summary>
      ///  <return>TDBXRequestFilter</return>
      function Clone: TDBXRequestFilter; virtual; abstract;
  end;

  /// <summary>Returns parts of the DBX values, based on offset and
  /// count.</summary>
  TDBXCropRequestFilter = class(TDBXRequestFilter)
    strict private
      FOff, FCount: Integer;

    protected
      constructor Create(const TypeName: string; Off, Count: Integer); reintroduce; overload;

      property Off: Integer read FOff;
      property Count: Integer read FCount;

    public
      constructor Create(const TypeName: string); overload; override;

      destructor Destroy; override;

      function SetParameterValue(ParamName: string; ParamValue: string): Boolean; override;
      function HasParameter(const ParamName: string): Boolean; override;
  end;

  /// <summary>Represents the specialized request filter for the string and
  /// TStream types.</summary>
  TDBXSubStringRequestFilter = class(TDBXCropRequestFilter)
    public
      function CanConvert(Value: TDBXValue): Boolean; override;
      function ToJSON(Value: TDBXValue; IsLocal: Boolean = false): TJSONValue; override;

      function Clone: TDBXRequestFilter; override;
  end;

  /// <summary>Represents the specialized crop filter for DBX Reader.</summary>
  TDBXReaderRequestFilter = class(TDBXCropRequestFilter)
    public
      function CanConvert(Value: TDBXValue): Boolean; override;
      function ToJSON(Value: TDBXValue; IsLocal: Boolean = false): TJSONValue; override;

      function Clone: TDBXRequestFilter; override;
  end;

  /// <summary>Handles the available DBX request filters.</summary>
  TDBXRequestFilterFactory = class
    strict private
      class var
        FInstance: TDBXRequestFilterFactory;
    private
      FRepo: TDictionary<string, TDBXRequestFilter>;

      class procedure SetUp;
      class procedure CleanUp;
    public
      constructor Create;
      destructor Destroy; override;

      procedure RegisterRequestFilter(Converter: TDBXRequestFilter);
      function RequestFilter(Name: string): TDBXRequestFilter;
      procedure GetAllWithField(FieldName: string; List: TObjectList<TDBXRequestFilter>);

      class property Instance: TDBXRequestFilterFactory read FInstance;
  end;

  /// <summary>Represents the class for DataSnap service exceptions.</summary>
  TDSServiceException = class(Exception)
  end;

  TDBXRequestFilterDictionary =  TObjectDictionary<string, TDBXRequestFilter>;

  /// <summary>Implements functionality for managing request filters.</summary>
  TDSRequestFilterManager = class
  protected
    FRequestFilterStore: TDBXRequestFilterDictionary;
    FStreamAsJSON: Boolean;

    ///  <summary> Processes request parameters name from: DCType1-10.Field or DCType.Field or DCType1,3.Field
    ///  </summary>
    class procedure ParseParamName(const PName: string; out DCName: string; out DCType: string; out FieldName: string;
                                   out Range: TParamRange; out OnResult: Boolean);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    ///  <summary> Builds the appropriate data converters out of query parameters</summary>
    function ProcessQueryParameter(const ParamName: string; const ParamValue: string): Boolean;

    procedure FiltersForCriteria(const TypeName: string; const Range: TParamRange;
                                 const OnResult: Boolean; const List: TObjectList<TDBXRequestFilter>); overload;
    procedure FiltersForCriteria(const Range: TParamRange; const OnResult: Boolean;
                                 const List: TObjectList<TDBXRequestFilter>); overload;


    ///  <summary> Checks if two converters overlap ranges in FDataConverterStore </summary>
    function CheckConvertersForConsistency: Boolean;
  end;

  /// <summary>Is the API class for DataSnap-specific stateless
  /// services.</summary>
  TDSService = class(TDSRequestFilterManager)
  protected type
    TExecuteCallback = reference to procedure(var AConnection: TDBXConnection; var ACommand: TDBXCommand;
      const AResponseHandler: TRequestCommandHandler);
  private
    FDBXProperties: TDBXDatasnapProperties;
    FLocalConnection: Boolean;
    function GetInputParameterInstance(JsonParam: TJSONValue; Parameter: TDBXParameter;
                                       var InstanceOwner: Boolean): TJSONValue;
  protected
    ///  <summary> Dispatches the JSON request to appropriate processing method. It
    ///    accepts an array of JSON objects that will be dispatched to the processing
    ///    mrthod. The response is a JSON array with the execution results.
    ///  </summary>
    ///  <remarks>
    ///     Example of JSON request: [{"execute":{"MethodClass.MethodName":[inputParameter,...]}},...]
    ///
    ///      Where output or return parameters are defined, they are picked up into a JSON response:
    ///          [{"result":[parameterValue,parameterValue...]},...]
    ///
    ///      If the server throws an exception, then the JSON response is:
    ///          [{"error":"error message"},...]
    ///  </remarks>
    ///  <param name="Request">JSON request in the protocol format, never nil</param>
    ///  <param name="ResponseHandler"> Handler responsible for managing the result
    ///  </param>
    procedure ProcessRequest(const Request: TJSONArray; ResponseHandler: TRequestCommandHandler); overload; virtual;

    procedure ProcessRequest(const ACommand: string; const AResponseHandler: TRequestCommandHandler; ACallback: TExecuteCallback); overload; virtual;
    ///  <summary> Executes the JSON request and generates the JSON response
    ///  </summary>
    ///  <remarks> Input parameters are consumed from left to right (position based).
    ///    The values are bound to the IN or IN/OUT method actual parameters orderly
    ///    from left to right, skipping the OUT or RETURN parameters.
    ///    If not enough input parameters are supplied, the outstanding actual parameters
    ///    are bound to nil.
    ///  </remarks>
    /// <param name="Request">JSON request in the protocol format, never nil</param>
    /// <param name="ResponseHandler">Handles the result of command execution</param>
    procedure Execute(const Request: TJSONObject; ResponseHandler: TRequestCommandHandler); overload;

    procedure Execute(const ACommand: string; const AResponseHandler: TRequestCommandHandler; ACallback: TExecuteCallback); overload;

                                    
    function GetDBXConnection: TDBXConnection; virtual;
    function GetDSServer: TDSCustomServer; virtual;
  public
    constructor Create(DSServerName, DSHostname: string; DSPort: Integer;
                       AuthUser: string = ''; AuthPassword: string = ''); reintroduce; overload; virtual;
    constructor Create(DSServerName, DSHostname: string; DSPort: Integer;
                       AuthUser: string = ''; AuthPassword: string = ''; AIPImplementationID: string = ''); reintroduce; overload; virtual;
    destructor Destroy; override;

    ///  <summary> processes GET request
    ///  </summary>
    ///  <remarks> The response contains either success or an error message in an JSON object.
    ///  </remarks>
    ///  <param name="Request">contains the original request, never nil or empty</param>
    ///  <param name="Params">request parameters</param>
    ///  <param name="Content">contains the request content, usually the serialized JSON object to be updated.</param>
    ///  <param name="ResponseHandler">Handles the command populated with the result</param>
    procedure ProcessGETRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); virtual; abstract;

    ///  <summary> processes PUT request
    ///  </summary>
    ///  <remarks> The response contains either success or an error message in an JSON object.
    ///  </remarks>
    ///  <param name="Request">contains the original request, never nil or empty</param>
    ///  <param name="Params">request parameters</param>
    ///  <param name="Content">contains the request content, usually the serialized JSON object to be updated.</param>
    ///  <param name="ResponseHandler">Handles the command populated with the result</param>
    procedure ProcessPUTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); virtual; abstract;

    ///  <summary> processes POST request
    ///  </summary>
    ///  <remarks> The response contains either success or an error message in an JSON object.
    ///  </remarks>
    ///  <param name="Request">contains the original request, never nil or empty</param>
    ///  <param name="Params">request parameters</param>
    ///  <param name="Content">contains the request content, usually the serialized JSON object to be updated.</param>
    ///  <param name="ResponseHandler">Handles the command populated with the result</param>
    procedure ProcessPOSTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); virtual; abstract;

    ///  <summary> processes DELETE request
    ///  </summary>
    ///  <remarks> The response contains either success or an error message in an JSON object.
    ///  </remarks>
    ///  <param name="Request">contains the original request, never nil or empty</param>
    ///  <param name="Params">request parameters</param>
    ///  <param name="Content">contains the request content, usually the serialized JSON object to be updated.</param>
    ///  <param name="ResponseHandler">Handles the command populated with the result</param>
    procedure ProcessDELETERequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); virtual; abstract;

    property LocalConnection: Boolean read FLocalConnection;

    ///  <summary> Set with query parameter 'json' allowing the user to returna  stream as a
    ///    JSON array of bytes instead of a content stream.
    ///  </summary>
    property StreamAsJSON: Boolean read FStreamAsJSON write FStreamAsJSON;
  end;

  /// <summary>REST service implementation.</summary>
  TDSRESTService = class(TDSService)
  private
    FPeerProcs: IIPPeerProcs;
    FDSServer: TDSCustomServer;
    /// <summary> processes REST request
    /// </summary>
    /// <remarks> The response contains either success or an error message
    /// </remarks>
    /// <param name="RequestType">The request type, one of GET, POST, PUT and DELETE</param>
    /// <param name="RestRequest">contains the REST request, never nil or empty</param>
    /// <param name="Content">contains the HTTP content, usually the object to be updated</param>
    /// <param name="ResponseHandler"> Handler responsible for managing the result </param>
    procedure ProcessREST(const RequestType: string; const RestRequest: string;
                                const Content: TArray<Byte>;
                                const ResponseHandler: TRequestCommandHandler);

    procedure SetMethodNameWithPrefix(const RequestType, ClassName, MethodName: string; out DSMethodName: string);
    procedure ProcessParameters(const ADSMethodName: string;
      const Params: TStrings; Content: TArray<Byte>; const ACommand: TDBXCommand);
    procedure ParseRequestSegments(const Request: string;
      const Segments: TStrings);
    function PeerProcs: IIPPeerProcs;
  protected
    function GetDSServer: TDSCustomServer; override;
  public
    constructor Create(DSServerName, DSHostname: string; DSPort: Integer;
                       AuthUser: string = ''; AuthPassword: string = ''; AIPImplementationID: string = ''); override;
    constructor Create(const ADSServer: TDSCustomServer; DSHostname: string; DSPort: Integer;
                       AuthUser: string = ''; AuthPassword: string = ''; AIPImplementationID: string = ''); overload;
    destructor Destroy; override;

    procedure ProcessGETRequest(const Request: string; Params: TStrings;
                                Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;
    procedure ProcessPUTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;
    procedure ProcessPOSTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;
    procedure ProcessDELETERequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;
  end;

  /// <summary>Implements the service for the JSON HTTP request.</summary>
  TDSJSONService = class(TDSService)
  protected
    procedure ProcessJSONCommand(Content: TArray<Byte>; ResponseHandler: TRequestCommandHandler);

  public
    constructor Create( dsServerName, dsHostname: string; dsPort: Integer; AuthUser: string = '';
                        AuthPassword: string = ''; AIPImplementationID: string = '' ); override;
    destructor Destroy; override;

    procedure ProcessGETRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;

    procedure ProcessPUTRequest(const Request: string; Params: TStrings;
                                Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;
    procedure ProcessPOSTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;
    procedure ProcessDELETERequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                                ResponseHandler: TRequestCommandHandler); override;
  end; 

implementation

uses
  Data.DBXClientResStrs,
  Data.DBXJSONCommon,
  Data.DBXPlatform,
  Datasnap.DSHTTPCommon,
  System.StrUtils,
  System.Character,
  System.Math;

const
  CMD_EXECUTE = 'execute';
  CMD_ERROR   = 'error';
  DRIVER_NAME = 'Datasnap';
  NULL        = 'null';
  PARAMETERS_PAIR  = '_parameters';

{TDSService}

constructor TDSService.Create(dsServerName, dsHostname: string; dsPort: Integer; AuthUser, AuthPassword: string);
begin
  Create(dsServerName, dsHostname, dsPort, AuthUser, AuthPassword, '');
end;

constructor TDSService.Create(dsServerName, dsHostname: string; dsPort: Integer; AuthUser, AuthPassword, AIPImplementationID: string);
begin
  inherited Create;
  FDBXProperties := TDBXDatasnapProperties.Create(nil);
  if DSServerName = EmptyStr then
  begin
    FDBXProperties.Values[ TDBXPropertyNames.DriverName ] := DRIVER_NAME;
    FDBXProperties.Values[ TDBXPropertyNames.HostName ] := dsHostname;
    FDBXProperties.Values[ TDBXPropertyNames.Port ] := IntToStr( dsPort );
    FLocalConnection := false;
  end
  else
  begin
                                                                                 
    FDBXProperties.Values[ TDBXPropertyNames.DriverName ] := DSServerName;
    // Indicate that this connection is not a proxy to another process
    FDBXProperties.Values[ 'InProcessServer' (*TDBXPropertyNames.InprocessServer*) ] := 'REST';
    FLocalConnection := true;
  end;
  FDBXProperties.DSAuthUser := AuthUser;
  FDBXProperties.DSAuthPassword := AuthPassword;
  FDBXProperties.Values[ TDBXPropertyNames.IPImplementationID ] := AIPImplementationID;

  StreamAsJSON := False;
end;

destructor TDSService.Destroy;
begin
  FDBXProperties.Free;
  inherited;
end;

procedure TDSService.ProcessRequest(const ACommand: string; const AResponseHandler: TRequestCommandHandler; ACallback: TExecuteCallback);
begin
  try
    Execute(ACommand, AResponseHandler, ACallback) //, ResponseHandler);
  except
    on ex: Exception do
      AResponseHandler.AddCommandError(ex.Message);
  end;
end;

procedure TDSService.ProcessRequest(const Request: TJSONArray; ResponseHandler: TRequestCommandHandler);
var
  JsonCmd: TJSONstring;
  I: Integer;
begin
  for I := 0 to Request.Count - 1 do
  begin
    JsonCmd := TJSONObject(Request.Items[I]).Pairs[0].JsonString;
    if JsonCmd.Value = CMD_EXECUTE then
    begin
      try
        Execute(TJSONObject(TJSONObject(request.Items[I]).Pairs[0].JsonValue), ResponseHandler);
      except
        on ex: Exception do
          ResponseHandler.AddCommandError(ex.Message);
      end;
    end
    else
    begin
      ResponseHandler.AddCommandError(Format(SInvalidInternalCmd, [JsonCmd.Value]));
    end;
  end;
end;

function TDSService.GetInputParameterInstance(JsonParam: TJSONValue; Parameter: TDBXParameter;
                                              var InstanceOwner: Boolean): TJSONValue;
var
  ParameterType: Integer;
  ParamDirection: TDBXParameterDirection;
begin
  //unless cloned, result will be the same as the value passed in
  Result := JsonParam;

  InstanceOwner := False;

  ParameterType := Parameter.DataType;
  ParamDirection := Parameter.ParameterDirection;

  //potentially clone the JsonParam, depending on if its value will be
  //returned in the response (var param) and if it is a complex type that
  //isn't cloned by JSONToDBX
  if (ParamDirection = TDBXParameterDirections.InOutParameter) then
  begin
    if JsonParam is TJSONObject then
    begin
      if (ParameterType = TDBXDataTypes.JsonValueType) then
      begin
        if Parameter.Value.ValueType.SubType <> TDBXDataTypes.UserSubType then
          InstanceOwner := True;
      end
      else if (ParameterType = TDBXDataTypes.TableType) then
        InstanceOwner := True;
    end
    else if JsonParam is TJSONArray then
      InstanceOwner := True;

    if InstanceOwner then
      Result := TJSONValue(JsonParam.Clone);
  end;
end;

function TDSService.GetDBXConnection: TDBXConnection;
var
  LServer: TDSCustomServer;
begin
  LServer := Self.GetDSServer;
  if LServer = nil then
  begin
    // Connect to another server
    TDBXConnectionFactory.Lock;
    try
      Result := TDBXConnectionFactory.GetConnectionFactory.GetConnection(FDBXProperties);
    finally
      TDBXConnectionFactory.Unlock;
    end;
  end
  else
    // In process server
    Result := TDSServerConnectionFactory.Instance.GetConnection(FDBXProperties, LServer);
end;

function TDSService.GetDSServer: TDSCustomServer;
begin
  Result := nil;
end;

                                                                                            
procedure TDSService.Execute(const ACommand: string; const AResponseHandler: TRequestCommandHandler; ACallback: TExecuteCallback);
var
    DBXConnection: TDBXConnection;
    DBXCommand: TDBXCommand;
begin
  DBXCommand := nil;

  DBXConnection := GetDBXConnection;
  try
    DBXCommand := DBXConnection.CreateCommand;
    DBXCommand.CommandType := TDBXCommandTypes.DSServerMethod;

    DBXCommand.Text := ACommand;
    DBXCommand.Prepare;

    ACallback(DBXConnection, DBXCommand, AResponseHandler);
  finally

    if DBXCommand <> nil then
      DBXCommand.Close;

    if DBXConnection <> nil then
      DBXConnection.Close;

    DBXCommand.Free;

    DBXConnection.Free;
  end;
end;


                                                                                            
procedure TDSService.Execute(const Request: TJSONObject; ResponseHandler: TRequestCommandHandler);
var
    JsonParams: TJSONArray;
    Command: string;
    OwnParams: Boolean;
begin
  OwnParams := false;
  JsonParams := nil;

  Command := Request.Pairs[0].JsonString.Value;
  try
  Execute(Command, ResponseHandler,
    procedure(var DBXConnection: TDBXConnection; var DBXCommand: TDBXCommand;
     const AResponseHandler: TRequestCommandHandler)
    var
      I: Integer;
      J: Integer;
      ParamDirection: TDBXParameterDirection;
      DidClone: Boolean;
      JsonParam: TJSONValue;
    begin

        JsonParams := TJSONArray(Request.Pairs[0].JsonValue);

        if JsonParams.Count > DBXCommand.Parameters.Count then
        begin
          // too many parameters
          raise TDSServiceException.Create(Format(STooManyParameters, [Command, DBXCommand.Parameters.Count,
            JsonParams.Count]));
        end;

        // populate input parameters - skip the output ones
        J := 0;
        for I := 0 to DBXCommand.Parameters.Count - 1 do
        begin
          DidClone := False;

          ParamDirection := DBXCommand.Parameters[I].ParameterDirection;
          if (ParamDirection = TDBXParameterDirections.InOutParameter) or
             (ParamDirection = TDBXParameterDirections.InParameter) then
          begin
            // if less input arguments are provided the rest are assumed to be nil
            if J >= jsonParams.Count then
              JsonParam := nil
            else
            begin
              JsonParam := JsonParams.Items[J];

              //in some cases, we will want to use a cloned instance of JsonParam, this helper
              //class assists with that... returning either the same instance or a cloned instance.
              JsonParam := GetInputParameterInstance(JsonParam, DBXCommand.Parameters[I], DidClone);
              Inc(J);
            end;


            try
              //Only set instanceOnwer to true if the instance has just been cloned
              TDBXJSONTools.JSONToDBX( JsonParam, DBXCommand.Parameters[I].Value, DBXCommand.Parameters[I].DataType, LocalConnection, DidClone );
            except
              //if an exception happened while trying to set the value,
              //we assume the value wasn't set. So, if the parameter passed in was cloned,
              //we need to free it here to prevent a memory leak
              if DidClone then
                FreeAndNil(JsonParam);
              raise;
            end;
          end;
        end;

        if J < jsonParams.Count then
        begin
          // reject execution if not all input parameters were used
          raise TDSServiceException.Create(Format(STooManyInputParams, [Command, J, jsonParams.Count]));
        end;

        DBXCommand.ExecuteUpdate;

        AResponseHandler.AddCommand(DBXCommand, DBXConnection);
        DBXCommand := nil;
        DBXConnection := nil;
    end);
  finally
    if OwnParams then
      JsonParams.Free;
  end;;
end;

{TDSRESTService}

constructor TDSRESTService.Create(DSServerName, DSHostname: string; DSPort: Integer; AuthUser, AuthPassword: string; AIPImplementationID: string);
begin
  inherited Create(DSServerName, DSHostname, DSPort, AuthUser, AuthPassword, AIPImplementationID);
end;

constructor TDSRESTService.Create(const ADSServer: TDSCustomServer; DSHostname: string; DSPort: Integer; AuthUser, AuthPassword: string; AIPImplementationID: string);
var
  LName: string;
begin
  if ADSServer <> nil then
    LName := ADSServer.Name;
  //CreateImpl(ADSServer, LName, DSHostname, DSPort, AuthUser, AuthPassword, AIPImplementationID);
  FDSServer := ADSServer;
  inherited Create(LName, DSHostname, DSPort, AuthUser, AuthPassword, AIPImplementationID);
end;

destructor TDSRESTService.Destroy;
begin
  inherited;
end;

function TDSRESTService.GetDSServer: TDSCustomServer;
begin
  Result := FDSServer;
end;

function TDSRESTService.PeerProcs: IIPPeerProcs;
var
  LIPImplementationID: string;
begin
  if FPeerProcs = nil then
  begin
    LIPImplementationID := FDBXProperties.Values[TDBXPropertyNames.IPImplementationID];
    FPeerProcs := IPProcs(LIPImplementationID);
  end;
  Result := FPeerProcs;
end;

procedure TDSRESTService.ParseRequestSegments(const Request: string;
   const Segments: TStrings);
var
  SlashLeft, SlashRight: Integer;
  LSegment: string;
  LPeerProcs: IIPPeerProcs;
  LMoreSegments: Boolean;
begin
  LPeerProcs := Self.PeerProcs; 
  Segments.Clear;
  // extract the class name
  SlashLeft := Request.IndexOf(REQUEST_DELIMITER);
  if SlashLeft < 0 then
  begin
    // no delimiter for class name
    raise TDSServiceException.Create(SInvalidRequestFormat);
  end
  else if SlashLeft > 0 then
  begin
    // first / is missing
    SlashRight := SlashLeft;
    SlashLeft := 0;
  end
  else  // SlashLeft = 0
  begin
    SlashRight := Request.IndexOf(REQUEST_DELIMITER, SlashLeft+1);
    if SlashRight < 0 then
      SlashRight := Request.Length;
  end;
  LMoreSegments := True;
  while LMoreSegments do
  begin
    if (SlashRight = SlashLeft + 1) then
      Segments.Add(EmptyStr)
    else
    begin
      LSegment := Request.Substring(Slashleft+1, SlashRight-SlashLeft-1);
      if LSegment.IndexOf('%') >= 0 then  // Optimization
        LSegment := LPeerProcs.URLDecode(LSegment);
      Segments.Add(LSegment);
    end;
    LMoreSegments := SlashRight < Request.Length - 1;
    if LMoreSegments then
    begin
      SlashLeft := SlashRight;
      SlashRight := Request.IndexOf(REQUEST_DELIMITER, SlashLeft+1);
      if SlashRight < 0 then
        SlashRight := Request.Length;
    end;
  end;
end;

procedure TDSRESTService.ProcessParameters(const ADSMethodName: string; const Params: TStrings; Content: TArray<Byte>; const ACommand: TDBXCommand);
var
  I: Integer;
  LParamIndex: Integer;
  LWritable: Boolean;
  LBody: TJSONValue;
  LBodyArray: TJSONArray;
  LBodyArrayIndex: Integer;
  LFreeBody: TJSONValue;
  LJSONParam: TJSONValue;
  LDBXParameter: TDBXParameter;
  LCanFreeJSON: Boolean;
  S: string;
begin
  LFreeBody := nil;
  LBody := nil;
  LBodyArray := nil;
  LParamIndex := 0;
  LBodyArrayIndex := 0;
  try
    for I := 0 to ACommand.Parameters.Count - 1 do
    begin
      case ACommand.Parameters[I].ParameterDirection of
        TDBXParameterDirections.InParameter,
        TDBXParameterDirections.InOutParameter:
          LWritable := True;
      else
        LWritable := False;
      end;
      if LWritable then
      begin
        LDBXParameter := ACommand.Parameters[I];
        if LParamIndex < Params.Count then
        begin
          S := Params[LParamIndex];
          if AnsiCompareStr(S,NULL) = 0 then
                                                    
            TDBXJSONTools.JSONNullToDBX(LDBXParameter.Value, LDBXParameter.DataType)
          else
            TDBXJSONTools.JSONStringToDBX(S, LDBXParameter.Value, LDBXParameter.DataType);
          Inc(LParamIndex);
        end
        else
        begin
          // Look for more parameters in the body
          if (Content <> nil) and (Length(Content) > 0) then
          begin
            if LBody = nil then
            begin
              LBodyArray := nil;
              LBody := TJSONObject.ParseJSONValue(Content, 0);
              LFreeBody := LBody;
              if LBody = nil then
              begin
                //ParamArray.Free;
                raise TDSServiceException.Create(SNoJSONValue);
              end;
              if (LBody is TJSONObject) and (TJSONObject(LBody).Count = 1) and
                (TJSONObject(LBody).Pairs[0].JSonString.Value = PARAMETERS_PAIR) and
                (TJSONObject(LBody).Pairs[0].JsonValue is TJSONArray) then
              begin
                LBodyArray := TJSONArray(TJSONObject(LBody).Pairs[0].JsonValue);
                LBodyArrayIndex := 0;
              end
            end;
          end;
          if LBody <> nil then
          begin
            if LBodyArray <> nil then
            begin
              if LBodyArrayIndex < LBodyArray.Count  then
              begin
                LJSONParam := LBodyArray.Items[LBodyArrayIndex];
                TDBXJSONTools.JSONToDBX(LJSONParam, LDBXParameter.Value, LDBXParameter.DataType, LocalConnection,
                  True (* Owns *), LCanFreeJSON );
                if not LCanFreeJSON then
                  LJSONParam.Owned := False;  // Don't free when LBody is freed
                Inc(LBodyArrayIndex);
                Inc(LParamIndex);
              end
            end
            else
            begin
              if LFreeBody = LBody then  // Body already processed
              begin
                LJSONParam := LBody;
                LFreeBody := nil;
                TDBXJSONTools.JSONToDBX(LJSONParam, LDBXParameter.Value, LDBXParameter.DataType, LocalConnection,
                  True (* Owns *));
                Inc(LParamIndex);
              end;
            end;
          end
          else
          begin
            // If not all parameters passed on url, set remaining to null
            TDBXJSONTools.JSONNullToDBX(LDBXParameter.Value, LDBXParameter.DataType);
            Inc(LParamIndex);
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(LFreeBody);
  end;
  if LParamIndex < Params.Count then
  begin
    // reject execution if not all input parameters were used
    raise TDSServiceException.Create(Format(STooManyInputParams, [
      ADSMethodName, LParamIndex, Params.Count]));
  end;
end;

procedure TDSRESTService.ProcessREST(const RequestType: string;
                                     const RestRequest: string;
                                     const Content: TArray<Byte>;
                                     const ResponseHandler: TRequestCommandHandler);

var
  Params, Segments: TStrings;
  ClassName, MethodName, DSMethodName: string;
  LHandled: Boolean;
  I: Integer;
begin
  Segments := TStringList.Create;
  Params := TStringList.Create;
  try
    try
      // get class, method name, parameters
      LHandled := False;

      ParseRequestSegments(RestRequest, Segments);
      if ResponseHandler is TDSServiceResponseHandler then
        TDSServiceResponseHandler(ResponseHandler).DoParsingRequest(Self,
          RequestType, Segments, DSMethodName, Params, LHandled);
      if not LHandled then
      begin
        if Segments.Count < 2 then
          raise TDSServiceException.Create(SInvalidRequestFormat);
        ClassName := Segments[0];
        MethodName := Segments[1];
        if (ClassName = '') or (MethodName = '') then
          raise TDSServiceException.Create(SInvalidRequestFormat);
        for I := 2 to Segments.Count - 1 do
          Params.Add(Segments[I]);
        SetMethodNameWithPrefix(RequestType, ClassName, MethodName, DSMethodName);
      end;
      if ResponseHandler is TDSServiceResponseHandler then
        TDSServiceResponseHandler(ResponseHandler).DoParseRequest(Self,
          RequestType, Segments, DSMethodName, Params);

      ProcessRequest(DSMethodName, ResponseHandler,
        procedure(var AConnection: TDBXConnection; var ACommand: TDBXCommand;
          const ResponseHandler: TRequestCommandHandler)
        begin
          ProcessParameters(DSMethodName, Params, Content, ACommand);
          ACommand.ExecuteUpdate;

          ResponseHandler.AddCommand(ACommand, AConnection); // Owns
          ACommand := nil;
          AConnection := nil;

        end);
    except
      on ex: Exception do
      begin
        ResponseHandler.AddCommandError(ex.Message);
      end;
    end;
  finally
    Params.Free;
    Segments.Free;
  end;
end;

procedure TDSRESTService.SetMethodNameWithPrefix(const RequestType, ClassName, MethodName: string;
                                                 out DSMethodName: string);
var
  Prefix: string;
begin
  //prefix method name if it isn't quoted
  if (MethodName.Chars[0] <> '"') and (MethodName.Chars[0] <> '''') and
     //and if the class isn't one which specifically doesn't support method name prefixing
     (ClassName <> 'DSAdmin') and (ClassName <> 'DSMetadata') then
  begin
    if RequestType = 'PUT' then
      Prefix := 'accept'
    else if RequestType = 'POST' then
      Prefix := 'update'
    else if RequestType = 'DELETE' then
      Prefix := 'cancel';
  end;

  DSMethodName := string.Format('%s.%s%s', [ClassName, Prefix, MethodName]);
end;

procedure TDSRESTService.ProcessGETRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                              ResponseHandler: TRequestCommandHandler);
begin
  ProcessREST('GET', Request, nil, ResponseHandler);
end;

procedure TDSRESTService.ProcessPOSTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                              ResponseHandler: TRequestCommandHandler);
begin
  if (Content <> nil) and (Length(Content) > 1) and
     not (Content[0] in [91,123]) and (Params <> nil) and (Params.Count = 1) and (Params.Names[0] <> EmptyStr) then
     // Param starts with '{' or '['
    ProcessREST('POST', Request, BytesOf(Params.Values[Params.Names[0]]), ResponseHandler)
  else
    ProcessREST('POST', Request, Content, ResponseHandler);
end;

procedure TDSRESTService.ProcessPUTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                              ResponseHandler: TRequestCommandHandler);
begin
  ProcessREST('PUT', Request, Content, ResponseHandler);
end;

procedure TDSRESTService.ProcessDELETERequest(const Request: string; Params: TStrings; Content: TArray<Byte>;
                              ResponseHandler: TRequestCommandHandler);
begin
  ProcessREST('DELETE', Request, nil, ResponseHandler);
end;

{TDSJSONService}

constructor TDSJSONService.Create(dsServerName, dsHostname: string; dsPort: Integer; AuthUser, AuthPassword, AIPImplementationID: string);
begin
  inherited Create(dsServerName, dsHostname, dsPort, AuthUser, AuthPassword, AIPImplementationID);
end;

destructor TDSJSONService.Destroy;
begin
  inherited;
end;

procedure TDSJSONService.ProcessJSONCommand(Content: TArray<Byte>; ResponseHandler: TRequestCommandHandler);
var
  Cmd: TJSONValue;
begin
  Cmd := TJSONObject.ParseJSONValue(Content, 0);
  if Cmd = nil then
      Raise TDSServiceException.Create(SNoJSONValue);

  try
    if Cmd is TJSONArray then
      ProcessRequest(TJSONArray(Cmd), ResponseHandler)
    else
      raise TDSServiceException.Create(Format(SJSONArrayExpected, [Cmd.ClassName]));
  finally
    Cmd.Free;
  end;
end;

procedure TDSJSONService.ProcessPOSTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>; ResponseHandler: TRequestCommandHandler);
begin
  if (Content <> nil) and (Length(Content) > 0) then
    ProcessJSONCommand(Content, ResponseHandler)
  else
    raise TDSServiceException.Create(Format(SNoJSONCmdContent, ['POST']));
end;

procedure TDSJSONService.ProcessGETRequest(const Request: string; Params: TStrings; Content: TArray<Byte>; ResponseHandler: TRequestCommandHandler);
begin
  raise TDSServiceException.Create(Format(SPOSTExpected, ['GET']));
end;

procedure TDSJSONService.ProcessPUTRequest(const Request: string; Params: TStrings; Content: TArray<Byte>; ResponseHandler: TRequestCommandHandler);
begin
  raise TDSServiceException.Create(Format(SPOSTExpected, ['PUT']));
end;

procedure TDSJSONService.ProcessDELETERequest(const Request: string; Params: TStrings; Content: TArray<Byte>; ResponseHandler: TRequestCommandHandler);
begin
  raise TDSServiceException.Create(Format(SPOSTExpected, ['DELETE']));
end;

{ TDSRequestFilter<T> }

constructor TDSRequestFilter<T>.Create(const TypeName: string);
begin
  FTypeName := TypeName;
end;

destructor TDSRequestFilter<T>.Destroy;
begin

  inherited;
end;

function TDSRequestFilter<T>.HasParameter(const ParamName: string): Boolean;
begin
  exit(false);
end;

function TDSRequestFilter<T>.SetParameterValue(ParamName,
  ParamValue: string): Boolean;
begin
  Result := false;
end;

{ TDBXRequestFilterFactory }

class procedure TDBXRequestFilterFactory.CleanUp;
begin
  FreeAndNil( FInstance );
end;

constructor TDBXRequestFilterFactory.Create;
begin
  FRepo := TDBXRequestFilterDictionary.Create([doOwnsValues]);
end;

function TDBXRequestFilterFactory.RequestFilter(
  Name: string): TDBXRequestFilter;
begin
  if FRepo.ContainsKey(Name) then
    FRepo.TryGetValue(Name, Result)
  else
    Result := nil
end;

destructor TDBXRequestFilterFactory.Destroy;
begin
  FreeAndNil( FRepo );
  inherited;
end;

procedure TDBXRequestFilterFactory.GetAllWithField(FieldName: string;
  List: TObjectList<TDBXRequestFilter>);
var
  Itr: TDBXRequestFilterDictionary.TValueEnumerator;
  DC: TDBXRequestFilter;
begin
  Itr := FRepo.Values.GetEnumerator;
  try
    while Itr.MoveNext do
    begin
      DC := Itr.Current;
      if DC.HasParameter(FieldName) then
        List.Add(DC);
    end;
  finally
    Itr.Free;
  end;
end;

procedure TDBXRequestFilterFactory.RegisterRequestFilter(
  Converter: TDBXRequestFilter);
begin
  FRepo.Add(Converter.TypeName, Converter);
end;

class procedure TDBXRequestFilterFactory.SetUp;
begin
  FInstance := TDBXRequestFilterFactory.Create;
end;

{ TDBXCropDataConverter }

constructor TDBXCropRequestFilter.Create(const TypeName: string);
begin
  inherited Create(TypeName);
  FOff := 0;
  FCount := MaxInt;
end;

constructor TDBXCropRequestFilter.Create(const TypeName: string; Off,
  Count: Integer);
begin
  inherited Create(TypeName);
  FOff := Off;
  FCount := Count;
end;

destructor TDBXCropRequestFilter.Destroy;
begin
  inherited;
end;

function TDBXCropRequestFilter.HasParameter(
  const ParamName: string): Boolean;
begin
  if (AnsiCompareText(ParamName, 'o') = 0) or (AnsiCompareText(ParamName, 'c') = 0)
     or (AnsiCompareText(ParamName, 'r') = 0) then
    exit(true);
  Result := inherited;
end;

function TDBXCropRequestFilter.SetParameterValue(ParamName,
  ParamValue: string): Boolean;
var
  RangeSep : Integer;
begin
  if AnsiCompareText(ParamName, 'o') = 0 then
    FOff := StrToInt(ParamValue)
  else if AnsiCompareText(ParamName, 'c') = 0 then
    FCount := StrToInt(ParamValue)
  {If the 'r' field is used then the user is providing a pair of integers, separated by a comma.
   Before the comma is the offset for the substring, and the number after the comma is the count
   of how many character after the offset to include in the substring (the length.)}
  else if AnsiCompareText(ParamName, 'r') = 0 then
  begin
    RangeSep := ParamValue.IndexOf(',') + 1;
    if ( RangeSep > 1 ) and ( RangeSep < ParamValue.Length ) then
    begin
      FOff := StrToInt(ParamValue.Substring(0, RangeSep - 1));
      FCount := StrToInt(ParamValue.Substring(RangeSep, ParamValue.Length - RangeSep));
    end
    else
      exit(false);
  end
  else
    exit(false);
  exit(true);
end;

{ TDBXSubStringDataConverter }

function TDBXSubStringRequestFilter.Clone: TDBXRequestFilter;
begin
  Result := TDBXSubStringRequestFilter.Create(TypeName, Off, Count);
end;

function TDBXSubStringRequestFilter.CanConvert(Value: TDBXValue): Boolean;
begin
  case Value.ValueType.DataType of
    {Implementation for Strings}
    TDBXDataTypes.AnsiStringType, TDBXDataTypes.WideStringType,
    {Implementation for Streams}
    TDBXDataTypes.BlobType, TDBXDataTypes.BinaryBlobType:
      exit(true);
    else
      exit(false);
  end;
end;

function TDBXSubStringRequestFilter.ToJSON(Value: TDBXValue; IsLocal: Boolean): TJSONValue;
begin
  case Value.ValueType.DataType of
    TDBXDataTypes.BlobType, TDBXDataTypes.BinaryBlobType:
      Result := TDBXJSONTools.streamToJSON(Value.GetStream(False), Off, Count);
    else
      Result := TJSONString.Create(Value.AsString.Substring(Off, Count));
  end;
end;

{ TDBXReaderDataConverter }

function TDBXReaderRequestFilter.CanConvert(Value: TDBXValue): Boolean;
begin
  Result := Value.ValueType.DataType = TDBXDataTypes.TableType;
end;

function TDBXReaderRequestFilter.Clone: TDBXRequestFilter;
begin
  Result := TDBXReaderRequestFilter.Create(TypeName, Off, Count);
end;

function TDBXReaderRequestFilter.ToJSON(Value: TDBXValue; IsLocal: Boolean): TJSONValue;
var
  DBXReader: TDBXReader;
  RowCount: Integer;
begin
  DBXReader := Value.GetDBXReader;
  RowCount := Off;
  while RowCount > 0 do
  begin
    DBXReader.Next;
    Dec(RowCount);
  end;
  Result := TDBXJSONTools.TableToJSON(DBXReader, Count, IsLocal);
end;

{ TDSRequestFilterManager }

procedure TDSRequestFilterManager.FiltersForCriteria(const TypeName: string; const Range: TParamRange;
                                                     const OnResult: Boolean; const List: TObjectList<TDBXRequestFilter>);
var
  itr: TObjectDictionary<string, TDBXRequestFilter>.TValueEnumerator;
begin
  itr := FRequestFilterStore.Values.GetEnumerator;
  try
    while itr.MoveNext do
      if (itr.Current.TypeName = TypeName) and
          (((itr.Current.Range * Range) <> []) or (itr.Current.OnResult = OnResult)) then
        List.Add(itr.Current); // add it
  finally
    itr.Free;
  end;
end;

function TDSRequestFilterManager.CheckConvertersForConsistency: Boolean;
var
  itr: TObjectDictionary<string, TDBXRequestFilter>.TValueEnumerator;
  Range: TParamRange;
  OnResult: Boolean;
begin
  Range := [];
  OnResult := false;
  itr := FRequestFilterStore.Values.GetEnumerator;
  try
    while itr.MoveNext do
    begin
      if ((itr.Current.Range * Range) <> []) or (OnResult and (itr.Current.OnResult = OnResult)) then
        exit(false);
      Range := Range + itr.Current.Range;
      OnResult := OnResult or itr.Current.OnResult;
    end;
    Result := true;
  finally
    itr.Free;
  end;
end;

constructor TDSRequestFilterManager.Create;
begin
  FRequestFilterStore := TDBXRequestFilterDictionary.Create([doOwnsValues]);
end;

destructor TDSRequestFilterManager.Destroy;
begin
  FRequestFilterStore.Free;
  inherited;
end;

procedure TDSRequestFilterManager.FiltersForCriteria(const Range: TParamRange; const OnResult: Boolean;
                                                     const List: TObjectList<TDBXRequestFilter>);
var
  itr: TObjectDictionary<string, TDBXRequestFilter>.TValueEnumerator;
begin
  itr := FRequestFilterStore.Values.GetEnumerator;
  try
    while itr.MoveNext do
      if ((itr.Current.Range * Range) <> []) or (OnResult and itr.Current.OnResult) then
        List.Add(itr.Current); // add it
  finally
    itr.Free;
  end;
end;

class procedure TDSRequestFilterManager.ParseParamName(const PName: string; out DCName, DCType, FieldName: string;
                                                       out Range: TParamRange; out OnResult: Boolean);
const
  CharRange : array[0..1] of Char = ('-', ',');
var
  TokenIndex: Integer;
  RangeIndex: Integer;
  LowIdx: Integer;
  RangeStarted: Boolean;

  procedure FillRange(Low: Integer; Hi: Integer; var Range: TParamRange);
  begin
    while Low <= Hi do
    begin
      Range := Range + [Low];
      Inc(Low);
    end;
  end;
  procedure AddRange;
  begin
    if TokenIndex < RangeIndex then
    begin
      if not RangeStarted then
        Range := Range + [ StrToInt(DCName.Substring(TokenIndex - 1, RangeIndex - TokenIndex)) ]
      else
      begin
        FillRange(LowIdx, StrToInt(DCName.Substring(TokenIndex - 1, RangeIndex - TokenIndex)), Range);
        RangeStarted := false;
      end;
      TokenIndex := RangeIndex + 1;
      LowIdx := 0;
    end
    else
      raise Exception.Create(Format(SBadParamName, [PName]));
  end;
begin
  // look for dot and extract the DC name
  TokenIndex := PName.IndexOf('.') + 1;
  if TokenIndex = 0 then
    DCName := EmptyStr
  else
    DCName := PName.Substring(0, TokenIndex - 1);

  // field name follows the .
  FieldName := PName.Substring(TokenIndex, PName.Length - TokenIndex);

  // look for range
  if DCName <> EmptyStr then
  begin
    RangeIndex := 1;
    while (RangeIndex <= DCName.Length) and not (Char.IsDigit(DCName, RangeIndex-1) or Char.IsInArray(DCName, RangeIndex-1, CharRange)) do
      Inc(RangeIndex);
    DCType := DCName.Substring(0, RangeIndex - 1);

    // check for range
    Range := [];
    if RangeIndex <= DCName.Length then
    begin
      OnResult := false;
      TokenIndex := RangeIndex;
      RangeStarted := false;
      while RangeIndex <= DCName.Length do
      begin
        if DCName.Chars[RangeIndex-1] = ',' then
        begin
          // consume <nb>, pattern
          AddRange;
        end
        else if DCName.Chars[RangeIndex-1] = '-' then
        begin
          // consume <nb>-<nb> pattern
          if TokenIndex < RangeIndex then
            LowIdx := StrToInt(DCName.Substring(TokenIndex - 1, RangeIndex - TokenIndex))
          else
            LowIdx := 0;
          TokenIndex := RangeIndex + 1;
          RangeStarted := true;
        end;
        Inc(RangeIndex);
      end;
      AddRange;
    end
    else
      OnResult := true
  end
  else
    OnResult := true;
end;

function TDSRequestFilterManager.ProcessQueryParameter(const ParamName, ParamValue: string): Boolean;
var
  DCName, DCType, FieldName: string;
  Range: TParamRange;
  OnResult: Boolean;
  DBXConverter: TDBXRequestFilter;
  DBXConverterList, CurrentList: TObjectList<TDBXRequestFilter>;
  I, J: Integer;

  function SetupDCParam: Boolean;
  begin
    DBXConverter.Range := Range;
    DBXConverter.OnResult := OnResult;
    Result := DBXConverter.SetParameterValue(FieldName, ParamValue);
  end;


begin
  if ParamName = EmptyStr then
    exit(true); // skip empty parameters

  {handle the json parameter, which is a flag saying if streams should be passed back as json arrays}
  if 'json' = AnsiLowerCase(ParamName) then
  begin
    FStreamAsJSON := StrToBool(ParamValue);
    exit(true);
  end;

  // get the DC name
  ParseParamName(ParamName, DCName, DCType, FieldName, Range, OnResult);
  if DCType = EmptyStr then
  begin
    // iterate through all DC and pick the ones with given parameter
    DBXConverterList := TObjectList<TDBXRequestFilter>.Create(false);
    try
      TDBXRequestFilterFactory.Instance.GetAllWithField(FieldName, DBXConverterList);
      Result := True;
      for I := 0 to DBXConverterList.Count - 1 do
      begin
        DBXConverter := DBXConverterList.Items[I];
        // join with the existing converters
        CurrentList := TObjectList<TDBXRequestFilter>.Create;
        try
          FiltersForCriteria(DBXConverter.TypeName, Range, OnResult, CurrentList);
          if CurrentList.Count > 0 then
          begin
            for J := 0 to CurrentList.Count - 1 do
            begin
              DBXConverter := CurrentList.Items[J];
              if not DBXConverter.SetParameterValue(FieldName, ParamValue) then
                Result := false;
            end;
          end
          else
          begin
            // add new one
            DBXConverter := DBXConverter.Clone;
            DBXConverter.Name := DBXConverter.TypeName;
            if SetupDCParam then
              FRequestFilterStore.Add(DBXConverter.TypeName, DBXConverter)
            else
              Result := false
          end;
        finally
          CurrentList.Free;
        end;
      end;
    finally
      DBXConverterList.Free;
    end;
  end
  else
  begin
    if FRequestFilterStore.ContainsKey(DCName) then
      FRequestFilterStore.TryGetValue(DCName, DBXConverter)
    else
    begin
      DBXConverter := TDBXRequestFilterFactory.Instance.RequestFilter(DCType);
      if (DBXConverter = nil) or not DBXConverter.HasParameter(FieldName) then
        exit(True); //the query parameter wasn't a request filter. return true

      DBXConverter := DBXConverter.Clone;
      DBXConverter.Name := DCName;
      FRequestFilterStore.Add(DCName, DBXConverter);
    end;

    Result := SetupDCParam;
  end;
end;

initialization
    TDBXRequestFilterFactory.SetUp;
    TDBXRequestFilterFactory.Instance.RegisterRequestFilter(TDBXSubStringRequestFilter.Create('ss'));
    TDBXRequestFilterFactory.Instance.RegisterRequestFilter(TDBXReaderRequestFilter.Create('t'));

finalization
    TDBXRequestFilterFactory.CleanUp;

end.



