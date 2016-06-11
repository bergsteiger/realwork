{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.BehaviorManager;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Generics.Collections, System.Devices, FMX.Types, FMX.Forms, FMX.Graphics;

type
  IStyleBehavior = interface
    ['{665EC261-3E3C-41F1-9964-ADCB39B47662}']
    procedure GetSystemStyle(const Context: TFmxObject; var Style: TFmxObject);
  end;

  IDeviceBehavior = interface
    ['{820055FF-2005-4160-8751-6BCD492C117E}']
    procedure GetName(const Context: TFmxObject; var DeviceName: string);
    function GetDeviceClass(const Context: TFmxObject): TDeviceInfo.TDeviceClass;
    /// <summary>Returns current device, which's view is selected in IDE</summary>
    function GetDevice(const Context: TFmxObject): TDeviceInfo;
    function GetOSPlatform(const Context: TFmxObject): TOSPlatform;
    function GetDisplayMetrics(const Context: TFmxObject): TDeviceDisplayMetrics;
  end;

  IOSVersionForStyleBehavior = interface
    ['{F55F7580-3E67-4916-8D16-A33AFC171888}']
    procedure GetMajorOSVersion(const Context: TFMXObject; var OSVersion: Integer);
  end;

  IFontBehavior = interface
    ['{25D83842-FF28-4748-90C0-7E8610141190}']
    procedure GetDefaultFontFamily(const Context: TFmxObject; var FontFamily: string);
    procedure GetDefaultFontSize(const Context: TFmxObject; var FontSize: Single);
  end;

  IListener = interface
    ['{9D325387-E1F1-4B3F-A9FB-BAFF9CE03B8C}']
    procedure GetBehaviorService(const AServiceGUID: TGUID;
      var AService: IInterface; const Context: TFmxObject);
    procedure SupportsBehaviorService(const AServiceGUID: TGUID;
      const Context: TFmxObject; var Found: Boolean); overload;
    procedure SupportsBehaviorService(const AServiceGUID: TGUID;
      var AService: IInterface; const Context: TFmxObject; var Found: Boolean); overload;
  end;

  /// <summary>Used by <c>TPresentedControl</c> for getting overlay icon. This icon is used to point that
  /// <c>TPresentedControl</c> uses platform presentation (ControlType = Platform)</summary>
  IPresentedControlBehavior = interface
    ['{B98B1B59-C1AF-4D53-8D81-1A429460A11C}']
    /// <summary>Returns overlay icon. See description of <c>IPresentedControlBehavior</c></summary>
    function GetOverlayIcon: TBitmap;
  end;

  TBehaviorServices = class
  protected type
    TServicesList = TDictionary<TGUID, IInterface>;
    TListenerList = TList<IListener>;
  private
    FServicesList: TServicesList;
    FListenerList: TListenerList;
    function GetServicesList: TServicesList;
    function GetListenerList: TListenerList;
  private
    class var FCurrent: TBehaviorServices;
    class destructor DestroyCurrent;
    class function GetCurrent: TBehaviorServices; static;
  protected
    property ServicesList: TServicesList read GetServicesList;
    property ListenerList: TListenerList read GetListenerList;
  public
    destructor Destroy; override;
    procedure AddBehaviorListener(const Listener: IListener);
    procedure AddBehaviorService(const AServiceGUID: TGUID; const AService: IInterface);
    function GetBehaviorService(const AServiceGUID: TGUID;
      const Context: TFmxObject): IInterface;
    procedure RemoveBehaviorListener(const Listener: IListener);
    procedure RemoveBehaviorService(const AServiceGUID: TGUID);
    function SupportsBehaviorService(const AServiceGUID: TGUID;
      const Context: TFmxObject): Boolean; overload;
    function SupportsBehaviorService(const AServiceGUID: TGUID;
      out AService; const Context: TFmxObject): Boolean; overload;
    class property Current: TBehaviorServices read GetCurrent;
  end;

  /// <summary>Type of Boolean value, which has third value, which is depended on target platform</summary>
  TBehaviorBoolean = (True, False, PlatformDefault);

function BehaviorServices: TBehaviorServices; inline; deprecated 'Use TBehaviorServices.Current';

implementation

uses
  System.SysUtils;

function BehaviorServices: TBehaviorServices;
begin
  Result := TBehaviorServices.Current;
end;

{ TBehaviorServices }

destructor TBehaviorServices.Destroy;
begin
  FreeAndNil(FServicesList);
  FreeAndNil(FListenerList);
  inherited;
end;

function TBehaviorServices.GetServicesList: TServicesList;
begin
  if FServicesList = nil then
    FServicesList := TServicesList.Create;
  Result := FServicesList;
end;

function TBehaviorServices.GetListenerList: TListenerList;
begin
  if FListenerList = nil then
    FListenerList := TList<IListener>.Create;
  Result := FListenerList;
end;

procedure TBehaviorServices.AddBehaviorListener(const Listener: IListener);
begin
  ListenerList.Add(Listener);
end;

procedure TBehaviorServices.AddBehaviorService(const AServiceGUID: TGUID;
  const AService: IInterface);
begin
  if not ServicesList.ContainsKey(AServiceGUID) then
    ServicesList.Add(AServiceGUID, AService);
end;

function TBehaviorServices.GetBehaviorService(const AServiceGUID: TGUID; const Context: TFmxObject): IInterface;
var
  Listener: IListener;
begin
  Supports(ServicesList.Items[AServiceGUID], AServiceGUID, Result);
  for Listener in ListenerList do
    Listener.GetBehaviorService(AServiceGUID, Result, Context);
end;

procedure TBehaviorServices.RemoveBehaviorListener(const Listener: IListener);
begin
  ListenerList.Remove(Listener);
end;

procedure TBehaviorServices.RemoveBehaviorService(const AServiceGUID: TGUID);
begin
  ServicesList.Remove(AServiceGUID);
end;

function TBehaviorServices.SupportsBehaviorService(const AServiceGUID: TGUID;
  out AService; const Context: TFmxObject): Boolean;
var
  Listener: IListener;
  TempResult: Boolean;
begin
  if ServicesList.ContainsKey(AServiceGUID) then
    Result := Supports(ServicesList.Items[AServiceGUID], AServiceGUID, AService)
  else
  begin
    Pointer(AService) := nil;
    Result := False;
  end;
  TempResult := Result;
  for Listener in ListenerList do
  begin
    Listener.SupportsBehaviorService(AServiceGUID, IInterface(AService), Context, TempResult);
    Result := Result or TempResult;
  end;
end;

function TBehaviorServices.SupportsBehaviorService(const AServiceGUID: TGUID; const Context: TFmxObject): Boolean;
var
  Listener: IListener;
begin
  Result := ServicesList.ContainsKey(AServiceGUID);
  for Listener in ListenerList do
  begin
    Listener.SupportsBehaviorService(AServiceGUID, Context, Result);
    if Result then
      Break;
  end;
end;

class destructor TBehaviorServices.DestroyCurrent;
begin
  FreeAndNil(FCurrent);
end;

class function TBehaviorServices.GetCurrent: TBehaviorServices;
begin
  if FCurrent = nil then
    FCurrent := TBehaviorServices.Create;
  Result := FCurrent;
end;

end.
