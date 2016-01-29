{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit MetropolisUI.Tile;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, System.UIConsts,
{$IFDEF MSWINDOWS}
  System.Win.Registry, Winapi.Windows, Winapi.Messages,
{$ENDIF}
  System.SyncObjs;

type
  /// <summary> The role of the tile information, either narrow or wide. A tile can have both </summary>
  TTileRole = (trNarrowTile, trWideTile);

  /// <summary> The error codes passed to the tile OnError event, in all cases not worth an exception </summary>
  TTileError = (teNoRegistryEntry, teServiceNotResponding, teUnexistingTileTemplate, teUnsupportedOS);

  /// <summary> Custom exception object of the TMetropolisUITile component </summary>
  EMetropolisUITileException = class(Exception);

  /// <summary> TMetropolisUITile component OnError event signature, with error code </summary>
  TMetropolisUITileErrorEvent = procedure(Sender: TObject; TileError: TTileError) of object;

  TLiveTile = class;

  /// <summary> The TTileInfo class has information about each individual tile, the selected template,
  /// the dynamic properties of the tile (based on the template) </summary>
  TTileInfo = class(TPersistent)
  private
    FTileRole: TTileRole;
    FTileTemplate: string;
    FItems: TStrings;
    FMetropolisUITile: TLiveTile;
    procedure SetTileTemplate(const Value: string);

    procedure UpdateItemsNames;
    procedure SetItems(const Value: TStrings);
    function GetCurrentTemplateXml: string;

    function CheckNarrowTileExists(const TemplateName: string): Boolean;
    function CheckWideTileExists(const TemplateName: string): Boolean;

    procedure ItemsChange(Sender: TObject);
  protected
    /// <summary> The TTileInfo constructor requires as parameters the tile and its role. Not to be called outside the TMetropolisUITile component </summary>
    constructor Create(AMetropolisUITile: TLiveTile; ATileRole: TTileRole);
  public
    destructor Destroy; override;

    /// <summary> Returns the XML information of the tile, merging its template with the actual Items data</summary>
    function GetXMLInfo: string;
    /// <summary> Populates string list of the elements (text and images) of the current template </summary>
    procedure FillItemsNames(FillItemsNames: TStringList);
    /// <summary> Removes tile Items not matching the current template (as in the designer) </summary>
    procedure CleanNamesNotInTemplate;
    /// <summary> The role of the tile, narrow or wide </summary>
    property TileRole: TTileRole read FTileRole;
    /// <summary> The TMetropolisUITile component owning this tile information </summary>
    property MetropolisUITile: TLiveTile read FMetropolisUITile;
  published
    /// <summary> The specific elements of the tile. Only entries matching the current template are considered. For text elements,
    /// use plan text. For images element use the plain name of the file in the tile folder (the component will automatically add the
    /// "ms-appdata" prefix or use a URL for Web based images)</summary>
    property Items: TStrings read FItems write SetItems;
    /// <summary> The current template, can be only one of those defined by Microsoft in the TileTemplateTile enumeration (
    /// see http://msdn.microsoft.com/en-us/library/windows/apps/windows.ui.notifications.tiletemplatetype.aspx) </summary>
    property TileTemplate: string read FTileTemplate write SetTileTemplate;
  end;

  /// <summary> The TMetropolisUITile component defines the elements of the Windows 8 tiles and allows changing their format and
  /// contents at runtime. Requires specific metropolis service and the generation of a custom package tile. Use desing-time
  /// instrumentation to perform these steps, read the documentation for the (rather complex) details! </summary>
  TLiveTile = class(TComponent)
  private
    FServicePort: Integer;
    FMetropolisAvailable: Boolean;
    FMetropolisAppName: string;
    FWideTile: TTileInfo;
    FNarrowTile: TTileInfo;
    FAppID: string;
    FOnError: TMetropolisUITileErrorEvent;
    FPublisherName: string;
    FAutoUpdate: Boolean;

    // registry monitoring support
    FUdpateThread: TThread;
    FTimerId: Cardinal;
    FFamilyName: string;
{$IFDEF MSWINDOWS}
    FTimerProcInstance: Pointer;
    procedure TileTimerProc(var aMessage: TMessage);
{$ENDIF}

    /// <summary> narrow and wide templates lists </summary>
    class var FWideTemplates: TStringList;
    class var FNarrowTemplates: TStringList;
  private
    FBackgroundColor: TColor;
    FImageFolder: string;
    FIncludeWideTile: Boolean;
    FUserName: string;
    FCertificateName: string;

    /// <summary> initialization of narrow and wide templates lists </summary>
    class constructor CreateClass;
    class destructor DestroyClass;

    // properties getters and setters
    procedure SetMetropolisAppName(const Value: string);
    procedure SetNarrowTile(const Value: TTileInfo);
    procedure SetWideTile(const Value: TTileInfo);
    procedure SetAppID(const Value: string);
    class procedure SetNarrowTemplates(const Value: TStringList); static;
    class procedure SetWideTemplates(const Value: TStringList); static;
    function GetNarrowValue(ItemName: string): string;
    function GetWideValue(ItemName: string): string;
    procedure SetNarrowValue(ItemName: string; const Value: string);
    procedure SetWideValue(ItemName: string; const Value: string);
    procedure SetPublisherName(const Value: string);
    procedure SetAutoUpdate(const Value: Boolean);
    procedure SetBackgroundColor(const Value: TColor);
    function GetImageFolder: string;
    function GetServiceTileURL: string;
    function GetXMLInfo: string;
    procedure SetIncludeWideTile(const Value: Boolean);
    function GetAppRegistryKey: string;
    function GetUserProcessRegistryKey: string;
    // internal operations
    procedure InternalNotifyTile;
    procedure PostDeactivation;
    procedure PostActivation;
    // procedure EnableBringToFront;
    function GetDesktopAppURL: string;
    function UserName: string;
    procedure SetCertificateName(const Value: string);
  protected
    procedure Loaded; override;
    procedure NotifyError(TileError: TTileError);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// <summary> Send updates to the actual tile through the Metropolis service
    /// using a REST call, fires OnError if service not listening. This is called automatically for each
    /// change in the tiles data if AutoUpdateTile is active (it is not by default) </summary>
    procedure UpdateTile;
    /// <summary> Reads configuration information (like the service port and the active images folder)
    /// from the registry. </summary>
    procedure ReadRegistryKeys;

    /// <summary> lists of available templates and related XML data (in key=value pairs) for narrow tiles </summary>
    class property NarrowTemplatesList: TStringList read FNarrowTemplates write SetNarrowTemplates;
    /// <summary> lists of available templates and related XML data (in key=value pairs) for wide tiles </summary>
    class property WideTemplatesList: TStringList read FWideTemplates write SetWideTemplates;

    /// <summary> the images folder, with the "family name " read form the registry (where it is written
    /// by the install script) and the inclusion of the current user folder path </summary>
    property ImagesFolder: string read GetImageFolder;
    /// <summary> The URL of the service REST calls for the given tile (includes the AppID) </summary>
    property ServiceTileURL: string read GetServiceTileURL;
    /// <summary> The XML of the current tile(s) information </summary>
    property XMLinfo: string read GetXMLInfo;

    /// <summary> access to "dynamic properties" of narrow tile, shortcut from using the Items property of the TTileInfo.
    /// Changing values part of the template updates the tile information, values not in the template are ignored  </summary>
    property NarrowValue[ItemName: string]: string read GetNarrowValue write SetNarrowValue;
    /// <summary> access to "dynamic properties" of wide tile, shortcut from using the Items property of the TTileInfo.
    /// Changing values part of the template updates the tile information, values not in the template are ignored  </summary>
    property WideValue[ItemName: string]: string read GetWideValue write SetWideValue;
  published
    /// <summary> The unique AppID, a GUID created when the component is initialized. Must be kept in synch with to AppID
    /// added to the manifest of the WinRT project. Don't change it at runtime. At design time this value is read
    /// only in the Object Inspector. To reset clear manually in DFM file, than make sure you update and rebuild the re-deploy the tile. </summary>
    property AppID: string read FAppID write SetAppID;
    /// <summary> The application name added to the Metropolis WinRT project. Added to manifest file, not used at runtime. </summary>
    property MetropolisAppName: string read FMetropolisAppName write SetMetropolisAppName;
    /// <summary> The publisher name of the metropolis tile. Added to manifest file, not used at runtime. </summary>
    property PublisherName: string read FPublisherName write SetPublisherName;
    /// <summary> The publisher certificate name (CN). Added to manifest file, used in the packaging and signing process, not at runtime. </summary>
    property CertificateName: string read FCertificateName write SetCertificateName;
    /// <summary> The narrow tile information structure </summary>
    property NarrowTile: TTileInfo read FNarrowTile write SetNarrowTile;
    /// <summary> The wide tile information structure </summary>
    property WideTile: TTileInfo read FWideTile write SetWideTile;
    /// <summary> Automatically sends the tile information to the service in case of changes, calling UpdateTile,
    /// Disabled by default. </summary>
    property AutoUpdateTile: Boolean read FAutoUpdate write SetAutoUpdate default False;
    /// <summary> The background color of the tile. Added to manifest file, not used at runtime. Blue-violet by default. </summary>
    property BackgroundColor: TColor read FBackgroundColor
      write SetBackgroundColor default TColor($324352);
    /// <summary> Whether to use the narrow tile only, or both the narrow and wide tile. Added to the manifest,
    /// but also used at runtime to compute the tile XML. Active by default. </summary>
    property IncludeWideTile: Boolean read FIncludeWideTile
      write SetIncludeWideTile default True;
    /// <summary> Event handler called for most internal errors, like unsuitable operating systmem, or missing service,
    /// missing registry keys, not responding REST calls. Meant to avoid repeated exceptions on non Windows 8 system or
    /// misconfigured one. Handle to warn users of potential problems, if applicable. </summary>
    property OnError: TMetropolisUITileErrorEvent read FOnError write FOnError;
  end;

implementation

uses
  Xml.XMLIntf, Xml.XMLDoc, MetropolisUI.TileConsts, MetropolisUI.FormUtils, 
  IdHTTP, IdStack, IdStackWindows, IdStackConsts, IdException
{$IFDEF MSWINDOWS}, Winapi.SHFolder {$ENDIF};

const
  DefaultNarrowTileTemplate = 'TileSquareText01';
  DefaultWideTileTemplate = 'TileWideText01';

{$IFDEF WIN32}
  registryPath = 'SOFTWARE\Embarcadero\Metropolis'; // do not translate
{$ELSE}
  registryPath = 'SOFTWARE\Wow6432Node\Embarcadero\Metropolis'; // do not translate
{$ENDIF}

type
  /// <summary> Internal thread class used by the TMetropolisUITile component for listening to registry changes </summary>
  TTileThread = class(TThread)
  private
{$IFDEF MSWINDOWS}
    reg: TRegistry;
{$ENDIF}
    FUpdateEvent: TEvent;
    FMetropolisUITile: TLiveTile;
  protected
    procedure Execute; override;
    /// <summary> Terminates hosting process by sending a close request to main window </summary>
    procedure TerminateProcess;
    /// <summary> Brings main form of hosting process to front via API call </summary>
    // procedure BringToFront;
  public
    /// <summary> Terminates hosting process by sending a close request to main window </summary>
    constructor Create(AMetropolisUITile: TLiveTile);
    destructor Destroy; override;
  end;

  { TTileInfo }

function TTileInfo.CheckNarrowTileExists(const TemplateName: string): Boolean;
begin
  Result := TLiveTile.NarrowTemplatesList.IndexOfName(TemplateName) >= 0;
  if not Result then
    FMetropolisUITile.NotifyError(teUnexistingTileTemplate);
end;

function TTileInfo.CheckWideTileExists(const TemplateName: string): Boolean;
begin
  Result := TLiveTile.WideTemplatesList.IndexOfName(TemplateName) >= 0;
  if not Result then
    FMetropolisUITile.NotifyError(teUnexistingTileTemplate);
end;

procedure TTileInfo.CleanNamesNotInTemplate;
var
  ItemNames: TStringList;
  I: Integer;
begin
  ItemNames := TStringList.Create;
  try
    FillItemsNames(ItemNames);
    for I := FItems.Count - 1 downto 0 do
      if ItemNames.IndexOf(FItems.Names[I]) < 0 then
        FItems.Delete(I);
  finally
    ItemNames.Free;
  end;
end;

constructor TTileInfo.Create(AMetropolisUITile: TLiveTile; ATileRole: TTileRole);
begin
  FItems := TStringList.Create;
  (FItems as TStringList).OnChange := ItemsChange;
  FTileRole := ATileRole;
  FMetropolisUITile := AMetropolisUITile;
  case FTileRole of
    trNarrowTile: SetTileTemplate (DefaultNarrowTileTemplate);
    trWideTile: SetTileTemplate (DefaultWideTileTemplate);
  end;
end;

destructor TTileInfo.Destroy;
begin
  FItems.Free;
  inherited;
end;

const
  tileOpenTag = '<tile><visual>'; // do not localize
  tileCloseTag = '</visual></tile>'; // do not localize
  msappdataProtocol = 'ms-appdata:///local/'; // do not localize

function TTileInfo.GetXMLInfo: string;
var
  xmlTemplate: string;
  strValue: string;
  XMLDoc: IXMLDocument;
  CurrentNode: IXMLNode;
  nodeValue: string;
begin
  Result := '';

  xmlTemplate := GetCurrentTemplateXml;
  if xmlTemplate <> EmptyStr then
  begin
    XMLDoc := TXMLDocument.Create(nil);
    XMLDoc.LoadFromXML(xmlTemplate);

    CurrentNode := XMLDoc.DocumentElement.ChildNodes.First;
    while Assigned(CurrentNode) do
    begin
      if CurrentNode.NodeName = 'text' then // do not translate
      begin
        nodeValue := CurrentNode.nodeValue;
        strValue := FItems.Values[nodeValue];
      end
      else if CurrentNode.NodeName = 'image' then // do not translate
      begin
        nodeValue := CurrentNode.Attributes['src']; // do not translate
        strValue := FItems.Values[nodeValue];
        // looks for any protocol
        if Pos('//', strValue) = 0 then
        begin
          // not a URL, should be a local file name
          strValue := msappdataProtocol + strValue;
        end;
      end;

      // replace text with matching FItems elements
      if strValue <> EmptyStr then
        if CurrentNode.NodeName = 'text' then // do not translate
          CurrentNode.nodeValue := strValue
        else if CurrentNode.NodeName = 'image' then // do not translate
          CurrentNode.Attributes['src'] := strValue; // do not translate

      CurrentNode := CurrentNode.NextSibling;
    end;
    Result := Result + XMLDoc.Xml.Text;
  end;
end;

procedure TTileInfo.ItemsChange(Sender: TObject);
begin
  if FMetropolisUITile.AutoUpdateTile then
    FMetropolisUITile.UpdateTile;
end;

function TTileInfo.GetCurrentTemplateXml: string;
begin
  case FTileRole of
    trNarrowTile:
      Result := TLiveTile.NarrowTemplatesList.Values[FTileTemplate];
    trWideTile:
      Result := TLiveTile.WideTemplatesList.Values[FTileTemplate];
  end;
end;

procedure TTileInfo.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TTileInfo.SetTileTemplate(const Value: string);
var
  templateExists: Boolean;
begin
  templateExists := False;
  if Value <> FTileTemplate then
  begin
    case FTileRole of
      trNarrowTile:
        templateExists := CheckNarrowTileExists(Value);
      trWideTile:
        templateExists := CheckWideTileExists(Value);
    end;

    if templateExists then
    begin
      FTileTemplate := Value;
      UpdateItemsNames;
      if FMetropolisUITile.AutoUpdateTile then
        FMetropolisUITile.UpdateTile;
    end;
  end;
end;

procedure TTileInfo.UpdateItemsNames;
var
  ItemsNamesList: TStringList;
  ItemName: string;
begin
  ItemsNamesList := TStringList.Create;
  try
    FillItemsNames(ItemsNamesList);
    for ItemName in ItemsNamesList do
    begin
      // add the non existing items, preserve all current items with values
      // even if not matching any more
      if FItems.IndexOfName(ItemName) < 0 then
        FItems.Add(ItemName + '=' + ItemName);
    end;
  finally
    ItemsNamesList.Free;
  end;
end;

procedure TTileInfo.FillItemsNames(FillItemsNames: TStringList);
var
  xmlTemplate: string;
  nodeValue: string;
  XMLDoc: IXMLDocument;
  CurrentNode: IXMLNode;
begin
  xmlTemplate := GetCurrentTemplateXml;

  if xmlTemplate <> EmptyStr then
  begin
    XMLDoc := TXMLDocument.Create(nil);
    XMLDoc.LoadFromXML(xmlTemplate);
    CurrentNode := XMLDoc.DocumentElement.ChildNodes.First;
    while Assigned(CurrentNode) do
    begin
      if CurrentNode.NodeName = 'text' then // do not translate
        nodeValue := CurrentNode.nodeValue
      else if CurrentNode.NodeName = 'image' then // do not translate
        nodeValue := CurrentNode.Attributes['src']; // do not translate

      FillItemsNames.Add(nodeValue);

      CurrentNode := CurrentNode.NextSibling;
    end;
  end;
end;

{ TMetropolisUITile }

constructor TLiveTile.Create(AOwner: TComponent);
begin
  inherited;

  // sub-objects initialization
  FNarrowTile := TTileInfo.Create(self, trNarrowTile);
  FWideTile := TTileInfo.Create(self, trWideTile);

  // default values (some of which should match the values of the default application manifest)
  FServicePort := 8081; // default value, actual one loaded form Registry
  FBackgroundColor := TColor($324352);
  FIncludeWideTile := True;
  FCertificateName := 'tileproxy.test';
  FPublisherName   := FCertificateName;

  // initialize AppID, if loading from stream existing value overrides this one
  if (csDesigning in ComponentState) then
    FAppID := Copy(TGUID.NewGUID.ToString, 2, 36); // remove { and }

  // turns into a do nothing component if not on Windows 8
  FMetropolisAvailable := (TOSVersion.Platform = pfWindows) and TOSVersion.Check(6, 2);
  if not FMetropolisAvailable then
    NotifyError(teUnsupportedOS);
end;

class constructor TLiveTile.CreateClass;
begin
  FNarrowTemplates := TStringList.Create;
  // do not translate tile names, part of a Window SDK enumeration
  FNarrowTemplates.Add('TileSquareBlock01=' + TileSquareBlock01);
  FNarrowTemplates.Add('TileSquareText01=' + TileSquareText01);
  FNarrowTemplates.Add('TileSquareText02=' + TileSquareText02);
  FNarrowTemplates.Add('TileSquareText03=' + TileSquareText03);
  FNarrowTemplates.Add('TileSquareText04=' + TileSquareText04);
  FNarrowTemplates.Add('TileSquareImage=' + TileSquareImage);
  FNarrowTemplates.Add('TileSquarePeekImageAndText01=' + TileSquarePeekImageAndText01);
  FNarrowTemplates.Add('TileSquarePeekImageAndText02=' + TileSquarePeekImageAndText02);
  FNarrowTemplates.Add('TileSquarePeekImageAndText03=' + TileSquarePeekImageAndText03);
  FNarrowTemplates.Add('TileSquarePeekImageAndText04=' + TileSquarePeekImageAndText04);

  FWideTemplates := TStringList.Create;
  FWideTemplates.Add('TileWideText01=' + TileWideText01);
  FWideTemplates.Add('TileWideText02=' + TileWideText02);
  FWideTemplates.Add('TileWideText03=' + TileWideText03);
  FWideTemplates.Add('TileWideText04=' + TileWideText04);
  FWideTemplates.Add('TileWideText05=' + TileWideText05);
  FWideTemplates.Add('TileWideText06=' + TileWideText06);
  FWideTemplates.Add('TileWideText07=' + TileWideText07);
  FWideTemplates.Add('TileWideText08=' + TileWideText08);
  FWideTemplates.Add('TileWideText09=' + TileWideText09);
  FWideTemplates.Add('TileWideText10=' + TileWideText10);
  FWideTemplates.Add('TileWideText11=' + TileWideText11);
  FWideTemplates.Add('TileWideImage=' + TileWideImage);
  FWideTemplates.Add('TileWideImageAndText01=' + TileWideImageAndText01);
  FWideTemplates.Add('TileWideImageAndText02=' + TileWideImageAndText02);
  FWideTemplates.Add('TileWideBlockAndText01=' + TileWideBlockAndText01);
  FWideTemplates.Add('TileWideBlockAndText02=' + TileWideBlockAndText02);
  FWideTemplates.Add('TileWideSmallImageAndText01=' + TileWideSmallImageAndText01);
  FWideTemplates.Add('TileWideSmallImageAndText02=' + TileWideSmallImageAndText02);
  FWideTemplates.Add('TileWideSmallImageAndText03=' + TileWideSmallImageAndText03);
  FWideTemplates.Add('TileWideSmallImageAndText04=' + TileWideSmallImageAndText04);
  FWideTemplates.Add('TileWideSmallImageAndText05=' + TileWideSmallImageAndText05);
  FWideTemplates.Add('TileWidePeekImageCollection01=' + TileWidePeekImageCollection01);
  FWideTemplates.Add('TileWidePeekImageCollection02=' + TileWidePeekImageCollection02);
  FWideTemplates.Add('TileWidePeekImageCollection03=' + TileWidePeekImageCollection03);
  FWideTemplates.Add('TileWidePeekImageCollection04=' + TileWidePeekImageCollection04);
  FWideTemplates.Add('TileWidePeekImageCollection05=' + TileWidePeekImageCollection05);
  FWideTemplates.Add('TileWidePeekImageCollection06=' + TileWidePeekImageCollection06);
  FWideTemplates.Add('TileWidePeekImageAndText01=' + TileWidePeekImageAndText01);
  FWideTemplates.Add('TileWidePeekImageAndText02=' + TileWidePeekImageAndText02);
  FWideTemplates.Add('TileWidePeekImage01=' + TileWidePeekImage01);
  FWideTemplates.Add('TileWidePeekImage02=' + TileWidePeekImage02);
  FWideTemplates.Add('TileWidePeekImage03=' + TileWidePeekImage03);
  FWideTemplates.Add('TileWidePeekImage04=' + TileWidePeekImage04);
  FWideTemplates.Add('TileWidePeekImage05=' + TileWidePeekImage05);
  FWideTemplates.Add('TileWidePeekImage06=' + TileWidePeekImage06);
end;

destructor TLiveTile.Destroy;
begin
  FNarrowTile.Free;
  FWideTile.Free;
  FUdpateThread.Free; // also terminates the thread

  if not(csDesigning in ComponentState) then
    PostDeactivation;

  inherited;
end;

class destructor TLiveTile.DestroyClass;
begin
  FNarrowTemplates.Free;
  FWideTemplates.Free;
end;

type
  TLockSetForegroundWindow = function(uLockCode: Integer): LongBool; stdcall;
  TAllowSetForegroundWindow = function(dwProcessId: Cardinal): LongBool; stdcall;
  TSwitchToThisWindow = procedure(hWnd: THandle; fAltTab: LongBool); stdcall;

{$IFDEF MSWINDOWS}
  // procedure TMetropolisUITile.EnableBringToFront;
  // var
  // AllowSetForegroundWindow: TAllowSetForegroundWindow;
  // hLib: THandle;
  // pid: Cardinal;
  // begin
  // hLib := LoadLibrary ('user32.dll');
  // AllowSetForegroundWindow  := TAllowSetForegroundWindow (GetProcAddress (hLib, PAnsiChar('AllowSetForegroundWindow')));
  //
  // pid := GetCurrentProcessId();
  // if Assigned (AllowSetForegroundWindow) then
  // AllowSetForegroundWindow (pid);
  // FreeLibrary (hLib);
  // end;
{$ENDIF}

function TLiveTile.GetAppRegistryKey: string;
begin
  Result := registryPath + '\' + FAppID; // do not translate
end;

function TLiveTile.GetDesktopAppURL: string;
begin
  // format is "~/{appid}/{username}/controller"
  Result := Format('http://localhost:%d/api/%s/%s/DesktopApp', // do not translate
    [FServicePort, FAppID, UserName]);
end;

function GetUserLocalPath: string;
var
  LStr: array [0 .. MAX_PATH] of Char;
begin
  Result := '';
{$IFDEF MSWINDOWS}
  SetLastError(ERROR_SUCCESS);
  if SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, 0, @LStr) = S_OK then
    Result := LStr;
