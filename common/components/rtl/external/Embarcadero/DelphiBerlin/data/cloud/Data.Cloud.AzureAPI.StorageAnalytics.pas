{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.Cloud.AzureAPI.StorageAnalytics;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Generics.Collections,
  Xml.XMLIntf, Xml.XMLDoc;

const
  cStorageAnalyticsVersion = '1.0';
  cStorageServiceProperties = 'StorageServiceProperties';
  cLogging = 'Logging';
  cRetentionPolicy = 'RetentionPolicy';
  cMetrics = 'Metrics';
  cHourMetrics = 'HourMetrics';
  cMinuteMetrics = 'MinuteMetrics';
  cCorsRule = 'CorsRule';
  cCors = 'Cors';
  cVersion = 'Version';
  cEnabled = 'Enabled';
  cDelete = 'Delete';
  cRead = 'Read';
  cWrite = 'Write';
  cDays = 'Days';
  cIncludeAPIs = 'IncludeAPIs';
  cAllowedOrigins = 'AllowedOrigins';
  cAllowedMethods = 'AllowedMethods';
  cExposedHeaders = 'ExposedHeaders';
  cAllowedHeaders = 'AllowedHeaders';
  cMaxAgeInSeconds = 'MaxAgeInSeconds';
  cStorageServiceStats = 'StorageServiceStats';
  cGeoReplication = 'GeoReplication';
  cStatus = 'Status';
  cLastSyncTime = 'LastSyncTime';
  cLiveStatus = 'live';
  cBootstrapStatus = 'bootstrap';
  cUnavailableStatus = 'unavailable';

type
  /// <summary>Class to store CORS rules.</summary>
  TCorsRule = class
  private
    /// <summary>The origin domains that are permitted to make a request against the storage service via CORS.</summary>
    FAllowedOrigins: TStrings;
    /// <summary>The methods (HTTP request verbs) that the origin domain may use for a CORS request.</summary>
    FAllowedMethods: TStrings;
    /// <summary>The maximum amount time that a browser should cache the preflight OPTIONS request.</summary>
    FMaxAgeInSeconds: Integer;
    /// <summary>The response headers that may be sent in the response to the CORS request and exposed by the browser to the request issuer.</summary>
    FExposedHeaders: TStrings;
    /// <summary>The request headers that the origin domain may specify on the CORS request.</summary>
    FAllowedHeaders: TStrings;

    /// <summary>Initiates the class with the values from a XML node.</summary>
    procedure LoadFromXMLNode(const AValue: IXMLNode);
    /// <summary>Return the XML representation.</summary>
    /// <returns>Return the XML representation.</returns>
    function GetXML: string;
    /// <summary>Return the list of allowed origins.</summary>
    function GetAllowedOrigins: TArray<String>;
    /// <summary>Return the list of allowed headers.</summary>
    function GetAllowedHeaders: TArray<String>;
    /// <summary>Return the list of allowed methods.</summary>
    function GetAllowedMethods: TArray<String>;
    /// <summary>Return the list of exposed methods.</summary>
    function GetExposedHeaders: TArray<String>;
  public
    /// <summary>Creates a new instance of TCorsRule.</summary>
    constructor Create;
    /// <summary>Frees the lists and destroys the instance.</summary>
    destructor Destroy; override;

    /// <summary>Add a new origin domain to the list.</summary>
    procedure AddAllowedOrigin(const AValue: string);
    /// <summary>Add a new allowed header to the list.</summary>
    procedure AddAllowedHeader(const AValue: string);
    /// <summary>Add a new exposed header to the list.</summary>
    procedure AddExposedHeader(const AValue: string);
    /// <summary>Add a new allowed method to the list.</summary>
    procedure AddAllowedMethod(const AValue: string);

    /// <summary>The origin domains that are permitted to make a request against the storage service via CORS.</summary>
    property AllowedOrigins: TArray<String> read GetAllowedOrigins;
    /// <summary>The methods (HTTP request verbs) that the origin domain may use for a CORS request.</summary>
    property AllowedMethods: TArray<String> read GetAllowedMethods;
    /// <summary>The maximum amount time that a browser should cache the preflight OPTIONS request.</summary>
    property MaxAgeInSeconds: Integer read FMaxAgeInSeconds write FMaxAgeInSeconds;
    /// <summary>The response headers that may be sent in the response to the CORS request and exposed by the browser to the request issuer.</summary>
    property ExposedHeaders: TArray<String> read GetExposedHeaders;
    /// <summary>The request headers that the origin domain may specify on the CORS request.</summary>
    property AllowedHeaders: TArray<String> read GetAllowedHeaders;
    /// <summary>The XML representation.</summary>
    property XML: string read GetXML;
  end;

  /// <summary>Class to store service properties.</summary>
  TStorageServiceProperties = class
  private type
    /// <summary>Class to store service retetition policies.</summary>
    TRetentionPolicy = class
    private
      /// <summary>Indicates whether a retention policy is enabled for the storage service.</summary>
      FEnabled: Boolean;
      /// <summary>Indicates the number of days that metrics or logging data is retained. All data older than this value will be deleted.</summary>
      FDays: Integer;

      /// <summary>Initiates the class with the values from a XML node.</summary>
      procedure LoadFromXMLNode(const AValue: IXMLNode);
      /// <summary>Return the XML representation.</summary>
      /// <returns>Return the XML representation.</returns>
      function GetXML: string;
    public
      /// <summary>Indicates whether a retention policy is enabled for the storage service.</summary>
      property Enabled: Boolean read FEnabled write FEnabled;
      /// <summary>Indicates the number of days that metrics or logging data is retained. All data older than this value will be deleted.</summary>
      property Days: Integer read FDays write FDays;
    /// <summary>The XML representation</summary>
      property XML: string read GetXML;
    end;

    /// <summary>Class to store request statistics.</summary>
    TMetric = class
    private
      /// <summary>Indicates whether metrics are enabled for the service.</summary>
      FEnabled: Boolean;
      /// <summary>Indicates whether metrics generate summary statistics for called API operations.</summary>
      FIncludeAPI: Boolean;
      /// <summary>Store a retention policy.</summary>
      FRetentionPolicy: TRetentionPolicy;

      /// <summary>Initiates the class with the values from a XML node.</summary>
      procedure LoadFromXMLNode(const AValue: IXMLNode);
      /// <summary>Return the XML representation.</summary>
      /// <returns>Return the XML representation.</returns>
      function GetXML: string;
      /// <summary>Return the XML node name.</summary>
      /// <returns>Return the XML node name.</returns>
      function GetNodeName: string; virtual;
    public
      /// <summary>Creates a new instance of TMetric.</summary>
      constructor Create;
      /// <summary>Frees the Retention Policy and destroys the instance.</summary>
      destructor Destroy; override;

      /// <summary>Indicates whether metrics are enabled for the service.</summary>
      property Enabled: Boolean read FEnabled write FEnabled;
      /// <summary>Indicates whether metrics generate summary statistics for called API operations.</summary>
      property IncludeAPI: Boolean read FIncludeAPI write FIncludeAPI;
      /// <summary>Store a retention policy.</summary>
      property RetentionPolicy: TRetentionPolicy read FRetentionPolicy;
      /// <summary>The XML representation.</summary>
      property XML: string read GetXML;
    end;

    /// <summary>Class to store request statistics grouped by API in hourly.</summary>
    THourMetric = class(TMetric)
    private
      /// <summary>Return the XML node name.</summary>
      /// <returns>Return the XML node name.</returns>
      function GetNodeName: string; override;
    end;

    /// <summary>Class to store request statistics for each minute.</summary>
    TMinuteMetric = class(TMetric)
    private
      /// <summary>Return the XML node name.</summary>
      /// <returns>Return the XML node name.</returns>
      function GetNodeName: string; override;
    end;

    /// <summary>Class to store Azure Analytics Logging settings.</summary>
    TLogging = class
    private
      /// <summary>Indicates whether delete requests are being logged.</summary>
      FLogDelete: Boolean;
      /// <summary>Indicates whether read requests are being logged.</summary>
      FLogRead: Boolean;
      /// <summary>Indicates whether write requests are being logged.</summary>
      FLogWrite: Boolean;
      /// <summary>Store a retention policy.</summary>
      FRetentionPolicy: TRetentionPolicy;

      /// <summary>Initiates the class with the values from a XML node.</summary>
      procedure LoadFromXMLNode(AValue: IXMLNode);
      /// <summary>Return the XML representation.</summary>
      /// <returns>Return the XML representation.</returns>
      function GetXML: string;
    public
      /// <summary>Creates a new instance of TLogging.</summary>
      constructor Create;
      /// <summary>Frees the Retention Policy and destroys the instance.</summary>
      destructor Destroy; override;

      /// <summary>Indicates whether delete requests are being logged.</summary>
      property LogDelete: Boolean read FLogDelete write FLogDelete;
      /// <summary>Indicates whether read requests are being logged.</summary>
      property LogRead: Boolean read FLogRead write FLogRead;
      /// <summary>Indicates whether write requests are being logged.</summary>
      property LogWrite: Boolean read FLogWrite write FLogWrite;
      /// <summary>Store a retention policy.</summary>
      property RetentionPolicy: TRetentionPolicy read FRetentionPolicy;
      /// <summary>The XML representation.</summary>
      property XML: string read GetXML;
    end;

    /// <summary>Class to store the rule list in the service.</summary>
    TCors = class
    private
      /// <summary>Store the rule list in the service.</summary>
      FRules: TList<TCorsRule>;

      /// <summary>Initiates the class with the values from a XML node.</summary>
      procedure LoadFromXMLNode(const AValue: IXMLNode);
      /// <summary>Return the XML representation.</summary>
      /// <returns>Return the XML representation.</returns>
      function GetXML: string;
      /// <summary>Return the rule list.</summary>
      function GetRules: TArray<TCorsRule>;
    public
      /// <summary>Creates a new instance of TCors.</summary>
      constructor Create;
      /// <summary>Frees the Rules list and destroys the instance</summary>
      destructor Destroy; override;

      /// <summary>Add a new rule to the rule list.</summary>
      procedure AddRule(const AValue: TCorsRule);

      /// <summary>Store the rule list in the service.</summary>
      property Rules: TArray<TCorsRule> read GetRules;
      /// <summary>The XML representation.</summary>
      property XML: string read GetXML;
    end;
  private
    /// <summary>Store Azure Analytics Logging settings.</summary>
    FLogging: TLogging;
    /// <summary>Store request statistics grouped by API in hourly.</summary>
    FHourMetrics: THourMetric;
    /// <summary>Store request statistics for each minute.</summary>
    FMinuteMetrics: TMinuteMetric;
    /// <summary>Store the rule list in the service.</summary>
    FCors: TCors;

    /// <summary>Return the XML representation.</summary>
    /// <returns>Return the XML representation.</returns>
    function GetXML: string;
  public
    /// <summary>Creates a new instance of TStorageServiceProperties.</summary>
    constructor Create;
    /// <summary>Destroys the instance.</summary>
    destructor Destroy; override;

    /// <summary>Initiates the class with the values from a XML node.</summary>
    procedure LoadFromXML(const AValue: string);

    /// <summary>Store Azure Analytics Logging settings.</summary>
    property Logging: TLogging read FLogging;
    /// <summary>Store request statistics grouped by API in hourly.</summary>s
    property HourMetrics: THourMetric read FHourMetrics;
    /// <summary>Store request statistics for each minute.</summary>
    property MinuteMetrics: TMinuteMetric read FMinuteMetrics;
    /// <summary>Store the rule list in the service.</summary>
    property Cors: TCors read FCors;
    /// <summary>The XML representation.</summary>
    property XML: string read GetXML;
  end;

  /// <summary>Class to store service stats</summary>
  TStorageServiceStats = class
  type
    /// <summary>
    ///  The status of the secondary location. Possible values are:
    ///    live: Indicates that the secondary location is active and operational.
    ///    bootstrap: Indicates initial synchronization from the primary location to the secondary location is in progress. This typically occurs when replication is first enabled.
    ///    unavailable: Indicates that the secondary location is temporarily unavailable.
    ///  </summary>
    TGRStatus = (Live, Bootstrap, Unavailable);
  private type
    /// <summary>Class to store the georeplication statistics.</summary>
    TGeoReplication = class
    private
      /// <summary>The status of the secondary location.</summary>
      FStatus: TGRStatus;
      /// <summary>A GMT date/time value, to the second.</summary>
      FLastSyncTime: string;

      /// <summary>Return the status of the secondary location.</summary>
      /// <param name="AValue">The description of the status.</param>
      /// <returns>Return the status value.</returns>
      function GetStatus(const AValue: string): TGRStatus;
      /// <summary>Return the status description of the secondary location.</summary>
      /// <param name="AValue">The status value.</param>
      /// <returns>Return the status description.</returns>
      function GetStatusDef(AValue: TGRStatus): string;

      /// <summary>Initiates the class with the values from a XML node</summary>
      procedure LoadFromXMLNode(const AValue: IXMLNode);
      /// <summary>Return the XML representation.</summary>
      /// <returns>Return the XML representation.</returns>
      function GetXML: string;
    public
      /// <summary>The status of the secondary location.</summary>
      property Status: TGRStatus read FStatus write FStatus;
      /// <summary>A GMT date/time value, to the second.</summary>
      property LastSyncTime: string read FLastSyncTime write FLastSyncTime;
      /// <summary>The XML representation.</summary>
      property XML: string read GetXML;
    end;
  private
    /// <summary>The georeplication statistics.</summary>
    FGeoReplication: TGeoReplication;

    /// <summary>Return the XML representation.</summary>
    /// <returns>Return the XML representation.</returns>
    function GetXML: string;
  public
    /// <summary>Creates a new instance of TStorageServiceStats.</summary>
    constructor Create;
    /// <summary>Destroys the instance.</summary>
    destructor Destroy; override;

    /// <summary>Initiates the class with the values from a XML node.</summary>
    procedure LoadFromXML(const AValue: String);

    /// <summary>The georeplication statistics.</summary>
    property GeoReplication: TGeoReplication read FGeoReplication;
    /// <summary>The XML representation.</summary>
    property XML: string read GetXML;
  end;

implementation

uses
  System.SysUtils;

function WriteOpenTag(const ANAme: string): string;
begin
  Result := '<' + AName + '>';
end;

function WriteCloseTag(const AName: string): string;
begin
  Result := '</' + AName + '>';
end;

function WriteEmptyTag(const AName: string): string;
begin
  Result := '<' + AName + '/>';
end;

function WriteValueTag(const AName, AValue: string): string;
begin
  Result := WriteOpenTag(AName) + AValue + WriteCloseTag(AName);
end;

{ TStorageServiceProperties }

constructor TStorageServiceProperties.Create;
begin
  FLogging := TLogging.Create;
  FHourMetrics := THourMetric.Create;
  FMinuteMetrics := TMinuteMetric.Create;
  FCors := TCors.Create;
end;

destructor TStorageServiceProperties.Destroy;
begin
  FLogging.Free;
  FHourMetrics.Free;
  FMinuteMetrics.Free;
  FCors.Free;
  inherited;
end;

function TStorageServiceProperties.GetXML: string;
begin
  Result :=
    WriteOpenTag(cStorageServiceProperties) +
      FLogging.XML + FHourMetrics.XML + FMinuteMetrics.XML + FCors.XML +
    WriteCloseTag(cStorageServiceProperties);
end;

procedure TStorageServiceProperties.LoadFromXML(const AValue: string);
var
  LXmlDoc: IXMLDocument;
  LRootNode: IXMLNode;
  LChildNode: IXMLNode;
begin
  if AValue <> '' then
  begin
    LXmlDoc := TXMLDocument.Create(nil);
    LXmlDoc.LoadFromXML(AValue);
    LRootNode := LXmlDoc.DocumentElement;

    if (LRootNode <> nil) and LRootNode.NodeName.Equals(cStorageServiceProperties) and (LRootNode.HasChildNodes) then
    begin
      LChildNode := LRootNode.ChildNodes.First;
      while LChildNode <> nil do
      begin
        if LChildNode.NodeName.Equals(cLogging) then
          FLogging.LoadFromXMLNode(LChildNode)
        else if LChildNode.NodeName.Equals(cHourMetrics) then
          FHourMetrics.LoadFromXMLNode(LChildNode)
        else if LChildNode.NodeName.Equals(cMinuteMetrics) then
          FMinuteMetrics.LoadFromXMLNode(LChildNode)
        else if LChildNode.NodeName.Equals(cCors) then
          FCors.LoadFromXMLNode(LChildNode);

        LChildNode := LChildNode.NextSibling;
      end;
    end;
  end;
end;

{ TLogging }

constructor TStorageServiceProperties.TLogging.Create;
begin
  FRetentionPolicy := TRetentionPolicy.Create;
end;

destructor TStorageServiceProperties.TLogging.Destroy;
begin
  FRetentionPolicy.Destroy;
  inherited;
end;

function TStorageServiceProperties.TLogging.GetXML: string;
begin
  Result :=
    WriteOpenTag(cLogging) +
      WriteValueTag(cVersion, cStorageAnalyticsVersion) +
      WriteValueTag(cDelete, FLogDelete.ToString(TUseBoolStrs.True)) +
      WriteValueTag(cRead, FLogRead.ToString(TUseBoolStrs.True)) +
      WriteValueTag(cWrite, FLogWrite.ToString(TUseBoolStrs.True)) +
      FRetentionPolicy.XML +
    WriteCloseTag(cLogging);
end;

procedure TStorageServiceProperties.TLogging.LoadFromXMLNode(AValue: IXMLNode);
var
  LChildNode: IXMLNode;
begin
  if (AValue <> nil) and AValue.NodeName.Equals(cLogging) and (AValue.HasChildNodes) then
  begin
    LChildNode := AValue.ChildNodes.First;
    while LChildNode <> nil do
    begin
      if LChildNode.NodeName.Equals(cDelete) then
        FLogDelete := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cRead) then
        FLogRead := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cWrite) then
        FLogWrite := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cRetentionPolicy) then
        FRetentionPolicy.LoadFromXMLNode(LChildNode);

      LChildNode := LChildNode.NextSibling;
    end;
  end;
