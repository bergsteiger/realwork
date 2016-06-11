{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.Android.Beacon;

interface

uses
  System.Beacon, System.Bluetooth;

type
/// <summary>
///  Implements TBeaconAdvertiser for Android platform
/// </summary>
  TPlatformBeaconAdvertiser = class(TBeaconAdvertiser)
  public
    /// <summary> Gets an instance of the Beacon Device for the current platform </summary>
    class function GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser; override;
    /// <summary> Gets an instance of the Beacon Device as a purpose of help, without GattServer for the current platform </summary>
    class function GetHelperInstance: TBeaconAdvertiser; override;
  end;

implementation

uses System.SysUtils, System.Types;

type

  TAndroidBeaconAdvertiser = class(TBeaconAdvertiser)
  private
    function GetDefaultTxPower: Integer;
  protected
    function GetManufacturerData: TBytes; override;
    class function GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser; override;
    class function GetHelperInstance: TBeaconAdvertiser; override;
  end;

{ TPlatformBeaconAdvertiser }

class function TPlatformBeaconAdvertiser.GetInstance(const AGattServer: TBluetoothGattServer): TBeaconAdvertiser;
begin
  Result := TAndroidBeaconAdvertiser.GetInstance(AGattServer);
end;

class function TPlatformBeaconAdvertiser.GetHelperInstance: TBeaconAdvertiser;
begin
  Result := TAndroidBeaconAdvertiser.GetHelperInstance;
end;

{ TAndroidBeaconAdvertiser }

function TAndroidBeaconAdvertiser.GetDefaultTxPower: Integer;
begin
  Result := TxPower;
end;

class function TAndroidBeaconAdvertiser.GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser;
begin
  Result := TAndroidBeaconAdvertiser.Create(AGattServer);
end;

class function TAndroidBeaconAdvertiser.GetHelperInstance: TBeaconAdvertiser;
begin
  Result := TAndroidBeaconAdvertiser.Create(nil, True);
end;

function TAndroidBeaconAdvertiser.GetManufacturerData: TBytes;
const
  // Beacon (ManufacturerData) packet format
  //  ID   Type  GUID   Major   Minor   TX    Alt
  //[0..1][2..3][4..19][20..21][22..23][24]//[25]
  UUID_BYTES_128_BIT = 16;
  BEACON_STANDARD_ADV_LENGTH = 25;
  BEACON_ADV_MAJOR_POSITION = 20;
  BEACON_ADV_MINOR_POSITION = 22;
  BEACON_ADV_TXPOWER_POSITION = 24;
var
  LTxPower: Integer;
  BEACON_PREFIXLength: Integer;
  ADVLength: Integer;
begin
  BEACON_PREFIXLength := Length(BEACON_PREFIX);
  Setlength(Result, BEACON_PREFIXLength);
  Move(BEACON_PREFIX[0], Result[0], BEACON_PREFIXLength);

  if BeaconType = BEACON_ST_TYPE then
    ADVLength := BEACON_STANDARD_ADV_LENGTH
  else
  begin
    ADVLength := ALTERNATIVE_DATA_LENGTH;
    PWord(@Result[BEACON_MANUFACTURER_ID_POSITION])^ := ManufacturerId;
    PWord(@Result[BEACON_TYPE_POS])^ := Swap(BeaconType);
  end;

  if TxPower = DEFAULT_TXPOWER then
    LTxPower := GetDefaultTxPower
  else
    LTxPower := TxPower;

  SetLength(Result, ADVLength);
  Move(GUID.ToByteArray(TEndian.Big)[0], Result[BEACON_PREFIXLength], UUID_BYTES_128_BIT);
  PWord(@Result[BEACON_ADV_MAJOR_POSITION])^ := Swap(Major);
  PWord(@Result[BEACON_ADV_MINOR_POSITION])^ := Swap(Minor);
  PShortInt(@Result[BEACON_ADV_TXPOWER_POSITION])^ := Int8(LTxPower);
  if BeaconType <> BEACON_ST_TYPE then
    PShortInt(@Result[BEACON_ADV_TXPOWER_POSITION + 1])^ := MFGReserved;
end;

end.