end;
{$ENDIF MSWINDOWS}

function TLiveTile.GetImageFolder: string;
begin
  if (FImageFolder = EmptyStr) and FMetropolisAvailable then
  begin
    FImageFolder := GetUserLocalPath + PathDelim + 'Packages' + // do not translate
      PathDelim + FFamilyName + PathDelim + 'LocalState' + // do not translate
      PathDelim;
  end;
  Result := FImageFolder;
end;

function TLiveTile.GetNarrowValue(ItemName: string): string;
begin
  Result := FNarrowTile.Items.Values[ItemName];
end;

function TLiveTile.GetUserProcessRegistryKey: string;
begin
  Result := GetAppRegistryKey + '\' + string(UserName) + '\ProcessControl';
end;

function TLiveTile.GetServiceTileURL: string;
begin
  // format is "~/{appid}/{username}/controller"
  Result := Format('http://localhost:%d/api/%s/%s/Tile', // do not translate
    [FServicePort, FAppID, UserName]);
end;

function TLiveTile.GetWideValue(ItemName: string): string;
begin
  Result := FWideTile.Items.Values[ItemName];
end;

function TLiveTile.GetXMLInfo: string;
begin
  if FIncludeWideTile then
    Result := tileOpenTag + FNarrowTile.GetXMLInfo + FWideTile.GetXMLInfo + tileCloseTag
  else
    Result := tileOpenTag + FNarrowTile.GetXMLInfo + tileCloseTag;
