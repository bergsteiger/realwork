{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.Mac.Beacon;

interface

uses
  System.Beacon, System.Bluetooth;

type
/// <summary>
///  Implements TBeaconAdvertiser for MacOS and iOS platforms
/// </summary>
  TPlatformBeaconAdvertiser = class(TBeaconAdvertiser)
  public
    /// <summary> Gets an instance of the Beacon Device for the current platform </summary>
    class function GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser; override;
    /// <summary> Gets an instance of the Beacon Device as a purpose of help, without GattServer for the current platform </summary>
    class function GetHelperInstance: TBeaconAdvertiser; override;
  end;

implementation

uses
{$IFDEF IOS}
  iOSapi.CoreLocation,
  iOSapi.Foundation,
{$ENDIF}
  Macapi.Helpers, Macapi.ObjectiveC, System.NetConsts,
  Macapi.ObjCRuntime, Generics.Collections, System.SysUtils, System.Classes, System.DateUtils, System.Math, System.Types;

type

  TMacBeaconAdvertiser = class(TBeaconAdvertiser)
  private
    function GetDefaultTxPower: Integer;
  protected
    function GetManufacturerData: TBytes; override;
    class function GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser; override;
    class function GetHelperInstance: TBeaconAdvertiser; override;
  end;

{ TPlatformBeaconAdvertiser }

class function TPlatformBeaconAdvertiser.GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser;
begin
  Result := TMacBeaconAdvertiser.GetInstance(AGattServer);
end;

class function TPlatformBeaconAdvertiser.GetHelperInstance: TBeaconAdvertiser;
begin
  Result := TMacBeaconAdvertiser.GetHelperInstance;
end;

{ TMacBeaconAdvertiser }
function TMacBeaconAdvertiser.GetDefaultTxPower: Integer;
const
  MAC_DEFAULT_TXPOWER = -56;
  BEACON_ADV_LENGTH = 21;
  BEACON_ADV_TXPOWER_POSITION = 20;
{$IFDEF IOS}
var
  LStrGUID: string;
  LNSUUID: NSUUID;
  LBeaconRegion: CLBeaconRegion;
  LDict: NSMutableDictionary;
  LPointer: Pointer;
  LData: NSData;
  LTxPower: ShortInt;
begin
  LTxPower := MAC_DEFAULT_TXPOWER;
  LStrGUID := GUIDToString(GUID);
  LStrGUID := LStrGUID.Substring(1, LStrGUID.Length - 2);
  LNSUUID := TNSUUID.Alloc.initWithUUIDString(StrToNSStr(LStrGUID));
  try
    LBeaconRegion := TCLBeaconRegion.Wrap(TCLBeaconRegion.Alloc.initWithProximityUUIDIdentifier(LNSUUID, StrToNSStr('id')));
    try
      LDict := LBeaconRegion.peripheralDataWithMeasuredPower(nil);
      LPointer := LDict.allValues.objectAtIndex(0);
      if LPointer <> nil then
      begin
        LData := TNSData.Wrap(LPointer);
        if LData.length = BEACON_ADV_LENGTH then
          LData.getBytes(@LTxPower, NSMakeRange(BEACON_ADV_TXPOWER_POSITION, 1));
      end;
    finally
      LBeaconRegion.release;
    end;
  finally
    LNSUUID.release;
  end;
  Result := LTxPower;
{$ELSE}
begin
  Result := MAC_DEFAULT_TXPOWER;
{$ENDIF}
end;

class function TMacBeaconAdvertiser.GetInstance(const AGattServer: TBluetoothGattServer): TBeaconAdvertiser;
begin
  Result := TMacBeaconAdvertiser.Create(AGattServer);
end;

class function TMacBeaconAdvertiser.GetHelperInstance: TBeaconAdvertiser;
begin
  Result := TMacBeaconAdvertiser.Create(nil, True);
end;

function TMacBeaconAdvertiser.GetManufacturerData: TBytes;
const
  BEACON_ADV_LENGTH = 25;
  BEACON_ADV_MAJOR_POSITION = 20;
  BEACON_ADV_MINOR_POSITION = 22;
  BEACON_ADV_TXPOWER_POSITION = 24;
var
  LTxPower: Integer;
begin
  if TxPower = DEFAULT_TXPOWER then
    LTxPower := GetDefaultTxPower
  else
    LTxPower := TxPower;
  Result := BEACON_PREFIX;
  SetLength(Result, BEACON_ADV_LENGTH);
  Move(GUID.ToByteArray(TEndian.Big)[0], Result[Length(BEACON_PREFIX)], 16);
  PWord(@Result[BEACON_ADV_MAJOR_POSITION])^ := Swap(Major);
  PWord(@Result[BEACON_ADV_MINOR_POSITION])^ := Swap(Minor);
  PShortInt(@Result[BEACON_ADV_TXPOWER_POSITION])^ := Int8(LTxPower);
end;

end.
