{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.Cloud.AzureAPI;

interface

uses System.Classes,
     System.SysUtils,
     System.Generics.Collections,
     Data.Cloud.CloudAPI,
     Xml.XMLIntf
;

type

  /// <summary>Azure extension of TCloudConnectionInfo</summary>
  /// <remarks>This provides Azure specific information, such as settings for development storage,
  ///    and getting the service URLs.
  /// </remarks>
  TAzureConnectionInfo = class(TCloudConnectionInfo)
  private
    /// <summary>True to connect to a local development storage service, False to connect to the cloud.</summary>
    FUseDevelopmentStorage: Boolean;
    /// <summary>The blob service URL to use if FUseDefaultEndpoints is false</summary>
    FBlobEndpoint: string;
    /// <summary>The queue service URL to use if FUseDefaultEndpoints is false</summary>
    FQueueEndpoint: string;
    /// <summary>The table service URL to use if FUseDefaultEndpoints is false</summary>
    FTableEndpoint: string;
    /// <summary>Sets if development storage should be used, instead of issuing requests to the cloud.</summary>
    /// <param name="use">True to use development storage, false otherwise</param>
    procedure SetUseDevelopmentStorage(use: Boolean);
    /// <summary>Returns the service URL, based on the given information</summary>
    /// <remarks>This is a helper function used by the BlobURL, TableURL and QueueURL functions.</remarks>
    /// <param name="ServiceType">One of: (blob|table|queue)</param>
    /// <param name="ServiceEndpoint">The value of the corresponding [X]Endpoint property.</param>
    /// <returns>The URL to the storage service.</returns>
    function ServiceURL(const ServiceType, ServiceEndpoint: string): string;

    function GetBlobEndpoint: string;
    function GetQueueEndpoint: string;
    function GetTableEndpoint: string;
  protected
    /// <summary>Returns the account name used for authentication with the service</summary>
    function GetAccountName: string; override;
    /// <summary>Returns the account key/password used for authenticating the service</summary>
    function GetAccountKey: string; override;
  public
    /// <summary>Creates a new instance of TAzureConnectionInfo</summary>
    // / <param name="AOwner">The TComponent owning this one, or nil</param>
    constructor Create(AOwner: TComponent); override;

    /// <summary>Returns the URL for working with the blob service.</summary>
    /// <returns>The URL for working with the blob service.</returns>
    function BlobURL: string;
    /// <summary>Returns the URL for working with the table service.</summary>
    /// <returns>The URL for working with the table service.</returns>
    function TableURL: string;
    /// <summary>Returns the URL for working with the queue service.</summary>
    /// <returns>The URL for working with the queue service.</returns>
    function QueueURL: string;
  published
    /// <summary>True to connect to a local development storage service, False to connect to the cloud.</summary>
    [Default(False)]
    property UseDevelopmentStorage: Boolean read FUseDevelopmentStorage write SetUseDevelopmentStorage default False;
    /// <summary>The blob service URL to use if FUseDefaultEndpoints is false</summary>
    property BlobEndpoint: string read GetBlobEndpoint write FBlobEndpoint;
    /// <summary>The queue service URL to use if FUseDefaultEndpoints is false</summary>
    property QueueEndpoint: string read GetQueueEndpoint write FQueueEndpoint;
    /// <summary>The table service URL to use if FUseDefaultEndpoints is false</summary>
    property TableEndpoint: string read GetTableEndpoint write FTableEndpoint;
    /// <summary>The protocol to use as part of the service URL (http|https)</summary>
    property Protocol;
    /// <summary>Raising the property to published</summary>
    property AccountName;
    /// <summary>Raising the property to published</summary>
    property AccountKey;
    /// <summary>The proxy host to use for the HTTP requests to the cloud, or empty string to use none</summary>
    property RequestProxyHost;
    /// <summary>The proxy host's port to use for the HTTP requests to the cloud</summary>
    property RequestProxyPort;
    /// <summary>True to use the default service URLs, false to use endpoints from the endpoint properties.
    /// </summary>
    property UseDefaultEndpoints;
  end;

  /// <summary>Azure specific implementation of TCloudSHA256Authentication</summary>
  /// <remarks>Sets the Authorization type to 'SharedKey'</remarks>
  TAzureAuthentication = class(TCloudSHA256Authentication)
  protected
    /// <summary>Overrides the base implementation, treating the key as base64 encoded.</summary>
    /// <param name="AccountKey">The account key, in base64 encoded string representation.</param>
     procedure AssignKey(const AccountKey: string); override;
  public
    /// <summary>Creates a new instance of TAzureAuthentication</summary>
    /// <remarks>Sets the authorization type (for the authorization header) to 'SharedKey'</remarks>
    // / <param name="ConnectionInfo">The connection info to use in authentiation</param>
    constructor Create(ConnectionInfo: TAzureConnectionInfo); overload;
  end;

  /// <summary>Abstract extension of the TCloudService class.</summary>
  /// <remarks>This implements all functionality common to the Azure Blob, Queue and Table
  ///    services, or common two two of them (allowing the third to extend further and override.)
  ///</remarks>
  TAzureService = class abstract(TCloudService)
  protected
    /// <summary>The lazy-loaded list of required header names.</summary>
    FRequiredHeaderNames: TStrings;

    /// <summary>URL Encodes the param name and value.</summary>
    /// <remarks>Skips encoding if not for URL.</remarks>
    /// <param name="ForURL">True if the parameter is for a URL, false if it is for a signature.</param>
    /// <param name="ParamName">Name of the parameter</param>
    /// <param name="ParamValue">Value of the parameter</param>
    procedure URLEncodeQueryParams(const ForURL: Boolean; var ParamName, ParamValue: string); override;

    /// <summary>Returns the current date and time, properly formatted for the x-ms-date header.</summary>
    /// <returns>The current date and time, properly formatted for the x-ms-date header.</returns>
    function XMsDate: string;
    /// <summary>Populates the x-ms-date (and optionally the Date) header in the given list.</summary>
    /// <param name="Headers">The header list to add the date header(s) to.</param>
    /// <param name="AddRegularDateHeader">True to add the Date header instead of just thex-ms-date one.</param>
    procedure PopulateDateHeader(Headers: TStrings; AddRegularDateHeader: Boolean = True);
    /// <summary>Returns the TAzureConnectionInfo held by the service</summary>
    /// <returns>The TAzureConnectionInfo held by the service</returns>
    function GetConnectionInfo: TAzureConnectionInfo;

    /// <summary>Returns the list of required header names</summary>
    /// <remarks>Implementation of abstract declaration in parent class.
    ///    Lazy-loads and returns FRequiredHeaderNames. Sets InstanceOwner to false,
    ///    since this class instance will manage the memory for the object.
    /// </remarks>
    /// <param name="InstanceOwner">Returns false, specifying the caller doesn't own the list.</param>
    /// <returns>The list of required hear names. No values.</returns>
    function GetRequiredHeaderNames(out InstanceOwner: Boolean): TStrings; override;
    /// <summary>Returns the header name prefix for Azure services, for headers to be included
    ///     as name/value pairs in the StringToSign in authentication.
    /// </summary>
    /// <returns>The header prefix (x-ms-)</returns>
    function GetCanonicalizedHeaderPrefix: string; override;
  public
    /// <summary>Creates a new instance of TAzureService</summary>
    /// <remarks>This class does not own the ConnectionInfo instance.</remarks>
    // / <param name="ConnectionInfo">The Azure service connection info</param>
    constructor Create(ConnectionInfo: TAzureConnectionInfo);
    /// <summary>Frees the required headers list and destroys the instance</summary>
    destructor Destroy; override;
  end;

  /// <summary>Implementation of TAzureService for managing a Windows Azure Table Service account.</summary>
  TAzureTableService = class(TAzureService)
  private
    function ModifyEntityHelper(const TableName: string; const Entity: TCloudTableRow;
                                out url, QueryPrefix: string;
                                out Headers: TStringList): Boolean;
    procedure AddTableVersionHeaders(Headers: TStrings);
    function UpdatedDate: string;
    function BuildRowList(const XML: string; const FromQuery: Boolean): TList<TCloudTableRow>;
    function GetTablesQueryPrefix(Headers: TStrings; TableName: string = 'Tables'): string;
    function GetInsertEntityXML(Entity: TCloudTableRow): string;
  protected
    /// <summary>Returns the list of required header names</summary>
    /// <remarks>Overrides the base implementation, as the Table Service had different/fewer
    ///     required headers. Lazy-loads and returns FRequiredHeaderNames. Sets InstanceOwner to false,
    ///     since this class instance will manage the memory for the object.
    /// </remarks>
    /// <param name="InstanceOwner">Returns false, specifying the caller doesn't own the list.</param>
    /// <returns>The list of required hear names. No values.</returns>
    function GetRequiredHeaderNames(out InstanceOwner: Boolean): TStrings; override;
  public
    /// <summary>Creates a new instance of TAzureTableService</summary>
    /// <remarks>Sets FUseCanonicalizedHeaders to False</remarks>
    // / <param name="ConnectionInfo">The connection info to use for issuing requests.</param>
    constructor Create(ConnectionInfo: TAzureConnectionInfo);

    /// <summary>Returns an XML representation of the tables existing in the table service account.</summary>
    /// <remarks>ContinuationToken is used if there exists more than 1000 tables, and a previous call
    ///     didn't return the last of the tables. It would have provided a ContinuationToken in the header:
    ///     'x-ms-continuation-NextTableName'.
    /// </remarks>
    /// <param name="ContinuationToken">The optional name of the table to start retrieval from</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the available tables for the service</returns>
    function QueryTablesXML(const ContinuationToken: string = ''; ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Returns a list of the tables existing in the table service account.</summary>
    /// <remarks>ContinuationToken is used if there exists more than 1000 tables, and a previous call
    ///     didn't return the last of the tables. It would have provided a ContinuationToken in the header:
    ///     'x-ms-continuation-NextTableName'.
    /// </remarks>
    /// <param name="ContinuationToken">The optional name of the table to start retrieval from</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of available tables for the service</returns>
    function QueryTables(const ContinuationToken: string = ''; ResponseInfo: TCloudResponseInfo = nil): TStrings;
    /// <summary>Returns the entities (rows) for the specified table, optionally filtering the result.</summary>
    /// <remarks> See the MSDN documentation on "Querying Tables and Entities" for more information
    ///           on the FilterExpression parameter.
    ///           At most, 1000 rows are returned. If 1000 rows are returned, use the header values for:
    ///           x-ms-continuation-NextPartitionKey and x-ms-continuation-NextRowKey to get the unique
    ///           identifier of the 1001th row. To get these values you need to use the ResponseInfo parameter.
    ///           Uses the unique identifier values (NextParitionKey and NextRowKey) in your next call to this
    ///           function, to retrieve the next batch of rows.
    /// </remarks>
    /// <param name="TableName">The name of the table to get the rows for</param>
    /// <param name="FilterExpression">The optional filter expression for refining the results</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <param name="NextPartitionKey">Continuation token value from x-ms-continuation-NextPartitionKey</param>
    /// <param name="NextRowKey">Continuation token value from x-ms-continuation-NextRowKey</param>
    /// <returns>The XML representation of the rows</returns>
    function QueryEntitiesXML(const TableName: string; const FilterExpression: string = '';
                              ResponseInfo: TCloudResponseInfo = nil;
                              const NextPartitionKey: string = '';
                              const NextRowKey: string = ''): string; overload;
    /// <summary>Returns the entities (rows) for the specified table, optionally filtering the result.</summary>
    /// <remarks> See the MSDN documentation on "Querying Tables and Entities" for more information
    ///           on the FilterExpression parameter.
    ///           At most, 1000 rows are returned. If 1000 rows are returned, use the header values for:
    ///           x-ms-continuation-NextPartitionKey and x-ms-continuation-NextRowKey to get the unique
    ///           identifier of the 1001th row. To get these values you need to use the ResponseInfo parameter.
    ///           Uses the unique identifier values (NextParitionKey and NextRowKey) in your next call to this
    ///           function, to retrieve the next batch of rows.
    /// </remarks>
    /// <param name="TableName">The name of the table to get the rows for</param>
    /// <param name="FilterExpression">The optional filter expression for refining the results</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <param name="NextPartitionKey">Continuation token value from x-ms-continuation-NextPartitionKey</param>
    /// <param name="NextRowKey">Continuation token value from x-ms-continuation-NextRowKey</param>
    /// <returns>The table's rows which match the given filter, or all rows (up to 1000 rows)
    ///          if no filter is given.
    /// </returns>
    function QueryEntities(const TableName: string; const FilterExpression: string = '';
                           ResponseInfo: TCloudResponseInfo = nil;
                           const NextPartitionKey: string = '';
                           const NextRowKey: string = ''): TList<TCloudTableRow>; overload;
    /// <summary>Returns the entity(row) for the specified table with the given partition and row keys.</summary>
    /// <remarks> The unique key of any Azure table row is comprised of both the Partition Key and Row Key.
    ///           There should be no situation where a call to this function returns more than one row.
    /// </remarks>
    /// <param name="TableName">The name of the table to get the row from</param>
    /// <param name="PartitionKey">The value of the partition key in the row you want to get</param>
    /// <param name="RowKey">The value of the row key in the row you want to get</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the row</returns>
    function QueryEntityXML(const TableName: string; const PartitionKey: string; const RowKey: string;
                            ResponseInfo: TCloudResponseInfo = nil): string; overload;
    /// <summary>Returns the entity(row) for the specified table with the given partition and row keys.</summary>
    /// <remarks> The unique key of any Azure table row is comprised of both the Partition Key and Row Key.
    /// </remarks>
    /// <param name="TableName">The name of the table to get the row from</param>
    /// <param name="PartitionKey">The value of the partition key in the row you want to get</param>
    /// <param name="RowKey">The value of the row key in the row you want to get</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The table's row matching the specified keys, or nil if not found</returns>
    function QueryEntity(const TableName: string; const PartitionKey: string; const RowKey: string;
                         ResponseInfo: TCloudResponseInfo = nil): TCloudTableRow; overload;
    /// <summary>Creates a table with the given name.</summary>
    /// <param name="TableName">The name of the table to create</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the creation was a success, false otherwise.</returns>
    function CreateTable(const TableName: string; ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Deletes the table with the given name.</summary>
    /// <remarks>This marks the table for delete and hides it from future calls when querying the
    ///          list of available tables. However, it isn't deleted from the server right away,
    ///          and for a short time after calling delete, you will not be able to create a new table
    ///          with the same name.
    /// </remarks>
    /// <param name="TableName">The name of the table to delete</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the delete is successful, false otherwise</returns>
    function DeleteTable(const TableName: string; ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Inserts a row into the given table.</summary>
    /// <remarks> The row must have a PartitionKey and RowKey column. If it has a Timestamp column,
    ///           it will be ignored.
    ///           Insert fails (409 - Conflict) if another row with the same PartitonKey and RowKey exists.
    /// </remarks>
    /// <param name="TableName">The name of the table to insert the row into</param>
    /// <param name="Entity">The row to insert</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the insertion is successful, false otherwise</returns>
    function InsertEntity(const TableName: string; Entity: TCloudTableRow;
                          ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Inserts a row into the given table, replacing a previous version of the row, if any.</summary>
    /// <remarks> The row must have a PartitionKey and RowKey column. If it has a Timestamp column,
    ///           it will be ignored.
    ///           If another row already exists in the table with the given PartitionKey and RowKey, it will
    ///           be replaced by this row, losing any columns the original row had but this new one doesn't.
    /// </remarks>
    /// <param name="TableName">The name of the table to insert the row into</param>
    /// <param name="Entity">The row to insert</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the insertion is successful, false otherwise</returns>
    function UpdateEntity(const TableName: string; Entity: TCloudTableRow;
                          ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Inserts a row into the given table, merging with a previous version of the row, if any.</summary>
    /// <remarks> The row must have a PartitionKey and RowKey column. If it has a Timestamp column,
    ///           it will be ignored.
    ///           If another row already exists in the table with the given PartitionKey and RowKey, it will
    ///           be merged with the row being specified in this call. The resulting row will be the one
    ///           specified here, plus any columns not in this row, but existing in the original row.
    /// </remarks>
    /// <param name="TableName">The name of the table to insert the row into</param>
    /// <param name="Entity">The row to insert</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the insertion is successful, false otherwise</returns>
    function MergeEntity(const TableName: string; Entity: TCloudTableRow;
                         ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Deletes the given row from the specified table.</summary>
    /// <remarks>The row must have a PartitionKey and RowKey column specified.</remarks>
    /// <param name="TableName">The name of the table to delete the row from.</param>
    /// <param name="Entity">The row to delete</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the deletion is successful, false otherwise.</returns>
    function DeleteEntity(const TableName: string; const Entity: TCloudTableRow;
                          ResponseInfo: TCloudResponseInfo = nil): Boolean;
  end;

  /// <summary>Implementation of TAzureService for managing a Windows Azure Queue Service account.</summary>
  TAzureQueueService = class(TAzureService)
  private
    function GetQueuesQueryPrefix(Headers: TStrings; QueueName: string = 'Queues'): string;
    function GetMessagesFromXML(const xml: string): TList<TCloudQueueMessage>;
    function GetOrPeekMessagesXML(const QueueName: string;
                                  PeekOnly: Boolean;
                                  NumOfMessages: Integer = 0;
                                  VisibilityTimeout: Integer = 0;
                                  ResponseInfo: TCloudResponseInfo = nil): string;
  public
    /// <summary>Returns the maximum number of queue messages that can be returned.</summary>
    /// <returns>The number of queue messages which can be returned by the API for a given queue.</returns>
    function GetMaxMessageReturnCount: Integer;

    /// <summary>Lists the queues currently available in the queue service account.</summary>
    /// <remarks>The supported optional parameters are: prefix, maxresults, include=metadata
    ///          The 'prefix' parameter has a value which is the prefix a queue name must start with
    ///          in order to be includes in the list of queues returned by this request.
    ///          The 'maxresults' parameter takes an integer value specifying how many
    ///          queues to return. If this isn't specified, up to 5000 queues will be returned.
    ///          If the 'include' parameter is specified with a value of 'metadata', then metadata
    ///          corresponding to each queue will be returned in the XML.
    /// </remarks>
    /// <param name="OptionalParams">Optional parameters to use in the query. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML string representing the queues</returns>
    function ListQueuesXML(OptionalParams: TStrings = nil; ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Lists the queues currently available in the queue service account.</summary>
    /// <remarks>The supported optional parameters are: prefix, maxresults
    ///          The 'prefix' parameter has a value which is the prefix a queue name must start with
    ///          in order to be includes in the list of queues returned by this request.
    ///          The 'maxresults' parameter takes an integer value specifying how many
    ///          queues to return. If this isn't specified, up to 5000 queues will be returned.
    /// </remarks>
    /// <param name="OptionalParams">Optional parameters to use in the query. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of queues, or an empty list</returns>
    function ListQueues(OptionalParams: TStrings = nil; ResponseInfo: TCloudResponseInfo = nil): TList<TCloudQueue>;
    /// <summary>Creates a queue with the given name and metadata.</summary>
    /// <remarks>If metadata is specified, it will be set as the metadata associated with the queue.</remarks>
    /// <param name="QueueName">The name of the queue to create.</param>
    /// <param name="MetaDataHeaders">The header name/value pairs to associate with the queue.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the create was successful, false otherwise.</returns>
    function CreateQueue(const QueueName: string; const MetaDataHeaders: TStrings = nil;
                         ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Deletes the queue with the given name.</summary>
    /// <remarks>The queue is marked for delete and won't show up in queries, but there will be a short time
    ///          before the server allows another queue with the same name to be created again.
    /// </remarks>
    /// <param name="QueueName">The name of the queue to delete.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the delete is successful, false otherwise</returns>
    function DeleteQueue(const QueueName: string; ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Returns the metadata name/value pairs associated with the given queue</summary>
    /// <param name="QueueName">The name of the queue to get the metadata for</param>
    /// <param name="MetaData">The returned metadata, or nil if the call fails</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call is successful, false otherwise</returns>
    function GetQueueMetadata(const QueueName: string; out MetaData: TStrings;
                              ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Sets the metadata name/value pairs associated with the given queue</summary>
    /// <param name="QueueName">The name of the queue to set the metadata for</param>
    /// <param name="MetaData">The metadata to set for the queue</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call is successful, false otherwise</returns>
    function SetQueueMetadata(const QueueName: string; const MetaData: TStrings;
                              ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Adds a message to the given queue</summary>
    /// <remarks>The TimeToLive parameter, if set to something greater tha 0, speicifies the time in seconds
    ///          to leave the message in the queue before expiring it. The maximum (and default) is 7 days.
    /// </remarks>
    /// <param name="QueueName">The queue to add the message to</param>
    /// <param name="MessageText">The text of the message</param>
    /// <param name="TimeToLive">The time in seconds before the message expires, or 0 to use the server default.
    /// </param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the message was added successfully, false otherwise.</returns>
    function AddMessage(const QueueName: string; const MessageText: string; const TimeToLive: Integer = 0;
                        ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Returns messages from the given queue.</summary>
    /// <remarks>If NumOfMessages isn't set, then the server default of 1 is used. The maximum allowed value is 32.
    ///          If VisibilityTimeout isn't set, the server default (30 seconds) is used. The maximum allowed
    ///          value is 2 hours.
    ///          Note that messages returned by this call will have their PopReceipt specified, which is a
    ///          token unique to the message during the VisibilityTimeout which can be used to delete the message.
    /// </remarks>
    /// <param name="QueueName">The name of the queue to get the messages for</param>
    /// <param name="NumOfMessages">The maximum number of messages to return.</param>
    /// <param name="VisibilityTimeout">How long the messages should be reserved for</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the messages</returns>
    function GetMessagesXML(const QueueName: string;
                            NumOfMessages: Integer = 0;
                            VisibilityTimeout: Integer = 0;
                            ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Returns messages from the given queue.</summary>
    /// <remarks>If NumOfMessages isn't set, then the server default of 1 is used. The maximum allowed value is 32.
    ///          If VisibilityTimeout isn't set, the server default (30 seconds) is used. The maximum allowed
    ///          value is 2 hours.
    ///          Note that messages returned by this call will have their PopReceipt specified, which is a
    ///          token unique to the message during the VisibilityTimeout which can be used to delete the message.
    ///          During VisibilityTimeout the messages are hidden from any further message querying.
    /// </remarks>
    /// <param name="QueueName">The name of the queue to get the messages for</param>
    /// <param name="NumOfMessages">The maximum number of messages to return.</param>
    /// <param name="VisibilityTimeout">How long the messages should be reserved for</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of messages, with their pop receipts populated</returns>
    function GetMessages(const QueueName: string;
                         NumOfMessages: Integer = 0;
                         VisibilityTimeout: Integer = 0;
                         ResponseInfo: TCloudResponseInfo = nil): TList<TCloudQueueMessage>;
    /// <summary>Returns messages from the given queue.</summary>
    /// <remarks>If NumOfMessages isn't set, then the server default of 1 is used. The maximum allowed value is 32.
    ///          Note that messages returned by this call will NOT have their PopReceipt specified. There is
    ///          not VisibilityTimeout, and so other people can instantly query messages and see them.
    /// </remarks>
    /// <param name="QueueName">The name of the queue to get the messages for</param>
    /// <param name="NumOfMessages">The maximum number of messages to return.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the messages</returns>
    function PeekMessagesXML(const QueueName: string; NumOfMessages: Integer;
                             ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Returns messages from the given queue.</summary>
    /// <remarks>If NumOfMessages isn't set, then the server default of 1 is used. The maximum allowed value is 32.
    ///          Note that messages returned by this call will NOT have their PopReceipt specified. There is
    ///          no VisibilityTimeout, so other people can instantly query messages and see them.
    /// </remarks>
    /// <param name="QueueName">The name of the queue to get the messages for</param>
    /// <param name="NumOfMessages">The maximum number of messages to return.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of messages</returns>
    function PeekMessages(const QueueName: string; NumOfMessages: Integer;
                          ResponseInfo: TCloudResponseInfo = nil): TList<TCloudQueueMessage>;
    /// <summary>Deletes the given message from the specified queue</summary>
    /// <param name="QueueName">Name of the queue to delete a message from</param>
    /// <param name="MessageId">The unique ID of the message to delete</param>
    /// <param name="PopReceipt">The pop receipt required for deleting the message</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the delete was successful, false otherwise</returns>
    function DeleteMessage(const QueueName: string; const MessageId: string; const PopReceipt: string;
                           ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Deletes the given message from the specified queue</summary>
    /// <remarks>If GetPopReceiptIfNeeded is set to true (which it is by default) then if the message object
    ///          has empty string set as its pop receipt then a pop receipt is acquired by first calling
    ///          GetMessages with the default values for number of messages and visibility timeout.
    ///          If the message requesting deletion isn't on the top of the queue, the deletion will fail.
    /// </remarks>
    /// <param name="QueueName">The name of the queue to delete the message from</param>
    /// <param name="QueueMessage">The message to delete</param>
    /// <param name="GetPopReceiptIfNeeded">True to try getting a pop receipt for the message
    ///                                     if it doesn't have one already.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the deletion succeeds, false otherwise.</returns>
    function DeleteMessage(const QueueName: string; const QueueMessage: TCloudQueueMessage;
                           GetPopReceiptIfNeeded: Boolean = True;
                           ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Clears the messages from the given queue</summary>
    /// <param name="QueueName">The name of the queue to delete all messages from</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function ClearMessages(const QueueName: string;
                           ResponseInfo: TCloudResponseInfo = nil): Boolean;
  end;

  /// <summary>Represents a container for the Windows Azure Blob Service</summary>
  TAzureContainer = class
  private
    FName: string;
    FURL: string;
    FProperties: TStrings;
    FMetadata: TStrings;
  public
    /// <summary>Creates a new instance of TAzureContainer</summary>
    /// <remarks>If Properties and/or Metadata are left as nil, then a new empty TStrings will be created.
    /// </remarks>
    // / <param name="Name">The name of the container</param>
    // / <param name="URL">The unique URL of the container</param>
    // / <param name="Properties">The properties associated with the container</param>
    // / <param name="Metadata">The metadata associated with the container</param>
    constructor Create(const Name, URL: string; Properties: TStrings = nil; Metadata: TStrings = nil);
    /// <summary>Frees the properties and metadata and destroys the instance.</summary>
    destructor Destroy; override;

    /// <summary>Says if this container is the root container</summary>
    /// <returns>Returns </returns>
    function IsRoot: Boolean;

    /// <summary>The name of the container</summary>
    property Name: string read FName;
    /// <summary>The unique URL of the container</summary>
    property URL: string read FURL;
    /// <summary>The properties associated with the container</summary>
    property Properties: TStrings read FProperties;
    /// <summary>The metadata associated with the container</summary>
    property Metadata: TStrings read FMetadata;
  end;

  /// <summary>Options for container and blob public access restrictions.</summary>
  /// <remarks>These are used to determine which containers (and the blobs they contain) are visible to the public
  ///          and with which restrictions they are visible.
  ///          When bpaPrivate is used, neither the Container or the blobs it contains are publicly visible.
  ///          When bpaContainer is used, the container and its blobs are fully visible
  ///          When bpaBlob is used, the blobs within the container are visible, but the container
  ///          data itself is hidden. This also prevents enumerating the blobs of a container.
  /// </remarks>
  TBlobPublicAccess = (bpaPrivate, bpaContainer, bpaBlob);

  /// <summary>Access policy information, specifying the allowed public operations.</summary>
  /// <remarks>The four operations are: Read, Write, Delete and List. Each of these can be
  ///          enabled or disabled. Furthermore, the access policy can have a start time and
  ///          an expiry time, to create a window of time the policy takes effect for.
  /// </remarks>
  TAccessPolicy = record
    /// <summary>The date the access policy is not valid before.</summary>
    /// <remarks>must be expressed as UTC times and must adhere to a valid ISO 8061 format.
    ///          Supported formats include:
    ///          YYYY-MM-DD
    ///          YYYY-MM-DDThh:mmTZD
    ///          YYYY-MM-DDThh:mm:ssTZD
    ///          YYYY-MM-DDThh:mm:ss.ffffffTZD
    /// </remarks>
    Start: string;
    /// <summary>The date the access policy is not valid after.</summary>
    /// <remarks>must be expressed as UTC times and must adhere to a valid ISO 8061 format.
    ///          Supported formats include:
    ///          YYYY-MM-DD
    ///          YYYY-MM-DDThh:mmTZD
    ///          YYYY-MM-DDThh:mm:ssTZD
    ///          YYYY-MM-DDThh:mm:ss.ffffffTZD
    /// </remarks>
    Expiry: string;
    /// <summary>True when read permission is granted by this access policy</summary>
    PermRead: Boolean;
    /// <summary>True when write permission is granted by this access policy</summary>
    PermWrite: Boolean;
    /// <summary>True when delete permission is granted by this access policy</summary>
    PermDelete:Boolean;
    /// <summary>True when list permission is granted by this access policy</summary>
    PermList: Boolean;
    /// <summary>Returns the string representation of the permissions.</summary>
    /// <remarks>Always in the order: rwdl, omitting any which are currently set to false.</remarks>
    /// <returns>The string representation of the permissions currently set to true.</returns>
    function GetPermission: string;
    /// <summary>Sets the boolean fields by parsing the string representation.</summary>
    /// <remarks>Only four characters, at most, are expected in the string: rwdl. If one of
    ///          those characters is present in the string, then its corresponding permission
    ///          boolean field is set to true. Otherwise, it is set to false.
    /// </remarks>
    /// <param name="rwdl">The string representation of the permission fields that should be set to true</param>
    procedure SetPermission(const rwdl: string);
    /// <summary>Returns the XML representation of the access policy, as it is required by Azure</summary>
    /// <returns>The XML representation of the access policy, as it is required by Azure</returns>
    function AsXML: string;
    /// <summary>Creates a new instance of TAccessPolicy with all permissions, except read, off.</summary>
    /// <returns>The new initialized instance.</returns>
    class function Create: TAccessPolicy; static;
    /// <summary>Returns or sets the permissions with a string representation.</summary>
    property Permission: string read GetPermission write SetPermission;
  end;

  /// <summary>A signed identifier, which is used to uniquely identify an Access Policy.</summary>
  TSignedIdentifier = class
  private
    FId: string;
    FResource: string;
  public
    /// <summary>The Access Policy this identifies.</summary>
    AccessPolicy: TAccessPolicy;

    /// <summary>Creates a new instance of TSignedIdentifier</summary>
    // / <param name="Resource">The resource (container, for example) name this is for.</param>
    constructor Create(const Resource: string); overload;
    /// <summary>Creates a new instance of TSignedIdentifier</summary>
    // / <param name="Resource">The resource (container, for example) name this is for.</param>
    // / <param name="Policy">The access policy this identifies.</param>
    constructor Create(const Resource: string; Policy: TAccessPolicy; UniqueId: string = ''); overload;

    /// <summary>The XML representation of the signed identifier, as it is required for Azure requests.</summary>
    /// <returns>The XML representation used for create/update requests.</returns>
    function AsXML: string; virtual;

    /// <summary>The unique Id</summary>
    /// <remarks>The maximum length of the unique identifier is 64 characters</remarks>
    property Id: string read FId write FId;
  end;

  /// <summary>Enumerates the types of Azure blobs</summary>
  /// <remarks>abtPrefix is used when the item represents a virtual subdirectory containing blobs</remarks>
  TAzureBlobType = (abtBlock, abtPage, abtPrefix);

  /// <summary>Enumerates the different states a leasable item can be in.</summary>
  TAzureLeaseStatus = (alsLocked, alsUnlocked);

  /// <summary>Represents a blob of any supported type, with its common features.</summary>
  /// <remarks>abtPrefix is used as the BlobType when the item represents a virtual subdirectory
  ///          containing blobs and/or subdirectories. It signifies that only the Name property of
  ///          the blob instance is valid, as it doesn't represent a blob itself, but instead
  ///          represents a directory.
  /// </remarks>
  TAzureBlob = class
  private
    FName: string;
    FUrl: string;
    FSnapshot: string;
    FBlobType: TAzureBlobType;
    FLeaseStatus: TAzureLeaseStatus;
    FProperties: TStrings;
    FMetadata: TStrings;
  public
    /// <summary>Creates a new instance of TAzureBlob</summary>
    // / <param name="Name">The name of the blob, or BlobPrefix if BlobType is abtPrefix</param>
    // / <param name="BlobType">The blob type</param>
    // / <param name="Url">The Blob URL, or empty string if BlobType is abtPrefix</param>
    // / <param name="LeaseStatus">The lease status of the blob</param>
    // / <param name="Snapshot">The optional Snapshot date-time-value</param>
    constructor Create(const Name: string; BlobType: TAzureBlobType; const Url: string = '';
                       LeaseStatus: TAzureLeaseStatus = alsUnlocked; const Snapshot: string = '');
    /// <summary>Frees the metadata and properties and destroys the instance.</summary>
    destructor Destroy; override;
    /// <summary>The name of the blob, or BlobPrefix if BlobType is abtPrefix</summary>
    property Name: string read FName;
    /// <summary>The Blob URL, or empty string if BlobType is abtPrefix</summary>
    property Url: string read FUrl;
    /// <summary>The Blob type</summary>
    property BlobType: TAzureBlobType read FBlobType;
    /// <summary>The optional Snapshot date-time-value</summary>
    property Snapshot: string read FSnapshot;
    /// <summary>The lease status of the blob (locked/unlocked)</summary>
    property LeaseStatus: TAzureLeaseStatus read FLeaseStatus write FLeaseStatus;
    /// <summary>The blob's list of property name/value pairs</summary>
    property Properties: TStrings read FProperties;
    /// <summary>The blob's list of metadata name/value pairs</summary>
    property Metadata: TStrings read FMetadata;
  end;

  /// <summary>Record of optional conditional restrictions.</summary>
  /// <remarks>These can be used, for example, when copying a blob or when creating a blob
  ///          snapshot. They provide a way to specify under which conditions the action
  ///          should happen or not happen.
  /// </remarks>
  TBlobActionConditional = record
    /// <summary>A DateTime value. Specify to copy the blob only if the source blob has been
    ///          modified since the specified date/time.
    ///</summary>
    IfSourceModifiedSince: string;
    /// <summary>A DateTime value. Specify to copy the blob only if the source blob has not been
    ///          modified since the specified date/time.
    /// </summary>
    IfSourceUnmodifiedSince: string;
    /// <summary>Specify this conditional header to copy the source blob only if its
    ///          ETag matches the value specified.
    /// </summary>
    IfSourceMatch: string;
    /// <summary>Specify this conditional header to copy the blob only if its ETag
    ///          does not match the value specified.
    /// </summary>
    IfSourceNoneMatch: string;
    /// <summary>A DateTime value. Specify this conditional header to perform the action:
    ///          Copying a Blob:
    ///          only if the destination blob has been modified since the specified date/time.
    ///          Creating a Snapshot:
    ///          only if the blob has been modified since the specified date/time.
    /// </summary>
    IfModifiedSince: string;
    /// <summary>A DateTime value. Specify this conditional header to perform the action:
    ///          Copying a Blob:
    ///          only if the destination blob has not been modified since the specified date/time.
    ///          Creating a Snapshot:
    ///          only if the blob has not been modified since the specified date/time.
    /// </summary>
    IfUnmodifiedSince: string;
    /// <summary>Specify an ETag value to perform the action only if the blob's ETag value
    ///          matches the value specified. The blob checked is either the destination
    ///          blob (when copying a blob) or the blob being snapshotted (when creating a snapshot.)
    /// </summary>
    IfMatch: string;
    /// <summary>Specify an ETag value to perform the action only if the blob's ETag value
    ///          does not match the value specified. The blob checked is either the destination
    ///          blob (when copying a blob) or the blob being snapshotted (when creating a snapshot.)
    /// </summary>
    IfNoneMatch: string;
    /// <summary>Specifies a number that the sequence number must be less than or equal to.
    ///          Used in the PutPage action.
    /// </summary>
    IfSequenceNumberLessThanOrEqual: string;
    /// <summary>Specifies a number that the sequence number must be less than.
    ///          Used in the PutPage action.
    /// </summary>
    IfSequenceNumberLessThan: string;
    /// <summary>Specifies a number that the sequence number must be equal to.
    ///          Used in the PutPage action.
    /// </summary>
    IfSequenceNumberEquals: string;

    /// <summary>Creates a new instance of TBlobActionConditional</summary>
    class function Create: TBlobActionConditional; static;

    /// <summary>Populates the given header list with the key/value pair of any field with an assigned value.
    /// </summary>
    /// <remarks>The keys used will be the header names, as required by Azure requests.</remarks>
    /// <param name="Headers">The headers list to populate</param>
    procedure PopulateHeaders(Headers: TStrings);
  end;

  /// <summary>The available block types for Azure block blobs</summary>
  /// <remarks>abtLatest is used when calling PutBlockList and you want to use the latest version
  ///          of a block, which would either be in the uncommitted list (newer)
  ///          or the commited list (older.)
  /// </remarks>
  TAzureBlockType = (abtCommitted, abtUncommitted, abtLatest);

  /// <summary>A block blob block item.</summary>
  /// <remarks>Size can be left out if this item is being used in a PutBlockList operation.
  ///          It will be populated when calling GetBlockList.
  /// </remarks>
  TAzureBlockListItem = record
    /// <summary>The base 64 encoded unique ID of the block</summary>
    BlockId: string;
    /// <summary>The size of the block data in bytes</summary>
    /// <remarks>Ignore this value when doing utBlockList requests</remarks>
    Size: string;
    /// <summary>The block type</summary>
    /// <remarks>When populated from a GetBlockList call, the available types are:
    ///          abtCommitted and abtUncommitted. When calling PutBlockList, abtLatest is also supported.
    ///          A given ID can have up to two blocks associated with it, where one block is in
    ///          the committed list, and the other is in the uncommited list.
    /// </remarks>
    BlockType: TAzureBlockType;

    /// <summary>Creates a new instance of TAzureBlockListItem with the given values</summary>
    /// <param name="ABlockId">The blob Id to set</param>
    /// <param name="ABlockType">The block type to set</param>
    /// <param name="ASize">The size to set</param>
    /// <returns>A new instance of TAzureBlockListItem</returns>
    class function Create(ABlockId: string; ABlockType: TAzureBlockType;
                          ASize: string = '0'): TAzureBlockListItem; static;
    /// <summary>Returns the XML in a format as required by the PutBlockList action.</summary>
    function AsXML: string;
  end;

  /// <summary>Used when querying blocks, to get all blocks, or refine based on type.</summary>
  TAzureQueryIncludeBlockType = (aqbtCommitted, aqbtUncommitted, aqbtAll);

  /// <summary>Represents a page range, as returned by GetPageRegions.</summary>
  /// <remarks>These are used to specify pages which have been populated with data.
  /// </remarks>
  TAzureBlobPageRange = record
    /// <summary>The first byte of the range, which cab be used to infer the page</summary>
    StartByte: Int64;
    /// <summary>The end byte of the range, which can be used to calculate how many pages are in the range.</summary>
    EndByte: Int64;
    /// <summary>Creates a new instance of TAzureBlobPageRange</summary>
    class function Create(StartByte, EndByte: Int64): TAzureBlobPageRange; static;
    /// <summary>Returns the starting page, zero-indexed, based on the StartByte.</summary>
    /// <returns>the starting page of the range</returns>
    function GetStartPage: Integer;
    /// <summary>Returns the number of pages in the range.</summary>
    /// <returns>The number of pages in the range.</returns>
    function GetPageCount: Integer;
  end;

  /// <summary>Implementation of TAzureService for managing a Windows Azure Blob Service account.</summary>
  TAzureBlobService = class(TAzureService)
  private
    function GetBlobContainerQueryPrefix(Headers: TStrings;
                                         ContainerName: string = 'Container';
                                         BlobName: string = ''): string;
    function LoadChildrenAsProperties(ANode: IXMLNode): TStrings;
    function ParseContainerFromContainerNode(ContainerNode: IXMLNode): TAzureContainer;
    function BuildMetadataHeaderList(const Metadata: TStrings): TStringList;
    function GetPublicAccessString(PublicAccess: TBlobPublicAccess): string;
    function HandleBlobLease(ContainerName, BlobName: string; const LeaseAction, LeaseId: string;
                             SuccessCode: Integer;
                             out Success: Boolean; ResponseInfo: TCloudResponseInfo = nil): string;
    function DeleteBlobInternal(ContainerName, BlobName, SnapShot: string; OnlySnapshots: Boolean;
                                LeaseId: string; ResponseInfo: TCloudResponseInfo): Boolean;
    function GetBlobInternal(ContainerName, BlobName, Snapshot, LeaseId: string;
                             out Metadata, Properties: TStrings;
                             ResponseContent: TStream;
                             StartByte, EndByte: int64; GetAsHash: Boolean;
                             ResponseInfo: TCloudResponseInfo): Boolean;
    function CopyBlobInternal(TargetContainerName, TargetBlobName, SourceContainerName,
                              SourceBlobName: string;
                              const SourceSnapshot: string;
                              const TargetLeaseId: string;
                              CopyConditionals: TBlobActionConditional;
                              Metadata: TStrings;
                              ResponseInfo: TCloudResponseInfo): Boolean;
    function PutPageInternal(ContainerName, BlobName: string;
                             Content: TArray<Byte>; DoClear: Boolean;
                             StartPage, PageCount: Integer;
                             ActionConditional: TBlobActionConditional;
                             const ContentMD5: string;
                             const LeaseId: string;
                             ResponseInfo: TCloudResponseInfo): Boolean; overload;
    procedure PopulateBlobPropertyHeaders(Headers, Properties: TStrings);
    procedure AddBlockItems(BlocksNode: IXMLNode; BlockList: TList<TAzureBlockListItem>;
                            BlockType: TAzureBlockType);
  public
    /// <summary>Returns the containers available on the blob service account</summary>
    /// <remarks>Supported optional parameters are: prefix, marker, maxresults, include=metadata.
    ///          If 'prefix' is set, its value is set as being the prefix a container name needs to
    ///          start with in order to be included in the list of containers returned by this call.
    ///          If 'marker' is set then this is used as a continuation token, for which container to
    ///          start the listing at. The value for this continuation token is specified in the 'NextMarker'
    ///          element of the XML returned.
    ///          If 'maxresults' is specified, it is treated as an integer between 1 and 5000. This represents
    ///          the maximum number of containers to return with this call.
    ///          If 'include' is set, with a value of 'metadata' then the metadata for each container is also returned.
    /// </remarks>
    /// <param name="OptionalParams">The optional parameters for the call. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the available containers.</returns>
    function ListContainersXML(OptionalParams: TStrings = nil; ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Returns the containers available on the blob service account</summary>
    /// <remarks>Supported optional parameters are: prefix, marker, maxresults.
    ///          If 'prefix' is set, its value is set as being the prefix a container name needs to
    ///          start with in order to be included in the list of containers returned by this call.
    ///          If 'marker' is set then this is used as a continuation token, for which container to
    ///          start the listing at. The value for this continuation token is specified in the 'NextMarker'
    ///          element of the XML returned.
    ///          If 'maxresults' is specified, it is treated as an integer between 1 and 5000. This represents
    ///          the maximum number of containers to return with this call.
    ///          If 'include' is set, with a value of 'metadata' then the metadata for each container is also returned.
    /// </remarks>
    /// <param name="NextMarker">Will be set to the 'NextMarker' returned from the request, or empty string</param>
    /// <param name="OptionalParams">The optional parameters for the call. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the available containers.</returns>
    function ListContainers(out NextMarker: string;
                            OptionalParams: TStrings = nil;
                            ResponseInfo: TCloudResponseInfo = nil): TList<TAzureContainer>; overload;
    /// <summary>Returns the containers available on the blob service account</summary>
    /// <remarks>Supported optional parameters are: prefix, marker, maxresults.
    ///          If 'prefix' is set, its value is set as being the prefix a container name needs to
    ///          start with in order to be included in the list of containers returned by this call.
    ///          If 'marker' is set then this is used as a continuation token, for which container to
    ///          start the listing at. The value for this continuation token is specified in the 'NextMarker'
    ///          element of the XML returned.
    ///          If 'maxresults' is specified, it is treated as an integer between 1 and 5000. This represents
    ///          the maximum number of containers to return with this call.
    ///          If 'include' is set, with a value of 'metadata' then the metadata for each container is also returned.
    /// </remarks>
    /// <param name="OptionalParams">The optional parameters for the call. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the available containers.</returns>
    function ListContainers(OptionalParams: TStrings = nil;
                            ResponseInfo: TCloudResponseInfo = nil): TList<TAzureContainer>; overload;
    /// <summary>Creates a new container with the given name</summary>
    /// <remarks>If the container with the same name already exists, or if the naming requirements
    ///          aren't followed, then the operation fails.
    /// </remarks>
    /// <param name="ContainerName">The name of the container to create</param>
    /// <param name="MetaData">The optional metadata to associate with the container</param>
    /// <param name="PublicAccess">The public access setting to use for the container</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the creation was successful, false otherwise.</returns>
    function CreateContainer(ContainerName: string;
                             MetaData: TStrings = nil;
                             PublicAccess: TBlobPublicAccess = bpaContainer;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Creates the root container</summary>
    /// <remarks>If the root container already eists then the operation fails. This calls into
    ///          CreateContainer, passing $root as the ContainerName.
    /// </remarks>
    /// <param name="MetaData">The optional metadata to associate with the container</param>
    /// <param name="PublicAccess">The public access setting to use for the container</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the creation was successful, false otherwise.</returns>
    function CreateRootContainer(MetaData: TStrings = nil;
                                 PublicAccess: TBlobPublicAccess = bpaContainer;
                                 ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Deletes the container with the given name</summary>
    /// <param name="ContainerName">The name of the container to delete</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the delete is successful, false otherwise.</returns>
    function DeleteContainer(ContainerName: string; ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Deletes the root container</summary>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the delete is successful, false otherwise.</returns>
    function DeleteRootContainer(ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Returns the properties for the container with the given name.</summary>
    /// <param name="ContainerName">The name of the container to get the properties for</param>
    /// <param name="Properties">The outputted properties, or nil if the call fails</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the population was successful, false otherwise</returns>
    function GetContainerProperties(ContainerName: string; out Properties: TStrings;
                                    ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Returns the properties and metadata for the container with the given name.</summary>
    /// <param name="ContainerName">The name of the container to get the properties and metadata for</param>
    /// <param name="Properties">The outputted properties, or nil if the call fails</param>
    /// <param name="Metadata">The outputted metadata, or nil if the call fails</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the population was successful, false otherwise</returns>
    function GetContainerProperties(ContainerName: string; out Properties, Metadata: TStrings;
                                    ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Returns the metadata for the container with the given name.</summary>
    /// <param name="ContainerName">The name of the container to get the metadata for</param>
    /// <param name="Metadata">The outputted metadata, or an empty list</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the population was successful, false otherwise</returns>
    function GetContainerMetadata(ContainerName: string; out Metadata: TStrings;
                                  ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Sets the metadata for the specified container.</summary>
    /// <remarks>Note that this replaces any existing metadata values. If you don't want to lose any
    ///          of the metadata already on the container, be sure to include them in the Metadata
    ///          passed in to this call.
    /// </remarks>
    /// <param name="ContainerName">The name of the container to set the metadata for</param>
    /// <param name="Metadata">The metadata to set onto the container</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the action was successful, false otherwise</returns>
    function SetContainerMetadata(ContainerName: string; const Metadata: TStrings;
                                  ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Returns the public permissions for the container.</summary>
    /// <param name="ContainerName">The name of the container to get the permissions for</param>
    /// <param name="PublicAccess">The public access setting for the container</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the access policies</returns>
    function GetContainerACLXML(ContainerName: string; out PublicAccess: TBlobPublicAccess;
                                ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Returns the public permissions for the container.</summary>
    /// <param name="ContainerName">The name of the container to get the permissions for</param>
    /// <param name="PublicAccess">The public access setting for the container</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of access policies</returns>
    function GetContainerACL(ContainerName: string; out PublicAccess: TBlobPublicAccess;
                             ResponseInfo: TCloudResponseInfo = nil): TList<TSignedIdentifier>;
    /// <summary>Adds or updates the Signed Identifier with the given ID for the specified container.</summary>
    /// <remarks>When calling this function, the existing permissions are replaced.
    ///          To update the container's permissions, call GetContainerACL to retrieve all access policies
    ///          associated with the container, change the access policy that you want,
    ///          then call SetContainerACL with the complete list of TSignedIdentifier to perform the update,
    ///          Or passing the single SignedIdentifier's Id and AccessPolicy.
    /// </remarks>
    /// <param name="ContainerName">The name of the container to set the signed identifier for</param>
    /// <param name="SignedIdentifierId">The unique ID of the single signed identifier to add/update</param>
    /// <param name="AccessPolicy">The SignedIdentifier's access policy</param>
    /// <param name="PublicAccess">The value to set as the container's public access. Defaults to container</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the action was successful, false otherwise</returns>
    function SetContainerACL(ContainerName: string;
                             const SignedIdentifierId: string;
                             AccessPolicy: TAccessPolicy;
                             PublicAccess: TBlobPublicAccess = bpaContainer;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Adds or updates the Signed Identifiers for the specified container.</summary>
    /// <remarks>When calling this function, the existing permissions are replaced.
    ///          To update the container's permissions, call GetContainerACL to retrieve all access policies
    ///          associated with the container, change the access policy that you want,
    ///          then call SetContainerACL with the complete list of TSignedIdentifier to perform the update.
    /// </remarks>
    /// <param name="ContainerName">The name of the container to set the signed identifiers for</param>
    /// <param name="SignedIdentifiers">The signed identifiers (with their access policies) to set.</param>
    /// <param name="PublicAccess">The value to set as the container's public access. Defaults to container</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the action was successful, false otherwise</returns>
    function SetContainerACL(ContainerName: string;
                             SignedIdentifiers: TList<TSignedIdentifier>;
                             PublicAccess: TBlobPublicAccess = bpaContainer;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Returns the list of blobs for the given container.</summary>
    /// <remarks>The following optional parameters are supported:
    ///          prefix, delimiter, marker, maxresults, include={snapshots,metadata,uncommittedblobs}
    ///          If prefix is specified, only blobs with names starting with the specified prefix are shown.
    ///          If delimiter is specified, then Any blob with a name (after the prefix string) containing
    ///          the delimiter string will be grouped into a 'BlobPrefix' node, as appropriate. What this
    ///          does is provides a way to view the blobs with a virtual directory structure, where you could
    ///          then take the values of the returned 'BlobPrefix' Name nodes, and use those as prefix values
    ///          for subsequent calls.
    ///          If marker is specified, it is used as a continuation token to retrieve more blobs from where
    ///          a previous invocation left off when it wasn't able to return all the blobs.
    ///          If maxresults is specified, then it is treated as an integer representing the maximum
    ///          number of blobs to return. The default (and maximum) is 5000. If more blobs exist than the
    ///          maxresults allows, then the 'NextMarker' in the XML will be populated, and you can use this
    ///          as the value of 'marker' in a future call.
    ///          If include is specified it can have a CSV string of one or more of the following:
    ///            snapshots - include blob snapshots in the response (ordered oldest to newest)
    ///            metadata - specifies to include each blob's metadata in the response
    ///            uncommittedblobs - says to include in the response blobs with uncommitted sections
    ///          Note that blobs under the $root container can't have a slash in thier name.
    /// </remarks>
    /// <param name="ContainerName">The container to get the blobs for. Or $root for the root container.</param>
    /// <param name="OptionalParams">The optional parameter name/value pairs. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the container's blobs.</returns>
    function ListBlobsXML(ContainerName: string; OptionalParams: TStrings = nil;
                          ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Returns the list of blobs for the given container.</summary>
    /// <remarks>The following optional parameters are supported:
    ///          prefix, delimiter, marker, maxresults, include={snapshots,metadata,uncommittedblobs}
    ///          See comment for ListBlobsXML for more information.
    /// </remarks>
    /// <param name="ContainerName">The container to get the blobs for. Or $root for the root container.</param>
    /// <param name="OptionalParams">The optional parameter name/value pairs. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of the container's blobs.</returns>
    function ListBlobs(ContainerName: string; OptionalParams: TStrings = nil;
                       ResponseInfo: TCloudResponseInfo = nil): TList<TAzureBlob>; overload;
    /// <summary>Returns the list of blobs for the given container.</summary>
    /// <remarks>The following optional parameters are supported:
    ///          prefix, delimiter, marker, maxresults, include={snapshots,metadata,uncommittedblobs}
    ///          See comment for ListBlobsXML for more information.
    /// </remarks>
    /// <param name="ContainerName">The container to get the blobs for. Or $root for the root container.</param>
    /// <param name="NextMarker">The continuation token if not all the blobs were returned.</param>
    /// <param name="OptionalParams">The optional parameter name/value pairs. See remarks for more information.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of the container's blobs.</returns>
    function ListBlobs(ContainerName: string; out NextMarker: string; OptionalParams: TStrings = nil;
                       ResponseInfo: TCloudResponseInfo = nil): TList<TAzureBlob>; overload;
    /// <summary>Creates a new block blob, or updates an existing one, in the given container</summary>
    /// <remarks>If a block blob with the given name (in the specified container) already exists,
    ///          then its content will be replaced with the data from this call.
    ///          Note that LeaseId should be set as EmptyString, except when a blob with the given name
    ///          already exists, and it is currently locked.
    ///          The Optional headers can be set onto the request. Such as:
    ///            Content-Type (or x-ms-blob-content-type)
    ///            Content-Encoding (or x-ms-blob-content-encoding)
    ///            Content-Language (or x-ms-blob-content-language)
    ///            Content-MD5 (or x-ms-blob-content-md5)
    ///            Cache-Control (or x-ms-blob-cache-control)
    ///            If-Modified-Since
    ///            If-Unmodified-Since
    ///            If-Match (Compares the resource's Etag value to the value of this header)
    ///            If-None-Match (Compares the resource's Etag value to the value of this header)
    ///          The optional metadata names should start with 'x-ms-meta-'. If they do not,
    ///          this prefix will be added.
    ///          The maximum allowed Content-Length of a block blob is 64 MB. If it is larger than
    ///          that, then you need to upload it as blocks.
    /// </remarks>
    /// <param name="ContainerName">The name of the blob's container</param>
    /// <param name="BlobName">The name of the blob</param>
    /// <param name="Content">The content to set into the blob</param>
    /// <param name="LeaseId">The optional lease Id.</param>
    /// <param name="OptionalHeaders">The optional headers</param>
    /// <param name="Metadata">The metadata to set onto the blob</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the create/replace was successful, false otherwise.</returns>
    function PutBlockBlob(ContainerName, BlobName: string; Content: TArray<Byte>;
                          LeaseId: string = '';
                          OptionalHeaders: TStrings = nil; Metadata: TStrings = nil;
                          ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Creates a new block blob, or updates an existing one, in the given container</summary>
    /// <remarks>Creates a new page blob, with no content, but a specified maximum content length.
    ///          Page blobs don't have content until you add pages with a PutPage request.
    ///          For more information on the Header and Metadata parameters, see the documentation
    ///          for PutBlockBlob.
    ///          The maximum supported length is 1TB. Each page must be aligned to a 512-byte boundary.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob should be created in</param>
    /// <param name="BlobName">The name of the blob</param>
    /// <param name="MaximumSize">The maximum contentent length of the blob.</param>
    /// <param name="OptionalHeaders">The optional headers</param>
    /// <param name="Metadata">The metadata to set onto the blob</param>
    /// <param name="BlobSequenceNumber">Optional user-controlled value usable for tracking requests</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the create/replace was successful, false otherwise.</returns>
    function PutPageBlob(ContainerName, BlobName: string; MaximumSize: int64;
                         OptionalHeaders: TStrings = nil; Metadata: TStrings = nil;
                         BlobSequenceNumber: int64 = 0;
                         ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Attempts to acquire a lease on the specified blob</summary>
    /// <remarks>You can not acquire a lease for a snapshot.</remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to acquire a lease for</param>
    /// <param name="LeaseId">The acquired lease ID, or empty string is failed</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the lease was acquired, false otherwise</returns>
    function AcquireBlobLease(ContainerName, BlobName: string; out LeaseId: string;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Attempts to renew the specified lease for the given blob.</summary>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to renew the lease for</param>
    /// <param name="LeaseId">The Id of the lease that was previously acquired</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the lease was renewed, false otherwise</returns>
    function RenewBlobLease(ContainerName, BlobName: string; const LeaseId: string;
                            ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Releases a lease that was previously acquired</summary>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to release the lease for</param>
    /// <param name="LeaseId">The Id of the lease that was previously acquired</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call executes successfully, false otherwise</returns>
    function ReleaseBlobLease(ContainerName, BlobName: string; const LeaseId: string;
                              ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Breaks a lease previously acquired, without specifying the lease Id</summary>
    /// <remarks>Similar to calling 'ReleaseBlobLease' but since the LeaseId is not specified,
    ///          the lease is allowed to expire before a new lease can be acquired. In this period,
    ///          the lease is not able to be renewed.
    ///          The value set into LeaseTimeRemaining specifies how many seconds remain before
    ///          the current lease expires.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to break the lease for</param>
    /// <param name="LeaseTimeRemaining">The number of seconds remaining until the lease expires</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call executes successfully, false otherwise</returns>
    function BreakBlobLease(ContainerName, BlobName: string; out LeaseTimeRemaining: Integer;
                            ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Gets the metadata for a given blob</summary>
    /// <remarks>LeaseId is only required if it is the blob (not a snapshot) you are interested in,
    ///          and if that blob is currently locked. In no other situation should you specify a value
    ///          other than empty string for LeaseId, otherwise the request will fail.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to get the metadata for</param>
    /// <param name="Metadata">The returned metadata, or nil if the request fails</param>
    /// <param name="Snapshot">The snapshot identifier, if you are interested in a snapshot of the blob</param>
    /// <param name="LeaseId">The LeaseId, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call executes successfully, false otherwise</returns>
    function GetBlobMetadata(ContainerName, BlobName: string; out Metadata: TStrings;
                             const Snapshot: string = ''; const LeaseId: string = '';
                             ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Sets the given metadata onto the specified blob</summary>
    /// <remarks>LeaseId should only be something other than empty string if the blob is locked.
    ///          This replaces the full set of metadata currently on the blob, it doesn't append to it.
    ///          Updating the metadata of a snapshot is not supported.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to set the metadata for</param>
    /// <param name="Metadata">The metadata to set.</param>
    /// <param name="LeaseId">The LeaseId, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call executes successfully, false otherwise</returns>
    function SetBlobMetadata(ContainerName, BlobName: string; Metadata: TStrings; LeaseId: string = '';
                             ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Gets the properties for a given blob</summary>
    /// <remarks>LeaseId is only required if it is the blob (not a snapshot) you are interested in,
    ///          and if that blob is currently locked. In no other situation should you specify a value
    ///          other than empty string for LeaseId, otherwise the request will fail.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to get the properties for</param>
    /// <param name="Properties">The returned properties, or nil if the request fails</param>
    /// <param name="Snapshot">The snapshot identifier, if you are interested in a snapshot of the blob</param>
    /// <param name="LeaseId">The LeaseId, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call executes successfully, false otherwise</returns>
    function GetBlobProperties(ContainerName, BlobName: string; out Properties: TStrings;
                               const Snapshot: string = ''; const LeaseId: string = '';
                               ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Gets the properties and metadata for a given blob</summary>
    /// <remarks>LeaseId is only required if it is the blob (not a snapshot) you are interested in,
    ///          and if that blob is currently locked. In no other situation should you specify a value
    ///          other than empty string for LeaseId, otherwise the request will fail.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to get the properties for</param>
    /// <param name="Properties">The returned properties, or nil if the request fails</param>
    /// <param name="Metadata">The returned metadata, or nil if the request fails</param>
    /// <param name="Snapshot">The snapshot identifier, if you are interested in a snapshot of the blob</param>
    /// <param name="LeaseId">The LeaseId, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call executes successfully, false otherwise</returns>
    function GetBlobProperties(ContainerName, BlobName: string; out Properties: TStrings;
                               out Metadata: TStrings;
                               const Snapshot: string = ''; const LeaseId: string = '';
                               ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Sets the given properties onto the specified blob</summary>
    /// <remarks>The supported properties are:
    ///           x-ms-blob-cache-control,
    ///           x-ms-blob-content-type,
    ///           x-ms-blob-content-md5,
    ///           x-ms-blob-content-encoding,
    ///           x-ms-blob-content-language.
    ///          For Page Blobs, these are also supported:
    ///           x-ms-blob-content-length,
    ///           x-ms-sequence-number-action (max, update, increment)
    ///           x-ms-blob-sequence-number (unless x-ms-sequence-number-action = increment).
    ///          When issuing a GetBlobProperties request, the names of the properties are different:
    ///           Cache-Control,
    ///           Content-Type,
    ///           Content-MD5,
    ///           Content-Encoding,
    ///           Content-Language.
    ///          Properties passed in will be given the 'x-ms-blob-' prefix if it is missing. All other
    ///          properties will be ignored.
    ///          LeaseId should only be something other than empty string if the blob is locked.
    ///          This replaces the full set of metadata currently on the blob, it doesn't append to it.
    ///          Updating the metadata of a snapshot is not supported.
    ///
    ///          The x-ms-blob-content-length property can be set to change the "MaximumSize" value specified
    ///          when 'PutPageBlob' was executed.
    ///
    ///          The x-ms-sequence-number-action can be one of 'max', 'update', 'increment'.
    ///            'max': Use the largest integer, either the one specified with 'x-ms-blob-sequence-number'
    ///                   or the one already existing on the server.
    ///            'update': Replace the value of 'x-ms-blob-sequence-number' on the server with this one.
    ///            'increment': Increment the server's value of 'x-ms-blob-sequence-number' by one. Do not
    ///                         specify the 'x-ms-blob-sequence-number' header in this request.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to set the properties for</param>
    /// <param name="Properties">The properties to set.</param>
    /// <param name="LeaseId">The LeaseId, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the call executes successfully, false otherwise</returns>
    function SetBlobProperties(ContainerName, BlobName: string; Properties: TStrings;
                               const LeaseId: string = '';
                               ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Deletes the specified blob, or deletes all of its snapshots.</summary>
    /// <remarks>Deletes the specified blob if 'OnlySnapshots' is False, or deletes
    ///          only the blob's snapshots if 'SnapShot' is true.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to delete</param>
    /// <param name="OnlySnapshots">True to delete all of the blob's snapshots, but not the blob.</param>
    /// <param name="LeaseId">The LeaseId, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the blob is deleted successfully, false otherwise</returns>
    function DeleteBlob(ContainerName, BlobName: string; OnlySnapshots: Boolean = False;
                        LeaseId: string = '';
                        ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Deletes the specified snapshot of then given blob.</summary>
    /// <remarks>Deletes one specific snapshot of the specified blob.
    ///          To delete all snapshots, or the blob itself, call DeleteBlob.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to delete</param>
    /// <param name="SnapShot">The snapshot to delete</param>
    /// <param name="LeaseId">The LeaseId, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the blob is deleted successfully, false otherwise</returns>
    function DeleteBlobSnapshot(ContainerName, BlobName: string; SnapShot: string;
                                LeaseId: string = '';
                                ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Downloads the given blob, writing its content into the provided stream.</summary>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to download</param>
    /// <param name="BlobStream">The stream to write the blob content into</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlob(ContainerName, BlobName: string; BlobStream: TStream;
                     const LeaseId: string = ''; ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Downloads the given blob, writing its content into the provided stream.</summary>
    /// <remarks>This call also returns the blob's properties and metadata</remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to download</param>
    /// <param name="BlobStream">The stream to write the blob content into</param>
    /// <param name="Properties">The blob's property name/value pairs</param>
    /// <param name="Metadata">The blob's metadata name/value pairs</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlob(ContainerName, BlobName: string; BlobStream: TStream;
                     out Properties, Metadata: TStrings; const LeaseId: string = '';
                     ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Downloads the given blob, writing its content into the provided stream.</summary>
    /// <remarks>You can request only a range of the blob to be returned by specifying values
    ///          for StartByte and EndByte. If you specify a range, you can also set GetAsHash
    ///          to True, which will return the MD5 hash of the range's content, instead of the
    ///          content itself. Note that you can only return the hash for a range, and not the
    ///          full content.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to download</param>
    /// <param name="BlobStream">The stream to write the blob content into</param>
    /// <param name="StartByte">The starting byte index</param>
    /// <param name="EndByte">The ending byte index, or 0 if you don't want a range of the blob</param>
    /// <param name="GetAsHash">True, if EndByte greater than Start byte, returns content as MD5 hash</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlob(ContainerName, BlobName: string; BlobStream: TStream;
                     StartByte: int64; EndByte: int64; GetAsHash: Boolean = False;
                     const LeaseId: string = ''; ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Downloads the given blob, writing its content into the provided stream.</summary>
    /// <remarks>This call also returns the blob's properties and metadata.
    ///          You can request only a range of the blob to be returned by specifying values
    ///          for StartByte and EndByte. If you specify a range, you can also set GetAsHash
    ///          to True, which will return the MD5 hash of the range's content, instead of the
    ///          content itself. Note that you can only return the hash for a range, and not the
    ///          full content.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob to download</param>
    /// <param name="BlobStream">The stream to write the blob content into</param>
    /// <param name="Properties">The blob's property name/value pairs</param>
    /// <param name="Metadata">The blob's metadata name/value pairs</param>
    /// <param name="StartByte">The starting byte index</param>
    /// <param name="EndByte">The ending byte index, or 0 if you don't want a range of the blob</param>
    /// <param name="GetAsHash">True, if EndByte greater than Start byte, returns content as MD5 hash</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlob(ContainerName, BlobName: string; BlobStream: TStream;
                     out Properties, Metadata: TStrings;
                     StartByte: int64; EndByte: int64; GetAsHash: Boolean = False;
                     const LeaseId: string = ''; ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Downloads the given blob snapshot, writing its content into the provided stream.</summary>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob the snapshot is for</param>
    /// <param name="Snapshot">The snapshot to get</param>
    /// <param name="SnapshotStream">The stream to write the snapshot content into</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Downloads the given snapshot, writing its content into the provided stream.</summary>
    /// <remarks>This call also returns the snapshot's properties and metadata</remarks>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob the snapshot is for</param>
    /// <param name="Snapshot">The snapshot to get</param>
    /// <param name="SnapshotStream">The stream to write the snapshot content into</param>
    /// <param name="Properties">The snapshot's property name/value pairs</param>
    /// <param name="Metadata">The snapshot's metadata name/value pairs</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                             out Properties, Metadata: TStrings;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Downloads the given snapshot, writing its content into the provided stream.</summary>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob the snapshot is for</param>
    /// <param name="Snapshot">The snapshot to get</param>
    /// <param name="SnapshotStream">The stream to write the snapshot content into</param>
    /// <param name="StartByte">The starting byte index</param>
    /// <param name="EndByte">The ending byte index, or 0 if you don't want a range of the snapshot</param>
    /// <param name="GetAsHash">True, if EndByte greater than Start byte, returns content as MD5 hash</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                             StartByte: int64 = 0; EndByte: int64 = 0;
                             GetAsHash: Boolean = False;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Downloads the given snapshot, writing its content into the provided stream.</summary>
    /// <param name="ContainerName">The name of the container the blob is in</param>
    /// <param name="BlobName">The name of the blob the snapshot is for</param>
    /// <param name="Snapshot">The snapshot to get</param>
    /// <param name="SnapshotStream">The stream to write the snapshot content into</param>
    /// <param name="Properties">The snapshot's property name/value pairs</param>
    /// <param name="Metadata">The snapshot's metadata name/value pairs</param>
    /// <param name="StartByte">The starting byte index</param>
    /// <param name="EndByte">The ending byte index, or 0 if you don't want a range of the snapshot</param>
    /// <param name="GetAsHash">True, if EndByte greater than Start byte, returns content as MD5 hash</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the task was successful, false otherwise</returns>
    function GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                             out Properties, Metadata: TStrings;
                             StartByte: int64 = 0; EndByte: int64 = 0;
                             GetAsHash: Boolean = False;
                             ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Copies the specified blob to the given target location.</summary>
    /// <remarks>If a blob exists at the target location, the content will be replaced.
    ///          If metadata is specified, then the target blob will have that metadata,
    ///          otherwise, it will have the metadata that exists on the source blob.
    /// </remarks>
    /// <param name="TargetContainerName">The container to put the copied blob into</param>
    /// <param name="TargetBlobName">The name of the resulting blob</param>
    /// <param name="SourceContainerName">The container the blob being copied is in</param>
    /// <param name="SourceBlobName">The name of the blob being copied</param>
    /// <param name="TargetLeaseId">The lease Id, required if the target blob exists already and is locked.</param>
    /// <param name="Metadata">The optional metadata to use on the target, instead of the source's</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the copy was successful, false otherwise.</returns>
    function CopyBlob(TargetContainerName, TargetBlobName, SourceContainerName, SourceBlobName: string;
                      const TargetLeaseId: string = ''; Metadata: TStrings = nil;
                      ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Copies the specified blob to the given target location.</summary>
    /// <remarks>If a blob exists at the target location, the content will be replaced.
    ///          If metadata is specified, then the target blob will have that metadata,
    ///          otherwise, it will have the metadata that exists on the source blob.
    /// </remarks>
    /// <param name="TargetContainerName">The container to put the copied blob into</param>
    /// <param name="TargetBlobName">The name of the resulting blob</param>
    /// <param name="SourceContainerName">The container the blob being copied is in</param>
    /// <param name="SourceBlobName">The name of the blob being copied</param>
    /// <param name="CopyConditionals">The conditions to meet in order to do the copy</param>
    /// <param name="TargetLeaseId">The lease Id, required if the target blob exists already and is locked.</param>
    /// <param name="Metadata">The optional metadata to use on the target, instead of the source's</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the copy was successful, false otherwise.</returns>
    function CopyBlob(TargetContainerName, TargetBlobName, SourceContainerName, SourceBlobName: string;
                      CopyConditionals: TBlobActionConditional;
                      const TargetLeaseId: string = ''; Metadata: TStrings = nil;
                      ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Copies the specified snapshot into the target blob location.</summary>
    /// <remarks>If a blob exists at the target location, the content will be replaced.
    ///          If metadata is specified, then the target blob will have that metadata,
    ///          otherwise, it will have the metadata that exists on the source snapshot.
    /// </remarks>
    /// <param name="TargetContainerName">The container to put the copied blob into</param>
    /// <param name="TargetBlobName">The name of the resulting blob</param>
    /// <param name="SourceContainerName">The container the blob being copied is in</param>
    /// <param name="SourceBlobName">The name of the blob owning the snapshot being copied</param>
    /// <param name="SourceSnapshot">The blob's snapshot to copy</param>
    /// <param name="Metadata">The optional metadata to use on the target, instead of the source's</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the copy was successful, false otherwise.</returns>
    function CopySnapshotToBlob(TargetContainerName, TargetBlobName, SourceContainerName, SourceBlobName: string;
                                const SourceSnapshot: string; Metadata: TStrings = nil;
                                ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Copies the specified snapshot into the target blob location.</summary>
    /// <remarks>If a blob exists at the target location, the content will be replaced.
    ///          If metadata is specified, then the target blob will have that metadata,
    ///          otherwise, it will have the metadata that exists on the source snapshot.
    /// </remarks>
    /// <param name="TargetContainerName">The container to put the copied blob into</param>
    /// <param name="TargetBlobName">The name of the resulting blob</param>
    /// <param name="SourceContainerName">The container the blob being copied is in</param>
    /// <param name="SourceBlobName">The name of the blob owning the snapshot being copied</param>
    /// <param name="CopyConditionals">The conditions to meet in order to do the copy</param>
    /// <param name="SourceSnapshot">The blob's snapshot to copy</param>
    /// <param name="Metadata">The optional metadata to use on the target, instead of the source's</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if the copy was successful, false otherwise.</returns>
    function CopySnapshotToBlob(TargetContainerName, TargetBlobName, SourceContainerName, SourceBlobName: string;
                                const SourceSnapshot: string;
                                CopyConditionals: TBlobActionConditional;
                                Metadata: TStrings = nil;
                                ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Creates a new snapshot of the specified blob.</summary>
    /// <remarks>Set Metadata to nil or an empty list unless you want the snapshot's metadata
    ///          to be that, instead of the metadata on the blob having the snapshot taken.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the blob to create a snapshot for</param>
    /// <param name="SnapshotId">The resulting Snapshot Id, if successfully created</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="Metadata">The metadata to set onto the snapshot, instead of the blob's</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns></returns>
    function SnapshotBlob(ContainerName, BlobName: string; out SnapshotId: string; const LeaseId: string = '';
                          Metadata: TStrings = nil; ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Conditionally creates a new snapshot of the specified blob.</summary>
    /// <remarks>The snapshot is only created if the conditions specified in SnapshotConditionals are met.
    ///          Only some of the conditionals of the TBlobActionConditional instance are used.
    ///          For example, none which have field names beginning with 'IfSource' are used here.
    ///          Set Metadata to nil or an empty list unless you want the snapshot's metadata
    ///          to be that, instead of the metadata on the blob having the snapshot taken.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the blob to create a snapshot for</param>
    /// <param name="SnapshotConditionals">The conditions to meet in order to create the snapshot</param>
    /// <param name="SnapshotId">The resulting Snapshot Id, if successfully created</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="Metadata">The metadata to set onto the snapshot, instead of the blob's</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns></returns>
    function SnapshotBlob(ContainerName, BlobName: string;
                          SnapshotConditionals: TBlobActionConditional;
                          out SnapshotId: string;
                          const LeaseId: string = '';
                          Metadata: TStrings = nil;
                          ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;

    /// <summary>Creates a new block to be committed as part of a blob.</summary>
    /// <remarks>A block may be up to 4 MB in size.
    ///          BlockId must be a base 64 encoded string, which was less than or equal to 64 bytes
    ///          in size before it was encoded.
    ///          For a given blob, all block IDs must be the same length.
    ///          After you have uploaded a set of blocks, you can create or update the blob
    ///          on the server from this set by calling PutBlockList. Until then, the blob does
    ///          not contain this block as part of its content.
    ///          If you call Put Block on a blob that does not yet exist, a new uncommitted
    ///          block blob is created with a content length of 0.
    ///          If you call Put Block using a BlockId of an existing uncommitted block,
    ///          the content will be replaced.
    ///          If PutBlockList isn't called within a week, all uncommitted blocks will be deleted.
    ///          After calling PutBlockList, any uncommitted blocks not included in the list
    ///          will be deleted.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the blob to upload the block for</param>
    /// <param name="BlockId">The Id to that uniquely identifies the block</param>
    /// <param name="Content">The block's content in bytes</param>
    /// <param name="ContentMD5">An optional MD5 hash of the content, for verification purposes.</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function PutBlock(ContainerName, BlobName: string; const BlockId: string; Content: TArray<Byte>;
                      const ContentMD5: string = ''; const LeaseId: string = '';
                      ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Writes content to a range with a page blob.</summary>
    /// <remarks>The StartPage is zero-indexed, and maps to the first page in a range of 1 or more pages
    ///          to create or modify the content for.
    ///          Each page is exactly 512 bytes, so when passing in the Content, the length must be
    ///          (512 * PageCount). If the content is not that long, be sure to pad with zeros.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="Content">The content to add. Must be evenly divisible by 512. Pad with zeros if needed.</param>
    /// <param name="StartPage">The zero-based index of the first page this content applies to</param>
    /// <param name="PageCount">The number of (512 byte) pages this content spans</param>
    /// <param name="ContentMD5">The optional MD5 hash of the content being sent, for verifying integrity.</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function PutPage(ContainerName, BlobName: string; Content: TArray<Byte>;
                     StartPage, PageCount: Integer;
                     const LeaseId: string = '';
                     const ContentMD5: string = '';
                     ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Writes content to a range with a page blob.</summary>
    /// <remarks>The StartPage is zero-indexed, and maps to the first page in a range of 1 or more pages
    ///          to create or modify the content for.
    ///          Each page is exactly 512 bytes, so when passing in the Content, the length must be
    ///          (512 * PageCount). If the content is not that long, be sure to pad with zeros.
    ///          Supported action conditionals include:
    ///            IfModifiedSince,
    ///            IfUnmodifiedSince,
    ///            IfMatch,
    ///            IfNoneMatch,
    ///            if-sequence-number-lte,
    ///            if-sequence-number-lt,
    ///            if-sequence-number-eq.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="Content">The content to add. Must be evenly divisible by 512. Pad with zeros if needed.</param>
    /// <param name="StartPage">The zero-based index of the first page this content applies to</param>
    /// <param name="PageCount">The number of (512 byte) pages this content spans</param>
    /// <param name="ActionConditional">Conditions that must be met for the action to be executed.</param>
    /// <param name="ContentMD5">The optional MD5 hash of the content being sent, for verifying integrity.</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function PutPage(ContainerName, BlobName: string; Content: TArray<Byte>;
                     StartPage, PageCount: Integer; ActionConditional: TBlobActionConditional;
                     const ContentMD5: string = '';
                     const LeaseId: string = '';
                     ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Writes content to a range with a page blob.</summary>
    /// <remarks>The StartPage is zero-indexed, and maps to the first page in a range of 1 or more pages
    ///          to create or modify the content for.
    ///          The number is pages is calculated dynamically based on the length of the specified content.
    ///          If the content's length isn't evenly divisible by 512, then it is padded with zeros.
    ///          Supported action conditionals include:
    ///            IfModifiedSince,
    ///            IfUnmodifiedSince,
    ///            IfMatch,
    ///            IfNoneMatch,
    ///            if-sequence-number-lte,
    ///            if-sequence-number-lt,
    ///            if-sequence-number-eq.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="Content">The content to add. Must be evenly divisible by 512. Pad with zeros if needed.</param>
    /// <param name="StartPage">The zero-based index of the first page this content applies to</param>
    /// <param name="ActionConditional">Conditions that must be met for the action to be executed.</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function PutPage(ContainerName, BlobName: string; Content: TArray<Byte>;
                     StartPage: Integer; ActionConditional: TBlobActionConditional;
                     const LeaseId: string = '';
                     ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Writes content to a range with a page blob.</summary>
    /// <remarks>The StartPage is zero-indexed, and maps to the first page in a range of 1 or more pages
    ///          to create or modify the content for.
    ///          The number is pages is calculated dynamically based on the length of the specified content.
    ///          If the content's length isn't evenly divisible by 512, then it is padded with zeros.
    ///          This must only be called on a page blob that already exists.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="Content">The content to add. Must be evenly divisible by 512. Pad with zeros if needed.</param>
    /// <param name="StartPage">The zero-based index of the first page this content applies to</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function PutPage(ContainerName, BlobName: string; Content: TArray<Byte>; StartPage: Integer;
                     const LeaseId: string = '';
                     ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Clears the specified range and releases the spaced used in storage for that range.</summary>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="StartPage">The zero-based index of the first page this action applies to</param>
    /// <param name="PageCount">The number of pages this action applies to</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function ClearPage(ContainerName, BlobName: string; StartPage, PageCount: Integer;
                       const LeaseId: string = '';
                       ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Clears the specified range and releases the spaced used in storage for that range.</summary>
    /// <remarks>Supported action conditionals include:
    ///            IfModifiedSince,
    ///            IfUnmodifiedSince,
    ///            IfMatch,
    ///            IfNoneMatch,
    ///            if-sequence-number-lte,
    ///            if-sequence-number-lt,
    ///            if-sequence-number-eq.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="StartPage">The zero-based index of the first page this action applies to</param>
    /// <param name="PageCount">The number of pages this action applies to</param>
    /// <param name="ActionConditional">Conditions that must be met for the action to be executed.</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function ClearPage(ContainerName, BlobName: string; StartPage, PageCount: Integer;
                       ActionConditional: TBlobActionConditional;
                       const LeaseId: string = '';
                       ResponseInfo: TCloudResponseInfo = nil): Boolean; overload;
    /// <summary>Specifies the list of blocks to form the blob content from.</summary>
    /// <remarks>The list of blocks is used to build the given blob's content. The blocks
    ///          can either be committed (already part of the blob's content) or uncommitted
    ///          (uploaded with PutBlock, but not yet included in a PutBlockList call.)
    ///          Once this call is made, any block not in the block list is permanently deleted.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The blob to commit the block list for</param>
    /// <param name="BlockList">The list of blocks to form the blob's content with</param>
    /// <param name="Properties">Optional list of properties to specify on the blob</param>
    /// <param name="Metadata">Optional list of metadata to specify on the blob</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ContentMD5">The optional MD5 hash of the content being sent, for verifying integrity.</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>True if successful, false otherwise</returns>
    function PutBlockList(ContainerName, BlobName: string; BlockList: TList<TAzureBlockListItem>;
                          Properties: TStrings = nil; Metadata: TStrings = nil;
                          const LeaseId: string = ''; const ContentMD5: string = '';
                          ResponseInfo: TCloudResponseInfo = nil): Boolean;
    /// <summary>Returns the block list for the given blob</summary>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the block blob to get the block list for</param>
    /// <param name="BlockType">The type of blocks to get. Either committed, uncommitted, or both</param>
    /// <param name="SnapShot">The snapshot Id if you want the list of a snapshot instead of the blob</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the block list</returns>
    function GetBlockListXML(ContainerName, BlobName: string;
                             BlockType: TAzureQueryIncludeBlockType = aqbtCommitted;
                             const SnapShot: string = ''; const LeaseId: string = '';
                             ResponseInfo: TCloudResponseInfo = nil): string;
    /// <summary>Returns the block list for the given blob</summary>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the block blob to get the block list for</param>
    /// <param name="BlockType">The type of blocks to get. Either committed, uncommitted, or both</param>
    /// <param name="SnapShot">The snapshot Id if you want the list of a snapshot instead of the blob</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of blocks for the given blob or snapshot</returns>
    function GetBlockList(ContainerName, BlobName: string;
                          BlockType: TAzureQueryIncludeBlockType = aqbtCommitted;
                          const SnapShot: string = ''; const LeaseId: string = '';
                          ResponseInfo: TCloudResponseInfo = nil): TList<TAzureBlockListItem>;
    /// <summary>Returns the page regions for the given page blob.</summary>
    /// <remarks>This takes in a range. If the bytes are set to zero the whole page blob will
    ///          be analyzed, otherwise only the given range will be analyzed.
    ///          What is returns is a list of valid page ranges (start byte / end byte pairs).
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="StartByte">The start byte in the range to check for valid pages.</param>
    /// <param name="EndByte">The end byte in the range to check for valid pages.</param>
    /// <param name="Snapshot">The optional snapshot Id if you want to check one of the blob's snapshots</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the returned valid page ranges</returns>
    function GetPageRegionsXML(ContainerName, BlobName: string; StartByte, EndByte: Int64;
                               const Snapshot: string = ''; const LeaseId: string = '';
                               ResponseInfo: TCloudResponseInfo = nil): string; overload;
    /// <summary>Returns the page regions for the given page blob.</summary>
    /// <remarks>What is returns is a list of valid page ranges (start byte / end byte pairs).
    ///          Same as calling the version of GetPageRegionsXML with a Range, where the StartByte
    ///          and EndByte of the Range are set to zero.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="Snapshot">The optional snapshot Id if you want to check one of the blob's snapshots</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The XML representation of the returned valid page ranges</returns>
    function GetPageRegionsXML(ContainerName, BlobName: string;
                               const Snapshot: string = ''; const LeaseId: string = '';
                               ResponseInfo: TCloudResponseInfo = nil): string; overload;
    /// <summary>Returns the page regions for the given page blob.</summary>
    /// <remarks>This takes in a range. If the bytes are set to zero the whole page blob will
    ///          be analyzed, otherwise only the given range will be analyzed.
    ///          What is returns is a list of valid page ranges (start byte / end byte pairs).
    ///
    ///          x-ms-blob-content-length is the name of one of the header values returned,
    ///          which can be read using the ResponseInfo parameter.
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="StartByte">The start byte in the range to check for valid pages.</param>
    /// <param name="EndByte">The end byte in the range to check for valid pages.</param>
    /// <param name="Snapshot">The optional snapshot Id if you want to check one of the blob's snapshots</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of valid page ranges</returns>
    function GetPageRegions(ContainerName, BlobName: string; StartByte, EndByte: Int64;
                            const Snapshot: string = ''; const LeaseId: string = '';
                            ResponseInfo: TCloudResponseInfo = nil): TList<TAzureBlobPageRange>; overload;
    /// <summary>Returns the page regions for the given page blob.</summary>
    /// <remarks>The whole page blob will be analyzed.
    ///          What is returns is a list of valid page ranges (start byte / end byte pairs).
    /// </remarks>
    /// <param name="ContainerName">The name of the container the blob is in.</param>
    /// <param name="BlobName">The name of the page blob</param>
    /// <param name="Snapshot">The optional snapshot Id if you want to check one of the blob's snapshots</param>
    /// <param name="LeaseId">The lease Id, required if the blob is locked</param>
    /// <param name="ResponseInfo">The optional class for storing response info into</param>
    /// <returns>The list of valid page ranges</returns>
    function GetPageRegions(ContainerName, BlobName: string;
                            const Snapshot: string = ''; const LeaseId: string = '';
                            ResponseInfo: TCloudResponseInfo = nil): TList<TAzureBlobPageRange>; overload;
  end;

const
  /// <summary>The root container's name for the blob service.</summary>
  ROOT_CONTAINER = '$root';

implementation

uses System.DateUtils, System.StrUtils, Xml.XMLDoc;

const
  NODE_TABLE = 'entry';
  NODE_TABLE_CONTENT = 'content';
  NODE_PROPERTIES = 'm:properties';
  NODE_TABLE_NAME = 'd:TableName';
  NODE_QUEUES = 'Queues';
  NODE_QUEUE = 'Queue';
  NODE_QUEUE_NAME = 'Name';
  NODE_QUEUE_URL = 'Url';

  DT_XML_PREFIX = 'Edm.';
  DT_BINARY = 'Binary';
  DT_BOOLEAN = 'Boolean';
  DT_DATETIME = 'DateTime';
  DT_DOUBLE = 'Double';
  DT_GUID = 'Guid';
  DT_INT32 = 'Int32';
  DT_INT64 = 'Int64';
  DT_STRING = 'String';

function GetRowFromContentNode(ContentNode: IXMLNode): TCloudTableRow;
var
  PropertiesNode, PropertyNode: IXMLNode;
  PropName: string;
  Aux: Integer;
  Column: TCloudTableColumn;
begin
  if (ContentNode = nil) or (ContentNode.NodeName <> NODE_TABLE_CONTENT) then
    Exit(nil);

  Result := nil;

  if (ContentNode.HasChildNodes) then
  begin
    PropertiesNode := GetFirstMatchingChildNode(ContentNode, NODE_PROPERTIES);

    if (PropertiesNode <> nil) and (PropertiesNode.HasChildNodes) then
    begin
      PropertyNode := PropertiesNode.ChildNodes.First;
      Result := TCloudTableRow.Create;

      while PropertyNode <> nil do
      begin
        try
          PropName := PropertyNode.NodeName;
          Aux := AnsiPos(':', PropName);
          if Aux > 0 then
            PropName := PropName.Substring(Aux);

          Column := TCloudTableColumn.Create;
          Column.Name := PropName;
          Column.Value := PropertyNode.Text;

          if PropertyNode.HasAttribute('m:type') then
            Column.DataType := PropertyNode.Attributes['m:type'];

          Result.Columns.Add(Column);
        except
          break;
        end;
        PropertyNode := PropertyNode.NextSibling;
      end;
    end;
  end;
end;

{ TAzureConnectionInfo }

constructor TAzureConnectionInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FUseDevelopmentStorage := false;
  FUseDefaultEndpoints := true;
  FProtocol := 'http';
end;

function TAzureConnectionInfo.GetAccountKey: string;
begin
  if FUseDevelopmentStorage then
    Exit('Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==');

  Exit(FAccountKey);
end;

function TAzureConnectionInfo.GetAccountName: string;
begin
  if FUseDevelopmentStorage then
    Exit('devstoreaccount1');

  Exit(FAccountName);
end;

function TAzureConnectionInfo.GetBlobEndpoint: string;
begin
  if UseDefaultEndpoints and (not UseDevelopmentStorage) then
    Exit(Format('%s.%s.core.windows.net', [AccountName, 'blob']));

  Exit(FBlobEndpoint);
end;

function TAzureConnectionInfo.GetQueueEndpoint: string;
begin
  if UseDefaultEndpoints and (not UseDevelopmentStorage) then
    Exit(Format('%s.%s.core.windows.net', [AccountName, 'queue']));

  Exit(FQueueEndpoint);
end;

function TAzureConnectionInfo.GetTableEndpoint: string;
begin
  if UseDefaultEndpoints and (not UseDevelopmentStorage) then
    Exit(Format('%s.%s.core.windows.net', [AccountName, 'table']));

  Exit(FTableEndpoint);
end;

function TAzureConnectionInfo.BlobURL: string;
begin
  Result := ServiceURL('blob', BlobEndpoint);
end;

function TAzureConnectionInfo.TableURL: string;
begin
  Result := ServiceURL('table', TableEndpoint);
end;

function TAzureConnectionInfo.QueueURL: string;
begin
  Result := ServiceURL('queue', QueueEndpoint);
end;

function TAzureConnectionInfo.ServiceURL(const ServiceType, ServiceEndpoint: string): string;
var
  url: string;
begin
  if UseDevelopmentStorage then
    url := '127.0.0.1:10001/devstoreaccount1'
  else if UseDefaultEndpoints then
    url := Format('%s.%s.core.windows.net', [AccountName, ServiceType])
  else
    url := ServiceEndpoint;
  Result := Format('%s://%s', [Protocol, url]);
end;

procedure TAzureConnectionInfo.SetUseDevelopmentStorage(use: Boolean);
begin
  FUseDevelopmentStorage := use;
end;


{ TAzureAuthentication }

procedure TAzureAuthentication.AssignKey(const AccountKey: string);
begin
  FSHAKey := DecodeBytes64(FConnectionInfo.AccountKey);
end;

constructor TAzureAuthentication.Create(ConnectionInfo: TAzureConnectionInfo);
begin
  inherited Create(ConnectionInfo, 'SharedKey'); {do not localize}
end;

{ TAzureService }

constructor TAzureService.Create(ConnectionInfo: TAzureConnectionInfo);
begin
  inherited Create(ConnectionInfo, TAzureAuthentication.Create(ConnectionInfo));

  FRequiredHeaderNames := nil;

  //characters to use when building the query parameter part of the
  //CanonicalizedResource part of the 'stringToSign'
  FQueryStartChar := #10;
  FQueryParamKeyValueSeparator := ':';
  FQueryParamSeparator := #10;
end;

destructor TAzureService.Destroy;
begin
  FreeAndNil(FRequiredHeaderNames);
  inherited;
end;

function TAzureService.GetCanonicalizedHeaderPrefix: string;
begin
  Result := 'x-ms-'; {do not localize}
end;

function TAzureService.GetConnectionInfo: TAzureConnectionInfo;
begin
  Result := TAzureConnectionInfo(FConnectionInfo);
end;

function TAzureService.GetRequiredHeaderNames(out InstanceOwner: Boolean): TStrings;
begin
  InstanceOwner := False;
  //Required headers shared by Queue and Blob service. These go into the 'String To Sign' as just values
  if FRequiredHeaderNames = nil then
  begin
    //http://msdn.microsoft.com/en-us/library/dd179428.aspx
    FRequiredHeaderNames := TStringList.Create;
    if GetConnectionInfo.UseDevelopmentStorage then
    begin
      FRequiredHeaderNames.Add('content-md5');
      FRequiredHeaderNames.Add('content-type');
      FRequiredHeaderNames.Add('date');
    end
    else
    begin
      FRequiredHeaderNames.Add('content-encoding');
      FRequiredHeaderNames.Add('content-language');
      FRequiredHeaderNames.Add('content-length');
      FRequiredHeaderNames.Add('content-md5');
      FRequiredHeaderNames.Add('content-type');
      FRequiredHeaderNames.Add('date');
      FRequiredHeaderNames.Add('if-modified-since');
      FRequiredHeaderNames.Add('if-match');
      FRequiredHeaderNames.Add('if-none-match');
      FRequiredHeaderNames.Add('if-unmodified-since');
      FRequiredHeaderNames.Add('range');
    end;
  end;
  Result := FRequiredHeaderNames;
end;

procedure TAzureService.PopulateDateHeader(Headers: TStrings; AddRegularDateHeader: Boolean);
var
  msDate: string;
begin
  if Headers <> nil then
  begin
    msDate := XMsDate;
    if AddRegularDateHeader then
      Headers.Values['date'] := msDate;
    Headers.Values['x-ms-date'] := msDate;
  end;
end;

procedure TAzureService.URLEncodeQueryParams(const ForURL: Boolean; var ParamName, ParamValue: string);
begin
  if ForURL then
    inherited;
end;

function TAzureService.XMsDate: string;
begin
  Result := FormatDateTime('ddd, dd mmm yyyy hh:nn:ss "GMT"',
                           TTimeZone.Local.ToUniversalTime(Now),
                           TFormatSettings.Create('en-US'));
end;

{ TAzureTableService }

procedure TAzureTableService.AddTableVersionHeaders(Headers: TStrings);
begin
  if Headers <> nil then
  begin
    Headers.Values['x-ms-version'] := '2009-09-19';
    Headers.Values['DataServiceVersion'] := '1.0;NetFx';
    Headers.Values['MaxDataServiceVersion'] := '1.0;NetFx';
  end;
end;

constructor TAzureTableService.Create(ConnectionInfo: TAzureConnectionInfo);
begin
  inherited Create(ConnectionInfo);

  FUseCanonicalizedHeaders := False;
end;

function TAzureTableService.GetInsertEntityXML(Entity: TCloudTableRow): string;
var
  I, Count: Integer;
  Col: TCloudTableColumn;
begin
  Result :=
        string.Format('<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
                  '<entry xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" ' +
                         'xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" ' +
                         'xmlns="http://www.w3.org/2005/Atom">' +
                    '<title />' +
                    '<updated>%s</updated>' +
                    '<author><name /></author>' +
                    '<id />' +
                    '<content type="application/xml">' +
                        '<m:properties>',
                  [XMLEscape(UpdatedDate)]);

  Count := Entity.Columns.Count;
  for I := 0 to Count - 1 do
  begin
    Col := Entity.Columns[I];
    if (Col.DataType.Length > 0) then
      Result := Result + string.Format('<d:%s m:type="%s">%s</d:%s>',
                                [Col.Name, Col.DataType, XMLEscape(Col.Value), Col.Name])
    else
      Result := Result + string.Format('<d:%s>%s</d:%s>', [Col.Name, XMLEscape(Col.Value), Col.Name]);
  end;

  Result := Result + '</m:properties></content></entry>';
end;

function TAzureTableService.GetRequiredHeaderNames(out InstanceOwner: Boolean): TStrings;
begin
  InstanceOwner := False;
  if FRequiredHeaderNames = nil then
  begin
    //http://msdn.microsoft.com/en-us/library/dd179428.aspx
    FRequiredHeaderNames := TStringList.Create;
    FRequiredHeaderNames.Add('content-md5');
    FRequiredHeaderNames.Add('content-type');
    FRequiredHeaderNames.Add('date');
  end;
  Result := FRequiredHeaderNames;
end;

function TAzureTableService.GetTablesQueryPrefix(Headers: TStrings; TableName: string): string;
begin
  if GetConnectionInfo.UseDevelopmentStorage then
    Result := Format('/%s/%s/%s', [GetConnectionInfo.AccountName, GetConnectionInfo.AccountName, TableName])
  else
  begin
    AddTableVersionHeaders(Headers);
    Result := Format('/%s/%s', [GetConnectionInfo.AccountName, TableName]);
  end;
end;

function TAzureTableService.InsertEntity(const TableName: string; Entity: TCloudTableRow;
                                         ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  InputStream : TBytesStream;
  FreeResponseInfo: Boolean;
  xml: string;
begin
  url := Format('%s/%s', [GetConnectionInfo.TableURL, TableName]);

  if (Entity = nil) or (URL = EmptyStr) then
    Exit(False);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers);
  Headers.Values['Content-Type'] := 'application/atom+xml';

  QueryPrefix := GetTablesQueryPrefix(Headers, TableName);

  xml := GetInsertEntityXML(Entity);

  FreeResponseInfo := ResponseInfo = nil;
  if FreeResponseInfo then
    ResponseInfo := TCloudResponseInfo.Create;

  Response := nil;
  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  try
    try
      Response := IssuePostRequest(url, Headers, nil, QueryPrefix, ResponseInfo, InputStream);
      Result := ResponseInfo.StatusCode = 201;
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    InputStream.Free;
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureTableService.MergeEntity(const TableName: string; Entity: TCloudTableRow;
                                        ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  InputStream : TBytesStream;
  FreeResponseInfo: Boolean;
  xml: string;
begin
  if not ModifyEntityHelper(TableName, Entity, url, QueryPrefix, Headers) then
    Exit(False);

  xml := GetInsertEntityXML(Entity);

  FreeResponseInfo := False;
  if ResponseInfo = nil then
  begin
    FreeResponseInfo := True;
    ResponseInfo := TCloudResponseInfo.Create;
  end;

  Response := nil;
  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  try
    try
      Response := IssueMergeRequest(url, Headers, nil, QueryPrefix, ResponseInfo, InputStream);
      Result := ResponseInfo.StatusCode = 204;
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    InputStream.Free;
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureTableService.ModifyEntityHelper(const TableName: string; const Entity: TCloudTableRow;
                                               out url, QueryPrefix: string;
                                               out Headers: TStringList): Boolean;
var
  partitionKey, rowKey: string;
begin
  if Entity = nil then
    Exit(False);

  if not (Entity.GetColumnValue('PartitionKey', partitionKey) and
          Entity.GetColumnValue('RowKey', rowKey)) then
    Exit(False);

  Result := True;

  url := Format('%s/%s(PartitionKey=''%s'',RowKey=''%s'')',
                [GetConnectionInfo.TableURL, TableName, partitionKey, rowKey]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers);
  Headers.Values['Content-Type'] := 'application/atom+xml';
  Headers.Values['If-Match'] := '*';

  QueryPrefix := GetTablesQueryPrefix(Headers, TableName);
  QueryPrefix := Format('%s(PartitionKey=''%s'',RowKey=''%s'')', [QueryPrefix, partitionKey, rowKey]);
end;

function TAzureTableService.UpdateEntity(const TableName: string; Entity: TCloudTableRow;
                                         ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  InputStream : TBytesStream;
  FreeResponseInfo: Boolean;
  xml: string;
begin
  if not ModifyEntityHelper(TableName, Entity, url, QueryPrefix, Headers) then
    Exit(False);

  xml := GetInsertEntityXML(Entity);

  FreeResponseInfo := False;
  if ResponseInfo = nil then
  begin
    FreeResponseInfo := True;
    ResponseInfo := TCloudResponseInfo.Create;
  end;

  Response := nil;
  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  try
    try
      Response := IssuePutRequest(url, Headers, nil, QueryPrefix, ResponseInfo, InputStream);
      Result := ResponseInfo.StatusCode = 204;
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    InputStream.Free;
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureTableService.DeleteEntity(const TableName: string; const Entity: TCloudTableRow;
                                         ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
begin
  if not ModifyEntityHelper(TableName, Entity, url, QueryPrefix, Headers) then
    Exit(False);

  Response := nil;
  try
    try
      Response := IssueDeleteRequest(url, Headers, nil, QueryPrefix, ResponseInfo);
      Result := (Response <> nil) and (Response.ResponseCode = 204);
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

function TAzureTableService.CreateTable(const TableName: string;
                                        ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  InputStream : TBytesStream;
  xml: string;
  FreeResponseInfo: Boolean;
begin
  url := Format('%s/%s', [GetConnectionInfo.TableURL, 'Tables']);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers);

  Headers.Values['Content-Type'] := 'application/atom+xml';

  QueryPrefix := GetTablesQueryPrefix(Headers);

  xml := Format('<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
                  '<entry xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" ' +
                         'xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" ' +
                         'xmlns="http://www.w3.org/2005/Atom">' +
                    '<title />' +
                    '<updated>%s</updated>' +
                    '<author>' +
                      '<name />' +
                    '</author>' +
                    '<content type="application/xml">' +
                        '<m:properties>' +
                          '<d:TableName>%s</d:TableName>' +
                        '</m:properties>' +
                    '</content>' +
                  '</entry>',
                  [XMLEscape(UpdatedDate), XMLEscape(TableName)]);

  FreeResponseInfo := False;
  if ResponseInfo = nil then
  begin
    FreeResponseInfo := True;
    ResponseInfo := TCloudResponseInfo.Create;
  end;

  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));

  Response := nil;
  try
    try
      Response := IssuePostRequest(url, Headers, nil, QueryPrefix, ResponseInfo, InputStream);
      Result := ResponseInfo.StatusCode = 201;
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    InputStream.Free;
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureTableService.DeleteTable(const TableName: string; ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
begin
  url := Format('%s/Tables(''%s'')', [GetConnectionInfo.TableURL, TableName]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers);

  Headers.Values['Content-Type'] := 'application/atom+xml';

  QueryPrefix := GetTablesQueryPrefix(Headers);
  QueryPrefix := Format('%s(''%s'')', [QueryPrefix, TableName]);

  FreeResponseInfo := False;
  if ResponseInfo = nil then
  begin
    FreeResponseInfo := True;
    ResponseInfo := TCloudResponseInfo.Create;
  end;

  Response := nil;
  try
    try
      Response := IssueDeleteRequest(url, Headers, nil, QueryPrefix, ResponseInfo);
      Result := ResponseInfo.StatusCode = 204;
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureTableService.QueryTablesXML(const ContinuationToken: string; ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
begin
  url := Format('%s/%s', [GetConnectionInfo.TableURL, 'Tables']);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers);

  if ContinuationToken <> EmptyStr then
    url := url + Format('?NextTableName=%s', [URLEncode(ContinuationToken)]);

  QueryPrefix := GetTablesQueryPrefix(Headers);

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, nil, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

function TAzureTableService.UpdatedDate: string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', TTimeZone.Local.ToUniversalTime(Now));
end;

function TAzureTableService.QueryTables(const ContinuationToken: string; ResponseInfo: TCloudResponseInfo): TStrings;
var
  xml: string;
  xmlDoc: IXMLDocument;
  TableNode: IXMLNode;
  ContentNode: IXMLNode;
  PropertiesNode: IXMLNode;
  TableNameNode: IXMLNode;
begin
  xml := QueryTablesXML(ContinuationToken, ResponseInfo);

  Result := TStringList.Create;

  if xml <> EmptyStr then
  begin
    xmlDoc := TXMLDocument.Create(nil);

    try
      xmlDoc.LoadFromXML(xml);
    except
      Exit(Result);
    end;

    TableNode := xmlDoc.DocumentElement.ChildNodes.FindNode(NODE_TABLE);

    while (TableNode <> nil) and (TableNode.HasChildNodes) do
    begin
      if (TableNode.NodeName = NODE_TABLE) then
      begin
        ContentNode := TableNode.ChildNodes.FindNode(NODE_TABLE_CONTENT);

        if (ContentNode <> nil) and (ContentNode.HasChildNodes) then
        begin
          PropertiesNode := GetFirstMatchingChildNode(ContentNode, NODE_PROPERTIES);

          if (PropertiesNode <> nil) and (PropertiesNode.HasChildNodes) then
          begin
            TableNameNode := GetFirstMatchingChildNode(PropertiesNode, NODE_TABLE_NAME);
            Result.Add(TableNameNode.Text);
          end;
        end;
      end;
      TableNode := TableNode.NextSibling;
    end;
  end;
end;

function TAzureTableService.QueryEntityXML(const TableName, PartitionKey, RowKey: string;
                                             ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
begin
  url := Format('%s/%s(PartitionKey=''%s'',RowKey=''%s'')',
                [GetConnectionInfo.TableURL, TableName, PartitionKey, RowKey]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers);

  if GetConnectionInfo.UseDevelopmentStorage then
    QueryPrefix := Format('/%s/%s/%s(PartitionKey=''%s'',RowKey=''%s'')',
          [GetConnectionInfo.AccountName, GetConnectionInfo.AccountName,  TableName, PartitionKey, RowKey])
  else
  begin
    AddTableVersionHeaders(Headers);
    QueryPrefix := Format('/%s/%s(PartitionKey=''%s'',RowKey=''%s'')',
                          [GetConnectionInfo.AccountName, TableName, PartitionKey, RowKey]);
  end;

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, nil, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

function TAzureTableService.QueryEntitiesXML(const TableName, FilterExpression: string;
                                             ResponseInfo: TCloudResponseInfo;
                                             const NextPartitionKey, NextRowKey: string): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  url := Format('%s/%s()', [GetConnectionInfo.TableURL, TableName]);

  QueryParams := nil;
  if (NextPartitionKey <> EmptyStr) or (NextRowKey <> EmptyStr) then
  begin
    QueryParams := TStringList.Create;
    QueryParams.Values['NextPartitionKey'] := NextPartitionKey;
    QueryParams.Values['NextRowKey'] := NextRowKey;

    url := BuildQueryParameterString(url, QueryParams, False, True);
  end;

  if FilterExpression <> EmptyStr then
  begin
    if QueryParams = nil then
      QueryParams := TStringList.Create;
    QueryParams.Values['$filter'] :=  FilterExpression;
  end;

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers);

  QueryPrefix := GetTablesQueryPrefix(Headers, TableName) + '()';

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, nil, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

function TAzureTableService.BuildRowList(const XML: string; const FromQuery: Boolean): TList<TCloudTableRow>;
var
  xmlDoc: IXMLDocument;
  TableNode: IXMLNode;
  ContentNode: IXMLNode;
  Row: TCloudTableRow;
begin
  Result := TList<TCloudTableRow>.Create;

  if XML = EmptyStr then
    Exit;

  xmlDoc := TXMLDocument.Create(nil);
  xmlDoc.LoadFromXML(XML);

   //If it isn't from a query, then they specified PartitionKey and RowKey, so the root node represents the result
   //instead of having multiple child 'entry' nodes.
  if FromQuery then
    TableNode := xmlDoc.DocumentElement.ChildNodes.FindNode(NODE_TABLE)
  else if AnsiCompareText(xmlDoc.DocumentElement.NodeName, NODE_TABLE) = 0 then
    TableNode := xmlDoc.DocumentElement;

  while (TableNode <> nil) and (TableNode.HasChildNodes) do
  begin
    if (TableNode.NodeName = NODE_TABLE) then
    begin
      ContentNode := TableNode.ChildNodes.FindNode(NODE_TABLE_CONTENT);

      Row := GetRowFromContentNode(ContentNode);
      if Row <> nil then
        Result.Add(Row);
    end;

    //If it isn't from a query, then they specified PartitionKey and RowKey, so there is only one result
    if FromQuery then
      TableNode := TableNode.NextSibling
    else
      Break;
  end;
end;

function TAzureTableService.QueryEntity(const TableName, PartitionKey, RowKey: string;
                                          ResponseInfo: TCloudResponseInfo): TCloudTableRow;
var
  LResultList: TList<TCloudTableRow>;
  I, Count: Integer;
begin
  LResultList := BuildRowList(QueryEntityXML(TableName, PartitionKey, RowKey, ResponseInfo), False);

  try
    Count := LResultList.Count;
    if (LResultList = nil) or (Count = 0) then
      Exit(nil);

    //set the first row as the result.
    Result := LResultList[0];

    //there should never be a case where more than one row was returned, but
    //handle that possibility anyway, by freeing any other rows returned.
    if Count > 1 then
      for I := 1 to Count - 1 do
        LResultList[I].DisposeOf;
  finally
    FreeAndNil(LResultList);
  end;
end;

function TAzureTableService.QueryEntities(const TableName, FilterExpression: string;
                                          ResponseInfo: TCloudResponseInfo;
                                          const NextPartitionKey, NextRowKey: string): TList<TCloudTableRow>;
begin
  Result := BuildRowList(QueryEntitiesXML(TableName, FilterExpression, ResponseInfo,
                                         NextPartitionKey, NextRowKey), True);
end;

{ TAzureQueueService }

function TAzureQueueService.ListQueuesXML(OptionalParams: TStrings;
                                          ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  QueryParams: TStringList;
begin
  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryParams := nil;

  if GetConnectionInfo.UseDevelopmentStorage then
    QueryPrefix := Format('/%s/%s?%s', [GetConnectionInfo.AccountName, GetConnectionInfo.AccountName, 'comp=list'])
  else
  begin
    Headers.Values['x-ms-version'] := '2009-09-19';
    QueryPrefix := Format('/%s/', [GetConnectionInfo.AccountName]);
    QueryParams := TStringList.Create;
    QueryParams.Values['comp'] := 'list';
    if OptionalParams <> nil then
      QueryParams.AddStrings(OptionalParams);
  end;

  url := BuildQueryParameterString(GetConnectionInfo.QueueURL, QueryParams, False, True);

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureQueueService.GetQueuesQueryPrefix(Headers: TStrings; QueueName: string): string;
begin
  if GetConnectionInfo.UseDevelopmentStorage then
    Result := Format('/%s/%s/%s', [GetConnectionInfo.AccountName, GetConnectionInfo.AccountName, QueueName])
  else
  begin
    Headers.Values['x-ms-version'] := '2009-09-19';
    Result := Format('/%s/%s', [GetConnectionInfo.AccountName, QueueName]);
  end;
end;

function TAzureQueueService.ListQueues(OptionalParams: TStrings;
                                       ResponseInfo: TCloudResponseInfo): TList<TCloudQueue>;
var
  xml: string;
  xmlDoc: IXMLDocument;
  QueuesXMLNode: IXMLNode;
  QueueNode: IXMLNode;
  NameNode, UrlNode: IXMLNode;
begin
  xml := ListQueuesXML(OptionalParams, ResponseInfo);

  if XML = EmptyStr then
    Exit(nil);

  Result := TList<TCloudQueue>.Create;

  xmlDoc := TXMLDocument.Create(nil);
  xmlDoc.LoadFromXML(XML);

  QueuesXMLNode := xmlDoc.DocumentElement.ChildNodes.FindNode(NODE_QUEUES);

  if (QueuesXMLNode <> nil) and (QueuesXMLNode.HasChildNodes) then
  begin
    QueueNode := QueuesXMLNode.ChildNodes.FindNode(NODE_QUEUE);

    while (QueueNode <> nil) do
    begin
      if QueueNode.NodeName = NODE_QUEUE then
      begin
        NameNode := QueueNode.ChildNodes.FindNode(NODE_QUEUE_NAME);
        UrlNode := QueueNode.ChildNodes.FindNode(NODE_QUEUE_URL);
        if (NameNode <> nil) and (UrlNode <> nil) then
          Result.Add(TCloudQueue.Create(NameNode.Text, UrlNode.Text));
      end;
      QueueNode := QueueNode.NextSibling;
    end;
  end;
end;

function TAzureQueueService.CreateQueue(const QueueName: string; const MetaDataHeaders: TStrings;
                                        ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
begin
  url := Format('%s/%s', [GetConnectionInfo.QueueURL, QueueName]);
  Headers := TStringList.Create;

  if MetaDataHeaders <> nil then
    Headers.AddStrings(MetaDataHeaders);

  PopulateDateHeader(Headers, False);
  Headers.Values['Content-Length'] := '0';

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName);

  FreeResponseInfo := ResponseInfo = nil;
  if FreeResponseInfo then
    ResponseInfo := TCloudResponseInfo.Create;

  Response := nil;
  try
    try
      Response := IssuePutRequest(url, Headers, nil, QueryPrefix, ResponseInfo);
      Result := ResponseInfo.StatusCode = 201;
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureQueueService.DeleteQueue(const QueueName: string; ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
begin
  url := Format('%s/%s', [GetConnectionInfo.QueueURL, QueueName]);
  Headers := TStringList.Create;

  PopulateDateHeader(Headers, False);

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName);

  Response := nil;
  try
    try
      Response := IssueDeleteRequest(url, Headers, nil, QueryPrefix, ResponseInfo);
      Result := (Response <> nil) and (Response.ResponseCode = 204);
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

function TAzureQueueService.GetMaxMessageReturnCount: Integer;
begin
  Result := 32;
end;

function TAzureQueueService.GetQueueMetadata(const QueueName: string; out MetaData: TStrings;
                                             ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
  QueryParams: TStringList;
  I, Count: Integer;
begin
  QueryParams := nil;
  MetaData := nil;

  url := Format('%s/%s', [GetConnectionInfo.QueueURL, QueueName]);

  Headers := TStringList.Create;

  PopulateDateHeader(Headers, False);

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName);
  if GetConnectionInfo.UseDevelopmentStorage then
    QueryPrefix := Format('%s?%s', [QueryPrefix, 'comp=metadata'])
  else
  begin
    QueryParams := TStringList.Create;
    QueryParams.Values['comp'] := 'metadata';
    url := BuildQueryParameterString(url, QueryParams, False, True);
  end;

  FreeResponseInfo := ResponseInfo = nil;
  if FreeResponseInfo then
    ResponseInfo := TCloudResponseInfo.Create;

  Response := nil;
  try
    try
      Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
      Result := ResponseInfo.StatusCode = 200;
      if Result then
      begin
        MetaData := TStringList.Create;
        Count := ResponseInfo.Headers.Count;
        for I := 0 to Count - 1 do
        begin
          if AnsiContainsText(ResponseInfo.Headers.Names[I], 'x-ms-')then
          begin
            MetaData.Add(ResponseInfo.Headers[I]);
          end;
        end;
      end;
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureQueueService.SetQueueMetadata(const QueueName: string; const MetaData: TStrings;
                                             ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  QueryParams: TStringList;
  I, Count: Integer;
  MetaName: string;
begin
  QueryParams := nil;

  url := Format('%s/%s', [GetConnectionInfo.QueueURL, QueueName]);

  Headers := TStringList.Create;
  if MetaData <> nil then
  begin
    Count := MetaData.Count;
    for I := 0 to Count - 1 do
    begin
      MetaName := MetaData.Names[I];
      if not AnsiStartsText('x-ms-meta-', MetaName) then
        MetaName := 'x-ms-meta-' + MetaName;
      Headers.Values[MetaName] := MetaData.ValueFromIndex[I]; 
    end;
  end;

  PopulateDateHeader(Headers, False);
  Headers.Values['Content-Length'] := '0';

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName);
  if GetConnectionInfo.UseDevelopmentStorage then
    QueryPrefix := Format('%s?%s', [QueryPrefix, 'comp=metadata'])
  else
  begin
    QueryParams := TStringList.Create;
    QueryParams.Values['comp'] := 'metadata';
    url := BuildQueryParameterString(url, QueryParams, False, True);
  end;

  Response := nil;
  try
    try
      Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
      Result := (Response <> nil) and (Response.ResponseCode = 204);
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureQueueService.AddMessage(const QueueName, MessageText: string; const TimeToLive: Integer;
                                       ResponseInfo: TCloudResponseInfo): Boolean;
var
  strContent: string;
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  QueryParams: TStringList;
  reqStream: TBytesStream;
begin
  strContent := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
    '<QueueMessage><MessageText>' + XMLEscape(MessageText) + '</MessageText></QueueMessage>';

  url := Format('%s/%s/messages', [GetConnectionInfo.QueueURL, QueueName]);

  QueryParams := nil;
  if TimeToLive > 0 then
  begin
    QueryParams := TStringList.Create;
    QueryParams.Values['messagettl'] := IntToStr(TimeToLive);
    url := BuildQueryParameterString(url, QueryParams, False, True);
  end;

  reqStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(strContent));

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);
  Headers.Values['Content-Length'] := IntToStr(reqStream.Size);

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName) + '/messages';

  if GetConnectionInfo.UseDevelopmentStorage then
  begin
    QueryPrefix := QueryPrefix + BuildQueryParameterString(EmptyStr, QueryParams, False, True);
    //don't want to use the query params in the call to IssueGetRequest, since they are used now
    FreeAndNil(QueryParams);
  end;

  Response := nil;
  try
    try
      Response := IssuePostRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, reqStream);
      Result := (Response <> nil) and (Response.ResponseCode = 201);
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(reqStream);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureQueueService.GetOrPeekMessagesXML(const QueueName: string; PeekOnly: Boolean; NumOfMessages,
                                                VisibilityTimeout: Integer;
                                                ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  QueryParams: TStringList;
begin
  url := Format('%s/%s/messages', [GetConnectionInfo.QueueURL, QueueName]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryParams := nil;
  if (NumOfMessages > 0) or ((not PeekOnly) and (VisibilityTimeout > 0)) or PeekOnly then
  begin
    QueryParams := TStringList.Create;
    if NumOfMessages > 0 then
      QueryParams.Values['numofmessages'] := IntToStr(NumOfMessages);
    if (not PeekOnly) and (VisibilityTimeout > 0) then
      QueryParams.Values['visibilitytimeout'] := IntToStr(VisibilityTimeout);
    if PeekOnly then
      QueryParams.Values['peekonly'] := 'true';
    url := BuildQueryParameterString(url, QueryParams, False, True);
  end;

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName) + '/messages';

  if GetConnectionInfo.UseDevelopmentStorage then
  begin
    QueryPrefix := QueryPrefix + BuildQueryParameterString(EmptyStr, QueryParams, False, True);
    //don't want to use the query params in the call to IssueGetRequest, since they are used now
    FreeAndNil(QueryParams);
  end;

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    FreeAndNil(QueryParams);
  end;
end;

function TAzureQueueService.GetMessagesXML(const QueueName: string; NumOfMessages, VisibilityTimeout: Integer;
                                           ResponseInfo: TCloudResponseInfo): string;
begin
  Result := GetOrPeekMessagesXML(QueueName, False, NumOfMessages, VisibilityTimeout, ResponseInfo);
end;

function TAzureQueueService.GetMessages(const QueueName: string; NumOfMessages, VisibilityTimeout: Integer;
                                        ResponseInfo: TCloudResponseInfo): TList<TCloudQueueMessage>;
var
  xml: string;
begin
  xml := GetMessagesXML(QueueName, NumOfMessages, VisibilityTimeout, ResponseInfo);
  Result := GetMessagesFromXML(xml);
end;

function TAzureQueueService.GetMessagesFromXML(const xml: string): TList<TCloudQueueMessage>;
var
  xmlDoc: IXMLDocument;
  RootNode: IXMLNode;
  MessageNode, ChildNode: IXMLNode;
  MsgId, MsgText, PopReceipt: string;
  Msg: TCloudQueueMessage;
  MsgProps: TStrings;
begin
  Result := nil;

  if xml <> EmptyStr then
  begin
    Result := TList<TCloudQueueMessage>.Create;

    xmlDoc := TXMLDocument.Create(nil);
    xmlDoc.LoadFromXML(xml);
    RootNode := xmlDoc.DocumentElement;

    if (RootNode <> nil) and (RootNode.HasChildNodes) then
    begin
      MessageNode := RootNode.ChildNodes.FindNode('QueueMessage');

      while (MessageNode <> nil) do
      begin
        MsgProps := nil;

        //making sure to only add the message if MessageId and MessageText are both found
        if (MessageNode.NodeName = 'QueueMessage') and MessageNode.HasChildNodes then
        begin
          ChildNode := MessageNode.ChildNodes.First;

          MsgProps := TStringList.Create;

          while (ChildNode <> nil) do
          begin
            if AnsiSameText('MessageId' , ChildNode.NodeName) then
              MsgId := ChildNode.Text
            else if AnsiSameText('MessageText' , ChildNode.NodeName) then
              MsgText := ChildNode.Text
            else if AnsiSameText('PopReceipt' , ChildNode.NodeName) then
              PopReceipt := ChildNode.Text
            else
              MsgProps.Values[ChildNode.NodeName] := ChildNode.Text;

            ChildNode := ChildNode.NextSibling;
          end;

          if (MsgId <> EmptyStr) and (MsgText <> EmptyStr) then
          begin
            Msg := TCloudQueueMessage.Create(MsgId, MsgText, MsgProps);
            Msg.PopReceipt := PopReceipt;
            Result.Add(Msg);
          end
          else
            FreeAndNil(MsgProps);
        end;

        MessageNode := MessageNode.NextSibling;
      end;
    end;
  end;
end;

function TAzureQueueService.PeekMessagesXML(const QueueName: string; NumOfMessages: Integer;
                                            ResponseInfo: TCloudResponseInfo): string;
begin
  Result := GetOrPeekMessagesXML(QueueName, True, NumOfMessages, 0, ResponseInfo);
end;

function TAzureQueueService.PeekMessages(const QueueName: string; NumOfMessages: Integer;
                                         ResponseInfo: TCloudResponseInfo): TList<TCloudQueueMessage>;
var
  xml: string;
begin
  xml := PeekMessagesXML(QueueName, NumOfMessages, ResponseInfo);
  Result := GetMessagesFromXML(xml);
end;

function TAzureQueueService.DeleteMessage(const QueueName: string; const QueueMessage: TCloudQueueMessage;
                                          GetPopReceiptIfNeeded: Boolean; ResponseInfo: TCloudResponseInfo): Boolean;
var
  Msgs: TList<TCloudQueueMessage>;
begin
  if (QueueName = EmptyStr) or (QueueMessage = nil) or (QueueMessage.MessageId = EmptyStr) then
    Exit(False);

  if QueueMessage.PopReceipt = EmptyStr then
  begin
    //If there is no pop receipt, and the caller doesn't want to compute one, fail the execution.
    if not GetPopReceiptIfNeeded then
      Exit(False);

    Msgs := GetMessages(QueueName, 1, 0, ResponseInfo);

    if (Msgs = nil) or (Msgs.Count <> 1) then
    begin
      FreeAndNil(Msgs);
      Exit(False);
    end;

    //only set the pop receipt if the message on the top of the queue was the one requesting deletion.
    if Msgs[0].MessageId = QueueMessage.MessageId then
      QueueMessage.PopReceipt := Msgs[0].PopReceipt;
    FreeAndNil(Msgs);
  end;

  Result := DeleteMessage(QueueName, QueueMessage.MessageId, QueueMessage.PopReceipt, ResponseInfo);
end;

function TAzureQueueService.DeleteMessage(const QueueName, MessageId, PopReceipt: string;
                                          ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  QueryParams: TStringList;
begin
  if (QueueName = EmptyStr) or (MessageId = EmptyStr) or (PopReceipt = EmptyStr) then
    Exit(False);

  url := Format('%s/%s/messages/%s?popreceipt=%s',
                [GetConnectionInfo.QueueURL, QueueName, MessageId, URLEncode(PopReceipt, ['+','='])]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryParams := TStringList.Create;
  QueryParams.Values['popreceipt'] := PopReceipt;

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName) + '/messages/' + MessageId;

  Response := nil;
  try
    Response := IssueDeleteRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 204);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
    FreeAndNil(QueryParams);
  end;
end;


function TAzureQueueService.ClearMessages(const QueueName: string; ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
begin
  if (QueueName = EmptyStr) then
    Exit(False);

  url := Format('%s/%s/messages', [GetConnectionInfo.QueueURL, QueueName]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryPrefix := GetQueuesQueryPrefix(Headers, QueueName) + '/messages';

  Response := nil;
  try
    Response := IssueDeleteRequest(url, Headers, nil, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 204);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

{ TAzureBlobService }

function TAzureBlobService.ListContainersXML(OptionalParams: TStrings;
                                             ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  url := GetConnectionInfo.BlobURL;

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  if not GetConnectionInfo.UseDevelopmentStorage then
    Headers.Values['x-ms-version'] := '2009-09-19';

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'list';

  if OptionalParams <> nil then
    QueryParams.AddStrings(OptionalParams);

  url := BuildQueryParameterString(url, QueryParams, False, True);

  QueryPrefix := Format('/%s/', [GetConnectionInfo.AccountName]);

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.LoadChildrenAsProperties(ANode: IXMLNode): TStrings;
var
  ChildNode: IXMLNode;
begin
  Result := TStringList.Create;
  if (ANode <> nil) and ANode.HasChildNodes then
  begin
    ChildNode := ANode.ChildNodes.First;

    while ChildNode <> nil do
    begin
      try
        if ChildNode.IsTextElement then
          Result.Values[ChildNode.NodeName] := ChildNode.Text;
      finally
        ChildNode := ChildNode.NextSibling;
      end;
    end;
  end;
end;

function TAzureBlobService.ParseContainerFromContainerNode(ContainerNode: IXMLNode): TAzureContainer;
var
  Name, URL: string;
  Properties, Metadata: TStrings;
  ContainerItem: IXMLNode;
begin
  Result := nil;
  if (ContainerNode <> nil) and
     AnsiSameText(ContainerNode.NodeName, 'Container') and
     ContainerNode.HasChildNodes then
  begin
    Properties := nil;
    Metadata := nil;

    try
      ContainerItem := ContainerNode.ChildNodes.First;

      while ContainerItem <> nil do
      begin
        try
          if AnsiSameText(ContainerItem.NodeName, 'Name') then
            Name := ContainerItem.Text
          else if AnsiSameText(ContainerItem.NodeName, 'URL') then
            URL := ContainerItem.Text
          else if AnsiSameText(ContainerItem.NodeName, 'Properties') then
            Properties := LoadChildrenAsProperties(ContainerItem)
          else if AnsiSameText(ContainerItem.NodeName, 'Metadata') then
            Metadata := LoadChildrenAsProperties(ContainerItem);
        finally
          ContainerItem := ContainerItem.NextSibling;
        end;
      end;

      if (Name <> EmptyStr) and (URL <> EmptyStr) then
        Result := TAzureContainer.Create(Name, URL, Properties, Metadata);
    finally
      if Result = nil then
      begin
        FreeAndNil(Properties);
        FreeAndNil(Metadata);
      end;
    end;
  end;
end;

procedure TAzureBlobService.PopulateBlobPropertyHeaders(Headers, Properties: TStrings);
var
  PropName: string;
  I, Count: Integer;
begin
  if (Properties <> nil) and (Headers <> nil) then
  begin
    Count := Properties.Count;
    for I := 0 to Count - 1 do
    begin
      PropName := Properties.Names[I];
      //if the value doesn't start with 'x-ms-blob-' then the prefix will be added.
      //otherwise, the header will be added as-is, and may or may not be a valid header
      if AnsiSameText(PropName, 'x-ms-blob-cache-control') or
         AnsiSameText(PropName, 'Cache-Control') then
        Headers.Values['x-ms-blob-cache-control'] := Properties.ValueFromIndex[I]
      else if AnsiSameText(PropName, 'x-ms-blob-content-type') or
              AnsiSameText(PropName, 'Content-Type') then
        Headers.Values['x-ms-blob-content-type'] := Properties.ValueFromIndex[I]
      else if AnsiSameText(PropName, 'x-ms-blob-content-md5') or
              AnsiSameText(PropName, 'Content-MD5') then
        Headers.Values['x-ms-blob-content-md5'] := Properties.ValueFromIndex[I]
      else if AnsiSameText(PropName, 'x-ms-blob-content-encoding') or
              AnsiSameText(PropName, 'Content-Encoding') then
        Headers.Values['x-ms-blob-content-encoding'] := Properties.ValueFromIndex[I]
      else if AnsiSameText(PropName, 'x-ms-blob-content-language') or
              AnsiSameText(PropName, 'Content-Language') then
        Headers.Values['x-ms-blob-content-language'] := Properties.ValueFromIndex[I]
      else
        Headers.Values[PropName] := Properties.ValueFromIndex[I];
    end;
  end;
end;

function TAzureBlobService.PutBlock(ContainerName, BlobName: string; const BlockId: string; Content: TArray<Byte>;
                                    const ContentMD5, LeaseId: string;
                                    ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  contentStream: TBytesStream;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  if (Content = nil) or (ContainerName = EmptyStr) or (BlobName = EmptyStr) or
     (BlockId = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  if ContentMD5 <> EmptyStr then
    Headers.Values['Content-MD5'] := ContentMD5;

  if LeaseId <> emptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  contentStream := TBytesStream.Create(Content);

  //issuing a put, so need content length
  Headers.Values['Content-Length'] := IntToStr(contentStream.Size);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'block';
  QueryParams.Values['blockid'] := BlockId; //Base64 encode the BlockId

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, contentStream);
    Result := (Response <> nil) and (Response.ResponseCode = 201);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(contentStream);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.PutBlockBlob(ContainerName, BlobName: string; Content: TArray<Byte>; LeaseId: string;
                                        OptionalHeaders, Metadata: TStrings;
                                        ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  contentStream: TBytesStream;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
begin
  if (Content = nil) or (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := BuildMetadataHeaderList(MetaData);
  PopulateDateHeader(Headers, False);
  headers.Values['x-ms-blob-type'] := 'BlockBlob';

  if OptionalHeaders <> nil then
    Headers.AddStrings(OptionalHeaders);

  if LeaseId <> emptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  contentStream := TBytesStream.Create(Content);

  //issuing a put, so need content length
  Headers.Values['Content-Length'] := IntToStr(contentStream.Size);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, nil, QueryPrefix, ResponseInfo, contentStream);
    Result := (Response <> nil) and (Response.ResponseCode = 201);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(contentStream);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.PutBlockList(ContainerName, BlobName: string; BlockList: TList<TAzureBlockListItem>;
                                        Properties, Metadata: TStrings; const LeaseId: string;
                                        const ContentMD5: string;
                                        ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  xml: string;
  contentStream: TBytesStream;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
  Item: TAzureBlockListItem;
begin
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) or
     (BlockList = nil) or (BlockList.Count = 0) then
    Exit(False);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := BuildMetadataHeaderList(Metadata);
  PopulateDateHeader(Headers, False);

  if LeaseId <> EmptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  if ContentMD5 <> EmptyStr then
    Headers.Values['Content-MD5'] := ContentMD5;

  //Populate the headers, possibly prefixing with x-ms-blob-, when appropriate.
  //For example, 'Content-Type' in the Properties list would be added
  //to the Headers list as 'x-ms-blob-content-type'
  PopulateBlobPropertyHeaders(Headers, Properties);

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'blocklist';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  xml := '<?xml version="1.0" encoding="utf-8"?><BlockList>';
  for Item In BlockList do
    xml := xml + Item.AsXML;  
  xml := xml + '</BlockList>';

  contentStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  Headers.Values['Content-Length'] := IntToStr(contentStream.Size);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, contentStream);
    Result := (Response <> nil) and (Response.ResponseCode = 201);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(contentStream);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.PutPageInternal(ContainerName, BlobName: string; Content: TArray<Byte>; DoClear: Boolean;
                                           StartPage, PageCount: Integer; ActionConditional: TBlobActionConditional;
                                           const ContentMD5, LeaseId: string;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  contentStream: TBytesStream;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
  StartByte, EndByte: Int64;
begin
  if ((ContainerName = EmptyStr) or (BlobName = EmptyStr)) or
     //Content should only be nil if doing a 'clear' action on the given range
     ((Content = nil) and (not DoClear)) then
    Exit(False);

  //calculate the starting and ending byte based on the start page and page count
  StartByte := StartPage * 512; //Pages must each be 512 bytes
  EndByte := StartByte + (PageCount * 512 - 1); //Zero based indexing, so subtract 1 from the range

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  if EndByte > StartByte then
    Headers.Values['x-ms-range'] := Format('bytes=%d-%d', [StartByte, EndByte]);

  if ContentMD5 <> EmptyStr then
    Headers.Values['Content-MD5'] := ContentMD5;

  if LeaseId <> emptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  //issuing a put, so need content length
  contentStream := nil;
  if Content <> nil then
  begin
    contentStream := TBytesStream.Create(Content);
    Headers.Values['Content-Length'] := IntToStr(contentStream.Size);
  end
  else
    Headers.Values['Content-Length'] := '0';

  //either an update or clear action
  if DoClear then
    Headers.Values['x-ms-page-write'] := 'clear'
  else
    Headers.Values['x-ms-page-write'] := 'update';

  //add the conditional headers, if any are set
  ActionConditional.PopulateHeaders(Headers);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'page';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, contentStream);
    Result := (Response <> nil) and (Response.ResponseCode = 201);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(contentStream);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.PutPage(ContainerName, BlobName: string; Content: TArray<Byte>; StartPage: Integer;
                                   const LeaseId: string; ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := PutPage(ContainerName, BlobName, Content, StartPage, TBlobActionConditional.Create, LeaseId, ResponseInfo);
end;

function TAzureBlobService.PutPage(ContainerName, BlobName: string; Content: TArray<Byte>; StartPage: Integer;
                                   ActionConditional: TBlobActionConditional; const LeaseId: string;
                                   ResponseInfo: TCloudResponseInfo): Boolean;
var
  Len: Integer;
  LeftToPad, PageCount: Int64;
begin
  if Content = nil then
    Exit(False);

  //get the actual length of the content
  Len := Length(Content);

  //get the page count, which may or may not be one fewer than it needs to be
  PageCount :=  Trunc(Len / 512);

  //Determine if the current PageCount is correct, or if one more (partially filled) page is needed.
  //If one more page is needed, specify how many bytes need to be added as padding on the end.
  LeftToPad := 512 - (Len mod 512);

  //Increment the page count by one and pad the content with enough bytes to make (Length Mod 512) equal zero.
  if (LeftToPad < 512) then
  begin
    Inc(PageCount);
    SetLength(Content, Len + LeftToPad);
  end;

  Result := PutPage(ContainerName, BlobName, Content, StartPage, PageCount, ActionConditional,
                    EmptyStr, LeaseId, ResponseInfo);
end;

function TAzureBlobService.PutPage(ContainerName, BlobName: string; Content: TArray<Byte>;
                                   StartPage, PageCount: Integer; ActionConditional: TBlobActionConditional;
                                   const ContentMD5, LeaseId: string;
                                   ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := PutPageInternal(ContainerName, BlobName, Content, False, StartPage, PageCount, ActionConditional,
                            ContentMD5, LeaseId, ResponseInfo);
end;

function TAzureBlobService.PutPage(ContainerName, BlobName: string; Content: TArray<Byte>;
                                   StartPage, PageCount: Integer; const LeaseId, ContentMD5: string;
                                   ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := PutPage(ContainerName, BlobName, Content, StartPage, PageCount, TBlobActionConditional.Create,
                    ContentMD5, LeaseId, ResponseInfo);
end;

function TAzureBlobService.ClearPage(ContainerName, BlobName: string; StartPage, PageCount: Integer;
                                     ActionConditional: TBlobActionConditional; const LeaseId: string;
                                     ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := PutPageInternal(ContainerName, BlobName, nil, True, StartPage, PageCount, ActionConditional,
                            EmptyStr, LeaseId, ResponseInfo);
end;

function TAzureBlobService.ClearPage(ContainerName, BlobName: string; StartPage, PageCount: Integer;
                                     const LeaseId: string; ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := ClearPage(ContainerName, BlobName, StartPage, PageCount, TBlobActionConditional.Create,
                      LeaseId, ResponseInfo);
end;

function TAzureBlobService.PutPageBlob(ContainerName, BlobName: string; MaximumSize: int64; OptionalHeaders,
                                       Metadata: TStrings; BlobSequenceNumber: int64;
                                       ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
begin
  if (MaximumSize < 512) or (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := BuildMetadataHeaderList(MetaData);
  PopulateDateHeader(Headers, False);
  headers.Values['x-ms-blob-type'] := 'PageBlob';

  if OptionalHeaders <> nil then
    Headers.AddStrings(OptionalHeaders);

  //issuing a put, so need content length
  Headers.Values['Content-Length'] := '0';
  Headers.Values['x-ms-blob-content-length'] := IntToStr(MaximumSize);
  if BlobSequenceNumber > 0 then
    Headers.Values['x-ms-blob-sequence-number'] := IntToStr(BlobSequenceNumber);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, nil, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 201);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.SetContainerACL(ContainerName: string; const SignedIdentifierId: string;
  AccessPolicy: TAccessPolicy; PublicAccess: TBlobPublicAccess; ResponseInfo: TCloudResponseInfo): Boolean;
var
  SignedIdentifiers: TList<TSignedIdentifier>;
  SignedIdentifier: TSignedIdentifier;
begin
  SignedIdentifiers := TList<TSignedIdentifier>.Create;
  try
    //create a signed identifier list with the single signed identifier,
    //then call the function that takes a list.
    SignedIdentifier := TSignedIdentifier.Create(ContainerName, AccessPolicy, SignedIdentifierId);
    SignedIdentifiers.Add(SignedIdentifier);
    Result := SetContainerACL(ContainerName, SignedIdentifiers, PublicAccess, ResponseInfo);
  finally
    FreeAndNil(SignedIdentifier);
    FreeAndNil(SignedIdentifiers);
  end;
end;

function TAzureBlobService.SetBlobMetadata(ContainerName, BlobName: string; Metadata: TStrings;
                                           LeaseId: string; ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := BuildMetadataHeaderList(MetaData);

  PopulateDateHeader(Headers, False);

  //issuing a put, so need content length. But all data is passed in headers, so content length is 0
  Headers.Values['Content-Length'] := '0';

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'metadata';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 200);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.SetBlobProperties(ContainerName, BlobName: string; Properties: TStrings;
                                             const LeaseId: string; ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);
  if LeaseId <> EmptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  //issuing a put, so need content length. But all data is passed in headers, so content length is 0
  Headers.Values['Content-Length'] := '0';

  //Populate the headers, possibly prefixing with x-ms-blob-, when appropriate.
  //For example, 'Content-Type' in the Properties list would be added
  //to the Headers list as 'x-ms-blob-content-type'
  PopulateBlobPropertyHeaders(Headers, Properties);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'properties';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 200);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.SetContainerACL(ContainerName: string; SignedIdentifiers: TList<TSignedIdentifier>;
  PublicAccess: TBlobPublicAccess; ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
  ContentString: string;
  I, Count: Integer;
  ContentStream: TBytesStream;
begin
  if SignedIdentifiers = nil then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s', [GetConnectionInfo.BlobURL, ContainerName]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  //Create the XML representation of the SignedIdentifiers list, to 'PUT' to the server
  ContentString := '<?xml version="1.0" encoding="utf-8"?><SignedIdentifiers>';
  Count := SignedIdentifiers.Count;
  for I := 0 to Count - 1 do
    ContentString := ContentString + SignedIdentifiers[I].AsXML;
  ContentString := ContentString + '</SignedIdentifiers>';

  ContentStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(ContentString));
  //Add the XML's length as the Content-Length of the request
  Headers.Values['Content-Length'] := IntToStr(ContentStream.Size);
  if GetConnectionInfo.UseDevelopmentStorage then
    Headers.Values['x-ms-prop-publicaccess'] := 'true'
  else
    Headers.Values['x-ms-blob-public-access'] := GetPublicAccessString(PublicAccess);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName);

  QueryParams := TStringList.Create;
  QueryParams.Values['restype'] := 'container';
  QueryParams.Values['comp'] := 'acl';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, ContentStream);
    Result := (Response <> nil) and (Response.ResponseCode = 200);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(ContentStream);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.SetContainerMetadata(ContainerName: string; const Metadata: TStrings;
                                                ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s', [GetConnectionInfo.BlobURL, ContainerName]);

  Headers := BuildMetadataHeaderList(MetaData);

  PopulateDateHeader(Headers, False);

  //issuing a put, so need content length. But all data is passed in headers, so content length is 0
  Headers.Values['Content-Length'] := '0';

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName);

  QueryParams := TStringList.Create;
  QueryParams.Values['restype'] := 'container';
  QueryParams.Values['comp'] := 'metadata';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 200);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.SnapshotBlob(ContainerName, BlobName: string; out SnapshotId: string;
                                        const LeaseId: string; Metadata: TStrings;
                                        ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := SnapshotBlob(ContainerName, BlobName, TBlobActionConditional.Create, SnapshotId, LeaseId,
                         Metadata, ResponseInfo);
end;

function TAzureBlobService.SnapshotBlob(ContainerName, BlobName: string;
                                        SnapshotConditionals: TBlobActionConditional;
                                        out SnapshotId: string; const LeaseId: string;
                                        Metadata: TStrings; ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
begin
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := BuildMetadataHeaderList(Metadata);
  PopulateDateHeader(Headers, False);

  Headers.Values['Content-Length'] := '0';

  SnapshotConditionals.PopulateHeaders(Headers);

  if LeaseId <> EmptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'snapshot';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  FreeResponseInfo := ResponseInfo = nil;
  if FreeResponseInfo then
    ResponseInfo := TCloudResponseInfo.Create;

  Response := nil;
  try
    try
      Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
      Result := (Response <> nil) and (Response.ResponseCode = 201);
      if Result then
        SnapshotId := ResponseInfo.Headers.Values['x-ms-snapshot'];
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    if FreeResponseInfo then
      ResponseInfo.Free;
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.BuildMetadataHeaderList(const Metadata: TStrings): TStringList;
var
  I, Count: Integer;
  MetaName: string;
begin
  Result := TStringList.Create;

  //add the specified metadata into the headers, prefixing each
  //metadata header name with 'x-ms-meta-' if it wasn't already.
  if MetaData <> nil then
  begin
    Count := MetaData.Count;
    for I := 0 to Count - 1 do
    begin
      MetaName := MetaData.Names[I];
      if not AnsiStartsText('x-ms-meta-', MetaName) then
        MetaName := 'x-ms-meta-' + MetaName;
      Result.Values[MetaName] := MetaData.ValueFromIndex[I];
    end;
  end;
end;

function TAzureBlobService.CopyBlobInternal(TargetContainerName, TargetBlobName, SourceContainerName,
                                            SourceBlobName: string; const SourceSnapshot, TargetLeaseId: string;
                                            CopyConditionals: TBlobActionConditional;
                                            Metadata: TStrings;
                                            ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  Response: TCloudHTTP;
  CopySourceVal: string;
begin
  if (TargetContainerName = EmptyStr) or (TargetBlobName = EmptyStr) or
     (SourceContainerName = EmptyStr) or (SourceBlobName = EmptyStr) then
    Exit(False);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, TargetContainerName, URLEncode(TargetBlobName)]);

  Headers := BuildMetadataHeaderList(Metadata);
  PopulateDateHeader(Headers, False);
  Headers.Values['Content-Length'] := '0';

  if (SourceContainerName = EmptyStr) or (SourceContainerName = ROOT_CONTAINER) then
    CopySourceVal := Format('/%s/%s', [GetConnectionInfo.AccountName, SourceBlobName])
  else
    CopySourceVal := Format('/%s/%s/%s', [GetConnectionInfo.AccountName, SourceContainerName, SourceBlobName]);

  if SourceSnapshot <> EmptyStr then
    CopySourceVal := CopySourceVal + '?snapshot=' + SourceSnapshot;

  Headers.Values['x-ms-copy-source'] := CopySourceVal;

  CopyConditionals.PopulateHeaders(Headers);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, TargetContainerName, URLEncode(TargetBlobName));

  Response := nil;
  try
    try
      Response := IssuePutRequest(url, Headers, nil, QueryPrefix, ResponseInfo);
      Result := (Response <> nil) and (Response.ResponseCode = 201);
    except
      Result := false;
    end;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.CopyBlob(TargetContainerName, TargetBlobName, SourceContainerName,
                                    SourceBlobName: string; CopyConditionals: TBlobActionConditional;
                                    const TargetLeaseId: string; Metadata: TStrings;
                                    ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := CopyBlobInternal(TargetContainerName, TargetBlobName, SourceContainerName,
                             SourceBlobName, '', TargetLeaseId,
                             CopyConditionals, Metadata, ResponseInfo);
end;

function TAzureBlobService.CopyBlob(TargetContainerName, TargetBlobName, SourceContainerName,
                                    SourceBlobName: string; const TargetLeaseId: string;
                                    Metadata: TStrings; ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := CopyBlob(TargetContainerName, TargetBlobName, SourceContainerName, SourceBlobName,
                     TBlobActionConditional.Create, TargetLeaseId, Metadata, ResponseInfo);
end;

function TAzureBlobService.CopySnapshotToBlob(TargetContainerName, TargetBlobName, SourceContainerName,
                                              SourceBlobName: string; const SourceSnapshot: string;
                                              CopyConditionals: TBlobActionConditional;
                                              Metadata: TStrings;
                                              ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := CopyBlobInternal(TargetContainerName, TargetBlobName, SourceContainerName,
                             SourceBlobName, SourceSnapshot, '',
                             CopyConditionals, Metadata, ResponseInfo);
end;

function TAzureBlobService.CopySnapshotToBlob(TargetContainerName, TargetBlobName, SourceContainerName,
                                              SourceBlobName: string; const SourceSnapshot: string;
                                              Metadata: TStrings;
                                              ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := CopySnapshotToBlob(TargetContainerName, TargetBlobName, SourceContainerName,
                               SourceBlobName, SourceSnapshot, TBlobActionConditional.Create, Metadata,
                               ResponseInfo);
end;

function TAzureBlobService.CreateContainer(ContainerName: string;
                                           MetaData: TStrings;
                                           PublicAccess: TBlobPublicAccess;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s', [GetConnectionInfo.BlobURL, ContainerName]);

  Headers := BuildMetadataHeaderList(MetaData);

  PopulateDateHeader(Headers, False);

  if PublicAccess = bpaContainer then
    Headers.Values['x-ms-blob-public-access'] := 'container'
  else if PublicAccess = bpaBlob then
    Headers.Values['x-ms-blob-public-access'] := 'blob';

  //issuing a put, so need content length. But all data is passed in headers, so content length is 0
  Headers.Values['Content-Length'] := '0';

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName);

  QueryParams := TStringList.Create;
  QueryParams.Values['restype'] := 'container';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 201);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.CreateRootContainer(MetaData: TStrings; PublicAccess: TBlobPublicAccess;
                                               ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := CreateContainer(ROOT_CONTAINER, MetaData, PublicAccess, ResponseInfo);
end;

function TAzureBlobService.DeleteBlob(ContainerName, BlobName: string; OnlySnapshots: Boolean;
                                      LeaseId: string; ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := DeleteBlobInternal(ContainerName, BlobName, '', OnlySnapshots, LeaseId, ResponseInfo);
end;

function TAzureBlobService.DeleteBlobSnapshot(ContainerName, BlobName, SnapShot, LeaseId: string;
                                              ResponseInfo: TCloudResponseInfo): Boolean;
begin
  if SnapShot = EmptyStr then
    Exit(False);

  Result := DeleteBlobInternal(ContainerName, BlobName, SnapShot, True, LeaseId, ResponseInfo);
end;

function TAzureBlobService.DeleteBlobInternal(ContainerName, BlobName, SnapShot: string;
                                              OnlySnapshots: Boolean; LeaseId: string;
                                              ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  QueryParams := nil;
  if SnapShot <> EmptyStr then
  begin
    QueryParams := TStringList.Create;
    QueryParams.Values['snapshot'] := 'SnapShot';
    url := BuildQueryParameterString(url, QueryParams, False, True);
  end
  else
  begin
    //Controls if only the snapshots should be deleted, or the whole blob
    if OnlySnapshots then
      Headers.Values['x-ms-delete-snapshots'] := 'only'
    else
      Headers.Values['x-ms-delete-snapshots'] := 'include';
  end;

  Response := nil;
  try
    Response := IssueDeleteRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 202);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.DeleteContainer(ContainerName: string;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s', [GetConnectionInfo.BlobURL, ContainerName]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName);

  QueryParams := TStringList.Create;
  QueryParams.Values['restype'] := 'container';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssueDeleteRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Result := (Response <> nil) and (Response.ResponseCode = 202);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.DeleteRootContainer(ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := DeleteContainer(ROOT_CONTAINER, ResponseInfo);
end;

function TAzureBlobService.GetBlobInternal(ContainerName, BlobName, Snapshot, LeaseId: string;
                                           out Metadata, Properties: TStrings;
                                           ResponseContent: TStream;
                                           StartByte, EndByte: int64; GetAsHash: Boolean;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
var
  CurrentHeaderName, QueryPrefix, url: string;
  Headers, QueryParams: TStringList;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
  I, Count: Integer;
begin
  Metadata := nil;
  Properties := nil;

  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := string.Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  try
    PopulateDateHeader(Headers, False);
    if LeaseId <> EmptyStr then
      headers.Values['x-ms-lease-id'] := LeaseId;

    QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

    QueryParams := nil;
    try
      if Snapshot <> EmptyStr then
      begin
        QueryParams := TStringList.Create;
        QueryParams.Values['snapshot'] := 'Snapshot';
        url := BuildQueryParameterString(url, QueryParams, False, True);
      end;

      //Populate Range, and possibly also x-ms-range-get-content-md5
      if EndByte > StartByte then
      begin
        headers.Values['x-ms-range'] := Format('bytes=%d-%d', [StartByte, EndByte]);
        if GetAsHash then
          headers.Values['x-ms-range-get-content-md5'] := 'true'
      end;

      FreeResponseInfo := ResponseInfo = nil;
      if FreeResponseInfo then
        ResponseInfo := TCloudResponseInfo.Create;

      Response := nil;
      try
        Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, ResponseContent);
        Result := (Response <> nil) and (Response.ResponseCode = 200);

        //If the request was successful, populate the metadata and properties lists
        if Result then
        begin
          Metadata := TStringList.Create;
          Properties := TStringList.Create;
          Count := ResponseInfo.Headers.Count;
          for I := 0 to Count - 1 do
          begin
            CurrentHeaderName := ResponseInfo.Headers.Names[I];
            if AnsiStartsText('x-ms-meta-', CurrentHeaderName) then
            begin
              //strip the "x-ms-meta-" prefix from the name of the header,
              //to get the original metadata name, as entered by the user.
              CurrentHeaderName := CurrentHeaderName.Substring(10);
              Metadata.Values[CurrentHeaderName] := ResponseInfo.Headers.ValueFromIndex[I];
            end
            else
              Properties.Values[CurrentHeaderName] := ResponseInfo.Headers.ValueFromIndex[I];
          end;
        end;
      finally
        Response.Free;
        if FreeResponseInfo then
          ResponseInfo.Free;
      end;
    finally
      QueryParams.Free;
    end;
  finally
    Headers.Free;
  end;
end;

function TAzureBlobService.GetBlob(ContainerName, BlobName: string; BlobStream: TStream; StartByte,
                                   EndByte: int64; GetAsHash: Boolean; const LeaseId: string;
                                   ResponseInfo: TCloudResponseInfo): Boolean;
var
  Metadata: TStrings;
  Properties: TStrings;
begin
  try
    Result := GetBlob(ContainerName, BlobName, BlobStream, Properties, Metadata,
                      StartByte, EndByte, GetAsHash, LeaseId, ResponseInfo);
  finally
    FreeAndNil(Metadata);
    FreeAndNil(Properties);
  end;
end;

function TAzureBlobService.GetBlob(ContainerName, BlobName: string; BlobStream: TStream; out Properties,
                                   Metadata: TStrings; StartByte, EndByte: int64;
                                   GetAsHash: Boolean; const LeaseId: string;
                                   ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := GetBlobInternal(ContainerName, BlobName, '', LeaseId, Metadata, Properties,
                            BlobStream, StartByte, EndByte, GetAsHash, ResponseInfo);
end;

function TAzureBlobService.GetBlob(ContainerName, BlobName: string; BlobStream: TStream;
                                   const LeaseId: string; ResponseInfo: TCloudResponseInfo): Boolean;
var
  Metadata: TStrings;
  Properties: TStrings;
begin
  try
    Result := GetBlob(ContainerName, BlobName, BlobStream, Properties, Metadata, LeaseId, ResponseInfo);
  finally
    FreeAndNil(Metadata);
    FreeAndNil(Properties);
  end;
end;

function TAzureBlobService.GetBlob(ContainerName, BlobName: string; BlobStream: TStream;
                                   out Properties, Metadata: TStrings; const LeaseId: string;
                                   ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := GetBlobInternal(ContainerName, BlobName, '', LeaseId, Metadata, Properties,
                            BlobStream, 0, 0, False, ResponseInfo);
end;

function TAzureBlobService.GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                                           StartByte, EndByte: int64; GetAsHash: Boolean;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
var
  Metadata: TStrings;
  Properties: TStrings;
begin
  try
    Result := GetBlobSnapshot(ContainerName, BlobName, Snapshot, SnapshotStream, Properties, Metadata,
                              StartByte, EndByte, GetAsHash, ResponseInfo);
  finally
    FreeAndNil(Metadata);
    FreeAndNil(Properties);
  end;
end;

function TAzureBlobService.GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                                           out Properties, Metadata: TStrings; StartByte, EndByte: int64;
                                           GetAsHash: Boolean;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := GetBlobInternal(ContainerName, BlobName, Snapshot, '', Metadata, Properties,
                            SnapshotStream, StartByte, EndByte, GetAsHash, ResponseInfo);
end;

function TAzureBlobService.GetBlockListXML(ContainerName, BlobName: string;
                                           BlockType: TAzureQueryIncludeBlockType;
                                           const SnapShot, LeaseId: string; ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(EmptyStr);

  ContainerName := AnsiLowerCase(ContainerName);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);
  if LeaseId <> EmptyStr then
    Headers.Values['x-ms-lease-id'] := LeaseId;

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'blocklist';
  if Snapshot <> EmptyStr then
    QueryParams.Values['snapshot'] := Snapshot;

  if BlockType = aqbtUncommitted then
    QueryParams.Values['blocklisttype'] := 'uncommitted'
  else if BlockType = aqbtCommitted then
    QueryParams.Values['blocklisttype'] := 'committed'
  else if BlockType = aqbtAll then
    QueryParams.Values['blocklisttype'] := 'all';

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);
  url := BuildQueryParameterString(url, QueryParams, False, True);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, Result);
    if (Response = nil) or (Response.ResponseCode <> 200) then
      Result := '';
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.GetBlockList(ContainerName, BlobName: string;
                                        BlockType: TAzureQueryIncludeBlockType;
                                        const SnapShot, LeaseId: string;
                                        ResponseInfo: TCloudResponseInfo): TList<TAzureBlockListItem>;
var
  xml: string;
  xmlDoc: IXMLDocument;
  RootNode, ContainerNode: IXMLNode;
begin
  Result := nil;
  xml := GetBlockListXML(ContainerName, BlobName, BlockType, Snapshot, LeaseId, ResponseInfo);

  if xml <> EmptyStr then
  begin
    Result := TList<TAzureBlockListItem>.Create;

    xmlDoc := TXMLDocument.Create(nil);
    xmlDoc.LoadFromXML(xml);
    RootNode := xmlDoc.DocumentElement;

    ContainerNode := GetFirstMatchingChildNode(RootNode, 'CommittedBlocks');
    AddBlockItems(ContainerNode, Result, abtCommitted);

    ContainerNode := GetFirstMatchingChildNode(RootNode, 'UncommittedBlocks');
    AddBlockItems(ContainerNode, Result, abtUncommitted);
  end;
end;

procedure TAzureBlobService.AddBlockItems(BlocksNode: IXMLNode; BlockList: TList<TAzureBlockListItem>;
                                          BlockType: TAzureBlockType);
var
  BlockNode, SubNode: IXMLNode;
  Name, Size: string;
begin
  if (BlockList = nil) or (BlocksNode = nil) or (not BlocksNode.HasChildNodes) then
    Exit;

  BlockNode := BlocksNode.ChildNodes.First;

  while BlockNode <> nil do
  begin
    Name := '';
    Size := '';

    try
      if BlockNode.HasChildNodes then
      begin
        SubNode := BlockNode.ChildNodes.First;
        while SubNode <> nil do
        begin
          try
            if AnsiSameText(SubNode.NodeName, 'Name') then
              Name := SubNode.Text
            else if AnsiSameText(SubNode.NodeName, 'Size') then
              Size := SubNode.Text;
          finally
            SubNode := SubNode.NextSibling;
          end;
        end;
      end;
    finally
      if (Name <> EmptyStr) and (Size <> EmptyStr) then
        BlockList.Add(TAzureBlockListItem.Create(Name, BlockType, Size));

      BlockNode := BlockNode.NextSibling;
    end;
  end;
end;

function TAzureBlobService.GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
var
  Metadata: TStrings;
  Properties: TStrings;
begin
  try
    Result := GetBlobSnapshot(ContainerName, BlobName, Snapshot, SnapshotStream, Properties, Metadata,
                              ResponseInfo);
  finally
    FreeAndNil(Metadata);
    FreeAndNil(Properties);
  end;
end;

function TAzureBlobService.GetBlobSnapshot(ContainerName, BlobName, Snapshot: string; SnapshotStream: TStream;
                                           out Properties, Metadata: TStrings;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
begin
  Result := GetBlobInternal(ContainerName, BlobName, Snapshot, '', Metadata, Properties,
                            SnapshotStream, 0, 0, False, ResponseInfo);
end;

function TAzureBlobService.GetContainerProperties(ContainerName: string; out Properties: TStrings;
                                                  ResponseInfo: TCloudResponseInfo): Boolean;
var
  Metadata: TStrings;
begin
  Result := GetContainerProperties(Containername, Properties, Metadata, ResponseInfo);
  if Result then
    FreeAndNil(Metadata);
end;

function TAzureBlobService.GetBlobContainerQueryPrefix(Headers: TStrings; ContainerName: string;
                                                       BlobName: string): string;
begin
  if GetConnectionInfo.UseDevelopmentStorage then
    Result := Format('/%s/%s/%s', [GetConnectionInfo.AccountName, GetConnectionInfo.AccountName, ContainerName])
  else
  begin
    Headers.Values['x-ms-version'] := '2009-09-19';
    Result := Format('/%s/%s', [GetConnectionInfo.AccountName, ContainerName]);
  end;

  if BlobName <> EmptyStr then
  begin
    Result := Result + '/' + BlobName;
  end;
end;

function TAzureBlobService.GetBlobMetadata(ContainerName, BlobName: string; out Metadata: TStrings;
                                           const Snapshot, LeaseId: string;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
var
  CurrentHeaderName, QueryPrefix, url: string;
  Headers, QueryParams: TStringList;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
  I, Count: Integer;
begin
  Metadata := nil;
  ContainerName := AnsiLowerCase(ContainerName);

  url := string.Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  try
    PopulateDateHeader(Headers, False);
    if LeaseId <> EmptyStr then
      headers.Values['x-ms-lease-id'] := LeaseId;

    QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

    QueryParams := TStringList.Create;
    try
      QueryParams.Values['comp'] := 'metadata';
      if Snapshot <> EmptyStr then
        QueryParams.Values['snapshot'] := 'Snapshot';

      url := BuildQueryParameterString(url, QueryParams, False, True);

      FreeResponseInfo := ResponseInfo = nil;
      if FreeResponseInfo then
        ResponseInfo := TCloudResponseInfo.Create;

      Response := nil;
      try
        Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
        Result := (Response <> nil) and (Response.ResponseCode = 200);

        if Result then
        begin
          Metadata := TStringList.Create;
          Count := ResponseInfo.Headers.Count;
          for I := 0 to Count - 1 do
          begin
            CurrentHeaderName := ResponseInfo.Headers.Names[I];
            if AnsiStartsText('x-ms-meta-', CurrentHeaderName) then
            begin
              //strip the "x-ms-meta-" prefix from the name of the header,
              //to get the original metadata header name, as entered by the user.
              CurrentHeaderName := CurrentHeaderName.Substring(10);
              Metadata.Values[CurrentHeaderName] := ResponseInfo.Headers.ValueFromIndex[I];
            end;
          end;
        end;
      finally
        Response.Free;
        if FreeResponseInfo then
          ResponseInfo.Free;
      end;
    finally
      QueryParams.Free;
    end;
  finally
    Headers.Free;
  end;
end;

function TAzureBlobService.GetBlobProperties(ContainerName, BlobName: string; out Properties: TStrings;
                                             const Snapshot, LeaseId: string;
                                             ResponseInfo: TCloudResponseInfo): Boolean;
var
  Metadata: TStrings;
begin
  Result := GetBlobProperties(ContainerName, BlobName, Properties, Metadata, Snapshot, LeaseId, ResponseInfo);
  //We don't care about the Metadata, so free it.
  FreeAndNil(Metadata);
end;

function TAzureBlobService.GetBlobProperties(ContainerName, BlobName: string; out Properties,
                                             Metadata: TStrings; const Snapshot, LeaseId: string;
                                             ResponseInfo: TCloudResponseInfo): Boolean;
var
  HeaderName, QueryPrefix, url: string;
  Headers, QueryParams: TStringList;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
  I, Count: Integer;
begin
  Properties := nil;
  Metadata := nil;

  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit(False);

  ContainerName := AnsiLowerCase(ContainerName);

  url := string.Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  try
    PopulateDateHeader(Headers, False);
    if LeaseId <> EmptyStr then
      headers.Values['x-ms-lease-id'] := LeaseId;

    QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

    QueryParams := nil;
    try
      if Snapshot <> EmptyStr then
      begin
        QueryParams := TStringList.Create;
        QueryParams.Values['snapshot'] := Snapshot;
      end;

      url := BuildQueryParameterString(url, QueryParams, False, True);

      FreeResponseInfo := ResponseInfo = nil;
      if FreeResponseInfo then
        ResponseInfo := TCloudResponseInfo.Create;

      Response := nil;
      try
        Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
        Result := (Response <> nil) and (Response.ResponseCode = 200);

        if Result then
        begin
          Properties := TStringList.Create;
          Metadata := TStringList.Create;

          //Populate the result lists based on the returned headers from the request
          Count := ResponseInfo.Headers.Count;
          for I := 0 to Count - 1 do
          begin
            HeaderName := ResponseInfo.Headers.Names[I];
            //if a header name starts with x-ms-meta- then it is a metadata header.
            //exclude the metadata header name prefix from the name returned as the metadata name
            if AnsiStartsText('x-ms-meta-', HeaderName) and (HeaderName.Length > 11) then
              Metadata.Values[HeaderName.Substring(10)] := ResponseInfo.Headers.ValueFromIndex[I]
            else if not AnsiStartsText('x-ms-', HeaderName) then
              Properties.Values[HeaderName] := ResponseInfo.Headers.ValueFromIndex[I];
          end;
        end;
      finally
        Response.Free;
        if FreeResponseInfo then
          ResponseInfo.Free;
      end;
    finally
      QueryParams.Free;
    end;
  finally
    Headers.Free;
  end;
end;

function TAzureBlobService.GetContainerACLXML(ContainerName: string; out PublicAccess: TBlobPublicAccess;
                                              ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
  PublicAccessString: string;
  FreeResponseInfo: Boolean;
begin
  PublicAccess := bpaPrivate;
  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s', [GetConnectionInfo.BlobURL, ContainerName]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName);

  QueryParams := TStringList.Create;
  QueryParams.Values['restype'] := 'container';
  QueryParams.Values['comp'] := 'acl';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  FreeResponseInfo := ResponseInfo = nil;
  if FreeResponseInfo then
    ResponseInfo := TCloudResponseInfo.Create;

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, Result);

    PublicAccessString := ResponseInfo.Headers.Values['x-ms-blob-public-access'];
    if PublicAccessString = 'container' then
      PublicAccess := bpaContainer
    else if PublicAccessString = 'blob' then
      PublicAccess := bpaBlob;
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureBlobService.GetContainerACL(ContainerName: string; out PublicAccess: TBlobPublicAccess;
                                           ResponseInfo: TCloudResponseInfo): TList<TSignedIdentifier>;
var
  xml: string;
  xmlDoc: IXMLDocument;
  RootNode, SidNode, ChildNode, SubChildNode: IXMLNode;
  SignedIdentifier: TSignedIdentifier;
begin
  Result := nil;
  xml := GetContainerACLXML(ContainerName, PublicAccess, ResponseInfo);

  if xml <> emptyStr then
  begin
    xmlDoc := TXMLDocument.Create(nil);
    xmlDoc.LoadFromXML(xml);
    RootNode := xmlDoc.DocumentElement;

    if not RootNode.HasChildNodes then
      Exit(nil);

    Result := TList<TSignedIdentifier>.Create;

    SidNode := RootNode.ChildNodes.First;
    (*
       The XML looks like this:
       <SignedIdentifiers>
         <SignedIdentifier>
           <Id>unique-value</Id>
           <AccessPolicy>
             <Start>start-time</Start>
             <Expiry>expiry-time</Expiry>
             <Permission>abbreviated-permission-list</Permission>
           </AccessPolicy>
         </SignedIdentifier>
       </SignedIdentifiers>
    *)
    while SidNode <> nil do
    begin
      try
        if AnsiSameText(SidNode.NodeName, 'SignedIdentifier') then
        begin
          ChildNode := GetFirstMatchingChildNode(SidNode, 'Id');
          if ChildNode <> nil then
          begin
            SignedIdentifier := TSignedIdentifier.Create(ContainerName);
            SignedIdentifier.Id := ChildNode.Text;
            Result.Add(SignedIdentifier);

            ChildNode := GetFirstMatchingChildNode(SidNode, 'AccessPolicy');
            if (ChildNode <> nil) and (ChildNode.HasChildNodes) then
            begin
              SubChildNode := ChildNode.ChildNodes.First;
              while SubChildNode <> nil do
              begin
                try
                  if AnsiSameText(SubChildNode.NodeName, 'Start') then
                    SignedIdentifier.AccessPolicy.Start := SubChildNode.Text
                  else if AnsiSameText(SubChildNode.NodeName, 'Expiry') then
                    SignedIdentifier.AccessPolicy.Expiry := SubChildNode.Text
                  else if AnsiSameText(SubChildNode.NodeName, 'Permission') then
                    SignedIdentifier.AccessPolicy.Permission := SubChildNode.Text;
                finally
                  SubChildNode := SubChildNode.NextSibling;
                end;
              end;
            end;
          end;
        end;
      finally
        SidNode := SidNode.NextSibling;
      end;
    end;
  end;
end;

function TAzureBlobService.GetContainerMetadata(ContainerName: string; out Metadata: TStrings;
                                                ResponseInfo: TCloudResponseInfo): Boolean;
var
  Properties: TStrings;
begin
  (*
     Choosing to get all properties instead of just metadata, to reuse existing code.
     As far as I can tell, the request and responses are identical, except that a call to get
     metadata includes "&comp=metadata" in the URL and query parameters... even though all
     headers are returned anyway, not just the metadata ones.
  *)
  Result := GetContainerProperties(Containername, Properties, Metadata, ResponseInfo);
  if Result then
    FreeAndNil(Properties);
end;

function TAzureBlobService.GetContainerProperties(ContainerName: string; out Properties,
                                                  Metadata: TStrings; ResponseInfo: TCloudResponseInfo): Boolean;
var
  HeaderName, QueryPrefix, url: string;
  Headers, QueryParams: TStringList;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
  I, Count: Integer;
begin
  if (ContainerName = EmptyStr) then
    Exit(False);

  Properties := nil;
  Metadata := nil;

  ContainerName := AnsiLowerCase(ContainerName);

  url := string.Format('%s/%s', [GetConnectionInfo.BlobURL, ContainerName]);

  Headers := TStringList.Create;
  try
    PopulateDateHeader(Headers, False);

    QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName);

    QueryParams := TStringList.Create;
    try
      QueryParams.Values['restype'] := 'container';

      url := BuildQueryParameterString(url, QueryParams, False, True);

      FreeResponseInfo := ResponseInfo = nil;
      if FreeResponseInfo then
        ResponseInfo := TCloudResponseInfo.Create;

      Response := nil;
      try
        Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
        Result := (Response <> nil) and (Response.ResponseCode = 200);

        if Result then
        begin
          Properties := TStringList.Create;
          Metadata := TStringList.Create;

          //Populate the result lists based on the returned headers from the request
          Count := ResponseInfo.Headers.Count;
          for I := 0 to Count - 1 do
          begin
            HeaderName := ResponseInfo.Headers.Names[I];
            //if a header name starts with x-ms-meta- then it is a metadata header.
            //exclude the metadata header name prefix from the name returned as the metadata name
            if AnsiStartsText('x-ms-meta-', HeaderName) and (HeaderName.Length > 11) then
              Metadata.Values[HeaderName.Substring(10)] := ResponseInfo.Headers.ValueFromIndex[I]
            else if not AnsiStartsText('x-ms-', HeaderName) then
              Properties.Values[HeaderName] := ResponseInfo.Headers.ValueFromIndex[I];
          end;
        end;
      finally
        Response.Free;
        if FreeResponseInfo then
          ResponseInfo.Free;
      end;
    finally
      QueryParams.Free;
    end;
  finally
    Headers.Free;
  end;
end;

function TAzureBlobService.GetPageRegionsXML(ContainerName, BlobName: string; const Snapshot, LeaseId: string;
                                             ResponseInfo: TCloudResponseInfo): string;
begin
  Result := GetPageRegionsXML(ContainerName, BlobName, 0, 0, Snapshot, LeaseId, ResponseInfo);
end;

function TAzureBlobService.GetPageRegionsXML(ContainerName, BlobName: string; StartByte, EndByte: Int64;
                                             const Snapshot, LeaseId: string;
                                             ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Result := '';

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  if LeaseId <> EmptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  if (StartByte >= 0) and (EndByte > StartByte) then
    Headers.Values['x-ms-range'] := Format('bytes=%d-%d', [StartByte, EndByte]);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'pagelist';
  //development storiage doesn't support the snapshot query parameter
  if (Snapshot <> EmptyStr) and (not GetConnectionInfo.UseDevelopmentStorage) then
    QueryParams.Values['snapshot'] := Snapshot;

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.GetPageRegions(ContainerName, BlobName: string; StartByte, EndByte: Int64;
                                          const Snapshot, LeaseId: string;
                                          ResponseInfo: TCloudResponseInfo): TList<TAzureBlobPageRange>;
var
  xml: string;
  xmlDoc: IXMLDocument;
  RootNode, PRNode, StartNode, EndNode: IXMLNode;
  StartS, EndS: string;
  Item: TAzureBlobPageRange;
begin
  Result := nil;
  xml := GetPageRegionsXML(ContainerName, BlobName, StartByte, EndByte, Snapshot, LeaseId, ResponseInfo);

  if xml <> EmptyStr then
  begin
    Result := TList<TAzureBlobPageRange>.Create;

    xmlDoc := TXMLDocument.Create(nil);
    xmlDoc.LoadFromXML(xml);
    RootNode := xmlDoc.DocumentElement;

    if (RootNode <> nil) and (RootNode.HasChildNodes) then
    begin
      PRNode := GetFirstMatchingChildNode(RootNode, 'PageRange');

      while PRNode <> nil do
      begin
        try
          StartNode := GetFirstMatchingChildNode(PRNode, 'Start');
          EndNode := GetFirstMatchingChildNode(PRNode, 'End');

          if (StartNode <> nil) and (EndNode <> nil) then
          begin
            StartS := StartNode.Text;
            EndS := EndNode.Text;

            try
              Item := TAzureBlobPageRange.Create(StrToInt64(StartS), StrToInt64(EndS));
              Result.Add(Item);
            except
            end;
          end;
        finally
          PRNode := PRNode.NextSibling;
        end;
      end;
    end;
  end;
end;

function TAzureBlobService.GetPageRegions(ContainerName, BlobName: string; const Snapshot, LeaseId: string;
                                          ResponseInfo: TCloudResponseInfo): TList<TAzureBlobPageRange>;
begin
  Result := GetPageRegions(ContainerName, BlobName, 0, 0, Snapshot, LeaseId, ResponseInfo);
end;

function TAzureBlobService.GetPublicAccessString(PublicAccess: TBlobPublicAccess): string;
begin
  if PublicAccess = bpaContainer then
    Exit('container');
  if PublicAccess = bpaBlob then
    Exit('blob');
end;

function TAzureBlobService.HandleBlobLease(ContainerName, BlobName: string; const LeaseAction,
                                           LeaseId: string; SuccessCode: Integer; out Success: Boolean;
                                           ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
  FreeResponseInfo: Boolean;
begin
  Success := False;
  if (ContainerName = EmptyStr) or (BlobName = EmptyStr) then
    Exit('');

  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s/%s', [GetConnectionInfo.BlobURL, ContainerName, URLEncode(BlobName)]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);
  headers.Values['Content-Length'] := '0';
  headers.Values['x-ms-lease-action'] := LeaseAction;
  if LeaseId <> EmptyStr then
    headers.Values['x-ms-lease-id'] := LeaseId;

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName, URLEncode(BlobName));

  QueryParams := TStringList.Create;
  QueryParams.Values['comp'] := 'lease';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  FreeResponseInfo := ResponseInfo = nil;
  if FreeResponseInfo then
    ResponseInfo := TCloudResponseInfo.Create;

  Response := nil;
  try
    Response := IssuePutRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo);
    Success := Response.ResponseCode = SuccessCode;
    if Success then
      Result := ResponseInfo.Headers.Values['x-ms-lease-id'];
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    if FreeResponseInfo then
      ResponseInfo.Free;
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.AcquireBlobLease(ContainerName, BlobName: string; out LeaseId: string;
                                           ResponseInfo: TCloudResponseInfo): Boolean;
begin
  LeaseId := HandleBlobLease(ContainerName, BlobName, 'acquire', '', 201, Result, ResponseInfo);
end;

function TAzureBlobService.RenewBlobLease(ContainerName, BlobName: string; const LeaseId: string;
                                          ResponseInfo: TCloudResponseInfo): Boolean;
begin
  HandleBlobLease(ContainerName, BlobName, 'renew', LeaseId, 200, Result, ResponseInfo);
end;

function TAzureBlobService.ReleaseBlobLease(ContainerName, BlobName: string; const LeaseId: string;
                                            ResponseInfo: TCloudResponseInfo): Boolean;
begin
  HandleBlobLease(ContainerName, BlobName, 'release', LeaseId, 200, Result, ResponseInfo);
end;

function TAzureBlobService.BreakBlobLease(ContainerName, BlobName: string; out LeaseTimeRemaining: Integer;
                                          ResponseInfo: TCloudResponseInfo): Boolean;
var
  FreeResponseInfo: Boolean;
  TimeRemaining: string;
begin
  LeaseTimeRemaining := -1;
  FreeResponseInfo := ResponseInfo = nil;
  if FreeResponseInfo then
    ResponseInfo := TCloudResponseInfo.Create;

  try
    HandleBlobLease(ContainerName, BlobName, 'break', '', 202, Result, ResponseInfo);
    if Result then
    begin
      TimeRemaining := ResponseInfo.Headers.Values['x-ms-lease-time: seconds'];
      if TimeRemaining <> EmptyStr then
        try
          LeasetimeRemaining := StrToInt(TimeRemaining);
        except
        end;
    end;
  finally
    if FreeResponseInfo then
      ResponseInfo.Free;
  end;
end;

function TAzureBlobService.ListBlobs(ContainerName: string; OptionalParams: TStrings;
                                     ResponseInfo: TCloudResponseInfo): TList<TAzureBlob>;
var
  NextMarker: string;
begin
  Result := ListBlobs(ContainerName, NextMarker, OptionalParams, ResponseInfo);
end;

function TAzureBlobService.ListBlobs(ContainerName: string; out NextMarker: string;
                                     OptionalParams: TStrings;
                                     ResponseInfo: TCloudResponseInfo): TList<TAzureBlob>;
var
  xml: string;
  xmlDoc: IXMLDocument;
  RootNode, BlobsNode, BlobNode, Aux: IXMLNode;
  ABlob: TAzureBlob;
  BlobName, BlobURL, BlobSnapshot: string;
  BlobType: TAzureBlobType;
  Properties, Metadata: TStrings;
  LeaseStatus: TAzureLeaseStatus;
  AuxString: string;
begin
  Result := nil;
  Properties := nil;
  Metadata := nil;

  xml := ListBlobsXML(ContainerName, OptionalParams, ResponseInfo);

  if xml <> EmptyStr then
  begin
    Result := TList<TAzureBlob>.Create;

    xmlDoc := TXMLDocument.Create(nil);
    xmlDoc.LoadFromXML(xml);
    RootNode := xmlDoc.DocumentElement;

    //First load the continuation token, if there is any.
    Aux := GetFirstMatchingChildNode(RootNode, 'NextMarker');
    if (Aux <> nil) and (Aux.IsTextElement) then
      NextMarker := Aux.Text;

    //Then iterate the list of blobs
    BlobsNode := GetFirstMatchingChildNode(RootNode, 'Blobs');

    if (BlobsNode <> nil) and (BlobsNode.HasChildNodes) then
    begin
      BlobNode := BlobsNode.ChildNodes.First;
      while BlobNode <> nil do
      begin
        try
          //If the node is a 'BlobPrefix' node, instead of a full blob, just get the prefix name
          //this is used for virtual-drectory iteration througha  blob list, using 'prefix' and 'delimiter'
          if AnsiSameText(BlobNode.NodeName, 'BlobPrefix') then
          begin
            Aux := GetFirstMatchingChildNode(BlobNode, 'Name');
            if (Aux <> nil) and Aux.IsTextElement then
            begin
              //create a 'prefix' blob and add it to the result
              //this is a placeholder for all blobs that have names starting
              //with the specified prefix, and containing the specified delimiter
              Result.Add(TAzureBlob.Create(Aux.Text, abtPrefix));
            end;
          end
          //Otherwise, if it is a regular blob element, parse a full blob
          else if AnsiSameText(BlobNode.NodeName, 'Blob') then
          begin
            Aux := BlobNode.ChildNodes.First;
            while Aux <> nil do
            begin
              try
                if AnsiSameText(Aux.NodeName, 'Name') then
                  BlobName := Aux.Text
                else if AnsiSameText(Aux.NodeName, 'Snapshot') then
                  BlobSnapshot := Aux.Text
                else if AnsiSameText(Aux.NodeName, 'Url') then
                  BlobURL := Aux.Text
                else if AnsiSameText(Aux.NodeName, 'Properties') then
                  Properties := LoadChildrenAsProperties(Aux)
                else if AnsiSameText(Aux.NodeName, 'Metadata') then
                  Metadata := LoadChildrenAsProperties(Aux);
              finally
                Aux := Aux.NextSibling;
              end;
            end;

            //take the values passed in, read 'BlobType' and 'LeaseStatus' from the properties list,
            //build the blob object, and add it to the result.
            if (BlobName <> EmptyStr) and (BlobURL <> EmptyStr) and (Properties <> nil) then
            begin
              BlobType := abtBlock;
              LeaseStatus := alsUnlocked;

              //get the BlobType from the properties
              AuxString := Properties.Values['BlobType'];
              if AnsiSameText(AuxString, 'PageBlob') then
                BlobType := abtPage;

              //get the LeaseStatus from the properties
              AuxString := Properties.Values['LeaseStatus'];
              if AnsiSameText(AuxString, 'locked') then
                LeaseStatus := alsLocked;

              ABlob := TAzureBlob.Create(BlobName, BlobType, BlobURL, LeaseStatus, BlobSnapshot);
              ABlob.Properties.AddStrings(Properties);
              if Metadata <> nil then
                ABlob.Metadata.AddStrings(Metadata);

              //Add the blob to the list of blobs
              Result.Add(ABlob);
            end;
          end;
        finally
          FreeAndNil(Metadata);
          FreeAndNil(Properties);
          BlobNode := BlobNode.NextSibling;
        end;
      end;
    end;
  end;
end;

function TAzureBlobService.ListBlobsXML(ContainerName: string; OptionalParams: TStrings;
                                        ResponseInfo: TCloudResponseInfo): string;
var
  url: string;
  Headers: TStringList;
  QueryPrefix: string;
  QueryParams: TStringList;
  Response: TCloudHTTP;
begin
  ContainerName := AnsiLowerCase(ContainerName);

  url := Format('%s/%s', [GetConnectionInfo.BlobURL, ContainerName]);

  Headers := TStringList.Create;
  PopulateDateHeader(Headers, False);

  QueryPrefix := GetBlobContainerQueryPrefix(Headers, ContainerName);

  QueryParams := TStringList.Create;

  if OptionalParams <> nil then
    QueryParams.AddStrings(OptionalParams);

  QueryParams.Values['restype'] := 'container';
  QueryParams.Values['comp'] := 'list';

  url := BuildQueryParameterString(url, QueryParams, False, True);

  Response := nil;
  try
    Response := IssueGetRequest(url, Headers, QueryParams, QueryPrefix, ResponseInfo, Result);
  finally
    if Assigned(Response) then
      FreeAndNil(Response);
    FreeAndNil(QueryParams);
    FreeAndNil(Headers);
  end;
end;

function TAzureBlobService.ListContainers(OptionalParams: TStrings;
                                          ResponseInfo: TCloudResponseInfo): TList<TAzureContainer>;
var
  NextMarker: string;
begin
  Result := ListContainers(NextMarker, OptionalParams, ResponseInfo);
end;

function TAzureBlobService.ListContainers(out NextMarker: string; OptionalParams: TStrings;
                                          ResponseInfo: TCloudResponseInfo): TList<TAzureContainer>;
var
  xml: string;
  xmlDoc: IXMLDocument;
  RootNode, ContainersNode, ContainerNode: IXMLNode;
  Container: TAzureContainer;
begin
  Result := nil;
  xml := ListContainersXML(OptionalParams, ResponseInfo);

  if xml <> EmptyStr then
  begin
    Result := TList<TAzureContainer>.Create;

    xmlDoc := TXMLDocument.Create(nil);
    xmlDoc.LoadFromXML(xml);
    RootNode := xmlDoc.DocumentElement;

    if (RootNode <> nil) and (RootNode.HasChildNodes) then
    begin
      ContainersNode := GetFirstMatchingChildNode(RootNode, 'Containers');

      if (ContainersNode <> nil) and ContainersNode.HasChildNodes then
      begin
        ContainerNode := ContainersNode.ChildNodes.First;

        while ContainerNode <> nil do
        begin
          try
            Container := ParseContainerFromContainerNode(ContainerNode);
            if Container <> nil then
              Result.Add(Container);
          finally
            ContainerNode := ContainerNode.NextSibling;
          end;
        end;
      end;
    end;
  end;
end;

{ TAzureContainer }

constructor TAzureContainer.Create(const Name, URL: string; Properties, Metadata: TStrings);
begin
  FName := Name;
  FURL := URL;

  if Properties = nil then
    FProperties := TStringList.Create
  else
    FProperties := Properties;

  if Metadata = nil then
    FMetadata := TStringList.Create
  else
    FMetadata := Metadata;
end;

destructor TAzureContainer.Destroy;
begin
  FreeAndNil(FProperties);
  FreeAndNil(FMetadata);
  inherited;
end;

function TAzureContainer.IsRoot: Boolean;
begin
  Result := Name = ROOT_CONTAINER;
end;

{ TAccessPolicy }

class function TAccessPolicy.Create: TAccessPolicy;
var
  ap: TAccessPolicy;
begin
  ap.Start := FormatDateTime('yyyy-mm-dd', Now);
  ap.SetPermission('r');
  Exit(ap);
end;

function TAccessPolicy.AsXML: string;
begin
  Result := '<AccessPolicy><Start>' + Start + '</Start><Expiry>' + Expiry +
            '</Expiry><Permission>' + Permission + '</Permission></AccessPolicy>';
end;

function TAccessPolicy.GetPermission: string;
begin
  Result := '';
  if PermRead then
    Result := Result + 'r';
  if PermWrite then
    Result := Result + 'w';
  if PermDelete then
    Result := Result + 'd';
  if PermList then
    Result := Result + 'l';
end;

procedure TAccessPolicy.SetPermission(const rwdl: string);
var
  I, Count: Integer;
begin
  Count := rwdl.Length;
  PermRead   := False;
  PermWrite  := False;
  PermDelete := False;
  PermList   := False;
  for I := 0 to Count - 1 do
    if rwdl.Chars[I] = 'r' then
      PermRead := True
    else if rwdl.Chars[I] = 'w' then
      PermWrite := True
    else if rwdl.Chars[I] = 'd' then
      PermDelete := True
    else if rwdl.Chars[I] = 'l' then
      PermList := True;
end;

{ TSignedIdentifier }

constructor TSignedIdentifier.Create(const Resource: string);
begin
  FResource := Resource;
  AccessPolicy.PermRead := false;
  AccessPolicy.PermWrite := false;
  AccessPolicy.PermDelete := false;
  AccessPolicy.PermList := false;
end;

constructor TSignedIdentifier.Create(const Resource: string; Policy: TAccessPolicy; UniqueId: string);
begin
  FResource := Resource;
  AccessPolicy := Policy;
  FId := UniqueId;
end;

function TSignedIdentifier.AsXML: string;
begin
  Result := '<SignedIdentifier><Id>' + Id + '</Id>' + AccessPolicy.AsXML + '</SignedIdentifier>';
end;

{ TAzureBlob }

constructor TAzureBlob.Create(const Name: string; BlobType: TAzureBlobType; const Url: string;
  LeaseStatus: TAzureLeaseStatus; const Snapshot: string);
begin
  FName := Name;
  FBlobType := BlobType;
  FUrl := Url;
  FLeaseStatus := LeaseStatus;
  FSnapshot := Snapshot;
  FProperties := TStringList.Create;
  FMetadata := TStringList.Create;
end;

destructor TAzureBlob.Destroy;
begin
  FreeAndNil(FProperties);
  FreeAndnil(FMetadata);
  inherited;
end;

{ TBlobActionConditional }

class function TBlobActionConditional.Create: TBlobActionConditional;
var
  Inst: TBlobActionConditional;
begin
  Exit(Inst);
end;

procedure TBlobActionConditional.PopulateHeaders(Headers: TStrings);
begin
  if Headers <> nil then
  begin
    if IfSourceModifiedSince <> EmptyStr then
      Headers.Values['x-ms-source-if-modified-since'] := IfSourceModifiedSince;
    if IfSourceUnmodifiedSince <> EmptyStr then
      Headers.Values['x-ms-source-if-unmodified-since'] := IfSourceUnmodifiedSince;
    if IfSourceMatch <> EmptyStr then
      Headers.Values['x-ms-source-if-match'] := IfSourceMatch;
    if IfSourceNoneMatch <> EmptyStr then
      Headers.Values['x-ms-source-if-none-match'] := IfSourceNoneMatch;

    if IfModifiedSince <> EmptyStr then
      Headers.Values['If-Modified-Since'] := IfModifiedSince;
    if IfUnmodifiedSince <> EmptyStr then
      Headers.Values['If-Unmodified-Since'] := IfUnmodifiedSince;
    if IfMatch <> EmptyStr then
      Headers.Values['If-Match'] := IfMatch;
    if IfNoneMatch <> EmptyStr then
      Headers.Values['If-None-Match'] := IfNoneMatch;

    if IfSequenceNumberLessThanOrEqual <> EmptyStr then
      Headers.Values['x-ms-if-sequence-number-lte'] := IfSequenceNumberLessThanOrEqual;
    if IfSequenceNumberLessThan <> EmptyStr then
      Headers.Values['x-ms-if-sequence-number-lt'] := IfSequenceNumberLessThan;
    if IfSequenceNumberEquals <> EmptyStr then
      Headers.Values['x-ms-if-sequence-number-eq'] := IfSequenceNumberEquals;
  end;
end;

{ TAzureBlockListItem }

class function TAzureBlockListItem.Create(ABlockId: string; ABlockType: TAzureBlockType;
                                          ASize: string): TAzureBlockListItem;
var
  abli: TAzureBlockListItem;
begin
  abli.BlockId := ABlockId;
  abli.BlockType := ABlockType;
  abli.Size := ASize;

  Result := abli;
end;

function TAzureBlockListItem.AsXML: string;
var
  TagName: string;
begin
  case BlockType of
    abtUncommitted: TagName := 'Uncommitted';
    abtLatest: TagName := 'Latest';
    else
      TagName := 'Committed';
  end;

  Result := Format('<%s>%s</%0:s>', [TagName, XMLEscape(BlockId)]);
end;

{ TAzureBlobPageRange }

class function TAzureBlobPageRange.Create(StartByte, EndByte: Int64): TAzureBlobPageRange;
var
  res: TAzureBlobPageRange;
begin
  res.StartByte := StartByte;
  res.EndByte := EndByte;
  Exit(res);
end;

function TAzureBlobPageRange.GetPageCount: Integer;
var
  ByteCount: Int64;
begin
  ByteCount := EndByte - StartByte;

  //get the page count, which may or may not be one fewer than it needs to be
  Result := Trunc(ByteCount / 512);

  //Determine if the current PageCount is correct, or if one more page is needed.
  if (ByteCount Mod 512) <> 0 then
    Inc(Result);
end;

function TAzureBlobPageRange.GetStartPage: Integer;
begin
  Result := Trunc(StartByte / 512);
end;

end.
