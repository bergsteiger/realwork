unit htField;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , HT_Const
 , htInterfaces
 , daTypes
 , l3Date
;

type
 ThtField = class(Tl3ProtoObject, IdaField)
  procedure Create(const aDataBuffer: IdaResultBuffer;
   const aDataConverter: IhtDataConverter;
   const aClientInfo: IdaSelectField;
   const aServerInfo: OPEL);
  function Make(const aDataBuffer: IdaResultBuffer;
   const aDataConverter: IhtDataConverter;
   const aClientInfo: IdaSelectField;
   const aServerInfo: OPEL): IdaField;
  function BufferPtr: Pointer;
  function AsLargeInt: LargeInt;
  function AsInteger: Integer;
  function AsStDate: TStDate;
  function AsStTime: TStTime;
  function AsString: AnsiString;
  function AsByte: Byte;
  function Alias: AnsiString;
 end;//ThtField
 
implementation

uses
 l3ImplUses
;

end.
