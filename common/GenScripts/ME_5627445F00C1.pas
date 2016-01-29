unit pgField;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , pgInterfaces
 , daTypes
 , l3Date
;

type
 TpgField = class(Tl3ProtoObject, IdaField)
  procedure Create(const aDataBuffer: IdaResultBuffer;
   const aDataConverter: IpgDataConverter;
   const aClientInfo: IdaSelectField;
   aFieldIndex: Integer);
  function Make(const aDataBuffer: IdaResultBuffer;
   const aDataConverter: IpgDataConverter;
   const aClientInfo: IdaSelectField;
   aFieldIndex: Integer): IdaField;
  function BufferPtr: Pointer;
  function AsLargeInt: LargeInt;
  function AsInteger: Integer;
  function AsStDate: TStDate;
  function AsStTime: TStTime;
  function AsString: AnsiString;
  function AsByte: Byte;
  function Alias: AnsiString;
 end;//TpgField
 
implementation

uses
 l3ImplUses
;

end.
