{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.Cloud.CloudAPI;

interface

uses System.Classes,
     System.SysUtils,
     System.Net.HTTPClient,
     System.Net.URLClient,
     System.Generics.Collections,
     Xml.XMLIntf;

type

  /// <summary>Base connection info class for cloud services</summary>
  /// <remarks>Provides account credential information for the cloud service.</remarks>
  TCloudConnectionInfo = class(TComponent)
  private
    function IsProtocolStored: Boolean;
  protected
    /// <summary>The protocol to use as part of the service URL (http|https)</summary>
    FProtocol: string;
    /// <summary>The account name used for authentication with the service</summary>
    FAccountName: string;
    /// <summary>The account key/password used for authenticating the service</summary>
    FAccountKey: string;
    /// <summary>The proxy host to use for the HTTP requests to the cloud, or empty string to use none</summary>
    FRequestProxyHost: string;
    /// <summary>The proxy host's port to use for the HTTP requests to the cloud</summary>
    FRequestProxyPort: Integer;
    /// <summary>True to use the default service URLs, false to use custom ones.</summary>
    FUseDefaultEndpoints: Boolean;
    /// <summary>Returns the account name used for authentication with the service</summary>
    function GetAccountName: string; virtual;
    /// <summary>Returns the account key/password used for authenticating the service</summary>
    function GetAccountKey: string; virtual;
  public
    /// <summary>Creates a new instance of this connection info class</summary>
    /// <param name="AOwner">The component owner.</param>
    constructor Create(AOwner: TComponent); override;
    /// <summary>The protocol to use as part of the service URL (http|https)</summary>
    [Stored('IsProtocolStored'), nodefault]
    property Protocol: string read FProtocol write FProtocol stored IsProtocolStored;
    /// <summary>The account name used for authentication with the service</summary>
    property AccountName: string read GetAccountName write FAccountName;
    /// <summary>The account key/password used for authenticating the service</summary>
    property AccountKey: string read GetAccountKey write FAccountKey;
    /// <summary>The proxy host to use for the HTTP requests to the cloud, or empty string to use none</summary>
    property RequestProxyHost: string read FRequestProxyHost write FRequestProxyHost;
    /// <summary>The proxy host's port to use for the HTTP requests to the cloud</summary>
    [Default(0)]
    property RequestProxyPort: Integer read FRequestProxyPort write FRequestProxyPort default 0;
    /// <summary>True to use the default service URLs, false to use custom ones.</summary>
    [Default(True)]
    property UseDefaultEndpoints: Boolean read FUseDefaultEndpoints write FUseDefaultEndpoints default True;
  end;

  /// <summary>Base class for building a signed Authorization string</summary>
  /// <remarks>Subclasses implement the signing algorithm, which is used on the 'StringToSign',
  ///          and then becomes part of the Authorization String
  /// </remarks>
  TCloudAuthentication = class abstract
  protected
    /// <summary>The connection info passed in from the constructor</summary>
    [Weak]FConnectionInfo: TCloudConnectionInfo;
    /// <summary>The Base64 decoded bytes of the FConnectionInfo.AccountKey</summary>
    FSHAKey: TArray<Byte>;
    /// <summary>Assigns the algorithm key to use, from the string representation.</summary>
    /// <param name="AccountKey">The account key, in string representation.</param>
    procedure AssignKey(const AccountKey: string); virtual;

    /// <summary>Returns the authorization type to use in the value of the Authorization header</summary>
    /// <remarks>If the Authorization header is to look like this:
    ///            Authorization: SharedKey [AccountName]:[Signature]
    ///          Then this function should be implemented in a subclass to return "SharedKey"
    /// </remarks>
    /// <returns>the authorization type to use</returns>
    function GetAuthorizationType: string; virtual; abstract;
    /// <summary>Signs the given string, for use in authentication with the cloud service</summary>
    /// <param name="Signkey">The Key to use for signing</param>
    /// <param name="StringToSign">The string to sign</param>
    /// <returns>The signed string (as bytes), to use as part of the Authorization header in all requests.</returns>
    function SignString(const Signkey: TBytes; const StringToSign: string): TBytes; virtual; abstract;
  public
    /// <summary>Creates a new instance of TCloudAuthentication with the given connection info.</summary>
    // / <param name="ConnectionInfo">The connection info to get the required account info from when building the signed string.</param>
    constructor Create(const ConnectionInfo: TCloudConnectionInfo);
    /// <summary>Builds the string to use as the value of the Authorization header of requests..</summary>
    /// <remarks>The 'StringToSign' passed in is encoded using the 'ConnectionInfo' of this class, and the 'SignString' function of the subclass.
    ///          The result of this is then combined with the result returned by 'GetAuthorizationType' to build the value string to use with the
    ///          Authorization header of all requests to the cloud.
    /// </remarks>
    /// <param name="StringToSign">The string to sign and use in the Authorization header value</param>
    function BuildAuthorizationString(const StringToSign: string): string; virtual;
  end;

  /// <summary>Implementation of TCloudAuthentication, specific to the SHA256 algorithm.</summary>
  TCloudSHA256Authentication = class(TCloudAuthentication)
  private
    /// <summary>The AuthorizationType passed in from the Constructor, returned by GetAuthorizationType</summary>
    FAuthorizationType: string;
  protected
    /// <summary>Returns the authorization type to use in the value of the Authorization header</summary>
    /// <remarks> Implementation of the abstract function of the base class. Returns the value as specified 
    ///           in the Constructor of this instance.
    /// </remarks>
    /// <returns>the authorization type to use</returns>
    function GetAuthorizationType: string; override;
    /// <summary>Signs the given string using the SHA256 algorithm</summary>
    /// <param name="Signkey">The Key to use for signing</param>
    /// <param name="StringToSign">The string to sign</param>
    /// <returns>The SHA256 signed bytes of the given string</returns>
    function SignString(const Signkey: TBytes; const StringToSign: string): TBytes; override;
  public
    /// <summary>Creates SHA256 hash in hex from a string</summary>
    /// <param name="HashString">The string to hash</param>
    /// <returns>The SHA256 hash in hex</returns>
    class function GetHashSHA256Hex( HashString: string): string;
    /// <summary>Creates SHA256 hash in hex from a Stream</summary>
    /// <param name="content">The stream to hash</param>
    /// <returns>The SHA256 hash in hex</returns>
    class function GetStreamToHashSHA256Hex(const Content: TStream): string;
    /// <summary>Creates a new instance of TCloudSHA256Authentication</summary>
    // / <param name="ConnectionInfo">The connection info to use with string signing</param>
    // / <param name="AuthorizationType">The authorization type to use</param>
    constructor Create(const ConnectionInfo: TCloudConnectionInfo; AuthorizationType: string); overload;
  end;

  /// <summary>Implementation of TCloudAuthentication, specific to the SHA1 algorithm.</summary>
  TCloudSHA1Authentication = class(TCloudAuthentication)
  private
    /// <summary>The AuthorizationType passed in from the Constructor, returned by GetAuthorizationType</summary>
    FAuthorizationType: string;
  protected
    /// <summary>Returns the authorization type to use in the value of the Authorization header</summary>
    /// <remarks> Implementation of the abstract function of the base class. Returns the value as specified 
    ///           in the Constructor of this instance.
    /// </remarks>
    /// <returns>the authorization type to use</returns>
    function GetAuthorizationType: string; override;
    /// <summary>Signs the given string using the SHA1 algorithm</summary>
    /// <param name="Signkey">The Key to use for signing</param>
    /// <param name="StringToSign">The string to sign</param>
    /// <returns>The SHA1 signed bytes of the given string</returns>
    function SignString(const Signkey: TBytes; const StringToSign: string): TArray<Byte>; override;
  public
    /// <summary>Creates a new instance of TCloudSHA1Authentication</summary>
    // / <param name="ConnectionInfo">The connection info to use with string signing</param>
    // / <param name="AuthorizationType">The authorization type to use</param>
    constructor Create(ConnectionInfo: TCloudConnectionInfo; AuthorizationType: string); overload;
  end;

  /// <summary> Provides HTTP client functionality </summary>
  TCloudHTTP = class(TComponent)
  private
    FClient: THTTPClient;
    FResponse: IHTTPResponse;
    FOnAuthCallback: TCredentialsStorage.TCredentialAuthCallback;
  protected
    function GetResponseCode: Integer;
    function GetResponseText: string;
    function GetResponse: IHTTPResponse;
    function GetProxyParams: TProxySettings;
    procedure SetProxyParams(const Value: TProxySettings);
  public
    ///  <summary> Constructs a new instance of TCloudHTTP. </summary>
    constructor Create; reintroduce; overload;
    constructor Create(AOwner: TComponent); overload; override;
    destructor Destroy; override;

    ///  <summary> Sends a DELETE command type request. </summary>
    ///  <param name="AURL">URL where the delete command is sent</param>
    ///  <returns>The response stream in string form</returns>
    function Delete(AURL: string): string; overload;

    function Get(AURL: string): string; overload;
    ///  <summary> Sends a GET command type request. </summary>
    ///  <param name="AURL">URL where the GET command is sent</param>
    ///  <param name="AResponseContent">The stream to collect the response in</param>
    procedure Get(AURL: string; AResponseContent: TStream); overload;
    function Post(AURL: string; Source: TStream): string;

    ///  <summary> Sends a DELETE command type request. </summary>
    ///  <param name="AURL">URL where the delete command is sent</param>
    ///  <param name="AResponseStream">The stream to collect the response in</param>
    ///  <returns>The response stream in string form</returns>
    function Delete(AURL: string; AResponseStream: TStream): string; overload;
    ///  <summary> Sends a MERGE command type request. </summary>
    ///  <param name="AURL">URL where the merge command is sent</param>
    ///  <param name="RequestStream">The stream to send as the body of the request</param>
    procedure Merge(AURL: string; RequestStream: TStream);
    ///  <summary> Sends a OPTIONS command type request. </summary>
    ///  <param name="AURL">URL where the OPTIONS command is sent</param>
    ///  <returns>The response string</returns>
    function Options(const AURL: string): string; overload;
    ///  <summary> Sends a OPTIONS command type request. </summary>
    ///  <param name="AURL">URL where the OPTIONS command is sent</param>
    ///  <param name="AResponseContent">The stream to collect the response in</param>
    ///  <returns>The response string</returns>
    procedure Options(const AURL: string; AResponseContent: TStream); overload;
    /// <summary> Sends a HEAD command type request. </summary>
    /// <param name="AURL">URL where the head command is sent</param>
    /// <remarks> This TCloudHTTP instance will hold the resulting headers from the request. </remarks>
    procedure Head(AURL: string);
    ///  <summary>PUT command with empty content</summary>
    ///  <param name="AURL">URL where the put command is sent</param>
    ///  <param name="Source">Source TStream for put request</param>
    ///  <returns>The response string</returns>
    function Put(AURL: string; Source: TStream): string; overload;
    function Put(AURL: string): string; overload;
    /// <summary>Uses HTTP standard authentication protocols with the given credentials.</summary>
    /// <remarks>This sets the Authorization header of this request,
    ///          With the properly formatted and encoded user/password pairing provided.
    /// </remarks>
    /// <param name="AUser">The user name to encode for Authorization</param>
    /// <param name="APassword">The password to encode for Authorization</param>
    procedure SetAuthentication(const AUser: string; const APassword: string);
    property ResponseCode: Integer read GetResponseCode;
    property ResponseText: string read GetResponseText;
    property Response: IHTTPResponse read GetResponse;
    property ProxyParams: TProxySettings read GetProxyParams write SetProxyParams;
    ///  <summary>Set or Get Credentials Authentication Callback</summary>
    property OnAuthCallback: TCredentialsStorage.TCredentialAuthCallback read FOnAuthCallback write FOnAuthCallback;
    /// <summary>HTTP client used to provide HTTP functionality</summary>
    property Client: THTTPClient read FClient;
  end;

  /// <summary>Class meant to be populated with useful information from an HTTP response.</summary>
  /// <remarks>Cloud Service API calls should be implemented to optionally populated an instance of
  ///          TCloudResponseInfo. This would then provide a way to see the HTTP response information
  ///          from the request, such as the status code and message.
  /// </remarks>
  TCloudResponseInfo = class
  protected
    /// <summary>The status code of the response</summary>
    FStatusCode: Integer;
    /// <summary>The status message of the response</summary>
    FStatusMessage: string;
    /// <summary>The headers of the response</summary>
    FHeaders: TStrings;

    /// <summary>Sets the list of headers to hold in this instance.</summary>
    /// <remarks>This call also frees the previous header list</remarks>
    /// <param name="NewHeaders">The new header list to use</param>
    procedure SetHeaders(NewHeaders: TStrings);
  public
    /// <summary>Destroys the current instance and frees the headers.</summary>
    destructor Destroy; override;

    /// <summary>Copy the content of ASource into this instace</summary>
    procedure Assign(const ASource: TObject);

    /// <summary>The status code of the response</summary>
    property StatusCode: Integer read FStatusCode write FStatusCode;
    /// <summary>The status message of the response</summary>
    property StatusMessage: string read FStatusMessage write FStatusMessage;
    /// <summary>The headers of the response</summary>
    property Headers: TStrings read FHeaders write SetHeaders;
  end;

  /// <summary>Represents a single cell of a cloud table service table.</summary>
  /// <remarks>Some cloud table services don't support data types for columns,
  ///          and require all data to be strings. In these cases, DataType
  ///          will be empty.
  /// </remarks>
  TCloudTableColumn = class
  protected
    /// <summary>The name of the cell's column</summary>
    FName: string;
    /// <summary>The value held within the cell</summary>
    FValue: string;
    /// <summary>The name of the cell's datatype.</summary>
    /// <remarks>Empty string to use the default type.</remarks>
    FDataType: string;
  public
    /// <summary>The name of the cell's column</summary>
    property Name: string read FName write FName;
    /// <summary>The value held within the cell</summary>
    property Value: string read FValue write FValue;
    /// <summary>The name of the cell's datatype.</summary>
    /// <remarks>Empty string to use the default type.</remarks>
    property DataType: string read FDataType write FDataType;
  end;

  /// <summary>Represents a single row of a cloud table service table.</summary>
  TCloudTableRow = class
  protected
    /// <summary>The columns of the row</summary>
    FColumns: TList<TCloudTableColumn>;
    /// <summary>True if the columns of this service support datatypes, false
    ///          to ignore the datatypes of the columns.
    /// </summary>
    FSupportsDataType: Boolean;
  public
    /// <summary>Constructs a new instance of TCloudTableRow</summary>
    // / <param name="SupportsDataType">Sets the value of FSupportsDataType. Defaults to True.</param>
    constructor Create(SupportsDataType: Boolean = True); virtual;
    /// <summary>Frees the columns and destroys this instance.</summary>
    destructor Destroy; override;

    /// <summary>Adds the new column.</summary>
    /// <remarks>Replaces the value and datatype of an existing column with the given name
    ///          if one is found.
    ///
    ///          If Replace is set to false and a column with the given name already exists, but
    ///          but the value isn't the one mentioned, then a new column is created for the
    ///          specified value. There will be two columns with the same name, but different values.
    /// </remarks>
    /// <param name="Name">Name of the column to add</param>
    /// <param name="Value">Value to store in this row's cell for the column</param>
    /// <param name="DataType">The name of the cell's datatype. Optional, defaults to empty string.</param>
    /// <param name="Replace">True to replace previous value if it exists, false to create a second column.</param>
    procedure SetColumn(const Name, Value: string; const DataType: string = ''; const Replace: Boolean = true);
    /// <summary>Deletes the column with the given name, if found.</summary>
    /// <param name="Name">The name of the column to delete</param>
    /// <returns>true if the column had existed, false otherwise.</returns>
    function DeleteColumn(const Name: string): Boolean;
    /// <summary>Returns the first column instance with the given column name.</summary>
    /// <param name="Name">The name of the column to get</param>
    /// <returns>The first column with the given name, or nil if not found.</returns>
    function GetColumn(const Name: string): TCloudTableColumn;
    /// <summary>Gets the value of the column of this row with the given name.</summary>
    /// <remarks>False is returned here to differentiate between an empty string value,
    ///          and a column name that doesn't exist.
    /// </remarks>
    /// <param name="Name">The name of the column to get the value for</param>
    /// <param name="Value">The output parameter to store the value into</param>
    /// <returns>true if the Value was returned successfully, false otherwise.</returns>
    function GetColumnValue(const Name: string; out Value: string): Boolean;

    /// <summary>The columns of the row</summary>
    property Columns: TList<TCloudTableColumn> read FColumns;
    /// <summary>True if the columns of this service support datatypes, false
    ///          to ignore the datatypes of the columns.
    /// </summary>
    property SupportsDataType: Boolean read FSupportsDataType;
  end;

  /// <summary>Identifier for a single queue.</summary>
  TCloudQueue = record
    /// <summary></summary>
    Name: string;
    /// <summary></summary>
    URL: string;
    /// <summary>Creates a new instance of TCloudQueue</summary>
    /// <param name="Name">The queue's name</param>
    /// <param name="URL">The queue's URL</param>
    /// <returns>The new TCloudQueue instance</returns>
    class function Create(Name, URL: string): TCloudQueue; overload; static;
    /// <summary>Creates a new instance of TCloudQueue, parsing the Name from the given URL.</summary>
    /// <param name="URL">The URL to set and parse the name from</param>
    /// <returns>The new TCloudQueue instance</returns>
    class function Create(URL: string): TCloudQueue; overload; static;
  end;

  /// <summary>Represents a single message in a Cloud Queue service's queue.</summary>
  TCloudQueueMessage = class
  private
    /// <summary>Properties of the message</summary>
    FProperties: TStrings;
    /// <summary>Unique Id of the message</summary>
    FMessageId: string;
    /// <summary>Text of the message</summary>
    FMessageText: string;
    /// <summary>Key required for deleting the message from the queue.</summary>
    FPopReceipt: string;
  public
    /// <summary>Creates a new instance of TCloudQueueMessage, with an empty property list.</summary>
    // / <param name="MessageId">The value to set as the message's unique Id</param>
    // / <param name="MessageText">The value to set as the message's text</param>
    constructor Create(const MessageId, MessageText: string); overload;
    /// <summary>Creates a new instance of TCloudQueueMessage, with the given property list.</summary>
    /// <remarks>The properties specified will be owned by this instance</remarks>
    // / <param name="MessageId">The value to set as the message's unique Id</param>
    // / <param name="MessageText">The value to set as the message's text</param>
    // / <param name="Properties">The properties to set on the message.</param>
    constructor Create(const MessageId, MessageText: string; Properties: TStrings); overload;
    /// <summary>Frees the properties and destorys this instance.</summary>
    destructor Destroy; override;

    /// <summary>Properties of the message</summary>
    property Properties: TStrings read FProperties;
    /// <summary>Unique Id of the message</summary>
    property MessageId: string read FMessageId;
    /// <summary>Text of the message</summary>
    property MessageText: string read FMessageText;
    /// <summary>Key required for deleting the message from the queue.</summary>
    property PopReceipt: string read FPopReceipt write FPopReceipt;
  end;

  /// <summary>Base Cloud Service class, providing useful common functionality.</summary>
  /// <remarks>This class holds common functionality for building the authentication string,
  ///          And for issuing properly formatted requests. There are several abstract functions
  ///          which need to be implemented by subclasses, to provide service-specific functionality.
  /// </remarks>
  TCloudService = class abstract
  protected
    /// <summary>The authenticator to use when building the Authorization header value.</summary>
    FAuthenticator: TCloudAuthentication;
    /// <summary>The account connection info to use in connection and authentication</summary>
    [Weak]FConnectionInfo: TCloudConnectionInfo;

    /// <summary>The character to use to start the query string when building the StringToSign</summary>
    /// <remarks>This, for example, is #10 for Azure, as the query section begins on a new line.
    ///          For other services, this could be a '?', for example. The default is set to '?'.
    /// </remarks>
    FQueryStartChar: Char;
    /// <summary>The char to use to separate query parameter keys from their values</summary>
    /// <remarks>This is only used when building the query string for the StringToSign.
    ///          This defaults to '=' but could be anything else. It is ':' in Azure, for example.
    /// </remarks>
    FQueryParamKeyValueSeparator: Char;
    /// <summary>The char to use to separate query parameters from each other</summary>
    /// <remarks>This is only used when building the query string for the StringToSign.
    ///          This defaults to '&' but could be anything else. It is #10 in Azure, for example.
    /// </remarks>
    FQueryParamSeparator: Char;

    /// <summary>True to add headers to the StringToSign when building it, false otherwise.</summary>
    FUseCanonicalizedHeaders: Boolean;
    /// <summary>True to add query parameters to the StringToSign when building it, false otherwise.</summary>
    FUseCanonicalizedResource: Boolean;
    /// <summary>True to use the resource path in the StringToSign, false otherwise.</summary>
    /// <remarks>This would say to take the part of the request URI up to (but not including) the query string and
    ///          use it in the StringToSign. It's default location would be directly after the prefix (protocol)
    ///          before the headers or query parameters.
    /// </remarks>
    FUseResourcePath: Boolean;

    /// <summary>URL Encodes the param name and value.</summary>
    /// <remarks>Can be extended by a subclass, to conditionally do encoding.</remarks>
    /// <param name="ForURL">True if the parameter is for a URL, false if it is for a signature.</param>
    /// <param name="ParamName">Name of the parameter</param>
    /// <param name="ParamValue">Value of the parameter</param>
    procedure URLEncodeQueryParams(const ForURL: Boolean; var ParamName, ParamValue: string); virtual;

    /// <summary>List of header names, whose values (but not the names) must appear, in the given order,
    ///          in the StringToSign that gets built.
    /// </summary>
    /// <remarks>Note that the order matters. The headers must be returned in the exact order
    ///          they need to appear in the StringToSign for the cloud service in question.
    /// </remarks>
    /// <param name="InstanceOwner">Set to true if the caller should free the resulting list.</param>
    /// <returns>The list of required header names.</returns>
    function GetRequiredHeaderNames(out InstanceOwner: Boolean): TStrings; virtual; abstract;
    /// <summary>Returns the prefix a header name starts with if it is to be included in the
    ///          CanonicalizedHeaders of the StringToSign.
    /// </summary>
    /// <remarks>For example, this is 'x-ms-' in Azure and 'x-amz-' in Amazon.</remarks>
    /// <returns>The header prefix for names of CanonicalizedHeaders headers.</returns>
    function GetCanonicalizedHeaderPrefix: string; virtual; abstract;
    /// <summary>Sorts the given list of Query Parameters</summary>
    /// <remarks>Extend this if you wish to modify how the list is sorted, or to modify its contents.</remarks>
    /// <param name="QueryParameters">List of parameters to sort</param>
    /// <param name="ForURL">True if these are used in a URL, false if they are used in a StringToSign</param>
    procedure SortQueryParameters(const QueryParameters: TStringList; ForURL: Boolean); virtual;
    /// <summary>Sorts the given list of Headers.</summary>
    /// <remarks>Extend this if you wish to modify how the list is sorted.</remarks>
    /// <param name="Headers">List of headers to sort.</param>
    procedure SortHeaders(const Headers: TStringList); virtual;
    /// <summary>Builds a string representation of the given Query Parameters and the given prefix.</summary>
    /// <remarks>The parameters list will be lexicographically sorted if DoSort is set to true. The
    ///          characters used in the query string depend on the value of ForURL. If set to true,
    ///          '?' will be used after the prefix, '='
    /// </remarks>
    /// <param name="QueryPrefix">Value to prefix the result string with</param>
    /// <param name="QueryParameters">List of parameters to build the result string from</param>
    /// <param name="DoSort">True to sort the given QueryParameters list, false otherwise.</param>
    /// <param name="ForURL">True to use default (URL) characters in the string, false to use the
    ///        characters specified by FQueryStartChar, FQueryParamKeyValueSeparator and FQueryParamSeparator.
    /// </param>
    /// <returns>The string representation of the query aprameters.</returns>
    function BuildQueryParameterString(const QueryPrefix: string; QueryParameters: TStringList;
                                       DoSort: Boolean = False; ForURL: Boolean = True): string; virtual;
    /// <summary>Builds the StringToSign value, based on the given information.</summary>
    /// <param name="HTTPVerb">The HTTP verb (eg: GET, POST) of the request type.</param>
    /// <param name="Headers">The list of headers in the request, or nil</param>
    /// <param name="QueryParameters">The list of query parameters for the request, or nil</param>
    /// <param name="QueryPrefix">The string to prefix the query parameter string with.</param>
    /// <param name="URL">The URL of the request.</param>
    /// <returns>The StringToSign, which will be encoded and used for authentication.</returns>
    function BuildStringToSign(const HTTPVerb: string; Headers, QueryParameters: TStringList;
                               const QueryPrefix, URL: string): string; virtual;
    /// <summary>Takes in a URL and optionally uses it to parse the HTTPRequestURI</summary>
    /// <remarks>By default, conditionally (based on the value of FUseResourcePath) the value returned
    ///          is the part after the host name, up until the beginning of the query parameters.
    ///          Returning, at minimum, a forward slash character.
    /// </remarks>
    /// <param name="URL">The URL of the request.</param>
    /// <returns>The HTTPRequestURI, for use in a StringToSign, or Empty String</returns>
    function BuildStringToSignResourcePath(const URL: string): string; virtual;
    /// <summary>Optionally builds the CanonicalizedQueryString</summary>
    /// <remarks>Based on the value of FUseCanonicalizedResource, this either builds the query string,
    ///          or returns empty string.
    /// </remarks>
    /// <param name="QueryPrefix">The prefix to use before the query parameters</param>
    /// <param name="QueryParameters">The query parameters to build the string from</param>
    /// <returns>The CanonicalizedQueryString, or Empty String if FUseCanonicalizedResource is false</returns>
    function BuildStringToSignResources(QueryPrefix: string; QueryParameters: TStringList): string; virtual;
    /// <summary>Takes in a URL and uses it to parse the HTTPRequestURI for a StringToSign</summary>
    /// <remarks>By default, the value returns is the part after the host name, up until the
    ///          beginning of the query parameters. Returning, at minimum, a forward slash character.
    /// </remarks>
    /// <param name="URL">The URL of the request.</param>
    /// <returns>The HTTPRequestURI, for use in a StringToSign.</returns>
    function GetHTTPRequestURI(const URL: string): string; virtual;
    /// <summary>Builds the first part of the StringToSign, including the HTTP Verb</summary>
    /// <remarks>Subclasses can override this if they need to add to the stringToSign
    ///          before header and query parameter information is appended to it.
    /// </remarks>
    /// <param name="HTTPVerb">The HTTP verb (eg: GET, POST) of the request type.</param>
    /// <returns>The first portion of the stringToSign, before headers and query parameters</returns>
    function BuildStringToSignPrefix(const HTTPVerb: string): string; virtual;
    /// <summary>Builds the StringToSign value's header part</summary>
    /// <remarks>This will include both the required and optional headers, and end with a newline character.
    /// </remarks>
    /// <param name="Headers">The list of headers in the request, or nil</param>
    /// <returns>The headers portion of the StringToSign</returns>
    function BuildStringToSignHeaders(Headers: TStringList): string; virtual;
    /// <summary>Helper method to set the request's date based on the string value.</summary>
    /// <param name="Request">The request to add the date value to</param>
    /// <param name="DateTimeAsString">The date, in string format</param>
    procedure SetDateFromString(Request: THTTPClient; const DateTimeAsString: string); virtual;
    /// <summary>Helper method to add the given key/value pair to the request's headers.</summary>
    /// <remarks>This handles special cases, such as where the header being set is a field
    ///          in the request, instead of part of the custom header list.
    /// </remarks>
    /// <param name="Request">The request to add the header name/value pair to</param>
    /// <param name="headers">list of string key values</param>
    procedure AddHeaders(Request: THTTPClient; const headers: TStringList); virtual;
    /// <summary>Handles the StringToSign after it is created.</summary>
    /// <param name="HTTPVerb">The HTTP verb (eg: GET, POST) of the request.</param>
    /// <param name="Headers">The header name/value pairs</param>
    /// <param name="QueryParameters">The query parameter name/value pairs</param>
    /// <param name="StringToSign">The StringToSign for the request</param>
    /// <param name="URL">The URL of the request</param>
    /// <param name="Request">The request object</param>
    /// <param name="Content">The content stream of the request.</param>
    procedure PrepareRequestSignature(const HTTPVerb: string;
                                      const Headers, QueryParameters: TStringList;
                                      const StringToSign: string;
                                      var URL: string; Request: TCloudHTTP; var Content: TStream); virtual;
    /// <summary>Creates a new request object ad populated the headers, including the Authorization header.
    /// </summary>
    /// <remarks>The caller owns the lists passed in, and can free them any time after the invocation ends.
    /// </remarks>
    /// <param name="HTTPVerb">The HTTP verb (eg: GET, POST) of the request.</param>
    /// <param name="Headers">The header name/value pairs to populate the
    ///                       request and build the StringToSign with.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to
    ///                       populate the request and build the StringToSign with.</param>
    /// <param name="QueryPrefix">The string to prefix the query parameter string with, for the StringToSign.</param>
    /// <param name="URL">The request's URL</param>
    /// <param name="Content">The request content stream, or nil</param>
    /// <returns>The initialized TCloudHTTP instance.</returns>
    function PrepareRequest(const HTTPVerb: string; Headers, QueryParameters: TStringList;
                            const QueryPrefix: string; var URL: string; var Content: TStream): TCloudHTTP; overload; virtual;
    /// <summary>Creates a new request object ad populated the headers, including the Authorization header.
    /// </summary>
    /// <remarks>The caller owns the lists passed in, and can free them any time after the invocation ends.
    /// </remarks>
    /// <param name="HTTPVerb">The HTTP verb (eg: GET, POST) of the request.</param>
    /// <param name="Headers">The header name/value pairs to populate the
    ///                       request and build the StringToSign with.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to
    ///                       populate the request and build the StringToSign with.</param>
    /// <param name="QueryPrefix">The string to prefix the query parameter string with, for the StringToSign.</param>
    /// <param name="URL">The request's URL</param>
    /// <returns>The initialized TCloudHTTP instance.</returns>
    function PrepareRequest(const HTTPVerb: string; Headers, QueryParameters: TStringList;
                            const QueryPrefix: string; var URL: string): TCloudHTTP; overload; virtual;
    /// <summary>Populates the given ResponseInfo with appropriate information from the Response.</summary>
    /// <remarks>Fills in the status code, status message, and response headers for the ResponseInfo object,
    ///         Based on the values stored in the given Response object.
    /// </remarks>
    /// <param name="ACloudHTTP">The response object to get the values from</param>
    /// <param name="ResponseInfo">The ResponseInfo object to populate with information from the Response.</param>
    procedure PopulateResponseInfo(ACloudHTTP: TCloudHTTP; ResponseInfo: TCloudResponseInfo); virtual;

    /// <summary>Executes a HEAD request with the given parameters.</summary>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueHeadRequest(URL: string; Headers: TStringList;
                              QueryParameters: TStringList; const QueryPrefix: string;
                              ResponseInfo: TCloudResponseInfo): TCloudHTTP; virtual;
    /// <summary>Executes a GET request with the given parameters.</summary>
    /// <remarks>Returns the response stream as well as the TCloudHTTP instance used in the request.</remarks>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="ResponseContent">Response stream, to use in the request being made.</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueGetRequest(URL: string; Headers: TStringList;
                             QueryParameters: TStringList; const QueryPrefix: string;
                             ResponseInfo: TCloudResponseInfo;
                             ResponseContent: TStream): TCloudHTTP; overload; virtual;
    /// <summary>Executes a GET request with the given parameters.</summary>
    /// <remarks>Returns the response body as a string, as well as the TCloudHTTP instance used in the request.
    /// </remarks>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="ResponseString">Output parameter, set to the string content returned in the response.</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueGetRequest(URL: string; Headers: TStringList;
                             QueryParameters: TStringList; const QueryPrefix: string;
                             ResponseInfo: TCloudResponseInfo;
                             out ResponseString: string): TCloudHTTP; overload; virtual;
    /// <summary>Executes a GET request with the given parameters.</summary>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueGetRequest(URL: string; Headers: TStringList;
                             QueryParameters: TStringList; const QueryPrefix: string;
                             ResponseInfo: TCloudResponseInfo): TCloudHTTP; overload; virtual;
    /// <summary>Executes a PUT request with the given parameters.</summary>
    /// <remarks>Optionally takes a stream to use as the request body.</remarks>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="Content">The stream to send as the request content (optional)</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssuePutRequest(URL: string; Headers: TStringList;
                             QueryParameters: TStringList; const QueryPrefix: string;
                             ResponseInfo: TCloudResponseInfo;
                             Content: TStream = nil): TCloudHTTP; overload; virtual;
    /// <summary>Executes a PUT request with the given parameters.</summary>
    /// <remarks>Optionally takes a stream to use as the request body.</remarks>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="Content">The stream to send as the request content, or nil</param>
    /// <param name="ResponseString">Output parameter, set to the string content returned in the response.</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssuePutRequest(URL: string; Headers: TStringList;
                             QueryParameters: TStringList; const QueryPrefix: string;
                             ResponseInfo: TCloudResponseInfo;
                             Content: TStream; out ResponseString: string): TCloudHTTP; overload; virtual;
    /// <summary>Executes a MERGE request with the given parameters.</summary>
    /// <remarks>Takes a stream to use as the request body</remarks>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="Content">The stream to send as the request content (required)</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueMergeRequest(URL: string; Headers: TStringList;
                               QueryParameters: TStringList; const QueryPrefix: string;
                               ResponseInfo: TCloudResponseInfo;
                               Content: TStream): TCloudHTTP; virtual;
    /// <summary>Executes a POST request with the given parameters.</summary>
    /// <remarks>Takes a stream to use as the request body</remarks>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="Content">The stream to send as the request content (required)</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssuePostRequest(URL: string; Headers: TStringList;
                              QueryParameters: TStringList; const QueryPrefix: string;
                              ResponseInfo: TCloudResponseInfo;
                              Content: TStream): TCloudHTTP; overload; virtual;
    /// <summary>Executes a POST request with the given parameters.</summary>
    /// <remarks>Takes a stream to use as the request body</remarks>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="Content">The stream to send as the request content (required)</param>
    /// <param name="Content">Output parameter, set to the string content returned in the response.</param>
    /// <param name="ResponseString">Output parameter, set to the string content returned in the response.</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssuePostRequest(URL: string; Headers: TStringList;
                              QueryParameters: TStringList; const QueryPrefix: string;
                              ResponseInfo: TCloudResponseInfo;
                              Content: TStream; out ResponseString: string): TCloudHTTP; overload; virtual;
    /// <summary>Executes a DELETE request with the given parameters.</summary>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueDeleteRequest(URL: string; Headers: TStringList;
                                QueryParameters: TStringList; const QueryPrefix: string;
                                ResponseInfo: TCloudResponseInfo): TCloudHTTP; overload; virtual;
    /// <summary>Executes a DELETE request with the given parameters.</summary>
    /// <param name="URL">The URL to issue the request to</param>
    /// <param name="Headers">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="QueryParameters">The query parameter name/value pairs to use in the
    ///                               request and authentication.</param>
    /// <param name="QueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="ResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="ResponseString">Output parameter, set to the string content returned in the response.</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueDeleteRequest(URL: string; Headers: TStringList;
                                QueryParameters: TStringList; const QueryPrefix: string;
                                ResponseInfo: TCloudResponseInfo;
                                out ResponseString: string): TCloudHTTP; overload; virtual;

    /// <summary>Executes a OPTIONS request with the given parameters.</summary>
    /// <param name="AURL">The URL to issue the request to</param>
    /// <param name="AHeaders">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="AQueryParameters">The query parameter name/value pairs to use in the request and authentication.</param>
    /// <param name="AQueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="AResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueOptionsRequest(AURL: string; const AHeaders, AQueryParameters: TStringList; const AQueryPrefix: string;
                                 const AResponseInfo: TCloudResponseInfo): TCloudHTTP; overload; virtual;
    /// <summary>Executes a OPTIONS request with the given parameters.</summary>
    /// <param name="AURL">The URL to issue the request to</param>
    /// <param name="AHeaders">The header name/value pairs to use in the request and authentication.</param>
    /// <param name="AQueryParameters">The query parameter name/value pairs to use in the request and authentication.</param>
    /// <param name="AQueryPrefix">The string to prefix the query string with when building the StringToSign</param>
    /// <param name="AResponseInfo">The ResponseInfo instance to populate from the request's response, or nil</param>
    /// <param name="AResponseString">Output parameter, set to the string content returned in the response.</param>
    /// <returns>The TCloudHTTP instance used to issue the request.</returns>
    function IssueOptionsRequest(AURL: string; const AHeaders, AQueryParameters: TStringList;
                                 const AQueryPrefix: string; const AResponseInfo: TCloudResponseInfo;
                                 out AResponseString: string): TCloudHTTP; overload; virtual;

    /// <summary>URL encodes the given value.</summary>
    /// <param name="Value">The string to URL encode</param>
    /// <returns>The URL encoded value.</returns>
    function URLEncodeValue(const Value: string): string; virtual;
  public
    /// <summary>Creates a new instance of the service class.</summary>
    /// <remarks>Note that the ConnectionInfo is not freed when this instance is destructed,
    ///          but the Authenticator is.
    /// </remarks>
    // / <param name="ConnectionInfo">The service account connection/authentication information to use</param>
    // / <param name="Authenticator">The authentication instance to use for authenticating requests</param>
    constructor Create(const ConnectionInfo: TCloudConnectionInfo; const Authenticator: TCloudAuthentication);
    /// <summary>Frees the Authenticator and destroys the instance.</summary>
    /// <remarks>Note that the ConnectionInfo is not freed.</remarks>
    destructor Destroy; override;

    /// <summary> Reference to the ConnectionInfo held by this service, as specified in the constructor.
    /// </summary>
    property ConnectionInfo: TCloudConnectionInfo read FConnectionInfo;
  end;





                                                                  

  /// <summary>Escapes reserved XML characters in the string.</summary>
  /// <param name="Str">The string to XML escape.</param>
  /// <returns>The String with special XML characters escaped.</returns>
  function XMLEscape(const Str: string): string; deprecated;

  /// <summary>URL encodes the specified string</summary>
  /// <param name="Str">The string to URL encode.</param>
  /// <returns>The URL encoded version of the specified string.</returns>
  function URLEncode(const Str: string): string; overload;

  /// <summary>URL encodes the specified string</summary>
  // / <param name="Str">The string to URL encode.</param>
  // / <param name="EncodeChars">Additional non-standard characters to encode with their hex value.</param>
  /// <returns>The URL encoded version of the specified string.</returns>
  function URLEncode(const Str: string; const EncodeChars: array of Char): string; overload;

  /// <summary>Base 64 Encodes the specified string</summary>
  /// <param name="Str">The string to Base64 encode.</param>
  /// <returns>The encoded version of the string.</returns>
  function Encode64(Str: string): string; deprecated;

  /// <summary>Decodes a Base64 encoded string</summary>
  /// <param name="Str">The string to Base64 decode.</param>
  /// <returns>The decoded version of the string.</returns>
  function Decode64(Str: string): string; deprecated;

  /// <summary>Base 64 Encodes the specified bytes</summary>
  /// <param name="asBytes">The bytes to Base64 encode.</param>
  /// <returns>The encoded version of the string.</returns>
  function EncodeBytes64(asBytes: TArray<Byte>): string; deprecated;
  
  /// <summary>Base 64 Decodes the specified string</summary>
  /// <param name="Str">The string to Base64 decode.</param>
  /// <returns>The decoded version of the string.</returns>
  function DecodeBytes64(Str: string): TArray<Byte>; deprecated;

  /// <summary>Helper function that returns the first child node of the given name.</summary>
  /// <param name="Parent">The parent node to get the child nodes from.</param>
  /// <param name="ChildName">The name of the child node to find.</param>
  /// <returns>The first matching child node, or nil if none found.</returns>
  function GetFirstMatchingChildNode(Parent: IXMLNode; ChildName: string): IXMLNode;

  /// <summary>Populates the provided string list with Key-Value pairs.</summary>
  /// <remarks>Each child node of the given node is checked. If its name is the same as the specified
  ///          value of 'PairNodeName', then it is checked to see if it has a text node name matching
  ///          the value of KeyNodeName, as well as ValueNodeName. The value of these two nodes are
  ///          used as a key-value pair, which is populated into the given list.
  /// </remarks>
  /// <param name="Parent">The node to iterate over</param>
  /// <param name="PairList">The list to populate with key-value pairs</param>
  /// <param name="PairNodeName">The name of the child node type to get a single pair from</param>
  /// <param name="KeyNodeName">The name of the node containing the key information of a pair</param>
  /// <param name="ValueNodeName">The name of the node containing the value information of a pair</param>
  /// <returns>The first matching child node, or nil if none found.</returns>
  procedure PopulateKeyValuePairs(Parent: IXMLNode; PairList: TStrings; const PairNodeName: string;
                                  const KeyNodeName: string = 'Name';
                                  const ValueNodeName: string = 'Value');
  /// <summary>Returns the text contained within the child element.</summary>
  /// <remarks>This finds the first matching child tag with the given name, and if it is a text element,
  ///          returns the text contained within it. If it isn't a text element, or it isn't found, then
  ///          empty string will be returned.
  /// </remarks>
  /// <param name="NodeName">The name of the child node to get the text for</param>
  /// <param name="Parent">The parent node to get the child node for.</param>
  /// <returns>The child element's text value.</returns>
  function GetChildText(const NodeName: string; Parent: IXMLNode): string;
  