end;

{$IFDEF MSWINDOWS}
procedure TLiveTile.TileTimerProc(var aMessage: TMessage);
begin
  PostActivation;
  FUdpateThread := TTileThread.Create(self);
  KillTimer(0, FTimerId);
  FreeObjectInstance(FTimerProcInstance);
end;
{$ENDIF}

procedure TLiveTile.Loaded;
begin
  inherited;

  // read register keys and enable registry monitoring
  if FMetropolisAvailable and not(csDesigning in ComponentState) then
  begin
    ReadRegistryKeys;
    // CurrObj := self;
    // delayed activation, since the component has to wait for the main form to be created
    // to pass the handle to the Metropolis service
    FTimerProcInstance := MakeObjectInstance(TileTimerProc);
    FTimerId := SetTimer(0, 0, 1, FTimerProcInstance);
  end;
end;

procedure TLiveTile.NotifyError(TileError: TTileError);
begin
  if Assigned(FOnError) then
    FOnError(self, TileError);
end;

const
  jsonStructure = '{"Pid": %d, "ProcessPath": "%s", "Handle": "%s"}';

procedure TLiveTile.PostActivation;
var
  IdHTTP: TIdHTTP;
  strJson: string;
  pid: Cardinal;
  appPathName: string;
  stringStream: TStringStream;
  mainFormHandle: THandle;
