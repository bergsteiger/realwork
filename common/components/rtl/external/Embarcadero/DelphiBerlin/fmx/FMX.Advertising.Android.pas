{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.Advertising.Android;

interface

uses System.SysUtils;

{$SCOPEDENUMS ON}

procedure RegisterAdvertisingService;
procedure UnregisterAdvertisingService;

type
  ETestModeException = Exception;

implementation

uses
  System.Classes, System.Types, System.Generics.Collections, FMX.Controls, FMX.Types, FMX.Forms, System.Messaging,
  Androidapi.Helpers, FMX.Platform, FMX.Platform.Android, FMX.Advertising, FMX.Helpers.Android, Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes, Androidapi.JNI.Embarcadero, Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.AdMob,
  Androidapi.JNI.Os, FMX.Consts, Androidapi.JNI.App;

function IsPortrait: Boolean;
var
  ScreenService: IFMXScreenService;
begin
  Result := True;
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, ScreenService) then
    Result := ScreenService.GetScreenOrientation in [TScreenOrientation.Portrait,
      TScreenOrientation.InvertedPortrait];
end;

type
  TAndroidBannerAd = class;

  TAdViewListener = class(TJavaLocal, JIAdListener)
  private
    FAd : TAndroidBannerAd;
  public
    constructor Create(Ad: TAndroidBannerAd);
    destructor Destroy; override;
    procedure onAdClosed; cdecl;
    procedure onAdFailedToLoad(errorCode: Integer); cdecl;
    procedure onAdLeftApplication; cdecl;
    procedure onAdOpened; cdecl;
    procedure onAdLoaded; cdecl;
  end;

  TAndroidAdvertisingService = class(TInterfacedObject, IFMXAdvertisingService, IFMXAdvertisingTestModeService)
  private
    FTestDeviceID: string;
    FUseTestAds: Boolean;
  public
    constructor Create;
    { IFMXAdvertisingService }
    function CreateBannerAd(const AOwner: TCustomBannerAd): IBannerAd;
    procedure RemoveAd(const Ad: ICommonAd);
    { IFMXAdvertisingTestModeService }
    procedure SetTestMode(AValue: Boolean);
    function GetTestMode: Boolean;
    procedure SetTestModeDeviceID(const ADeviceID: string);
  end;

  TAndroidBannerAd = class(TInterfacedObject, IBannerAd)
  private
    FJAd : JAdView;
    FJAdRequest: JAdRequest;
    FScale : Single;
    FJNativeLayout: JNativeLayout;
    FAdViewListener: TAdViewListener;
    FAdControl: TCustomBannerAd;
    FAdUnitID: string;
    FBounds: TRect;
    FRealBounds : TRect;
    FOrientationChangedId: Integer;
    FActionIsInProgress: Boolean;
    FLoaded: Boolean;
    //This needs to be executed on the UI thread (the Java UI thread)
    procedure InitAd;
    //This needs to be executed on the UI thread (the Java UI thread)
    procedure FreeAd;
    procedure SetPositionUIThread;
    procedure CalcRealBorder;
    procedure OrientationChangedHandler(const Sender: TObject; const Msg: TMessage);
  protected
    function GetParent: TFmxObject;
    function GetVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure UpdateControlMetrics;
    procedure UpdateContentFromControl;
  public
    constructor Create(const AOwner: TCustomBannerAd);
    destructor Free;
    { ICommonAd }
    procedure CancelAction;
    function IsActionInProgress: Boolean;
    function IsLoaded: Boolean;
    function GetAdUnitID: string;
    procedure SetAdUnitID(const Value: string);
    procedure LoadAd;
    { IBannerAd }
    procedure SetBannerAdControl(const AValue: TCustomBannerAd);
  end;

var
  AdvertisingService : TAndroidAdvertisingService;

{ TAndroidAdvertisingService }

constructor TAndroidAdvertisingService.Create;
begin
  inherited Create;
  FUseTestAds := False;
end;

function TAndroidAdvertisingService.CreateBannerAd(const AOwner: TCustomBannerAd): IBannerAd;
begin
  Result := TAndroidBannerAd.Create(AOwner);
end;

