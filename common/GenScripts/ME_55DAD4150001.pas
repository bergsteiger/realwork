unit pgInterfaces;

interface

uses
 l3IntfUses
 , daInterfaces
 , ddAppConfig
 , daTypes
 , l3Date
 , SysUtils
;

type
 IpgParamsStorage = interface(IdaParamsStorage)
 end;//IpgParamsStorage
 
 IpgDataConverter = interface(IdaDataConverter)
  function ToInteger(aData: Pointer): Integer;
  function ToLargeInt(aData: Pointer): LargeInt;
  function ToStDate(aData: Pointer): TStDate;
  function ToStTime(aData: Pointer): TStTime;
  function ToString(aData: Pointer): AnsiString;
  function ToByte(aData: Pointer): Byte;
 end;//IpgDataConverter
 
 EPgError = class(Exception)
 end;//EPgError
 
 EpgLockError = class(EPgError)
 end;//EpgLockError
 
implementation

uses
 l3ImplUses
;

end.
