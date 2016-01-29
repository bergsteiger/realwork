{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Platform;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.Rtti, System.UITypes,
  System.Generics.Collections, FMX.Types, FMX.Forms, FMX.Dialogs, FMX.Text;

type
  EInvalidFmxHandle = class(Exception);
  EUnsupportedPlatformService = class(Exception)
    constructor Create(const Msg: string);
  end;

  TPlatformServices = class
  private
    FServicesList: TDictionary<TGUID, IInterface>;
    FGlobalFlags: TDictionary<string, Boolean>;
    class var FCurrentPlatform: TPlatformServices;
    class function GetCurrent: TPlatformServices; static;
  public
    constructor Create;
    destructor Destroy; override;
    class procedure UnInitialize;
    procedure AddPlatformService(const AServiceGUID: TGUID; const AService: IInterface);
    procedure RemovePlatformService(const AServiceGUID: TGUID);
    function GetPlatformService(const AServiceGUID: TGUID): IInterface;
    function SupportsPlatformService(const AServiceGUID: TGUID): Boolean; overload;
    function SupportsPlatformService(const AServiceGUID: TGUID;
      out AService: IInterface): Boolean; overload;
    property GlobalFlags: TDictionary<string, Boolean> read FGlobalFlags;
    class property Current: TPlatformServices read GetCurrent;
  end;

  IFMXApplicationService = interface(IInterface)
    ['{EFBE3310-D103-4E9E-A8E1-4E45AB46D0D8}']
    procedure Run;
    procedure Terminate;
    function HandleMessage: Boolean;
    procedure WaitMessage;
    function GetTitle: string;
    function Terminating: Boolean;
  end;

  TApplicationEvent = (aeFinishedLaunching, aeBecameActive, aeWillBecomeInactive,
    aeEnteredBackground, aeWillBecomeForeground, aeWillTerminate, aeLowMemory,
    aeTimeChange, aeOpenURL);
  TApplicationEventHandler = function(AAppEvent: TApplicationEvent; AContext: TObject): Boolean of object;
  IFMXApplicationEventService = interface(IInterface)
    ['{F3AAF11A-1678-4CC6-A5BF-721A24A676FD}']
    procedure SetApplicationEventHandler(AEventHandler: TApplicationEventHandler);
  end;

  IFMXHideAppService = interface(IInterface)
    ['{D9E49FCB-6A8B-454C-B11A-CEB3CEFAD357}']
    function GetHidden: boolean;
    procedure SetHidden(const Value: boolean);
    procedure HideOthers;
    property Hidden: boolean read GetHidden write SetHidden;
  end;

  IFMXDeviceService = interface(IInterface)
    ['{9419B3C0-379A-4556-B5CA-36C975462326}']
    function GetModel: string;
  end;

  IFMXStyleService = interface(IInterface)
    ['{9EA04045-26A5-4210-870B-56F9CBB7146B}']
    function GetSystemStyle: TFmxObject;
  end;

  IFMXStyleHiResService = interface(IInterface)
    ['{265F896D-B5A9-480A-895E-EEEB813B49AD}']
    function GetSystemStyleHiRes: TFmxObject;
  end;

  IFMXSystemFontService = interface(IInterface)
    ['{62017F22-ADF1-44D9-A21D-796D8C7F3CF0}']
    function GetDefaultFontFamilyName: string;
  end;

  IFMXDragDropService = interface(IInterface)
    ['{73133536-5868-44B6-B02D-7364F75FAD0E}']
    procedure BeginDragDrop(AForm: TCommonCustomForm; const Data: TDragObject; ABitmap: TBitmap);
  end;

  IFMXClipboardService = interface(IInterface)
    ['{CC9F70B3-E5AE-4E01-A6FB-E3FC54F5C54E}']
    procedure SetClipboard(Value: TValue);
    function GetClipboard: TValue;
  end;

  IFMXScreenService = interface(IInterface)
    ['{BBA246B6-8DEF-4490-9D9C-D2CBE6251A24}']
    function GetScreenSize: TPointF;
    function GetScreenScale: Single;
    function GetScreenOrientation: TScreenOrientation;
  end;

  IFMXLocaleService = interface(IInterface)
    ['{311A40D4-3D5B-40CC-A201-78465760B25E}']
    function GetCurrentLangID: string;
    function GetLocaleFirstDayOfWeek: string;
  end;

  IFMXDialogService = interface(IInterface)
    ['{CF7DCC1C-B5D6-4B24-92E7-1D09768E2D6B}']
    function DialogOpenFiles(var FileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
      var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
    function DialogPrint(var ACollate, APrintToFile: Boolean;
      var AFromPage, AToPage, ACopies: Integer; AMinPage, AMaxPage: Integer; var APrintRange: TPrintRange;
      AOptions: TPrintDialogOptions): Boolean;
    function PageSetupGetDefaults(var AMargin, AMinMargin: TRect; var APaperSize: TPointF;
      AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
    function DialogPageSetup(var AMargin, AMinMargin: TRect; var APaperSize: TPointF;
      var AUnits: TPageMeasureUnits; AOptions: TPageSetupDialogOptions): Boolean;
    function DialogSaveFiles(var AFileName: TFileName; const AInitDir, ADefaultExt, AFilter, ATitle: string;
      var AFilterIndex: Integer; var AFiles: TStrings; var AOptions: TOpenOptions): Boolean;
    function DialogPrinterSetup: Boolean;
    function MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
      DefaultButton: TMsgDlgBtn; X, Y: Integer; HelpCtx: Longint; const HelpFileName: string): Integer;
    function InputQuery(const ACaption: string; const APrompts: array of string;
      var AValues: array of string; CloseQueryFunc: TInputCloseQueryFunc = nil): Boolean;
  end;

  IFMXLoggingService = interface(IInterface)
    ['{01BFC200-0493-4b3b-9D7E-E3CDB1242795}']
    procedure Log(Format: String; Params: array of const);
  end;

  IFMXTextService = interface(IInterface)
    ['{A5FECE29-9A9C-4E8A-8794-89271EC71F1A}']
    function GetTextServiceClass: TTextServiceClass;
  end;

  IFMXCanvasService = interface(IInterface)
    ['{476E5E53-A77A-4ADA-93E3-CA66A8956059}']
    procedure RegisterCanvasClasses;
    procedure UnregisterCanvasClasses;
  end;
  
  IFMXContextService = interface(IInterface)
    ['{EB6C9074-48B9-4A99-ABF4-BFB6FCF9C385}']
    procedure RegisterContextClasses;
    procedure UnregisterContextClasses;
  end;

{ System Information service }

  TScrollingBehaviour = (sbBoundsAnimation, sbAnimation, sbTouchTracking, sbAutoShowing);
  TScrollingBehaviours = set of TScrollingBehaviour;

  IFMXSystemInformationService = interface(IInterface)
    ['{2E01A60B-E297-4AC0-AA24-C5F52289EC1E}']
    { Scrolling information }
    function GetScrollingBehaviour: TScrollingBehaviours;
    function GetMinScrollThumbSize: Single;
    { Caret information }
    function GetCaretWidth: Integer;
  end;


  TComponentKind = (ckButton, ckLabel, ckEdit, ckScrollBar, ckListBoxItem);

  { Default metrics }
  IFMXDefaultMetricsService = interface(IInterface)
    ['{216841F5-C089-45F1-B350-E9B018B73441}']
    function SupportsDefaultSize(const AComponent: TComponentKind): Boolean;
    function GetDefaultSize(const AComponent: TComponentKind): TSize;
  end;

{ Generation tools }

  IFMXImageGeneratorService = interface(IInterface)
    ['{D8D50379-2ABE-4959-8FE7-3EF97BC68689}']
    function GenerateTabIcon(const ASource, ADest: TBitmap; const IsSelected, HiRes: Boolean): Boolean;
  end;

  { Platform-specific property defaults }
  IFMXDefaultPropertyValueService = interface(IInterface)
    ['{7E8A25A0-5FCF-49fa-990C-CEDE6ABEAE50}']
    function GetDefaultPropertyValue(const AClassName: string; const PropertyName: string): TValue;
  end;

implementation

uses
{$IFDEF IOS}
  FMX.Platform.iOS,
{$ELSE}
{$IFDEF MACOS}
  FMX.Platform.Mac,
{$ENDIF MACOS}
{$ENDIF IOS}
{$IFDEF MSWINDOWS}
  FMX.Platform.Win,
{$ENDIF}
  FMX.Consts;

{ TPlatformServices }

procedure TPlatformServices.AddPlatformService(const AServiceGUID: TGUID;
  const AService: IInterface);
begin
  if not FServicesList.ContainsKey(AServiceGUID) then
    FServicesList.Add(AServiceGUID, AService);
end;

constructor TPlatformServices.Create;
begin
  inherited;
  FServicesList := TDictionary<TGUID, IInterface>.Create;
  FGlobalFlags := TDictionary<string, Boolean>.Create;
end;

class procedure TPlatformServices.UnInitialize;
begin
  FreeAndNil(FCurrentPlatform);
  inherited;
end;

class function TPlatformServices.GetCurrent: TPlatformServices;
begin
  if FCurrentPlatform = nil then
    FCurrentPlatform := TPlatformServices.Create;
  Result := FCurrentPlatform;
end;

destructor TPlatformServices.Destroy;
begin
  FServicesList.Free;
  FGlobalFlags.Free;
  inherited;
end;

function TPlatformServices.GetPlatformService(const AServiceGUID: TGUID): IInterface;
begin
  Supports(FServicesList.Items[AServiceGUID], AServiceGUID, Result);
end;

procedure TPlatformServices.RemovePlatformService(const AServiceGUID: TGUID);
begin
  FServicesList.Remove(AServiceGUID);
end;

function TPlatformServices.SupportsPlatformService(const AServiceGUID: TGUID;
  out AService: IInterface): Boolean;
begin
  if FServicesList.ContainsKey(AServiceGUID) then
    Result := Supports(FServicesList.Items[AServiceGUID], AServiceGUID, AService)
  else
  begin
    AService := nil;
    Result := False;
  end;
end;

function TPlatformServices.SupportsPlatformService(const AServiceGUID: TGUID): Boolean;
begin
  Result := FServicesList.ContainsKey(AServiceGUID);
end;

{ EUnsupportedPlatformService }

constructor EUnsupportedPlatformService.Create(const Msg: string);
begin
  inherited CreateResFmt(@SUnsupportedPlatformService, [Msg]);
end;

initialization
  RegisterCorePlatformServices;
end.