end;

{ TRetentionPolicy }

function TStorageServiceProperties.TRetentionPolicy.GetXML: string;
begin
  Result := WriteOpenTag(cRetentionPolicy) +
            WriteValueTag(cEnabled, FEnabled.ToString(TUseBoolStrs.True));
  if FEnabled then
    Result := Result + WriteValueTag(cDays, FDays.ToString);
  Result := Result + WriteCloseTag(cRetentionPolicy);
end;

procedure TStorageServiceProperties.TRetentionPolicy.LoadFromXMLNode(const AValue: IXMLNode);
var
  LChildNode: IXMLNode;
begin
  if (AValue <> nil) and AValue.NodeName.Equals(cRetentionPolicy) and (AValue.HasChildNodes) then
  begin
    LChildNode := AValue.ChildNodes.First;
    while LChildNode <> nil do
    begin
      if LChildNode.NodeName.Equals(cEnabled) then
        FEnabled := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cDays) then
        FDays := LChildNode.NodeValue;

      LChildNode := LChildNode.NextSibling;
    end;
  end;
end;

{ TMetric }

constructor TStorageServiceProperties.TMetric.Create;
begin
  FRetentionPolicy := TRetentionPolicy.Create;
end;

destructor TStorageServiceProperties.TMetric.Destroy;
begin
  FRetentionPolicy.Free;
  inherited;
