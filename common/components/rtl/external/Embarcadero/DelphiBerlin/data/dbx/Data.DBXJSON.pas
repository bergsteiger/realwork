{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXJSON;

interface

uses
  Data.DBXPlatform,
  System.SysUtils,
  System.JSON
;

type

  /// <summary>Represents the base class for callback methods.</summary>
  TDBXCallback = class abstract
  public

    /// <summary> Holds the client side callback logic.
    /// </summary>
    /// <remarks>
    ///  Function doesn't have argument ownership
    ///
    /// </remarks>
    /// <param name="Arg">- JSON value</param>
    /// <returns>JSON value</returns>
    function Execute(const Arg: TJSONValue): TJSONValue; overload; virtual; abstract;

    /// <summary> Holds the client side callback logic.
    /// </summary>
    /// <remarks>
    ///  Function doesn't have argument ownership
    ///
    /// </remarks>
    /// <param name="Arg">- Object value</param>
    /// <returns>an object instance</returns>
    function Execute(Arg: TObject): TObject; overload; virtual; abstract;

{$IFNDEF AUTOREFCOUNT}
    /// <summary> Manage reference count by increasing with one unit
    ///
    /// </summary>
    /// <returns>new count</returns>
    function AddRef: Integer; virtual;

    /// <summary> Decreases the reference count. If the count is zero (or less)
    /// </summary>
    /// <remarks> If the count is zero (or less)
    ///  the instance self-destructs.
    ///
    /// </remarks>
    /// <returns>current count</returns>
    function Release: Integer; virtual;
{$ENDIF !AUTOREFCOUNT}
  protected

    /// <summary> Override the method if you are using the connection handler.
    /// </summary>
    /// <remarks>
    ///
    ///  The information when is provided when known.
    ///
    /// </remarks>
    /// <param name="ConnectionHandler">- connection handler as an Object</param>
    procedure SetConnectionHandler(const ConnectionHandler: TObject); virtual;
    procedure SetDsServer(const DsServer: TObject); virtual;

    /// <summary> Override this method if you are using the parameter ordinal (index in the
    ///  parameter list, starting with zero).
    /// </summary>
    /// <remarks>
    ///
    ///  The information when is provided when known.
    ///
    /// </remarks>
    /// <param name="Ordinal">- callback parameter index </param>
    procedure SetOrdinal(const Ordinal: Integer); virtual;

    function IsConnectionLost: Boolean; virtual;
  private
{$IFNDEF AUTOREFCOUNT}
    FFRefCount: Integer;
{$ENDIF !AUTOREFCOUNT}
  public

    /// <summary> Override the method if you are using the connection handler.
    /// </summary>
    /// <remarks>
    ///
    ///  The information when is provided when known.
    ///
    /// </remarks>
    property ConnectionHandler: TObject write SetConnectionHandler;
    property DsServer: TObject write SetDsServer;

    /// <summary> Override this method if you are using the parameter ordinal (index in the
    ///  parameter list, starting with zero).
    /// </summary>
    /// <remarks>
    ///
    ///  The information when is provided when known.
    ///
    /// </remarks>
    property Ordinal: Integer write SetOrdinal;

    property ConnectionLost: Boolean read IsConnectionLost;
  public

    /// <summary> Constant for JSON based argument remote invocation
    /// </summary>
    const ArgJson = 1;

    /// <summary> Constant for object based argument remote invocation
    /// </summary>
    const ArgObject = 2;
  end;


  /// <summary>Represents an intermediate placeholder for a callback
  /// instance.</summary>
  TDBXCallbackDelegate = class(TDBXCallback)
  public

    /// <summary> Frees the delegate, if any
    /// </summary>
    destructor Destroy; override;

    /// <summary> see com.borland.dbx.json.DBXCallback#execute(com.borland.dbx.json.JSONValue)
    /// </summary>
    function Execute(const Arg: TJSONValue): TJSONValue; overload; override;

    /// <summary> see <see cref="TDBXCallback.execute(TObject)"/>
    /// </summary>
    function Execute(Arg: TObject): TObject; overload; override;
  protected
    procedure SetDelegate(const Callback: TDBXCallback); virtual;
    function GetDelegate: TDBXCallback; virtual;
    procedure SetConnectionHandler(const ConnectionHandler: TObject); override;
    procedure SetOrdinal(const Ordinal: Integer); override;
    procedure SetDsServer(const DsServer: TObject); override;
    function IsConnectionLost: Boolean; override;
  private
    FDelegate: TDBXCallback;
    [Weak]FConnectionHandler: TObject;
    [Weak]FDsServer: TObject;
    FOrdinal: Integer;
  public
    property Delegate: TDBXCallback read GetDelegate write SetDelegate;
  end;


  /// <summary>Represents an extension of the base class for callback
  /// methods.</summary>
  TDBXNamedCallback = class abstract(TDBXCallback)
  public

    /// <summary> constructor for a named callback, which takes in the callback's name
    /// </summary>
    /// <param name="name">the name of the callback</param>
    constructor Create(const Name: string);
  protected

    /// <summary> Returns the name of this callback
    /// </summary>
    /// <returns>the callback's name</returns>
    function GetName: string; virtual;
  protected
    FName: string;
  public

    /// <summary> Returns the name of this callback
    /// </summary>
    /// <returns>the callback's name</returns>
    property Name: string read GetName;
  end;
  
  function GetUSFormat : TFormatSettings;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXCommon, System.StrUtils
;

const
  HexChars = '0123456789ABCDEF';


function GetUSFormat : TFormatSettings;
begin
  Result := TFormatSettings.Create( 'en-US' );
end;

procedure TDBXCallback.SetConnectionHandler(const ConnectionHandler: TObject);
begin
end;

procedure TDBXCallback.SetDsServer(const DsServer: TObject);
begin
end;

procedure TDBXCallback.SetOrdinal(const Ordinal: Integer);
begin
end;

{$IFNDEF AUTOREFCOUNT}
function TDBXCallback.AddRef: Integer;
begin
  Inc(FFRefCount);
  Result := FFRefCount;
end;

function TDBXCallback.Release: Integer;
var
  Count: Integer;
begin
  Dec(FFRefCount);
  Count := FFRefCount;
  if Count <= 0 then
    self.Free;
  Result := Count;
end;
{$ENDIF !AUTOREFCOUNT}

function TDBXCallback.IsConnectionLost: Boolean;
begin
  Result := False;
end;

destructor TDBXCallbackDelegate.Destroy;
begin
  FreeAndNil(FDelegate);
  inherited Destroy;
end;

function TDBXCallbackDelegate.Execute(const Arg: TJSONValue): TJSONValue;
begin
  Result := FDelegate.Execute(Arg);
end;

function TDBXCallbackDelegate.Execute(Arg: TObject): TObject;
begin
  Result := FDelegate.Execute(Arg);
end;

procedure TDBXCallbackDelegate.SetDelegate(const Callback: TDBXCallback);
begin
  FDelegate := Callback;
  if FDelegate <> nil then
  begin
    FDelegate.Ordinal := FOrdinal;
    FDelegate.ConnectionHandler := FConnectionHandler;
    FDelegate.DsServer := FDsServer;
  end;
end;

function TDBXCallbackDelegate.GetDelegate: TDBXCallback;
begin
  Result := FDelegate;
end;

function TDBXCallbackDelegate.IsConnectionLost: Boolean;
begin
  if Assigned(FDelegate) then
    Exit(FDelegate.ConnectionLost);

  Exit(False);
end;

procedure TDBXCallbackDelegate.SetConnectionHandler(const ConnectionHandler: TObject);
begin
  FConnectionHandler := ConnectionHandler;
  if FDelegate <> nil then
    FDelegate.ConnectionHandler := ConnectionHandler;
end;

procedure TDBXCallbackDelegate.SetOrdinal(const Ordinal: Integer);
begin
  FOrdinal := Ordinal;
  if FDelegate <> nil then
    FDelegate.Ordinal := Ordinal;
end;

procedure TDBXCallbackDelegate.SetDsServer(const DsServer: TObject);
begin
  FDsServer := DsServer;
  if FDelegate <> nil then
    FDelegate.DsServer := DsServer;
end;

constructor TDBXNamedCallback.Create(const Name: string);
begin
  inherited Create;
  FName := Name;
end;

function TDBXNamedCallback.GetName: string;
begin
  Result := FName;
end;


end.