procedure TAndroidAdvertisingService.RemoveAd(const Ad: ICommonAd);
begin
end;

procedure TAndroidAdvertisingService.SetTestModeDeviceID(const ADeviceID: string);
begin
  FTestDeviceID := ADeviceID;
end;

procedure TAndroidAdvertisingService.SetTestMode(AValue: Boolean);
begin
  if AValue then
  begin
    if FTestDeviceID = '' then
      FTestDeviceID := JStringToString(MainActivity.getDeviceID);
    if FTestDeviceID = '' then
      raise ETestModeException.Create(SCannotGetDeviceIDForTestAds);
  end;
  FUseTestAds := AValue;
end;

function TAndroidAdvertisingService.GetTestMode: Boolean;
begin
  Result := FUseTestAds;
end;

{ TAndroidBannerAd }

constructor TAndroidBannerAd.Create(const AOwner: TCustomBannerAd);
var
  ScreenService: IFMXScreenService;
begin
  inherited Create;
  FAdControl := AOwner;
  CalcRealBorder;
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, ScreenService) then
    FScale := ScreenService.GetScreenScale
  else
    FScale := 1;
  FOrientationChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, OrientationChangedHandler);
end;

destructor TAndroidBannerAd.Free;
begin
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, FOrientationChangedId);
  if FAdUnitId <> '' then
    CallInUIThread(FreeAd);
  inherited Destroy;
end;

procedure TAndroidBannerAd.CalcRealBorder;
var
  NativeWin: JWindow;
  DecorView: JView;
  ContentRect: JRect;
begin
  NativeWin := TAndroidHelper.Activity.getWindow;
  if NativeWin <> nil then
  begin
    ContentRect := TJRect.Create;
    DecorView := NativeWin.getDecorView;
    DecorView.getWindowVisibleDisplayFrame(ContentRect);
    FRealBounds := TRect.Create(ContentRect.left, ContentRect.top, ContentRect.right, ContentRect.bottom);
  end;
end;

procedure TAndroidBannerAd.CancelAction;
begin
  //Android doesn't offer a way to do this
end;

procedure TAndroidBannerAd.FreeAd;
begin
  FJNativeLayout := nil;
  FJAdRequest := nil;
  FJAd.setAdListener(nil);
  FAdViewListener := nil;
  if FJAd <> nil then
    FJAd.destroy;
  FJAd := nil;
  FLoaded := False;
end;

function TAndroidBannerAd.GetAdUnitID: string;
begin
  Result := FAdUnitID;
end;

function TAndroidBannerAd.GetParent: TFmxObject;
begin
  Result := nil;
  if FAdControl <> nil then
    Result := FAdControl.Parent;
end;

function TAndroidBannerAd.GetVisible: Boolean;
begin
  Result := False;
  if FAdControl <> nil then
    Result := FAdControl.Visible;
end;

procedure TAndroidBannerAd.Hide;
begin
  CallInUIThread(
    procedure
    begin
      if (FJAd <> nil) and (FJAd.getVisibility <> TJView.JavaClass.INVISIBLE) then
      begin
        FJAd.setVisibility(TJView.JavaClass.INVISIBLE);
        if FJNativeLayout <> nil then
          FJNativeLayout.SetPosition(FRealBounds.Right * 2 , FRealBounds.Height * 2);
      end;
    end);
end;

procedure TAndroidBannerAd.InitAd;
var
  LAdSize: JAdSize;
  RequestBuilder: JAdRequest_Builder;
