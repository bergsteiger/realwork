unit pgInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For Archi::PG::pgInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  daTypes,
  daInterfaces,
  SysUtils,
  l3Date
  ;

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

const
  { Defaults }
 c_DefaultPostgresPort = 5432;
{$IfEnd} //UsePostgres

implementation

end.