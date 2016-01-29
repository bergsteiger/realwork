{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework SystemConfiguration 
//
unit Macapi.SystemConfiguration;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.CoreFoundation;

const
  kSCBondStatusLinkInvalid = 1;
  kSCBondStatusNoPartner = 2;
  kSCBondStatusNotInActiveGroup = 3;
  kSCBondStatusOK = 0;
  kSCBondStatusUnknown = 999;
  kSCNetworkConnectionConnected = 2;
  kSCNetworkConnectionConnecting = 1;
  kSCNetworkConnectionDisconnected = 0;
  kSCNetworkConnectionDisconnecting = 3;
  kSCNetworkConnectionInvalid = -1;
  kSCNetworkConnectionPPPAuthenticating = 5;
  kSCNetworkConnectionPPPConnected = 8;
  kSCNetworkConnectionPPPConnectingLink = 2;
  kSCNetworkConnectionPPPDialOnTraffic = 3;
  kSCNetworkConnectionPPPDisconnected = 0;
  kSCNetworkConnectionPPPDisconnectingLink = 10;
  kSCNetworkConnectionPPPHoldingLinkOff = 11;
  kSCNetworkConnectionPPPInitializing = 1;
  kSCNetworkConnectionPPPNegotiatingLink = 4;
  kSCNetworkConnectionPPPNegotiatingNetwork = 7;
  kSCNetworkConnectionPPPSuspended = 12;
  kSCNetworkConnectionPPPTerminating = 9;
  kSCNetworkConnectionPPPWaitingForCallBack = 6;
  kSCNetworkConnectionPPPWaitingForRedial = 13;
  kSCNetworkFlagsConnectionAutomatic = 8;
  kSCNetworkFlagsConnectionRequired = 4;
  kSCNetworkFlagsInterventionRequired = 16;
  kSCNetworkFlagsIsDirect = 131072;
  kSCNetworkFlagsIsLocalAddress = 65536;
  kSCNetworkFlagsReachable = 2;
  kSCNetworkFlagsTransientConnection = 1;
  kSCNetworkReachabilityFlagsConnectionAutomatic = 8;
  kSCNetworkReachabilityFlagsConnectionOnDemand = 32;
  kSCNetworkReachabilityFlagsConnectionOnTraffic = 8;
  kSCNetworkReachabilityFlagsConnectionRequired = 4;
  kSCNetworkReachabilityFlagsInterventionRequired = 16;
  kSCNetworkReachabilityFlagsIsDirect = 131072;
  kSCNetworkReachabilityFlagsIsLocalAddress = 65536;
  kSCNetworkReachabilityFlagsReachable = 2;
  kSCNetworkReachabilityFlagsTransientConnection = 1;
  kSCPreferencesNotificationApply = 2;
  kSCPreferencesNotificationCommit = 1;
  kSCStatusAccessError = 1003;
  kSCStatusConnectionNoService = 5001;
  kSCStatusFailed = 1001;
  kSCStatusInvalidArgument = 1002;
  kSCStatusKeyExists = 1005;
  kSCStatusLocked = 1006;
  kSCStatusMaxLink = 3006;
  kSCStatusNeedLock = 1007;
  kSCStatusNoConfigFile = 3003;
  kSCStatusNoKey = 1004;
  kSCStatusNoLink = 3004;
  kSCStatusNoPrefsSession = 3001;
  kSCStatusNoStoreServer = 2002;
  kSCStatusNoStoreSession = 2001;
  kSCStatusNotifierActive = 2003;
  kSCStatusOK = 0;
  kSCStatusPrefsBusy = 3002;
  kSCStatusReachabilityUnknown = 4001;
  kSCStatusStale = 3005;

implementation
end.