begin
  if FAdControl <> nil then
    case FAdControl.AdSize of
      TBannerAdSize.Auto:
        LAdSize := TJAdSize.JavaClass.SMART_BANNER;
      TBannerAdSize.Small:
        LAdSize := TJAdSize.JavaClass.BANNER;
      TBannerAdSize.Medium:
        LAdSize := TJAdSize.JavaClass.FULL_BANNER;
      TBannerAdSize.Large:
        LAdSize := TJAdSize.JavaClass.LEADERBOARD;
    end
  else
    LAdSize := TJAdSize.JavaClass.SMART_BANNER;
  FJAd := TJAdView.JavaClass.init(TAndroidHelper.Activity);
  FJAd.setAdUnitId(StringToJString(FAdUnitID));
  FJAd.setAdSize(LAdSize);

  FAdViewListener := TAdViewListener.Create(Self);
  FJAd.setAdListener(TJAdListenerAdapter.JavaClass.init(FAdViewListener));

  if FJAdRequest = nil then
  begin
    RequestBuilder := TJAdRequest_Builder.JavaClass.init();
    if AdvertisingService.FUseTestAds then
        RequestBuilder.addTestDevice(StringToJString(AdvertisingService.FTestDeviceID));
    RequestBuilder.addTestDevice(TJAdRequest.JavaClass.DEVICE_ID_EMULATOR);
    FJAdRequest := RequestBuilder.build;
  end;

  FJAd.loadAd(FJAdRequest);
end;

function TAndroidBannerAd.IsActionInProgress: Boolean;
begin
  Result := FActionIsInProgress;
end;

function TAndroidBannerAd.IsLoaded: Boolean;
begin
  Result := FLoaded;
end;

procedure TAndroidBannerAd.LoadAd;
begin
  FLoaded := False;
  if FJAd <> nil then
    CallInUIThreadAndWaitFinishing(FreeAd);
  CallInUIThreadAndWaitFinishing(InitAd);
end;

procedure TAndroidBannerAd.OrientationChangedHandler(const Sender: TObject; const Msg: TMessage);
var
  OldControl: TCustomBannerAd;
begin
  if (FAdControl <> nil) and FAdControl.Visible then
  begin
    //Avoid issue with portrait ad still being visible when form has rotated to landscape
    Hide;
    //Kill off existing ad and recreate it
    LoadAd;
    //Kill off old layout and recreate it
    OldControl := FAdControl;
    SetBannerAdControl(nil);
    SetBannerAdControl(OldControl);
    UpdateContentFromControl;
  end;
end;

procedure TAndroidBannerAd.SetAdUnitID(const Value: string);
begin
  FAdUnitID := Value;
end;

procedure TAndroidBannerAd.SetBannerAdControl(const AValue: TCustomBannerAd);
begin
  FAdControl := AValue;
  if FAdControl = nil then
    FJNativeLayout := nil
  else
    CallInUIThreadAndWaitFinishing(
      procedure
      begin
        if FJNativeLayout = nil then
          FJNativeLayout := TJNativeLayout.JavaClass.init(TAndroidHelper.Activity, MainActivity.getTextEditorProxy.getWindowToken);
        FJNativeLayout.SetPosition(Round(FAdControl.Position.X), Round(FAdControl.Position.Y));
        FJNativeLayout.SetSize(Round(FAdControl.Width), Round(FAdControl.Height));
        FJNativeLayout.SetControl(FJAd);
        FJNativeLayout.SetFocus(False);
        UpdateControlMetrics;
      end);
end;

procedure TAndroidBannerAd.SetPositionUIThread;
begin
  FJNativeLayout.SetPosition(FBounds.Left, FBounds.Top);
  FJNativeLayout.SetSize(FBounds.Right, FBounds.Bottom);
end;

procedure TAndroidBannerAd.Show;
begin
  CallInUIThread(
    procedure
    begin
      SetPositionUIThread;
      if FJAd.getVisibility <> TJView.JavaClass.VISIBLE then
        FJAd.setVisibility(TJView.JavaClass.VISIBLE);
    end);
end;

procedure TAndroidBannerAd.UpdateContentFromControl;
var
  Pos: TPointF;
begin
  if (FAdControl = nil) or not IsLoaded then
    Exit;
  while FJNativeLayout = nil do
    Application.ProcessMessages;
  if FJNativeLayout <> nil then
  begin
    if (FAdControl <> nil) and not(csDesigning in FAdControl.ComponentState) and (FAdControl.Root <> nil) and
      (FAdControl.Root.GetObject is TCommonCustomForm) then
    begin
      if FAdControl.Parent is TCommonCustomForm then
        Pos := TPointF.Create(Round(FAdControl.Position.X * FScale), Round(FAdControl.Position.Y * FScale))
      else
        Pos := (FAdControl.Parent as IControl).LocalToScreen(FAdControl.Position.Point);
      FBounds := TRect.Create(Round(Pos.X), Round(Pos.Y), Round(FAdControl.Width * FScale), Round(FAdControl.Height * FScale));
      if FAdControl.Visible and FAdControl.ParentedVisible and (FAdControl.Root.GetObject as TCommonCustomForm).Visible then
        Show
      else
        Hide;
    end
    else
      Hide;
  end;
