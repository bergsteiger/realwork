unit daParam;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , l3Date
;

type
 TdaParam = class(Tl3ProtoObject, IdaParam)
  procedure Create(const aConverter: IdaDataConverter;
   const aDesc: IdaParamDescription;
   aParamType: TdaParamType);
  function Make(const aConverter: IdaDataConverter;
   const aDesc: IdaParamDescription;
   aParamType: TdaParamType): IdaParam;
  function Name: AnsiString;
  function IsSameType(const aDesc: IdaParamDescription): Boolean;
  function AsInteger: LongInt;
  function DataBuffer: Pointer;
  function AsLargeInt: LargeInt;
  function AsString: AnsiString;
  function AsStDate: TStDate;
  function AsStTime: TStTime;
  function ParamType: TdaParamType;
 end;//TdaParam
 
implementation

uses
 l3ImplUses
;

end.
