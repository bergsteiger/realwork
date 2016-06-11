{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Devices;

interface

uses System.Types, System.SysUtils, System.Generics.Collections;

{$SCOPEDENUMS ON}
const
  // Common design-time attribute key names - These keys are not localized, however the values associated
  //   with these keys *may* be localized where appropriate
  // NOTE: These attribute names are reserved and used by the IDE at design-time. Do not modify the values associated
  //       with these attributes. Also, they will only be present at design-time.
  sDevAttrDisplayName = 'DisplayName'; // This will be the user-friendly name of a specific device
  sDevAttrOPDefine    = 'OPDefine'; // This is the Object Pascal compiler platform conditional define of a specific device
  sDevAttrCPPDefine   = 'CPPDefine'; // This is the C++ compiler platform conditional define of a specific device
  sDevAttrPlatforms   = 'Platforms'; // This is the list of platform targets with which this device is associated

type
  TDeviceInfo = class sealed
  public type
    TDeviceClass = (Unknown, Desktop, Phone, MediaPlayer, Tablet, Automotive, Industrial, Embedded, Watch, Glasses, Elf, Dwarf, Wizard);
  private type
    TDeviceList = class(TObjectList<TDeviceInfo>)
    private
      FSorted: Boolean;
    protected
      procedure Notify(const Item: TDeviceInfo; Action: TCollectionNotification); override;
      procedure CalculateDeltas;
    public
      procedure Sort;
    end;
  private
    class var FDevices: TDeviceList;
    class var FThisDevice: TDeviceInfo;
    class constructor Create;
    class destructor Destroy;
    class procedure SetThisDevice(const Device: TDeviceInfo); static;
    class function GetThisDevice: TDeviceInfo; static;
    class function GetDeviceCount: Integer; static; inline;
    class function GetDevice(Index: Integer): TDeviceInfo; static;  inline;
    class function GetDeviceByID(const AID: string): TDeviceInfo; static;
  private
    FDeviceClass: TDeviceClass;
    FID: string;
    FPlatform: TOSVersion.TPlatform;
    FMinPhysicalScreenSize: TSize; // Minimum Screen actual pixel dimensions
    FMinLogicalScreenSize: TSize; // Minimum Screen logical dimensions
    FMaxPhysicalScreenSize: TSize; // Maximum Screen actual pixel dimensions
    FMaxLogicalScreenSize: TSize; // Maximum Screen logical dimensions
    FAspectRatio: Single;
    FLowDelta, FHighDelta: Single;
    FPixelsPerInch: Integer;
    FExclusive: Boolean; // If True, this device will never be returned unless it matches
    FAttributes: TDictionary<string, string>;
    constructor Create(ADeviceClass: TDeviceClass; const AID: string;
      const AMinPhysicalScreenSize, AMinLogicalScreenSize, AMaxPhysicalScreenSize, AMaxLogicalScreenSize: TSize;
      APlatform: TOSVersion.TPlatform; APixelsPerInch: Integer; AExclusive: Boolean); overload;
    function GetAttribute(const Key: string): string;
    function GetMaxDiagonal: Single;
    function GetMinDiagonal: Single;
    property LowDelta: Single read FLowDelta write FLowDelta;
    property HighDelta: Single read FHighDelta write FHighDelta;
  public // Instance publics
    constructor Create; overload; // do not call this constructor
    destructor Destroy; override;
    function Equals(Obj: TObject): Boolean; override;
    procedure AddAttribute(const Key, Value: string);
    function HasAttribute(const Key: string): Boolean;
    property DeviceClass: TDeviceClass read FDeviceClass;
    property Exclusive: Boolean read FExclusive;
    property ID: string read FID;
    property Platform: TOSVersion.TPlatform read FPlatform;
    property MinPhysicalScreenSize: TSize read FMinPhysicalScreenSize;
    property MinLogicalScreenSize: TSize read FMinLogicalScreenSize;
    property MaxPhysicalScreenSize: TSize read FMaxPhysicalScreenSize;
    property MaxLogicalScreenSize: TSize read FMaxLogicalScreenSize;
    property AspectRatio: Single read FAspectRatio;
    property PixelsPerInch: Integer read FPixelsPerInch;
    property MaxDiagonal: Single read GetMaxDiagonal;
    property MinDiagonal: Single read GetMinDiagonal;
    property Attributes[const Key: string]: string read GetAttribute;
  public // class publics
    class function AddDevice(ADeviceClass: TDeviceClass; const AID: string;
      const APhysicalScreenSize, ALogicalScreenSize: TSize; APlatform: TOSVersion.TPlatform; APixelsPerInch: Integer;
      AExclusive: Boolean = False): TDeviceInfo; overload;
    class function AddDevice(ADeviceClass: TDeviceClass; const AID: string;
      const AMinPhysicalScreenSize, AMinLogicalScreenSize, AMaxPhysicalScreenSize, AMaxLogicalScreenSize: TSize;
      APlatform: TOSVersion.TPlatform; APixelsPerInch: Integer; AExclusive: Boolean = False): TDeviceInfo; overload;
    class procedure RemoveDevice(const AID: string);
    class function SelectDevices(ADeviceClass: TDeviceClass; const APhysicalScreenSize, ALogicalScreenSize: TSize;
      APlatform: TOSVersion.TPlatform; APixelsPerInch: Integer; SetThisDevice: Boolean = True): TArray<TDeviceInfo>;
    class property DeviceCount: Integer read GetDeviceCount;
    class property Devices[Index: Integer]: TDeviceInfo read GetDevice;
    class property DeviceByID[const AID: string]: TDeviceInfo read GetDeviceByID;
    class property ThisDevice: TDeviceInfo read GetThisDevice write SetThisDevice;
  end;

implementation

uses System.RTLConsts, System.Generics.Defaults, System.Math,
{$IF Defined(MSWINDOWS)}
  System.Win.Devices
{$ELSEIF Defined(IOS)}
  System.iOS.Devices
{$ELSEIF Defined(MACOS)}
  System.Mac.Devices
{$ELSEIF Defined(ANDROID)}
  System.Android.Devices
{$ELSE}
{$MESSAGE FATAL 'System.Devices is not supported on this platform'} // do not localize
{$ENDIF}
;

{ TDeviceInfo }

procedure TDeviceInfo.AddAttribute(const Key, Value: string);
begin
  if FAttributes.ContainsKey(Key) then
    raise EInvalidOpException.CreateResFmt(@sAttributeExists, [Key]);
  FAttributes.Add(Key, Value);
end;

class constructor TDeviceInfo.Create;
begin
  FDevices := TDeviceList.Create(TDelegatedComparer<TDeviceInfo>.Create(
    function (const Left, Right: TDeviceInfo): Integer
    begin
      Result := Ord(Left.Platform) - Ord(Right.Platform);
      if Result = 0 then
        Result := Ord(Left.DeviceClass) - Ord(Right.DeviceClass);
      if Result = 0 then
        Result := Trunc(Left.MinDiagonal - Right.MinDiagonal);
      if Result = 0 then
        Result := Trunc(Left.AspectRatio - Right.AspectRatio);
      if Result = 0 then
        Result := ((Left.MinPhysicalScreenSize.cx * 100) div Left.PixelsPerInch) - ((Right.MinPhysicalScreenSize.cx * 100) div Right.PixelsPerInch);
      if Result = 0 then
        Result := ((Left.MinPhysicalScreenSize.cy * 100) div Left.PixelsPerInch) - ((Right.MinPhysicalScreenSize.cy * 100) div Right.PixelsPerInch);
    end) as IComparer<TDeviceInfo>);
  AddDevices;
end;

class function TDeviceInfo.AddDevice(ADeviceClass: TDeviceClass; const AID: string; const APhysicalScreenSize,
  ALogicalScreenSize: TSize; APlatform: TOSVersion.TPlatform; APixelsPerInch: Integer; AExclusive: Boolean = False): TDeviceInfo;
begin
  Result := TDeviceInfo.Create(ADeviceClass, AID, APhysicalScreenSize, ALogicalScreenSize,
    APhysicalScreenSize, ALogicalScreenSize, APlatform, APixelsPerInch, AExclusive);
  try
    if DeviceByID[AID] = nil then
      FDevices.Add(Result)
    else
      raise EInvalidOpException.CreateResFmt(@sDeviceExists, [AID]);
  except
    Result.Free;
    raise;
  end;
end;

constructor TDeviceInfo.Create;
begin
  raise ENoConstructException.Create(sCannotManuallyConstructDevice);
end;

class function TDeviceInfo.AddDevice(ADeviceClass: TDeviceClass; const AID: string; const AMinPhysicalScreenSize,
  AMinLogicalScreenSize, AMaxPhysicalScreenSize, AMaxLogicalScreenSize: TSize; APlatform: TOSVersion.TPlatform;
  APixelsPerInch: Integer; AExclusive: Boolean = False): TDeviceInfo;
begin
  Result := TDeviceInfo.Create(ADeviceClass, AID, AMinPhysicalScreenSize, AMinLogicalScreenSize,
    AMaxPhysicalScreenSize, AMaxLogicalScreenSize, APlatform, APixelsPerInch, AExclusive);
  try
    if DeviceByID[AID] = nil then
      FDevices.Add(Result)
    else
      raise EInvalidOpException.CreateResFmt(@sDeviceExists, [AID]);
  except
    Result.Free;
    raise;
  end;
end;

constructor TDeviceInfo.Create(ADeviceClass: TDeviceClass; const AID: string; const AMinPhysicalScreenSize,
  AMinLogicalScreenSize, AMaxPhysicalScreenSize, AMaxLogicalScreenSize: TSize; APlatform: TOSVersion.TPlatform;
  APixelsPerInch: Integer; AExclusive: Boolean);
begin
  inherited Create;
  FDeviceClass := ADeviceClass;
  FExclusive := AExclusive;
  FID := AID;
  FMinPhysicalScreenSize := AMinPhysicalScreenSize;
  FMinLogicalScreenSize := AMinLogicalScreenSize;
  FMaxPhysicalScreenSize := AMaxPhysicalScreenSize;
  FMaxLogicalScreenSize := AMaxLogicalScreenSize;
  FPixelsPerInch := APixelsPerInch;
  FAspectRatio := Max(FMinPhysicalScreenSize.cy, FMinPhysicalScreenSize.cx) / Min(FMinPhysicalScreenSize.cy, FMinPhysicalScreenSize.cx);
  FPlatform := APlatform;
  FAttributes := TDictionary<string, string>.Create;
end;

destructor TDeviceInfo.Destroy;
begin
  FAttributes.Free;
  inherited Destroy;
end;

function TDeviceInfo.Equals(Obj: TObject): Boolean;
begin
  Result := (Obj = Self) or ((Obj is TDeviceInfo) and
    (TDeviceInfo(Obj).FDeviceClass = Self.FDeviceClass) and
    (TDeviceInfo(Obj).FPlatform = Self.FPlatform) and
    (TDeviceInfo(Obj).FMinPhysicalScreenSize = Self.FMinPhysicalScreenSize) and
    (TDeviceInfo(Obj).FMaxPhysicalScreenSize = Self.FMaxPhysicalScreenSize) and
    (TDeviceInfo(Obj).FMinLogicalScreenSize = Self.FMinLogicalScreenSize) and
    (TDeviceInfo(Obj).FMaxLogicalScreenSize = Self.FMaxLogicalScreenSize) and
    (TDeviceInfo(Obj).FPixelsPerInch = Self.FPixelsPerInch));
end;

class destructor TDeviceInfo.Destroy;
begin
  if (FThisDevice <> nil) and ((FDevices = nil) or (FDevices.IndexOf(FThisDevice) < 0)) then
    FThisDevice.Free;
  FDevices.Free;
end;

function TDeviceInfo.GetAttribute(const Key: string): string;
begin
  Result := FAttributes[Key];
end;

class function TDeviceInfo.GetDevice(Index: Integer): TDeviceInfo;
begin
  Result := FDevices[Index];
end;

class function TDeviceInfo.GetDeviceByID(const AID: string): TDeviceInfo;
var
  I: Integer;
begin
  for I := 0 to DeviceCount - 1 do
  begin
    Result := FDevices[I];
    if SameText(Result.ID, AID) then
      Exit;
  end;
  Result := nil;
end;

class function TDeviceInfo.GetDeviceCount: Integer;
begin
  Result := FDevices.Count;
end;

function TDeviceInfo.GetMaxDiagonal: Single;
begin
  Result := Sqrt(Sqr(FMaxPhysicalScreenSize.CX) + Sqr(FMaxPhysicalScreenSize.CY)) / FPixelsPerInch;
end;

function TDeviceInfo.GetMinDiagonal: Single;
begin
  Result := Sqrt(Sqr(FMinPhysicalScreenSize.CX) + Sqr(FMinPhysicalScreenSize.CY)) / FPixelsPerInch;
end;

class function TDeviceInfo.GetThisDevice: TDeviceInfo;
begin
  Result := FThisDevice;
end;

function TDeviceInfo.HasAttribute(const Key: string): Boolean;
begin
  Result := FAttributes.ContainsKey(Key);
end;

class procedure TDeviceInfo.RemoveDevice(const AID: string);
var
  Device: TDeviceInfo;
begin
  Device := DeviceByID[AID];
  if Device <> nil then
    FDevices.Remove(Device);
end;

class function TDeviceInfo.SelectDevices(ADeviceClass: TDeviceClass; const APhysicalScreenSize,
  ALogicalScreenSize: TSize; APlatform: TOSVersion.TPlatform; APixelsPerInch: Integer; SetThisDevice: Boolean = True): TArray<TDeviceInfo>;
var
  I, Index: Integer;
  LDevice, LThisDevice, LMatch: TDeviceInfo;
  LClosest, LDistance: Single;
  LDevices: TList<TDeviceInfo>;
  LDiagonal: Single;
begin
  FDevices.Sort;
  LMatch := nil;
  if SetThisDevice then
    LThisDevice := TDeviceInfo.Create(ADeviceClass, '', APhysicalScreenSize, ALogicalScreenSize,
      APhysicalScreenSize, ALogicalScreenSize, APlatform, APixelsPerInch, True)
  else
    LThisDevice := nil;
  try
    LDiagonal := Sqrt(Sqr(APhysicalScreenSize.cx) + Sqr(APhysicalScreenSize.cy)) / APixelsPerInch;
    LDevices := TList<TDeviceInfo>.Create;
    try
      for I := 0 to DeviceCount - 1 do
      begin
        LDevice := Devices[I];
        if LDevice.Equals(LThisDevice) then
          LMatch := LDevice;
        if LDevice.Platform = APlatform then
        begin
          if (LDiagonal >= LDevice.MinDiagonal + LDevice.LowDelta) and (LDiagonal <= LDevice.MaxDiagonal + LDevice.HighDelta) then
          begin
            if LDevice.DeviceClass = ADeviceClass then
              LDevices.Insert(0, LDevice)
            else if not LDevice.Exclusive then
              LDevices.Add(LDevice);
          end;
        end;
      end;
      Index := LDevices.Count;
      LClosest := Single.MaxValue;
      for I := 0 to DeviceCount - 1 do
      begin
        LDevice := Devices[I];
        if (LDevice.Platform = APlatform) and (LDevices.IndexOf(LDevice) < 0) and not LDevice.Exclusive then
        begin
          LDistance := Abs(LDiagonal - (LDevice.MinDiagonal + (LDevice.MaxDiagonal - LDevice.MinDiagonal) / 2));
          if LDistance < LClosest then
          begin
            LDevices.Insert(Index, LDevice);
            LClosest := LDistance;
          end else
            LDevices.Add(LDevice);
        end;
      end;
      if LMatch <> nil then
      begin
        FThisDevice := LMatch;
        LThisDevice.Free;
      end else
        FThisDevice := LThisDevice;
      Result := LDevices.ToArray;
    finally
      LDevices.Free;
    end;
  except
    if FThisDevice = LThisDevice then
      FThisDevice := nil;
    LThisDevice.Free;
    raise;
  end;
end;

class procedure TDeviceInfo.SetThisDevice(const Device: TDeviceInfo);
begin
  FThisDevice := Device;
end;

{ TDeviceInfo.TDeviceList }

procedure TDeviceInfo.TDeviceList.CalculateDeltas;
var
  CurDevice, LastDevice: TDeviceInfo;
begin
  LastDevice := nil;
  for CurDevice in Self do
  begin
    if (LastDevice = nil) or (LastDevice.Platform <> CurDevice.Platform) then
    begin
      if LastDevice <> nil then
        LastDevice.HighDelta := 0.0;
      CurDevice.LowDelta := -CurDevice.MinDiagonal;
      LastDevice := CurDevice;
    end else if (LastDevice.DeviceClass <> CurDevice.DeviceClass) and
      SameValue(LastDevice.MinDiagonal, CurDevice.MinDiagonal) and SameValue(LastDevice.MaxDiagonal, CurDevice.MaxDiagonal) then
    begin
      CurDevice.HighDelta := LastDevice.HighDelta;
      CurDevice.LowDelta := LastDevice.LowDelta;
      LastDevice := CurDevice;
    end else
    begin
      LastDevice.HighDelta := Max(0.0, (CurDevice.MinDiagonal - LastDevice.MaxDiagonal) / 2);
      CurDevice.LowDelta := -LastDevice.HighDelta;
      LastDevice := CurDevice;
    end;
  end;
  if LastDevice <> nil then
    LastDevice.HighDelta := 0.0;
end;

procedure TDeviceInfo.TDeviceList.Notify(const Item: TDeviceInfo; Action: TCollectionNotification);
begin
  inherited Notify(Item, Action);
  FSorted := False;
end;

procedure TDeviceInfo.TDeviceList.Sort;
begin
  if not FSorted then
  begin
    inherited Sort;
    FSorted := True;
    CalculateDeltas;
  end;
end;

end.