implementation

uses
{$IF defined(MSWINDOWS) and not defined(NEXTGEN)}
  Xml.Win.msxmldom,
{$ELSE}
  Xml.omnixmldom,
{$ENDIF}
  System.DateUtils, System.StrUtils, System.Hash, Data.Cloud.CloudResStrs,
  System.NetEncoding;

const
  Codes64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  Pad = '=';

function XMLEscape(const Str: string): string;
begin
  Result := TNetEncoding.HTML.Encode(Str);
end;

function EncodeBytes64(asBytes: TArray<Byte>): string;
begin
  Result := TNetEncoding.Base64.EncodeBytesToString(asBytes);
end;

function Encode64(Str: string): string;
begin
  Result := TNetEncoding.Base64.Encode(Str);
end;

function DecodeBytes64(Str: string): TArray<Byte>;
begin
  Result := TNetEncoding.Base64.DecodeStringToBytes(Str);
end;

function Decode64(Str: string): string;
begin
  Result := TNetEncoding.Base64.Decode(Str);
end;

function URLEncode(const Str: string): string;
begin
  Result := URLEncode(Str, ['=']);
end;

                                               
function URLEncode(const Str: string; const EncodeChars: array of Char): string;

  function IsHexChar(C: Byte): Boolean;
  begin
    case Char(C) of
      '0'..'9', 'a'..'f', 'A'..'F':  Result := True;
    else
      Result := False;
    end;
  end;

