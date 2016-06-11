{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.Advertising.iOS;

interface

{$SCOPEDENUMS ON}

procedure RegisterAdvertisingService;
procedure UnregisterAdvertisingService;

implementation

uses
  System.SysUtils, System.Classes, System.Math, System.Types, System.Generics.Collections, System.Messaging,
  Macapi.ObjectiveC, Macapi.ObjCRuntime, iOSapi.UIKit, iOSapi.Foundation, iOSapi.CoreGraphics, iOSapi.iAd, FMX.Types,
  Macapi.Helpers, FMX.Helpers.iOS, FMX.Controls, FMX.Forms, FMX.Platform, FMX.Platform.iOS, FMX.Advertising;

function IsPortrait: Boolean;
var
  ScreenService: IFMXScreenService;
begin
  Result := True;
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, ScreenService) then
    Result := ScreenService.GetScreenOrientation in [TScreenOrientation.Portrait, TScreenOrientation.InvertedPortrait];
end;

type
  TiOSBannerAd = class;

  TiOSBannerAdDelegate = class(TOCLocal, ADBannerViewDelegate)
  private
    [weak]FAd : TiOSBannerAd;
  public
    procedure SetAd(Ad: TiOSBannerAd);
    procedure bannerView(banner: ADBannerView; didFailToReceiveAdWithError: NSError); cdecl;
    procedure bannerViewActionDidFinish(banner: ADBannerView); cdecl;
    function bannerViewActionShouldBegin(banner: ADBannerView; willLeaveApplication: Boolean): Boolean; cdecl;
    procedure bannerViewDidLoadAd(banner: ADBannerView); cdecl;
    procedure bannerViewWillLoadAd(banner: ADBannerView); cdecl;
  end;

  TiOSAdvertisingService = class(TInterfacedObject, IFMXAdvertisingService)
  public
    function CreateBannerAd(const AOwner: TCustomBannerAd): IBannerAd;
    procedure RemoveAd(const Ad: ICommonAd);
  end;

  TiOSBannerAd = class(TInterfacedObject, IBannerAd)
  private
    FAd: ADBannerView;
    FAdControl: TCustomBannerAd;
    FDelegate: TiOSBannerAdDelegate;
    FOrientationChangedId: Integer;
    procedure OrientationChangedHandler(const Sender: TObject; const Msg: TMessage);
  public
    constructor Create;
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
    function GetParent: TFmxObject;
    function GetVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure UpdateControlMetrics;
    procedure UpdateContentFromControl;
  end;

var
  AdvertisingService : TiOSAdvertisingService;

{ TiOSAdvertisingService }

function TiOSAdvertisingService.CreateBannerAd(const AOwner: TCustomBannerAd): IBannerAd;
begin
  Result := TiOSBannerAd.Create;
end;

procedure TiOSAdvertisingService.RemoveAd(const Ad: ICommonAd);
begin

end;

{ TiOSBannerAdDelegate }

procedure TiOSBannerAdDelegate.bannerView(banner: ADBannerView; didFailToReceiveAdWithError: NSError);
begin
  if (FAd <> nil) and (FAd.FAdControl <> nil) then
    FAd.FAdControl.DoDidFail(NSStrToStr(didFailToReceiveAdWithError.localizedDescription));
end;

procedure TiOSBannerAdDelegate.bannerViewActionDidFinish(banner: ADBannerView);
begin
  if (FAd <> nil) and (FAd.FAdControl <> nil) then
    FAd.FAdControl.DoActionDidFinish;
end;

function TiOSBannerAdDelegate.bannerViewActionShouldBegin(banner: ADBannerView; willLeaveApplication: Boolean): Boolean;
begin
  Result := willLeaveApplication;
  if (FAd <> nil) and (FAd.FAdControl <> nil) then
    FAd.FAdControl.DoActionCanBegin(Result);
end;

procedure TiOSBannerAdDelegate.bannerViewDidLoadAd(banner: ADBannerView);
begin
  if (FAd <> nil) and (FAd.FAdControl <> nil) then
    FAd.FAdControl.DoDidLoad;
end;

procedure TiOSBannerAdDelegate.bannerViewWillLoadAd(banner: ADBannerView);
begin
  if (FAd <> nil) and (FAd.FAdControl <> nil) then
    FAd.FAdControl.DoWillLoad;
end;

procedure TiOSBannerAdDelegate.SetAd(Ad: TiOSBannerAd);
begin
  FAd := Ad;
end;

{ TiOSBannerAd }

constructor TiOSBannerAd.Create;
begin
  //Subscribe to orientation change events
  FOrientationChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, OrientationChangedHandler);
end;

destructor TiOSBannerAd.Free;
begin
  //Unsubscribe to orientation change events
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, FOrientationChangedId);
  inherited Destroy;
end;

{$REGION 'ICommonAd members'}
procedure TiOSBannerAd.CancelAction;
begin
  if FAd <> nil then
    FAd.cancelBannerViewAction;
end;

function TiOSBannerAd.IsActionInProgress: Boolean;
begin
  Result := False;
  if FAd <> nil then
    Result := FAd.isBannerViewActionInProgress;
end;

function TiOSBannerAd.IsLoaded: Boolean;
begin
  Result := False;
  if FAd <> nil then
    Result := FAd.isBannerLoaded;
end;