begin
  if (csDesigning in ComponentState) or (not FMetropolisAvailable) then
    Exit;

  // prepare JSON data for REST call
  pid := GetCurrentProcessId();
  appPathName := GetModuleName(hInstance);
  appPathName := StringReplace(appPathName, '\', '\\', [rfReplaceAll]);

  TFindMainForms.ExtractHandles;
  mainFormHandle := TFindMainForms.hwndMain;

  strJson := Format(jsonStructure, [pid, appPathName, IntToStr (mainFormhandle)]);

  IdHTTP := TIdHTTP.Create(nil);
  try
    stringStream := TStringStream.Create(strJson, TEncoding.UTF8);
    try
      IdHTTP.Request.ContentType := 'application/json; charset=utf-8'; // do not translate
      try
        // POST will register the instance of the desktop application
        IdHTTP.Post(GetDesktopAppURL, stringStream);
      except
        NotifyError(teServiceNotResponding);
      end;
    finally
      stringStream.Free;
    end;
  finally
    IdHTTP.Free;
  end;
end;

{$IFDEF MSWINDOWS}
// Replace EIdSocketError to EIdSilentException for Id_WSAECONNREFUSED.
// Even if the server is not working, or running OS is no Windows8,
// IDE's debugger doesn't stop by EIdSilentException, however 
// You can still check the connection refuse error using FOnError.
type
  TIdLiveTileStack = class(TIdStackWindows)
  public
    procedure RaiseSocketError(AErr: Integer); override;
  end;

procedure TIdLiveTileStack.RaiseSocketError(AErr: Integer);
begin
  if AErr = Id_WSAECONNREFUSED then
    raise EIdSilentException.Create(WSTranslateSocketErrorMsg(AErr))
  else
    inherited;
end;
{$ENDIF MSWINDOWS}

procedure TLiveTile.PostDeactivation;
var
  IdHTTP: TIdHTTP;
begin
  if (csDesigning in ComponentState) or (not FMetropolisAvailable) then
    Exit;

  IdHTTP := TIdHTTP.Create(nil);
  try
    try
      // DELETE will unregister the instance of the desktop application
      IdHTTP.Delete(GetDesktopAppURL);
    except
      NotifyError(teServiceNotResponding);
    end;
  finally
    IdHTTP.Free;
  end;
end;

procedure TLiveTile.SetAppID(const Value: string);
begin
  FAppID := Value;
end;

procedure TLiveTile.SetAutoUpdate(const Value: Boolean);
begin
  FAutoUpdate := Value;
end;

procedure TLiveTile.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
end;

procedure TLiveTile.SetCertificateName(const Value: string);
begin
  FCertificateName := Value;
end;

procedure TLiveTile.SetIncludeWideTile(const Value: Boolean);
begin
  FIncludeWideTile := Value;
end;

procedure TLiveTile.SetMetropolisAppName(const Value: string);
begin
  FMetropolisAppName := Value;
end;

class procedure TLiveTile.SetNarrowTemplates(const Value: TStringList);
begin
  FNarrowTemplates.Assign(Value);
end;

procedure TLiveTile.SetNarrowTile(const Value: TTileInfo);
begin
  FNarrowTile.Assign(Value);
end;

procedure TLiveTile.SetNarrowValue(ItemName: string; const Value: string);
begin
  FNarrowTile.Items.Values[ItemName] := Value;
  if FAutoUpdate then
    UpdateTile;
end;

procedure TLiveTile.SetPublisherName(const Value: string);
begin
  FPublisherName := Value;
end;

class procedure TLiveTile.SetWideTemplates(const Value: TStringList);
begin
  FWideTemplates.Assign(Value);
end;

procedure TLiveTile.SetWideTile(const Value: TTileInfo);
begin
  FWideTile.Assign(Value);
end;

procedure TLiveTile.SetWideValue(ItemName: string; const Value: string);
begin
  FWideTile.Items.Values[ItemName] := Value;
  if FAutoUpdate then
    UpdateTile;
end;

procedure TLiveTile.ReadRegistryKeys;
{$IFDEF MSWINDOWS}
var
  reg: TRegistry;
{$ENDIF}
begin
  if not FMetropolisAvailable then
    Exit;

{$IFDEF MSWINDOWS}
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if not reg.KeyExists(registryPath) then
    begin
      NotifyError(teNoRegistryEntry);
      FMetropolisAvailable := False;
      Exit;
    end;

    reg.OpenKey(registryPath, False);
    try
      FServicePort := StrToIntDef(reg.GetDataAsString('Port'), 8081); // DEFAULT_PORT
    finally
      reg.CloseKey;
    end;

    reg.OpenKey(GetAppRegistryKey, True);
    try
      FFamilyName := reg.ReadString('Family');
    finally
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;
{$ENDIF}
end;

procedure TLiveTile.UpdateTile;
var
  strstr: TStringStream;
  sw: TStreamWriter;
  IdHTTP: TIdHTTP;
begin
  if (csDesigning in ComponentState) or (not FMetropolisAvailable) then
    Exit;

  // post XML data (UTF8 encoded) to Metropolis service via IdHTTP
  strstr := TStringStream.Create;
  try
    // write XML to the stream
    sw := TStreamWriter.Create(strstr, TEncoding.UTF8);
    try
      sw.Write(GetXMLInfo);
    finally
      sw.Free;
    end;
    // reset position
    strstr.Position := 0;
    // send XMl over HTTP
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.Request.ContentType := 'application/xml; charset=UTF-8'; // do not translate
      try
        IdHTTP.Post(GetServiceTileURL, strstr);
      except
        NotifyError(teServiceNotResponding);
      end;
    finally
      IdHTTP.Free;
    end;
  finally
    strstr.Free;
  end;
end;

function TLiveTile.UserName: string;
var
  buffer: array of Char;
  nBuffer: Cardinal;
begin
  if FUserName = '' then
  begin
    // call ADVAPI32.DLL GetUserName
    nBuffer := 256;
    SetLength(buffer, nBuffer);
    GetUserName(PChar(buffer), nBuffer);
    FUserName := StrPas(PChar(buffer));
  end;
  Result := FUserName;
end;

                                       
procedure TLiveTile.InternalNotifyTile;
var
  IdHTTP: TIdHTTP;
  stringStream: TStringStream;
begin
  if (csDesigning in ComponentState) or (not FMetropolisAvailable) then
    Exit;

  IdHTTP := TIdHTTP.Create(nil);
  try
    try
      IdHTTP.Request.ContentType := 'application/json; charset=utf-8';
      stringStream := TStringStream.Create('{"handle": "ok"}');
      try
        // PUT will ack the service the desktop application has processed the action
        IdHTTP.Put(GetDesktopAppURL, stringStream); // TStream(nil));
      finally
        stringStream.Free;
      end;
    except
      // do nothing, as there is currenlty an issue with the data length  -- was: NotifyError(teServiceNotResponding);
    end;
  finally
    IdHTTP.Free;
  end;
end;

{ TTileThread }

//procedure TTileThread.BringToFront;
//begin
//{$IFDEF MSWINDOWS}
//  MainFormUtils.TFindMainForms.ExtractHandles;
//  Synchronize(
//    procedure()
//    begin
//      if (GetForegroundWindow <> MainFormUtils.TFindMainForms.hwndMain) then
  // begin
//        SetForegroundWindow(MainFormUtils.TFindMainForms.hwndMain);
//      end;
  // end);
//{$ENDIF}
//end;

constructor TTileThread.Create(AMetropolisUITile: TLiveTile);
begin
  inherited Create(False); // start immediately after this initialization
  FMetropolisUITile := AMetropolisUITile;
  FUpdateEvent := TEvent.Create(nil, True, False, '');

{$IFDEF MSWINDOWS}
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_LOCAL_MACHINE;
  // should always be there, as it is created on activation (unless service is not active)
  try
    reg.OpenKey(FMetropolisUITile.GetUserProcessRegistryKey, True);
  except
    FMetropolisUITile.NotifyError(teNoRegistryEntry);
    Terminate;
    Exit;
  end;
  RegNotifyChangeKeyValue(reg.CurrentKey, False, REG_NOTIFY_CHANGE_LAST_SET,
    FUpdateEvent.Handle, True);
{$ENDIF}
end;

// "actions" used to communicate from service through the registry
const
  ProcessActionNoAction = 0;
  ProcessActionBringToFront = 1;
  ProcessActionTerminateProcess = 2;

destructor TTileThread.Destroy;
begin
  Terminate; // Set Terminated.
  FUpdateEvent.SetEvent; // wake up!
  inherited;
end;

procedure TTileThread.Execute;
var
  nAction: Integer;
begin
{$IFDEF MSWINDOWS}
  while not Terminated do
  begin
    if (FUpdateEvent.WaitFor(INFINITE) = wrSignaled) and (not Terminated) then
    begin
      nAction := StrToIntDef(reg.GetDataAsString('Action'), -1);

      // do specific update action
      case nAction of
        -1: Break; // exit thread.
        ProcessActionNoAction: ; // nothing to do
        ProcessActionBringToFront: ; // BringToFront;
        ProcessActionTerminateProcess:
        begin
          TerminateProcess;
          // acknowledge the REST service
          Synchronize(
            procedure()
            begin
              FMetropolisUITile.InternalNotifyTile;
            end);
        end;
      end;

      // wait for next change
      FUpdateEvent.ResetEvent;
      RegNotifyChangeKeyValue(reg.CurrentKey, False, REG_NOTIFY_CHANGE_LAST_SET,
        FUpdateEvent.Handle, True);
    end;
  end;
  reg.Free;
  FUpdateEvent.Free;
{$ENDIF}
end;

procedure TTileThread.TerminateProcess;
begin
  Terminate; // thread
{$IFDEF MSWINDOWS}
  TFindMainForms.ExtractHandles;
  PostMessage(TFindMainForms.hwndMain, WM_CLOSE, 0, 0);
{$ENDIF}
end;

initialization
  System.UIConsts.RegisterColorIntegerConsts;
{$IFDEF MSWINDOWS}
  IdStack.SetStackClass(TIdLiveTileStack);
{$ENDIF MSWINDOWS}
end.