const
  // Safe characters from on TIdURL.ParamsEncode
  // '*<>#%"{}|\^[]`'
  DefaultUnsafeChars: array[0..13] of Byte = (Ord('*'), Ord('<'), Ord('>'), Ord('#'),
    Ord('%'), Ord('"'), Ord('{'), Ord('}'), Ord('|'), Ord('\'), Ord('^'), Ord('['), Ord(']'), Ord('`'));
  XD: array[0..15] of char = ('0', '1', '2', '3', '4', '5', '6', '7',
                              '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
var
  Buff: TBytes;
  I, J: Integer;
  IsUnsafe: Boolean;
begin

  Result := '';
  if Str <> '' then
  begin
    Buff := TEncoding.UTF8.GetBytes(Str);
    I := 0;
    while I < Length(Buff) do
    begin
      if (Buff[I] < 33) or (Buff[I] > 127) then
        IsUnsafe := True
      else
      begin
        IsUnsafe := False;
        for J := 0 to Length(DefaultUnsafeChars) - 1 do
          if Buff[I] = DefaultUnsafeChars[J] then
          begin
            IsUnsafe := True;
            break;
          end;
        if not IsUnsafe then
          for J := 0 to Length(EncodeChars) - 1 do
            if Char(Buff[I]) = EncodeChars[J] then
            begin
              IsUnsafe := True;
              break;
            end;
      end;
      if IsUnsafe then
        Result := Result + '%' + XD[(Buff[I] shr 4) and $0F] + XD[Buff[I] and $0F]
      else
        Result := Result + Char(Buff[I]);
      Inc(I);
    end;
  end;
end;

function GetFirstMatchingChildNode(Parent: IXMLNode; ChildName: string): IXMLNode;
var
  Child: IXMLNode;
begin
  Result := nil;

  if (Parent <> nil) and Parent.HasChildNodes and (ChildName <> EmptyStr) then
  begin
    Child := Parent.ChildNodes.First;

    while Child <> nil do
    begin
      if AnsiSameText(Child.NodeName, ChildName) then
        Exit(Child);
      Child := Child.NextSibling;
    end;
  end;
end;

procedure PopulateKeyValuePairs(Parent: IXMLNode; PairList: TStrings; const PairNodeName: string;
                                const KeyNodeName: string;
                                const ValueNodeName: string);
var
  ChildNode, Aux: IXMLNode;
  Name: string;
begin
  if PairList = nil then
    Exit;

  ChildNode := GetFirstMatchingChildNode(Parent, PairNodeName);

  while ChildNode <> nil do
  begin
    try
      if AnsiSameText(ChildNode.NodeName, PairNodeName) then
      begin
        Aux := ChildNode.ChildNodes.FindNode(KeyNodeName);
        if (Aux <> nil) and Aux.IsTextElement then
        begin
          Name := Aux.Text;
          Aux := ChildNode.ChildNodes.FindNode(ValueNodeName);
          if (Aux <> nil) and Aux.IsTextElement then
          begin
            PairList.Values[Name] := Aux.Text;
          end;
        end;
      end;
    finally
      ChildNode := ChildNode.NextSibling;
    end;
  end;
end;

function GetChildText(const NodeName: string; Parent: IXMLNode): string;
var
  ChildNode: IXMLNode;
begin
  if (Parent <> nil) and (NodeName <> EmptyStr) and Parent.HasChildNodes then
  begin
    ChildNode := Parent.ChildNodes.FindNode(NodeName);
    if (ChildNode <> nil) and ChildNode.IsTextElement then
      Result := ChildNode.Text;
  end;
end;

{ TCloudAuthentication }

procedure TCloudAuthentication.AssignKey(const AccountKey: string);
begin
  FSHAKey := TEncoding.UTF8.GetBytes(FConnectionInfo.AccountKey);
end;

function TCloudAuthentication.BuildAuthorizationString(const StringToSign: string): string;
begin
  Result := Format('%s %s:%s', {do not localize}
                   [GetAuthorizationType,
                    FConnectionInfo.AccountName,
                    TNetEncoding.Base64.EncodeBytesToString(SignString(FSHAKey,StringToSign))]);
end;

constructor TCloudAuthentication.Create(const ConnectionInfo: TCloudConnectionInfo);
begin
  FConnectionInfo := ConnectionInfo;
  AssignKey(FConnectionInfo.AccountKey); 
end;

{ TCloudSHA256Authentication }

constructor TCloudSHA256Authentication.Create(const ConnectionInfo: TCloudConnectionInfo;
                                              AuthorizationType: string);
begin
  inherited Create(ConnectionInfo);
  FAuthorizationType := AuthorizationType;
end;

function TCloudSHA256Authentication.GetAuthorizationType: string;
begin
  Result := FAuthorizationType;
end;

function TCloudSHA256Authentication.SignString(const Signkey: TBytes; const StringToSign: string): TBytes;
begin
  Result := THashSHA2.GetHMACAsBytes(StringToSign, Signkey);
end;

class function TCloudSHA256Authentication.GetHashSHA256Hex( HashString: string): string;
var
  LBytes: TArray<Byte>;
begin
  //Hash bytes
  LBytes := THashSHA2.GetHashBytes(HashString);
  //hex string
  Result := THash.DigestAsString(LBytes);
end;

class function TCloudSHA256Authentication.GetStreamToHashSHA256Hex(const Content: TStream): string;
var
  LBytes : TBytes;
  Hash: THashSHA2;
begin
  LBytes := TBytesStream(Content).Bytes;
  //Hash bytes
  Hash := THashSHA2.Create;
  Hash.Update(LBytes);
  Result := Hash.HashAsString;
end;

{ TCloudSHA1Authentication }

constructor TCloudSHA1Authentication.Create(ConnectionInfo: TCloudConnectionInfo; AuthorizationType: string);
begin
  inherited Create(ConnectionInfo);
  FAuthorizationType := AuthorizationType;
end;

function TCloudSHA1Authentication.GetAuthorizationType: string;
begin
  Result := FAuthorizationType;
end;

function TCloudSHA1Authentication.SignString(const Signkey: TBytes; const StringToSign: string): TArray<Byte>;
begin
  Result := THashSHA1.GetHMACAsBytes(StringToSign, Signkey);
end;

function LexicographicalNameCompare(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := AnsiCompareText(List.Names[Index1], List.Names[Index2]);
  //if the keys are the same, sort by value
  if Result = 0 then
    Result := AnsiCompareText(List.ValueFromIndex[Index1], List.ValueFromIndex[Index2]);
end;

{ TCloudService }

constructor TCloudService.Create(const ConnectionInfo: TCloudConnectionInfo; const Authenticator: TCloudAuthentication);
begin
  FConnectionInfo := ConnectionInfo;
  FAuthenticator := Authenticator;

  FQueryStartChar := '?';
  FQueryParamKeyValueSeparator := '=';
  FQueryParamSeparator := '&';

  FUseCanonicalizedHeaders := True;
  FUseCanonicalizedResource := True;
  FUseResourcePath := False;
end;

destructor TCloudService.Destroy;
begin
  FreeAndNil(FAuthenticator);
  inherited;
end;

procedure TCloudService.SortHeaders(const Headers: TStringList);
begin
  if Headers <> nil then
    Headers.CustomSort(LexicographicalNameCompare);
end;

procedure TCloudService.SortQueryParameters(const QueryParameters: TStringList; ForURL: Boolean);
begin
  if QueryParameters <> nil then
    QueryParameters.CustomSort(LexicographicalNameCompare);
end;

procedure TCloudService.URLEncodeQueryParams(const ForURL: Boolean; var ParamName, ParamValue: string);
begin
  ParamName := URLEncodeValue(ParamName);
  ParamValue := URLEncodeValue(ParamValue);
end;

function TCloudService.URLEncodeValue(const Value: string): string;
begin
  Result := URLEncode(Value);
end;

function TCloudService.BuildQueryParameterString(const QueryPrefix: string; QueryParameters: TStringList;
                                                 DoSort, ForURL: Boolean): string;
var
  Count: Integer;
  I: Integer;
  lastParam, nextParam: string;
  QueryStartChar, QuerySepChar, QueryKeyValueSepChar: Char;
  CurrValue: string;
  CommaVal: string;
begin
  //if there aren't any parameters, just return the prefix
  if not Assigned(QueryParameters) or (QueryParameters.Count = 0) then
    Exit(QueryPrefix);

  if ForURL then
  begin
    //If the query parameter string is beign created for a URL, then
    //we use the default characters for building the strings, as will be required in a URL
    QueryStartChar := '?';
    QuerySepChar := '&';
    QueryKeyValueSepChar := '=';
  end
  else
  begin
    //otherwise, use the charaters as they need to appear in the signed string
    QueryStartChar := FQueryStartChar;
    QuerySepChar := FQueryParamSeparator;
    QueryKeyValueSepChar := FQueryParamKeyValueSeparator;
  end;

  if DoSort and not QueryParameters.Sorted then
    SortQueryParameters(QueryParameters, ForURL);

  Count := QueryParameters.Count;

  lastParam := QueryParameters.Names[0];
  CurrValue := Trim(QueryParameters.ValueFromIndex[0]);

  //URL Encode the firs set of params
  URLEncodeQueryParams(ForURL, lastParam, CurrValue);

  //there is at least one parameter, so add the query prefix, and then the first parameter
  //provided it is a valid non-empty string name
  Result := QueryPrefix;
  if CurrValue <> EmptyStr then
    Result := Result + Format('%s%s%s%s', [QueryStartChar, lastParam, QueryKeyValueSepChar, CurrValue])
  else
    Result := Result + Format('%s%s', [QueryStartChar, lastParam]);

  //in the URL, the comma character must be escaped. In the StringToSign, it shouldn't be.
  //this may need to be pulled out into a function which can be overridden by individual Cloud services.
  if ForURL then
    CommaVal := '%2c'
  else
    CommaVal := ',';

  //add the remaining query parameters, if any
  for I := 1 to Count - 1 do
  begin
    nextParam := Trim(QueryParameters.Names[I]);
    CurrValue := QueryParameters.ValueFromIndex[I];

    URLEncodeQueryParams(ForURL, nextParam, CurrValue);

    //match on key name only if the key names are not empty string.
    //if there is a key with no value, it should be formatted as in the else block
    if (lastParam <> EmptyStr) and (AnsiCompareText(lastParam, nextParam) = 0) then
      Result := Result + CommaVal + CurrValue
    else begin
      if (not ForURL) or (nextParam <> EmptyStr) then
      begin
        if CurrValue <> EmptyStr then
          Result := Result + Format('%s%s%s%s', [QuerySepChar, nextParam, QueryKeyValueSepChar, CurrValue])
        else
          Result := Result + Format('%s%s', [QuerySepChar, nextParam]);
      end;
      lastParam := nextParam;
    end;
  end;
end;

function TCloudService.GetHTTPRequestURI(const URL: string): string;
var
  Aux: string;
  Index: Integer;
begin
  //If there is no path to use, then put a forward slash.
  Result := '/';
  if (URL <> EmptyStr) and 
     (AnsiStartsText('http://', URL) or AnsiStartsText('https://', URL)) and
     (URL.Length > 8) then
  begin
    Index := AnsiPos('//', URL);
    Aux := URL.Substring(Index + 1);
    Index := AnsiPos('/', Aux);
    if Index > 0 then
    begin
      Aux := Aux.Substring(Index-1);
      Index := AnsiPos('?', Aux);
      if Index > 0 then
        Aux := Aux.Substring(0, Index);
        
      Result := Aux;
    end;
  end;
  Result := Result + #10;
end;

function TCloudService.BuildStringToSignPrefix(const HTTPVerb: string): string;
begin
  Result := string.Format('%s'#10, [HTTPVerb]);
end;

function TCloudService.BuildStringToSign(const HTTPVerb: string; Headers, QueryParameters: TStringList;
                                         const QueryPrefix, URL: string): string;
begin
  //Build the first part of the string to sign, including HTTPVerb
  Result := BuildStringToSignPrefix(HTTPVerb);

  //Build the resource path, which by default is from the end of the host/port
  //to the beginning of the query parameters.
  Result := Result + BuildStringToSignResourcePath(URL);

  //Special headers with a specific prefix. Names (lowercase) and values
  Result := Result + BuildStringToSignHeaders(Headers);

  //Build the query parameter string, sorted and formatted for the StringToSign
  Result := Result + BuildStringToSignResources(QueryPrefix, QueryParameters);
end;

function TCloudService.BuildStringToSignResourcePath(const URL: string): string;
begin
  if FUseResourcePath then
    Result := Result + GetHTTPRequestURI(URL);
end;

function TCloudService.BuildStringToSignResources(QueryPrefix: string; QueryParameters: TStringList): string;
begin
  if FUseCanonicalizedResource then
    Result := Result + BuildQueryParameterString(QueryPrefix, QueryParameters, true, false);
end;

function TCloudService.BuildStringToSignHeaders(Headers: TStringList): string;
var
  RequiredHeadersInstanceOwner: Boolean;
  RequiredHeaders: TStrings;
  I, Count: Integer;
  Aux: string;
  lastParam, nextParam: string;
  ConHeadPrefix: string;
begin
  if (Headers <> nil) and (not Headers.Sorted) then
    SortHeaders(Headers);

  RequiredHeaders := GetRequiredHeaderNames(RequiredHeadersInstanceOwner);

  //required headers. Values only, not header names
  if (RequiredHeaders <> nil) then
  begin
    Count := RequiredHeaders.Count;
    for I := 0 to Count - 1 do
    begin
      if (Headers <> nil) then
        Aux := Headers.Values[RequiredHeaders[I]];
      Result := Result + Format('%s'#10, [Aux]);
    end;
  end;

  if RequiredHeadersInstanceOwner then
    FreeAndNil(RequiredHeaders);

  //Special headers with a specific prefix. Names (lowercase) and values
  if FUseCanonicalizedHeaders and (Headers <> nil) then
  begin
    ConHeadPrefix := AnsiLowerCase(GetCanonicalizedHeaderPrefix);
    Count := Headers.Count;

    for I := 0 to Count - 1 do
    begin
      Aux := AnsiLowerCase(Headers.Names[I]);
      if AnsiStartsStr(ConHeadPrefix, Aux) then
      begin
        nextParam := Aux;
        if lastParam = EmptyStr then
        begin
          lastParam := nextParam;
          Result := Result + Format('%s:%s', [nextParam, Headers.ValueFromIndex[I]]);
        end
        else if lastParam = nextParam then
          Result := Result + Format(',%s', [Headers.ValueFromIndex[I]])
        else
        begin
          lastParam := nextParam;
          Result := Result + Format(#10'%s:%s', [nextParam, Headers.ValueFromIndex[I]]);
        end;
      end;
    end;
  end;

  //add a newline at the end if at least one header name/value pair was added.
  if lastParam <> EmptyStr then
    Result := Result + #10'';
end;

                                                                             
procedure TCloudService.PopulateResponseInfo(ACloudHTTP: TCloudHTTP; ResponseInfo: TCloudResponseInfo);
var
  HeadValuePair: TNameValuePair;
begin
  if (ACloudHTTP <> nil) and (ACloudHTTP.Response <> nil) and (ResponseInfo <> nil) then
  begin
    ResponseInfo.StatusCode := ACloudHTTP.Response.StatusCode;
    ResponseInfo.StatusMessage := ACloudHTTP.Response.StatusText;

    //don't free these headers, they are owned by the response
    ResponseInfo.Headers := TStringList.Create;

    for HeadValuePair in ACloudHTTP.Response.Headers do
       ResponseInfo.Headers.Values[Trim(HeadValuePair.Name)] := Trim(HeadValuePair.Value);
  end;
end;

procedure TCloudService.SetDateFromString(Request: THTTPClient; const DateTimeAsString: string);
begin
  //do nothing
end;

procedure TCloudService.AddHeaders(Request: THTTPClient; const headers: TStringList);
var
  I: Integer;
begin
  for I := 0 to Headers.Count - 1 do
    Request.CustomHeaders[Headers.Names[I]] := Headers.ValueFromIndex[I];
end;

function TCloudService.PrepareRequest(const HTTPVerb: string; Headers, QueryParameters: TStringList;
                                      const QueryPrefix: string; var URL: string): TCloudHTTP;
var
  Content: TStream;
begin
  Content := nil;
  try
    Result := PrepareRequest(HTTPVerb, Headers, QueryParameters, QueryPrefix, URL, Content);
  finally
    FreeAndNil(Content);
  end;
end;

procedure TCloudService.PrepareRequestSignature(const HTTPVerb: string;
                                                const Headers, QueryParameters: TStringList;
                                                const StringToSign: string;
                                                var URL: string; Request: TCloudHTTP; var Content: TStream);
var
  AuthorizationString: string;
begin
  if (Request <> nil) then
  begin
    AuthorizationString := FAuthenticator.BuildAuthorizationString(StringToSign);
    Request.Client.CustomHeaders['Authorization'] := AuthorizationString;
  end;
end;

function TCloudService.PrepareRequest(const HTTPVerb: string; Headers, QueryParameters: TStringList;
                                      const QueryPrefix: string; var URL: string; var Content: TStream): TCloudHTTP;
var
  StringToSign: string;
  LProxySettings : TProxySettings;
begin
  Result := TCloudHTTP.Create;
  //Optionally set the request proxy information
  if ConnectionInfo.RequestProxyHost <> EmptyStr then
  begin
    LProxySettings.Create(ConnectionInfo.RequestProxyHost, ConnectionInfo.RequestProxyPort);
    Result.ProxyParams := LProxySettings;
  end;

  if FAuthenticator <> nil then
  begin
    StringToSign := BuildStringToSign(HTTPVerb, Headers, QueryParameters, QueryPrefix, URL);
    PrepareRequestSignature(HTTPVerb, Headers, QueryParameters, StringToSign, URL, Result, Content);
  end;

  if Headers <> nil then
    AddHeaders(Result.Client, Headers);

end;

function TCloudService.IssueDeleteRequest(URL: string; Headers, QueryParameters: TStringList;
                                         const QueryPrefix: string; ResponseInfo: TCloudResponseInfo): TCloudHTTP;
var
  ResponseStr: string;
begin
  Result := IssueDeleteRequest(URL, Headers, QueryParameters, QueryPrefix, ResponseInfo, ResponseStr);
end;

function TCloudService.IssueDeleteRequest(URL: string; Headers, QueryParameters: TStringList;
  const QueryPrefix: string; ResponseInfo: TCloudResponseInfo; out ResponseString: string): TCloudHTTP;
begin
  Result := PrepareRequest('DELETE', Headers, QueryParameters, QueryPrefix, URL);

  try
    ResponseString := Result.Delete(URL);
    PopulateResponseInfo(Result, ResponseInfo);
  except
    on E: Exception do
    begin
      Result.Free;
      Raise;
    end;
  end;
end;

function TCloudService.IssueGetRequest(URL: string; Headers, QueryParameters: TStringList;
                                       const QueryPrefix: string; ResponseInfo: TCloudResponseInfo): TCloudHTTP;
begin
  Result := PrepareRequest('GET', Headers, QueryParameters, QueryPrefix, URL);

  try
    Result.Get(URL);
    PopulateResponseInfo(Result, ResponseInfo);
  except
    on E: Exception do
    begin
      Result.Free;
      Raise;
    end;
  end;
end;

function TCloudService.IssueHeadRequest(URL: string; Headers, QueryParameters: TStringList;
                                        const QueryPrefix: string;
                                        ResponseInfo: TCloudResponseInfo): TCloudHTTP;
begin
  Result := PrepareRequest('HEAD', Headers, QueryParameters, QueryPrefix, URL);

  try
    Result.Head(URL);
    PopulateResponseInfo(Result, ResponseInfo);
  except
    on E: Exception do
    begin
      Result.Free;
      Raise;
    end;
  end;
end;

function TCloudService.IssueMergeRequest(URL: string; Headers, QueryParameters: TStringList;
  const QueryPrefix: string; ResponseInfo: TCloudResponseInfo; Content: TStream): TCloudHTTP;
begin
// Android does not support MERGE as it is not standard
{$IFDEF ANDROID}
  Headers.Values['x-method-override'] := 'PATCH';
  Headers.Values['PATCHTYPE'] := 'MERGE';
  Result := PrepareRequest('PUT', Headers, QueryParameters, QueryPrefix, URL);
{$ELSE}
  Result := PrepareRequest('MERGE', Headers, QueryParameters, QueryPrefix, URL);
{$ENDIF}

  try
    Result.Merge(URL, Content);
    PopulateResponseInfo(Result, ResponseInfo);
  except
    on E: Exception do
    begin
      Result.Free;
      Raise;
    end;
  end;
end;

function TCloudService.IssueOptionsRequest(AURL: string; const AHeaders, AQueryParameters: TStringList;
  const AQueryPrefix: string; const AResponseInfo: TCloudResponseInfo): TCloudHTTP;
var
  LResponseStr: string;
begin
  Result := IssueOptionsRequest(AURL, AHeaders, AQueryParameters, AQueryPrefix, AResponseInfo, LResponseStr);
end;

function TCloudService.IssueOptionsRequest(AURL: string; const AHeaders, AQueryParameters: TStringList;
  const AQueryPrefix: string; const AResponseInfo: TCloudResponseInfo; out AResponseString: string): TCloudHTTP;
begin
  Result := PrepareRequest('OPTIONS', AHeaders, AQueryParameters, AQueryPrefix, AURL);

  try
    AResponseString := Result.Options(AURL);
    PopulateResponseInfo(Result, AResponseInfo);
  except
    on E: Exception do
    begin
      Result.Free;
      Raise;
    end;
  end;
end;

function TCloudService.IssueGetRequest(URL: string; Headers, QueryParameters: TStringList;
                                       const QueryPrefix: string; ResponseInfo: TCloudResponseInfo;
                                       ResponseContent: TStream): TCloudHTTP;
begin
  Result := PrepareRequest('GET', Headers, QueryParameters, QueryPrefix, URL);

  try
    Result.Get(URL, ResponseContent);
    PopulateResponseInfo(Result, ResponseInfo);
  except
    on E: Exception do
    begin
      Result.Free;
      Raise;
    end;
  end;
end;

function TCloudService.IssueGetRequest(URL: string; Headers, QueryParameters: TStringList;
                                       const QueryPrefix: string; ResponseInfo: TCloudResponseInfo;
                                       out ResponseString: string): TCloudHTTP;
var
  MemoryStream: TMemoryStream;
  Reader: TStreamReader;
begin
  MemoryStream := nil;

  Result := PrepareRequest('GET', Headers, QueryParameters, QueryPrefix, URL);

  try
    try
      MemoryStream := TMemoryStream.Create;

      Result.Get(URL, MemoryStream);
      PopulateResponseInfo(Result, ResponseInfo);

      MemoryStream.Position := 0;
      Reader := TStreamReader.Create(MemoryStream, True (* Detect BOM *));
      try
        ResponseString := Reader.ReadToEnd;
      finally
        Reader.Free;
      end;
    except
      on E: Exception do
      begin
    		Result.Free;
        Raise;
      end;
    end;
  finally
    MemoryStream.Free;
  end;
end;

function TCloudService.IssuePostRequest(URL: string; Headers, QueryParameters: TStringList;
                                        const QueryPrefix: string; ResponseInfo: TCloudResponseInfo;
                                        Content: TStream; out ResponseString: string): TCloudHTTP;
var
  OwnStream: Boolean;
begin
  OwnStream := Content = nil;
  Result := PrepareRequest('POST', Headers, QueryParameters, QueryPrefix, URL, Content);
  try
    try
      ResponseString := Result.Post(URL, Content);
      PopulateResponseInfo(Result, ResponseInfo);
    except
      on E: Exception do
      begin
        Result.Free;
        Raise;
      end;
    end;
  finally
    if OwnStream then
      FreeAndNil(Content);
  end;
end;

function TCloudService.IssuePostRequest(URL: string; Headers, QueryParameters: TStringList;
                                        const QueryPrefix: string; ResponseInfo: TCloudResponseInfo;
                                        Content: TStream): TCloudHTTP;
var
  OutStr: string;
begin
  Result := IssuePostRequest(URL, Headers, QueryParameters, QueryPrefix, ResponseInfo, Content, OutStr);
end;

function TCloudService.IssuePutRequest(URL: string; Headers, QueryParameters: TStringList;
                                       const QueryPrefix: string;
                                       ResponseInfo: TCloudResponseInfo;
                                       Content: TStream;
                                       out ResponseString: string): TCloudHTTP;
begin
  Result := PrepareRequest('PUT', Headers, QueryParameters, QueryPrefix, URL);

  try
    if Content <> nil then
      ResponseString := Result.Put(URL, Content)
    else
      ResponseString := Result.Put(URL);

    PopulateResponseInfo(Result, ResponseInfo);
  except
    on E: Exception do
    begin
      Result.Free;
      Raise;
    end;
  end;
end;

function TCloudService.IssuePutRequest(URL: string; Headers, QueryParameters: TStringList;
                                       const QueryPrefix: string; ResponseInfo: TCloudResponseInfo;
                                       Content: TStream): TCloudHTTP;
var
  RespStr: string;
begin
  Result := IssuePutRequest(URL, Headers, QueryParameters, QueryPrefix, ResponseInfo, Content, RespStr);
end;

{TAzureHTTP}

constructor TCloudHTTP.Create;
begin
  Create(nil);
end;

constructor TCloudHTTP.Create(AOwner: TComponent);
begin
  inherited;
  FClient := THTTPClient.Create;
end;

destructor TCloudHTTP.Destroy;
begin
  if Assigned(FClient) then
  begin
    FClient.Free;
    FClient := nil;
  end;
  inherited;
end;

function TCloudHTTP.Delete(AURL: string): string;
begin
    FResponse := FClient.Delete(AURL);
    Result := FResponse.ContentAsString;
end;

function TCloudHTTP.Delete(AURL: string; AResponseStream: TStream): string;
begin
  FResponse := FClient.Delete(AURL,AResponseStream);
  Result := FResponse.ContentAsString();
end;

function TCloudHTTP.Get(AURL: string): string;
begin
  FResponse := FClient.Get(AURL);
  Result := FResponse.ContentAsString();
end;

procedure TCloudHTTP.Get(AURL: string; AResponseContent: TStream);
begin
  FResponse := FClient.Get(AURL, AResponseContent);
end;


function TCloudHTTP.GetProxyParams: TProxySettings;
begin
  Result := FClient.ProxySettings;
end;

function TCloudHTTP.GetResponse: IHTTPResponse;
begin
  Result := FResponse;
end;

function TCloudHTTP.GetResponseCode: Integer;
begin
  Result := FResponse.StatusCode;
end;

function TCloudHTTP.GetResponseText: string;
begin
  Result := FResponse.StatusText;
end;

procedure TCloudHTTP.Head(AURL: string);
begin
  FResponse := FClient.Head(AURL);
end;

procedure TCloudHTTP.Merge(AURL: string; RequestStream: TStream);
begin
{$IFDEF ANDROID}
  FResponse := FClient.MergeAlternative(AURL, RequestStream);
{$ELSE}
  FResponse := FClient.Merge(AURL, RequestStream);
{$ENDIF}
end;

function TCloudHTTP.Options(const AURL: string): string;
begin
  FResponse := FClient.Options(AURL);
  Result := FResponse.ContentAsString();
end;

procedure TCloudHTTP.Options(const AURL: string; AResponseContent: TStream);
begin
  FResponse := FClient.Options(AURL, AResponseContent);
end;

function TCloudHTTP.Post(AURL: string; Source: TStream): string;
var
  LRespStream: TStringStream;
begin
  //get the result stream so we handle charset ourselves
  Result := EmptyStr;
  LRespStream := TStringStream.Create(EmptyStr, TEncoding.UTF8);
  try
    FResponse := FClient.Post(AURL, Source, LRespStream);
    Result := LRespStream.DataString;
  finally
    FreeAndNil(LRespStream);
  end;
end;

function TCloudHTTP.Put(AURL: string; Source: TStream): string;
begin
    FResponse := FClient.Put(AURL, Source); 
    Result := FResponse.ContentAsString();
end;

function TCloudHTTP.Put(AURL: string): string;
begin
  Result := Put(AURL, nil);
end;

procedure TCloudHTTP.SetAuthentication(const AUser, APassword: string);
begin
    FClient.CredentialsStorage.AddCredential(
    TCredentialsStorage.TCredential.Create(TAuthTargetType.Server, '', '', AUser, APassword))
end;

procedure TCloudHTTP.SetProxyParams(const Value: TProxySettings);
begin
  FClient.ProxySettings := Value;
  if FClient.ProxySettings.UserName <> '' then
    FClient.CredentialsStorage.AddCredential(
    TCredentialsStorage.TCredential.Create(TAuthTargetType.Proxy, '', '', FClient.ProxySettings.UserName, FClient.ProxySettings.Password))
end;

{ TCloudResponseInfo }

procedure TCloudResponseInfo.Assign(const ASource: TObject);
begin
  if ASource is TCloudResponseInfo then
  begin
    FStatusCode := TCloudResponseInfo(ASource).FStatusCode;
    FStatusMessage := TCloudResponseInfo(ASource).FStatusMessage;
    if FHeaders = nil then
      FHeaders := TStringList.Create
    else
      FHeaders.Clear;
    FHeaders.Assign(TCloudResponseInfo(ASource).FHeaders);
  end
  else
    raise EConvertError.CreateFmt(SInvalidSourceException, [ClassName]);
end;

destructor TCloudResponseInfo.Destroy;
begin
  try
    FreeAndNil(FHeaders);
  except
  end;
  inherited;
end;

procedure TCloudResponseInfo.SetHeaders(NewHeaders: TStrings);
begin
  FreeAndNil(FHeaders);
  FHeaders := NewHeaders;
end;

{ TCloudTableRow }

constructor TCloudTableRow.Create(SupportsDataType: Boolean);
begin
  FColumns := TObjectList<TCloudTableColumn>.Create;
  FSupportsDataType := SupportsDataType;
end;

destructor TCloudTableRow.Destroy;
begin
  FColumns.Free;
  inherited;
end;

function TCloudTableRow.GetColumn(const Name: string): TCloudTableColumn;
var
  I, Count: Integer;
begin
  Result := nil;

  TMonitor.Enter(FColumns);
  try
    Count := FColumns.Count;
    for I := 0 to Count - 1 do
    begin
      if AnsiCompareText(Name, FColumns[I].Name) = 0 then
        Exit(FColumns[I]);
    end;
  finally
    TMonitor.Exit(FColumns);
  end;
end;

function TCloudTableRow.GetColumnValue(const Name: string; out Value: string): Boolean;
var
  Col: TCloudTableColumn;
begin
  Value := '';

  Col := GetColumn(Name);
  Result := False;
  if Col <> nil then
  begin
    Result := True;
    Value := Col.Value;
  end;
end;

function TCloudTableRow.DeleteColumn(const Name: string): Boolean;
var
  I, Count: Integer;
begin
  Result := False;

  TMonitor.Enter(FColumns);
  try
    Count := FColumns.Count;
    for I := 0 to Count - 1 do
    begin
      if AnsiCompareText(Name, FColumns[I].Name) = 0 then
      begin
        FColumns.Delete(I);
        Exit(True);
      end;
    end;
  finally
    TMonitor.Exit(FColumns);
  end;
end;

procedure TCloudTableRow.SetColumn(const Name, Value, DataType: string; const Replace: Boolean);
var
  Col: TCloudTableColumn;
begin
  Col := GetColumn(Name);

  TMonitor.Enter(FColumns);
  try
    //if the column doesn't exists, or if it does exist but Replace is set to false
    //and the new value being set is different than the current value, then make a new column.
    if (Col = nil) or ((not Replace) and (not AnsiSameStr(Col.Value, Value))) then
    begin
      Col := TCloudTableColumn.Create;
      Col.Name := Name;
      FColumns.Add(Col);
    end;

    Col.Value := Value;
    Col.DataType := DataType;
  finally
    TMonitor.Exit(FColumns);
  end;
end;

{ TCloudQueueMessage }

constructor TCloudQueueMessage.Create(const MessageId, MessageText: string; Properties: TStrings);
begin
  FMessageId := MessageId;
  FMessageText := MessageText;

  if Properties <> nil then
    FProperties := Properties
  else
    FProperties := TStringList.Create;
end;

constructor TCloudQueueMessage.Create(const MessageId, MessageText: string);
begin
  Create(MessageId, MessageText, nil);
end;

destructor TCloudQueueMessage.Destroy;
begin
  FreeAndNil(FProperties);
  inherited;
end;

{ TCloudConnectionInfo }

constructor TCloudConnectionInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Protocol := 'http';
end;

function TCloudConnectionInfo.GetAccountKey: string;
begin
  Result := FAccountKey;
end;

function TCloudConnectionInfo.GetAccountName: string;
begin
  Result := FAccountName;
end;

function TCloudConnectionInfo.IsProtocolStored: Boolean;
begin
  Result := not SameText(FProtocol, 'http');
end;

{ TCloudQueue }

class function TCloudQueue.Create(Name, URL: string): TCloudQueue;
var
  Inst: TCloudQueue;
begin
  Inst.Name := Name;
  Inst.URL := URL;
  Result := Inst;
end;

class function TCloudQueue.Create(URL: string): TCloudQueue;
var
  Index: Integer;
  Inst: TCloudQueue;
begin
  Inst.URL := URL;
  Index := URL.LastDelimiter('/') + 1;
  if (Index > 0) and (Index < URL.Length) then
    Inst.Name := URL.Substring(Index)
  else
    Inst.Name := URL;
  Result := Inst;
end;

end.