procedure TiOSBannerAd.LoadAd;
begin
  //Android only so nothing to do
end;

procedure TiOSBannerAd.OrientationChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  //Set ad dimensions after screen rotation
  UpdateControlMetrics;
end;
{$ENDREGION}

{$REGION 'IBannerAd members'}
procedure TiOSBannerAd.SetAdUnitID(const Value: string);
begin
  //Android only so nothing to do
end;

procedure TiOSBannerAd.SetBannerAdControl(const AValue: TCustomBannerAd);
var
  SizesArray: NSMutableArray;
  SizesSet: NSSet;
begin
  FAdControl := AValue;
  if FAdControl <> nil then
  begin
    FAd := TADBannerView.Create;
    FDelegate := TiOSBannerAdDelegate.Create;
    FDelegate.SetAd(Self);
    FAd.setDelegate(FDelegate.GetObjectID);
    SizesArray := TNSMutableArray.Create;
    SizesArray.addObject((ADBannerContentSizeIdentifierLandscape as ILocalObject).GetObjectID);
    SizesArray.addObject((ADBannerContentSizeIdentifierPortrait as ILocalObject).GetObjectID);
    SizesSet := TNSSet.Wrap(TNSSet.OCClass.setWithArray(SizesArray));
    SizesArray.release;
    FAd.setRequiredContentSizeIdentifiers(SizesSet);

    UpdateControlMetrics
  end
  else
  begin
    FAd.setDelegate(nil);
    FAd.release;
    FAd := nil;
    FDelegate := nil;
  end;
end;

function TiOSBannerAd.GetAdUnitID: string;
begin
  //Android only so nothing to do
  Result := '';
end;

function TiOSBannerAd.GetParent: TFmxObject;
begin
  Result := nil;
  if FAdControl <> nil then
    Result := FAdControl.Parent;
end;

function TiOSBannerAd.GetVisible: Boolean;
begin
  Result := False;
  if FAdControl <> nil then
    Result := FAdControl.Visible;
end;

procedure TiOSBannerAd.Show;
begin
  if (FAd <> nil) and FAd.isHidden then
    FAd.setHidden(False);
end;

procedure TiOSBannerAd.Hide;
begin
  if (FAd <> nil) and not FAd.isHidden then
    FAd.setHidden(True);
end;

procedure TiOSBannerAd.UpdateContentFromControl;
var
  View: UIView;
  Bounds: TRectF;
  Form: TCommonCustomForm;
  NativeRect: NSRect;
begin
  if FAd <> nil then
  begin
    if (FAdControl <> nil) and not (csDesigning in FAdControl.ComponentState) and (FAdControl.Root <> nil)
      and (FAdControl.Root.GetObject is TCommonCustomForm) then
    begin
      Form := TCommonCustomForm(FAdControl.Root.GetObject);
      if Form <> nil then
      begin
        if Form.Width < Form.Height then
          FAd.setCurrentContentSizeIdentifier(ADBannerContentSizeIdentifierPortrait)
        else
          FAd.setCurrentContentSizeIdentifier(ADBannerContentSizeIdentifierLandscape);

        Bounds := TRectF.Create(0, 0, FAdControl.Width, FAdControl.Height);
        Bounds.Fit(FAdControl.AbsoluteRect);
        View := WindowHandleToPlatform(Form.Handle).View;
        View.addSubview(FAd);
        if not FAdControl.Visible or SameValue(Bounds.Width, 0) or SameValue(Bounds.Height, 0) then
          FAd.setHidden(True)
        else
        begin
          NativeRect := CGRectFromRect(Bounds);
          FAd.setFrame(NativeRect);
          FAd.setHidden(not FAdControl.ParentedVisible);
        end;
      end;
    end
    else
      FAd.setHidden(True);
  end;
end;

procedure TiOSBannerAd.UpdateControlMetrics;
var
  Frame: NSRect;
  Form: TCommonCustomForm;
const
  AdHeightPhonePortrait = 50;
  AdHeightPhoneLandscape = 32;
  AdHeightPad = 66;
begin
  if (FAdControl <> nil) and not Assigned(FAdControl.OnResize) then
  begin
    if IsPad then
      FAdControl.Height := AdHeightPad
    else
    begin
      if IsPortrait then
        FAdControl.Height := AdHeightPhonePortrait
      else
        FAdControl.Height := AdHeightPhoneLandscape;
    end;
    if Screen.ActiveForm <> nil then
      Form := Screen.ActiveForm
    else if Application.MainForm <> nil then
      Form := Application.MainForm
    else
      Form := nil;

    if Form <> nil then
    begin
      Frame := WindowHandleToPlatform(Form.Handle).View.frame;
      FAdControl.Width := round(Frame.size.width);
    end;
  end;
end;
{$ENDREGION}

var
  AdFramework: HMODULE;

procedure RegisterAdvertisingService;
begin
  AdFramework := LoadLibrary(iAdFwk);
  if AdFramework > 0 then
  begin
    AdvertisingService := TiOSAdvertisingService.Create;
    TPlatformServices.Current.AddPlatformService(IFMXAdvertisingService, AdvertisingService);
  end;
end;

procedure UnregisterAdvertisingService;
begin
  if AdFramework > 0 then
  begin
    TPlatformServices.Current.RemovePlatformService(IFMXAdvertisingService);
    FreeLibrary(AdFramework);
  end;
end;

end.
