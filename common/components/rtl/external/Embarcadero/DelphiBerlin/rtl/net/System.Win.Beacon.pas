{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.Win.Beacon;

interface

uses
  System.Beacon, System.Bluetooth;

type
/// <summary>
///  Implements TBeaconAdvertiser for Windows platform
/// </summary>
  TPlatformBeaconAdvertiser = class(TBeaconAdvertiser)
  public
    /// <summary> Gets an instance of the Beacon Advertiser for the current platform </summary>
    class function GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser; override;    
    /// <summary> Gets an instance of the Beacon Device as a purpose of help,
	/// without GattServer for the current platform
	/// </summary>
    class function GetHelperInstance: TBeaconAdvertiser; override;	
  end;

implementation

uses
  System.SysUtils, System.Classes, System.DateUtils, System.Math, System.Types;

type

  TWinBeaconAdvertiser = class(TBeaconAdvertiser)
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
  Result := TWinBeaconAdvertiser.GetInstance(AGattServer);
end;

class function TPlatformBeaconAdvertiser.GetHelperInstance: TBeaconAdvertiser;
begin
  Result := TWinBeaconAdvertiser.GetHelperInstance;
end;

{ TWinBeaconAdvertiser }

function TWinBeaconAdvertiser.GetDefaultTxPower: Integer;
const
  WIN_DEFAULT_TXPOWER = -56;
begin
  Result := WIN_DEFAULT_TXPOWER;
end;

class function TWinBeaconAdvertiser.GetInstance(const AGattServer: TBluetoothGattServer): TBeaconAdvertiser;
begin
  Result := TWinBeaconAdvertiser.Create(AGattServer);
end;

class function TWinBeaconAdvertiser.GetHelperInstance: TBeaconAdvertiser;
begin
  Result := TWinBeaconAdvertiser.Create(nil, True);
end;

function TWinBeaconAdvertiser.GetManufacturerData: TBytes;
const
  // Beacon (ManufacturerData) packet format
  //  ID   Type  GUID   Major   Minor   TX    Alt
  //[0..1][2..3][4..19][20..21][22..23][24]//[25]
  UUID_BYTES_128_BIT = 16;
  BEACON_STANDARD_ADV_LENGTH = 25;
  BEACON_ALTERNATIVE_ADV_LENGTH = 26;
  BEACON_ADV_MAJOR_POSITION = 20;
  BEACON_ADV_MINOR_POSITION = 22;
  BEACON_ADV_TXPOWER_POSITION = 24;
  MANUFACTURE_ID_POS = 0;
  BEACON_TYPE_POS = 2;
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
    ADVLength := BEACON_ALTERNATIVE_ADV_LENGTH;
    PWord(@Result[MANUFACTURE_ID_POS])^ := ManufacturerId;
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
