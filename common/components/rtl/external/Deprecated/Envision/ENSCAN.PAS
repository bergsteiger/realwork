{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnScan
|
| Description: Scanning class.
|
| History: Feb 28, 1999. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnScan;

{$I Envision.Inc}

interface

uses
    Windows,  { for THandle }
    SysUtils, { for Exception }
    EnTwain,  { for TTwainData }
    EnMisc;   { for TImageFormat, AddBackSlashToPath }

type


TScanner = class(TObject)
protected
    FTwainData   : TTwainData;

    { FCreated is set True when the object is properly created. This
      is used when destroying a partially created TScanner }
    FCreated     : Boolean;

    procedure LoadTwain;
    procedure UnloadTwain;

    function GetShowUI : Boolean;
    procedure SetShowUI( const Show : Boolean );

    function GetRequestedXDpi : Word;
    procedure SetRequestedXDpi( const Dpi : Word );

    function GetRequestedYDpi : Word;
    procedure SetRequestedYDpi( const Dpi : Word );

    function GetRequestedImageFormat : TImageFormat;
    procedure SetRequestedImageFormat( const ImageFormat : TImageFormat );


public
    constructor Create;
    destructor Destroy; override;

    { IsConfigured returns True if the scanner drivers are configured on
      computer. }
    function IsConfigured : Boolean;

    { Displays a modal dialog box which allows the user to select the
      scanner. Returns False on user cancel.}
    function SelectScanner : Boolean;

    procedure Acquire( const AcquireEvent : TAcquireEvent;
                       const CallBackData : LongInt );

    property  ShowUI : Boolean read GetShowUI
                               write SetShowUI;

    { these options are used  when ShowUI is set False before invoking
      Acquire.

      Defaults: RequestedXDpi        = 200
                RequestedYDpi        = 200
                RequestedImageFormat = ifBlackWhite

    }
    property  RequestedXDpi        : Word read GetRequestedXDpi
                                          write SetRequestedXDpi;

    property  RequestedYDpi        : Word read GetRequestedYDpi
                                          write SetRequestedYDpi;

    property  RequestedImageFormat : TImageFormat
                                       read GetRequestedImageFormat
                                       write SetRequestedImageFormat;
end;

EScannerError = class(Exception);

{--------------------------------------------------------------------------}

implementation

uses
    EnMsg;    { msgXXXX }

var

InstanceCreated : Boolean;

{--------------------------------------------------------------------------}

constructor TScanner.Create;
begin
    inherited Create;

    if InstanceCreated then
        raise EScannerError.Create(msgOnlyOneScannerObjectPermitted);

    FillChar(FTwainData, SizeOf(FTwainData), 0);
    with FTwainData.AppId do
    begin
        Id := 0;
        Version.MajorNum   := 1;
        Version.MinorNum   := 0;
        Version.Language   := TWLG_ENG;
        Version.Country    := TWCY_USA;
        StrPCopy(@Version.Info, '');

        ProtocolMajor      := TWON_PROTOCOLMAJOR;
        ProtocolMinor      := TWON_PROTOCOLMINOR;
        SupportedGroups    := DG_IMAGE or DG_CONTROL;
        StrPCopy(@Manufacturer, '');
        StrPCopy(@ProductFamily, '');
        StrPCopy(@ProductName, '');
    end;

    ShowUI               := True;
    RequestedXDpi        := 200;
    RequestedYDpi        := 200;
    RequestedImageFormat := ifBlackWhite;

    InstanceCreated     := True;

    FCreated            := True;

    { the drivers are only loaded upon the first usage }
end;

{--------------------------------------------------------------------------}

destructor TScanner.Destroy;
begin
    UnloadTwain;

    if FCreated then
        InstanceCreated := False;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

function TScanner.GetShowUI : Boolean;
begin
    Result := FTwainData.ShowUI;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetShowUI( const Show : Boolean );
begin
    FTwainData.ShowUI := Show;
end;

{--------------------------------------------------------------------------}

function TScanner.GetRequestedXDpi : Word;
begin
    Result := FTwainData.XDpi;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetRequestedXDpi( const Dpi : Word );
begin
    FTwainData.XDpi := Dpi;
end;

{--------------------------------------------------------------------------}

function TScanner.GetRequestedYDpi : Word;
begin
    Result := FTwainData.YDpi;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetRequestedYDpi( const Dpi : Word );
begin
    FTwainData.YDpi := Dpi;
end;

{--------------------------------------------------------------------------}

function TScanner.GetRequestedImageFormat : TImageFormat;
begin
    Result := FTwainData.ImageFormat;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetRequestedImageFormat( const ImageFormat : TImageFormat );
begin
    FTwainData.ImageFormat := ImageFormat;
end;

{--------------------------------------------------------------------------}

procedure TScanner.LoadTwain;
var
    TempStr       : String;
    Handle32      : TW_INT32;
begin
    if FTwainData.DllHandle <> 0 then
        Exit; { already loaded }

    SetLength(TempStr, 255);

    if GetWindowsDirectory(PChar(TempStr), 255) = 0 then
        raise EScannerError.Create('GetWindowsDirectory failed');

    SetLength(TempStr, StrLen(PChar(TempStr)));

    TempStr := AddBackSlashToPath(TempStr) + CTwainDllFileName;

    FTwainData.DllHandle := LoadLibrary(PChar(TempStr));

    if FTwainData.DllHandle <=  HINSTANCE_ERROR then
    begin
        { set DllHandle to 0 for proper clean up in UnloadTwain}
        FTwainData.DllHandle := 0;
        raise EScannerError.Create('LoadLibrary(' + TempStr + ') failed');
    end;

    TempStr := 'DSM_Entry';

    FTwainData.DSMEntry := TDSM_Entry(GetProcAddress(
                                        FTwainData.DLLHandle, PChar(TempStr)));

    if @FTwainData.DSMEntry = nil then
        raise EScannerError.Create('GetProcAddress failed: ' + TempStr);

    FTwainData.ParentHandle := CreateWindow(
                                 PChar('STATIC'), PChar('Twain Window'),
                                 WS_POPUPWINDOW,
                                 Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                                 Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                                 HWND_DESKTOP,
                                 0,
                                 hInstance,
                                 nil);
    if FTwainData.ParentHandle = 0 then
        raise EScannerError.Create('CreateWindow failed');

    Handle32 := FTwainData.ParentHandle;
    if not CallTriplet( nil, @FTwainData.AppId,
                        DG_CONTROL, DAT_PARENT, MSG_OPENDSM,
                        @Handle32, nil, FTwainData.DsmEntry) then
        raise EScannerError.Create(msgUnableToOpenTWAINSourceManager);

    { assert: TWAIN is currently in state 4, 'Source Opened' }
end;

{--------------------------------------------------------------------------}

procedure TScanner.UnloadTwain;
var
    Handle32      : TW_INT32;
begin
    if FTwainData.ParentHandle <> 0 then
    begin
        Handle32 := FTwainData.ParentHandle;
        CallTriplet( nil, @FTwainData.AppId,
                     DG_CONTROL, DAT_PARENT, MSG_CLOSEDSM, @Handle32,
                     nil, FTwainData.DsmEntry);

        DestroyWindow(FTwainData.ParentHandle);
        FTwainData.ParentHandle := 0;
    end;

    if FTwainData.DLLHandle <> 0 then
    begin
        FreeLibrary(FTwainData.DLLHandle);

        FTwainData.DLLHandle := 0;
        FTwainData.DSMEntry  := nil;
    end;
end;

{--------------------------------------------------------------------------}

function TScanner.SelectScanner : Boolean;
begin
    LoadTwain;

    FillChar(FTwainData.SourceId, SizeOf(FTwainData.SourceId), 0);

    Result := CallTriplet( nil, @FTwainData.AppId,
                           DG_CONTROL, DAT_IDENTITY, MSG_USERSELECT,
                           @FTwainData.SourceId, nil, FTwainData.DsmEntry);
end;

{--------------------------------------------------------------------------}

function TScanner.IsConfigured : Boolean;
begin
    { check is loaded first }
    Result := (FTwainData.DLLHandle <> 0);

    if not Result then
    begin
        Result := True;
        try
            LoadTwain;
        except
            Result := False;
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TScanner.Acquire( const AcquireEvent : TAcquireEvent;
                            const CallBackData : LongInt );

    { applies the current options in pTwainData^ to the currently opened
      source. }
    procedure ApplyOptions;
    var
        Fix32     : TW_FIX32;
        PixelType : TW_UINT16;
        BitDepth  : TW_UINT16;

    begin
        Fix32.Whole := FTwainData.XDpi;
        Fix32.Frac  := 0;
        SetSingleValueCap( ICAP_XRESOLUTION, TWTY_FIX32, Fix32.Long,
                           @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

        Fix32.Whole := FTwainData.YDpi;
        Fix32.Frac  := 0;
	SetSingleValueCap( ICAP_YRESOLUTION, TWTY_FIX32, Fix32.Long,
                           @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

        case FTwainData.ImageFormat of

            ifBlackWhite :
            begin
                PixelType := TWPT_BW;
                BitDepth  := 1;
            end;

            ifGray16 :
            begin
                PixelType := TWPT_GRAY;
                BitDepth  := 4;
            end;

            ifGray256:
            begin
                PixelType := TWPT_GRAY;
                BitDepth  := 8;
            end;

            ifColor16 :
            begin
                PixelType := TWPT_PALETTE;
                BitDepth  := 4;
            end;

            ifColor256:
            begin
                PixelType := TWPT_PALETTE;
                BitDepth  := 8;
            end;

            ifTrueColor:
            begin
                PixelType := TWPT_RGB;
                BitDepth  := 24;
            end;

            else
                raise ETwainError.Create('Invalid image type');
        end; { case }

        { NOTE: pixel type must be set before bit depth }
  	SetSingleValueCap( ICAP_PIXELTYPE, TWTY_UINT16, PixelType,
                           @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);
        SetSingleValueCap( ICAP_BITDEPTH, TWTY_UINT16, BitDepth,
                           @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);
    end; { ApplyOptions }

var
    WasEnabled    : Boolean;
    TwainUI       : TW_USERINTERFACE;

begin
    LoadTwain;

    FillChar(FTwainData.SourceId, SizeOf(FTwainData.SourceId), 0);
    if not CallTriplet( nil, @FTwainData.AppId, DG_CONTROL, DAT_IDENTITY, MSG_OPENDS,
                        @FTwainData.SourceId, nil, FTwainData.DsmEntry) then
        raise ETwainError.Create('Unable to open TWAIN data source');
    try
        WasEnabled := not EnableWindow(FTwainData.ParentHandle, False);
        try
            { ensure native transfer mode is used }
            SetSingleValueCap( ICAP_XFERMECH, TWTY_UINT16, TWSX_NATIVE,
                               @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

            { ensure any number of images may be scanned }
            SetSingleValueCap( CAP_XFERCOUNT, TWTY_INT16, -1,
                               @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

            { ensure units is inches }
            SetSingleValueCap( ICAP_UNITS, TWTY_UINT16, TWUN_INCHES,
                               @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

            { apply the options even if ShowUI is True, as this may set the default
              in the scanner's interface. }
            ApplyOptions;

            FillChar(TwainUI, SizeOf(TwainUI), 0);
            TwainUI.ShowUI  := FTwainData.ShowUI;
            TwainUI.hParent := FTwainData.ParentHandle;

            if not CallTriplet( @FTwainData.SourceId, @FTwainData.AppId,
                                DG_CONTROL, DAT_USERINTERFACE,
                                MSG_ENABLEDS, @TwainUI, nil, FTwainData.DsmEntry) then
                raise ETwainError.Create('Unable to enable twain source.');

            try
                ProcessImages( AcquireEvent,
                               @FTwainData.SourceId, @FTwainData.AppId,
                               FTwainData.DsmEntry, CallBackData);
            finally
                CallTriplet(
                    @FTwainData.SourceId, @FTwainData.AppId,
                    DG_CONTROL, DAT_USERINTERFACE, MSG_DISABLEDS, @TwainUI,
                    nil, FTwainData.DsmEntry);
            end;

        finally
            EnableWindow(FTwainData.ParentHandle, WasEnabled);
        end;

    finally
        if FTwainData.SourceId.Id <> 0 then
        begin
            if not CallTriplet( nil, @FTwainData.AppId, DG_CONTROL, DAT_IDENTITY, MSG_CLOSEDS,
                                @FTwainData.SourceId, nil, FTwainData.DsmEntry) then
                raise ETwainError.Create('Unable to close TWAIN data source');

            FillChar(FTwainData.SourceId, SizeOf(FTwainData.SourceId), 0);
        end;
    end;
end;

{--------------------------------------------------------------------------}

initialization
    InstanceCreated := False;
end.