end;

function TStorageServiceProperties.TMetric.GetNodeName: string;
begin
  Result := cMetrics;
end;

function TStorageServiceProperties.TMetric.GetXML: string;
begin
  Result :=
    WriteOpenTag(GetNodeName) +
      WriteValueTag(cVersion, cStorageAnalyticsVersion) +
      WriteValueTag(cEnabled, FEnabled.ToString(TUseBoolStrs.True));
  if FEnabled then
    Result := Result + WriteValueTag(cIncludeAPIs, FIncludeAPI.ToString(TUseBoolStrs.True));
  Result := Result + FRetentionPolicy.XML + WriteCloseTag(GetNodeName);
end;

procedure TStorageServiceProperties.TMetric.LoadFromXMLNode(const AValue: IXMLNode);
var
  LChildNode: IXMLNode;
begin
  if (AValue <> nil) and AValue.NodeName.Equals(GetNodeName) and (AValue.HasChildNodes) then
  begin
    LChildNode := AValue.ChildNodes.First;
    while LChildNode <> nil do
    begin
      if LChildNode.NodeName.Equals(cEnabled) then
        FEnabled := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cIncludeAPIs) then
        FIncludeAPI := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cRetentionPolicy) then
        FRetentionPolicy.LoadFromXMLNode(LChildNode);

      LChildNode := LChildNode.NextSibling;
    end;
  end;
