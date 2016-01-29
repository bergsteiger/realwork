unit pgDataConverter;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , pgInterfaces
 , daTypes
 , l3Date
 , daInterfaces
;

type
 TpgDataConverter = class(Tl3ProtoObject, IpgDataConverter)
  procedure Create;
  function Make: IpgDataConverter;
  function AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
  procedure ParamToDataBase(const aDescription: IdaParamDescription;
   ClientBufferFormat: TdaDataType;
   aClientBuffer: Pointer;
   aServerBuffer: Pointer);
  procedure ParamFromDataBase(const aDescription: IdaParamDescription;
   ClientBufferFormat: TdaDataType;
   aServerBuffer: Pointer;
   aClientBuffer: Pointer);
  procedure FreeParamBuffer(const aDescription: IdaParamDescription;
   aBuffer: Pointer);
  function ToInteger(aData: Pointer): Integer;
  function ToLargeInt(aData: Pointer): LargeInt;
  function ToStDate(aData: Pointer): TStDate;
  function ToStTime(aData: Pointer): TStTime;
  function ToString(aData: Pointer): AnsiString;
  function ToByte(aData: Pointer): Byte;
 end;//TpgDataConverter
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
