unit pgInterfaces;

// Модуль: "w:\common\components\rtl\Garant\PG\pgInterfaces.pas"
// Стереотип: "Interfaces"

{$Include pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daInterfaces
 , ddAppConfig
 , daTypes
 , l3Date
 , SysUtils
;

const
 c_DefaultPostgresPort = 5432;

type
 IpgParamsStorage = interface(IdaParamsStorage)
  ['{6C19DDA2-B6B6-4D74-B18D-DA7D80F4BEC5}']
  function Get_DataServerHostName: AnsiString;
  procedure Set_DataServerHostName(const aValue: AnsiString);
  function Get_DataServerPort: Integer;
  procedure Set_DataServerPort(aValue: Integer);
  property DataServerHostName: AnsiString
   read Get_DataServerHostName
   write Set_DataServerHostName;
  property DataServerPort: Integer
   read Get_DataServerPort
   write Set_DataServerPort;
 end;//IpgParamsStorage

 IpgDataConverter = interface(IdaDataConverter)
  ['{E5C309A7-632D-4345-92DF-9CA08F824EA7}']
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
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(UsePostgres)

end.