end;

{ THourMetric }

function TStorageServiceProperties.THourMetric.GetNodeName: string;
begin
  Result := cHourMetrics;
end;

{ TMinuteMetric }

function TStorageServiceProperties.TMinuteMetric.GetNodeName: string;
begin
  Result := cMinuteMetrics;
end;

{ TCors }

procedure TStorageServiceProperties.TCors.AddRule(const AValue: TCorsRule);
begin
  FRules.Add(AValue);
end;

constructor TStorageServiceProperties.TCors.Create;
begin
  FRules := TList<TCorsRule>.Create;
end;

destructor TStorageServiceProperties.TCors.Destroy;
var
  Rule: TCorsRule;
begin
  for Rule in FRules do
    Rule.Free;
  FRules.Free;
  inherited;
end;

function TStorageServiceProperties.TCors.GetRules: TArray<TCorsRule>;
begin
  Result := FRules.ToArray;
end;

function TStorageServiceProperties.TCors.GetXML: string;
var
  Rule: TCorsRule;
begin
  if FRules.Count = 0 then
    Result := WriteEmptyTag(cCors)
  else
  begin
    Result := WriteOpenTag(cCors);
    for Rule in FRules do
      Result := Result + Rule.XML;
    Result := Result + WriteCloseTag(cCors);
  end;
