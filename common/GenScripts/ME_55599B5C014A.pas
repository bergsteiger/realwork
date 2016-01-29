unit htDataConverter;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , htInterfaces
 , HT_Const
 , daTypes
 , l3Date
 , daInterfaces
;

type
 ThtDataConverter = class(Tl3ProtoObject, IhtDataConverter)
  procedure Create;
  function Make: IhtDataConverter;
  function MakeString(aData: Pointer;
   const aDesc: OPEL): AnsiString;
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
  function ToLargeInt(aData: Pointer;
   const aDesc: OPEL): LargeInt;
  function ToInteger(aData: Pointer;
   const aDesc: OPEL): Integer;
  function ToStDate(aData: Pointer;
   const aDesc: OPEL): TStDate;
  function ToStTime(aData: Pointer;
   const aDesc: OPEL): TStTime;
  function ToString(aData: Pointer;
   const aDesc: OPEL): AnsiString;
  function ToByte(aData: Pointer;
   const aDesc: OPEL): Byte;
 end;//ThtDataConverter
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , SysUtils
;

end.
