{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework iAd                       }
{                                                          }
{ Copyright (c) 2009, Apple Inc. All rights reserved.      }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.         }
{              All rights reserved                         }
{                                                          }
{**********************************************************}

unit iOSapi.iAd;

interface

uses
  Macapi.ObjectiveC, iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.UIKit, iOSapi.CoreGraphics;

const
  iAdFwk = '/System/Library/Frameworks/iAd.framework/iAd';

const
  ADErrorUnknown = 0;
  ADErrorServerFailure = 1;
  ADErrorLoadingThrottled = 2;
  ADErrorInventoryUnavailable = 3;
  ADErrorConfigurationError = 4;
  ADErrorBannerVisibleWithoutContent = 5;
  ADErrorApplicationInactive = 6;

// ===== Typedefs and structs =====
{$M+}
type
  ADError = NSUInteger;
  ADAdType = (
    ADAdTypeBanner = 0,
    ADAdTypeMediumRectangle = 1
  );

type
{$M+}
// ===== Forward declarations =====

  ADInterstitialAd = interface;
  ADBannerView = interface;
  ADInterstitialAdDelegate = interface;
  ADBannerViewDelegate = interface;

// ===== Protocol declarations =====

  ADInterstitialAdDelegate = interface(IObjectiveC)
    ['{6F4355B8-6A92-4ABC-B971-513E6465BC30}']
    procedure interstitialAd(interstitialAd: ADInterstitialAd; didFailWithError:NSError); cdecl;
    procedure interstitialAdActionDidFinish(interstitialAd: ADInterstitialAd); cdecl;
    function interstitialAdActionShouldBegin(interstitialAd: ADInterstitialAd; willLeaveApplication: Boolean): Boolean; cdecl;
    procedure interstitialAdDidLoad(interstitialAd: ADInterstitialAd); cdecl;
    procedure interstitialAdDidUnload(interstitialAd: ADInterstitialAd); cdecl;
    procedure interstitialAdWillLoad(interstitialAd: ADInterstitialAd); cdecl;
  end;

  ADBannerViewDelegate = interface(IObjectiveC)
    ['{95249262-9E7D-4841-B8E4-9EBBDADF3485}']
    procedure bannerView(banner: ADBannerView; didFailToReceiveAdWithError: NSError); cdecl;
    procedure bannerViewActionDidFinish(banner: ADBannerView); cdecl;
    function bannerViewActionShouldBegin(banner: ADBannerView; willLeaveApplication: Boolean): Boolean; cdecl;
    procedure bannerViewDidLoadAd(banner: ADBannerView); cdecl;
    procedure bannerViewWillLoadAd(banner: ADBannerView); cdecl;
  end;

// ===== Interface declarations =====

  ADInterstitialAdClass = interface(NSObjectClass)
    ['{8C5ACE62-A5B6-4B0B-9D62-43D3CB0A8BD0}']
  end;
  ADInterstitialAd = interface(NSObject)
    ['{31570147-4315-4616-8ECB-B4874008884B}']
    procedure cancelAction; cdecl;
    function delegate: Pointer; cdecl;
    function isActionInProgress: Boolean; cdecl;
    function isLoaded: Boolean; cdecl;
    procedure presentFromViewController(viewController: UIViewController); cdecl;
    function presentInView(containerView: UIView): Boolean; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
  end;
  TADInterstitialAd = class(TOCGenericImport<ADInterstitialAdClass, ADInterstitialAd>)  end;

  ADBannerViewClass = interface(UIViewClass)
    ['{B072DCC4-3CBE-4C07-B8B2-0B9B81A51AD9}']
    {class} function sizeFromBannerContentSizeIdentifier(contentSizeIdentifier: NSString): CGSize; cdecl;
  end;
  ADBannerView = interface(UIView)
    ['{2FD4C4B7-1FBE-46C0-83FD-A601B2DF980A}']
    function adType: ADAdType; cdecl;
    function advertisingSection: NSString; cdecl;
    procedure cancelBannerViewAction; cdecl;
    function currentContentSizeIdentifier: NSString; cdecl;
    function delegate: Pointer; cdecl;
    function initWithAdType(type_: ADAdType): Pointer; cdecl;
    function isBannerLoaded: Boolean; cdecl;
    function isBannerViewActionInProgress: Boolean; cdecl;
    function requiredContentSizeIdentifiers: NSSet; cdecl;
    procedure setAdvertisingSection(advertisingSection: NSString); cdecl;
    procedure setCurrentContentSizeIdentifier(currentContentSizeIdentifier: NSString); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setRequiredContentSizeIdentifiers(requiredContentSizeIdentifiers: NSSet); cdecl;
  end;
  TADBannerView = class(TOCGenericImport<ADBannerViewClass, ADBannerView>)  end;

// iAd constants

function ADBannerContentSizeIdentifierPortrait: NSString;
function ADBannerContentSizeIdentifierLandscape: NSString;
function ADBannerContentSizeIdentifier320x50: NSString;
function ADBannerContentSizeIdentifier480x32: NSString;
function ADErrorDomain: NSString;

implementation

uses
{$IF defined(IOS) and NOT defined(CPUARM)}
  Posix.Dlfcn,
{$ENDIF IOS}
  System.SysUtils;

function ADBannerContentSizeIdentifierPortrait: NSString;
begin
  Result := CocoaNSStringConst(iAdFwk, 'ADBannerContentSizeIdentifierPortrait');
end;

function ADBannerContentSizeIdentifierLandscape: NSString;
begin
  Result := CocoaNSStringConst(iAdFwk, 'ADBannerContentSizeIdentifierLandscape');
end;

function ADBannerContentSizeIdentifier320x50: NSString;
begin
  //ADBannerContentSizeIdentifier320x50 is deprecated
  //so we return the suggested replacement
  Result := ADBannerContentSizeIdentifierPortrait;
end;

function ADBannerContentSizeIdentifier480x32: NSString;
begin
  //ADBannerContentSizeIdentifier480x32 is deprecated
  //so we return the suggested replacement
  Result := ADBannerContentSizeIdentifierLandscape;
end;

function ADErrorDomain: NSString;
begin
  Result := CocoaNSStringConst(iAdFwk, 'ADErrorDomain');
end;

{$IF defined(IOS) and NOT defined(CPUARM)}
var
  iAdModule: THandle;

initialization
  iAdModule := dlopen(MarshaledAString(iAdFwk), RTLD_LAZY);

finalization
  dlclose(iAdModule);
{$ENDIF IOS}
end.