end;

procedure TStorageServiceProperties.TCors.LoadFromXMLNode(const AValue: IXMLNode);
var
  LChildNode: IXMLNode;
  LRule: TCorsRule;
begin
  if (AValue <> nil) and AValue.NodeName.Equals(cCors) and (AValue.HasChildNodes) then
  begin
    LChildNode := AValue.ChildNodes.First;
    while LChildNode <> nil do
    begin
      if LChildNode.NodeName.Equals(cCorsRule) then
      begin
        LRule := TCorsRule.Create;
        LRule.LoadFromXMLNode(LChildNode);
        FRules.Add(LRule);
      end;

      LChildNode := LChildNode.NextSibling;
    end;
  end;
end;

{ TCorsRule }

procedure TCorsRule.AddAllowedHeader(const AValue: string);
begin
  FAllowedHeaders.Add(AValue);
end;

procedure TCorsRule.AddAllowedMethod(const AValue: string);
begin
  FAllowedMethods.Add(AValue);
end;

procedure TCorsRule.AddAllowedOrigin(const AValue: string);
begin
  FAllowedOrigins.Add(AValue);
end;

procedure TCorsRule.AddExposedHeader(const AValue: string);
begin
  FExposedHeaders.Add(AValue);
end;

constructor TCorsRule.Create;
begin
  FAllowedOrigins := TStringList.Create;
  FAllowedMethods := TStringList.Create;
  FExposedHeaders := TStringList.Create;
  FAllowedHeaders := TStringList.Create;