end;

procedure TAndroidBannerAd.UpdateControlMetrics;
var
  Frame: TRectF;
  Form: TCommonCustomForm;
const
  AdHeightPortrait = 90;
  AdHeightLandscape = 90;
  AdHeightPhonePortrait = 50;
  AdHeightPhoneLandscape = 32;
  AndroidSW600DP = 600;
  AndroidSW600DPLandscape = 552;
  AdMobBannerHeight = 50;
  AdMobFullBannerHeight = 60;
  AdMobLeaderboardHeight = 90;
begin
  if (FAdControl <> nil) and not Assigned(FAdControl.OnResize) then
  begin
    case FAdControl.AdSize of
      TBannerAdSize.Auto:
        begin
          if Screen.Size.Height > Screen.Size.Width then
            if Screen.Size.Width < AndroidSW600DP then
              FAdControl.Height := AdHeightPhonePortrait
            else
              FAdControl.Height := AdHeightPortrait
          else
            if Screen.Size.Height < AndroidSW600DPLandscape then
              FAdControl.Height := AdHeightPhoneLandscape
            else
              FAdControl.Height := AdHeightLandscape;
        end;
      TBannerAdSize.Small:
        FAdControl.Height := AdMobBannerHeight;
      TBannerAdSize.Medium:
        FAdControl.Height := AdMobFullBannerHeight;
      TBannerAdSize.Large:
        FAdControl.Height := AdMobLeaderboardHeight;
    end;

    if Screen.ActiveForm <> nil then
      Form := Screen.ActiveForm
    else if Application.MainForm <> nil then
      Form := Application.MainForm
    else
      Form := nil;
    if Form <> nil then
    begin
      Frame := WindowHandleToPlatform(Form.Handle).Bounds;
      FAdControl.Width := Round(Frame.Width);
    end;
  end;
end;

{ TAdViewListener }

constructor TAdViewListener.Create(Ad: TAndroidBannerAd);
begin
  inherited Create;
  FAd := Ad;
end;

destructor TAdViewListener.Destroy;
begin
  FAd := nil;
  inherited;
end;

procedure TAdViewListener.onAdClosed;
begin
  if FAd.FAdControl <> nil then
    FAd.FAdControl.DoActionDidFinish;
  FAd.FActionIsInProgress := True;
end;

procedure TAdViewListener.onAdFailedToLoad(errorCode: Integer);
begin
  if FAd.FAdControl <> nil then
    FAd.FAdControl.DoDidFail(Format(SAdFailedToLoadError, [errorCode]));
end;

procedure TAdViewListener.onAdLeftApplication;
var
  ToBeDeleted: Boolean;
begin
  ToBeDeleted := True;
  if FAd.FAdControl <> nil then
    FAd.FAdControl.DoActionCanBegin(ToBeDeleted);
  FAd.FActionIsInProgress := True;
end;

procedure TAdViewListener.onAdOpened;
var
  ToBeDeleted: Boolean;
begin
  ToBeDeleted := False;
  if FAd.FAdControl <> nil then
    FAd.FAdControl.DoActionCanBegin(ToBeDeleted);
  FAd.FActionIsInProgress := True;
end;

procedure TAdViewListener.onAdLoaded;
begin
  if FAd.FAdControl <> nil then
  begin
    FAd.FLoaded := True;
    FAd.FAdControl.DoDidLoad;
  end;
end;

procedure RegisterAdvertisingService;
begin
  AdvertisingService := TAndroidAdvertisingService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXAdvertisingService, AdvertisingService);
  TPlatformServices.Current.AddPlatformService(IFMXAdvertisingTestModeService, AdvertisingService);
end;

procedure UnregisterAdvertisingService;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXAdvertisingService);
  TPlatformServices.Current.RemovePlatformService(IFMXAdvertisingTestModeService);
end;

end.