end;

destructor TCorsRule.Destroy;
begin
  FAllowedOrigins.Free;
  FAllowedMethods.Free;
  FExposedHeaders.Free;
  FAllowedHeaders.Free;

  inherited;
end;

function TCorsRule.GetAllowedHeaders: TArray<String>;
begin
  Result := FAllowedHeaders.ToStringArray;
end;

function TCorsRule.GetAllowedMethods: TArray<String>;
begin
  Result := FAllowedMethods.ToStringArray;
end;

function TCorsRule.GetAllowedOrigins: TArray<String>;
begin
  Result := FAllowedOrigins.ToStringArray;
end;

function TCorsRule.GetExposedHeaders: TArray<String>;
begin
  Result := FExposedHeaders.ToStringArray;
end;

function TCorsRule.GetXML: string;
begin
  Result :=
    WriteOpenTag(cCorsRule) +
      WriteValueTag(cAllowedOrigins, FAllowedOrigins.CommaText) +
      WriteValueTag(cAllowedMethods, FAllowedMethods.CommaText) +
      WriteValueTag(cMaxAgeInSeconds, FMaxAgeInSeconds.ToString) +
      WriteValueTag(cExposedHeaders, FExposedHeaders.CommaText) +
      WriteValueTag(cAllowedHeaders, FAllowedHeaders.CommaText) +
    WriteCloseTag(cCorsRule);
end;

procedure TCorsRule.LoadFromXMLNode(const AValue: IXMLNode);
var
  LChildNode: IXMLNode;
begin
  if (AValue <> nil) and AValue.NodeName.Equals(cCorsRule) and (AValue.HasChildNodes) then
  begin
    LChildNode := AValue.ChildNodes.First;
    while LChildNode <> nil do
    begin
      if LChildNode.NodeName.Equals(cAllowedOrigins) then
        FAllowedOrigins.CommaText := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cAllowedMethods) then
        FAllowedMethods.CommaText := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cMaxAgeInSeconds) then
        FMaxAgeInSeconds := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cExposedHeaders) then
        FExposedHeaders.CommaText := LChildNode.NodeValue
      else if LChildNode.NodeName.Equals(cAllowedHeaders) then
        FAllowedHeaders.CommaText := LChildNode.NodeValue;

      LChildNode := LChildNode.NextSibling;
    end;
  end;
end;

{ TStorageServiceStats.TGeoReplication }

function TStorageServiceStats.TGeoReplication.GetStatus(const AValue: string): TGRStatus;
begin
  if AValue.Equals(cLiveStatus) then
    Result := TGRStatus.Live
  else if AValue.Equals(cBootstrapStatus) then
    Result := TGRStatus.Bootstrap
  else
    Result := TGRStatus.Unavailable;
end;

function TStorageServiceStats.TGeoReplication.GetStatusDef(AValue: TGRStatus): string;
begin
  case AValue of
    TStorageServiceStats.TGRStatus.Live: Result := cLiveStatus;
    TStorageServiceStats.TGRStatus.Bootstrap: Result := cBootstrapStatus;
    TStorageServiceStats.TGRStatus.Unavailable: Result := cUnavailableStatus;
  end;
end;

procedure TStorageServiceStats.TGeoReplication.LoadFromXMLNode(const AValue: IXMLNode);
var
  LChildNode: IXMLNode;
begin
  if (AValue <> nil) and AValue.NodeName.Equals(cGeoReplication) and (AValue.HasChildNodes) then
  begin
    LChildNode := AValue.ChildNodes.First;
    while LChildNode <> nil do
    begin
      if LChildNode.NodeName.Equals(cStatus) then
        FStatus := GetStatus(LChildNode.NodeValue)
      else if LChildNode.NodeName.Equals(cLastSyncTime) then
        FLastSyncTime := LChildNode.NodeValue;

      LChildNode := LChildNode.NextSibling;
    end;
  end;
end;

function TStorageServiceStats.TGeoReplication.GetXML: string;
begin
  Result :=
    WriteOpenTag(cGeoReplication) +
      WriteValueTag(cStatus, GetStatusDef(FStatus)) +
      WriteValueTag(cLastSyncTime, FLastSyncTime) +
    WriteCloseTag(cGeoReplication);
end;

{ TStorageServiceStats }

constructor TStorageServiceStats.Create;
begin
  FGeoReplication := TGeoReplication.Create;
end;

destructor TStorageServiceStats.Destroy;
begin
  FGeoReplication.Free;
  inherited;
end;

procedure TStorageServiceStats.LoadFromXML(const AValue: String);
var
  LXmlDoc: IXMLDocument;
  LRootNode: IXMLNode;
  LChildNode: IXMLNode;
begin
  if AValue <> '' then
  begin
    LXmlDoc := TXMLDocument.Create(nil);
    LXmlDoc.LoadFromXML(AValue);
    LRootNode := LXmlDoc.DocumentElement;

    if (LRootNode <> nil) and LRootNode.NodeName.Equals(cStorageServiceStats) and (LRootNode.HasChildNodes) then
    begin
      LChildNode := LRootNode.ChildNodes.First;
      while LChildNode <> nil do
      begin
        if LChildNode.NodeName.Equals(cGeoReplication) then
          FGeoReplication.LoadFromXMLNode(LChildNode);

        LChildNode := LChildNode.NextSibling;
      end;
    end;
  end;
end;

function TStorageServiceStats.GetXML: string;
begin
  Result :=
    WriteOpenTag(cStorageServiceStats) +
      FGeoReplication.XML +
    WriteCloseTag(cStorageServiceStats);
end;

end.
