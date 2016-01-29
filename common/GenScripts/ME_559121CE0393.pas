unit htResultSet;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , HT_Const
 , dt_List
 , daFieldList
 , htInterfaces
 , daSelectFieldList
;

type
 ThtResultSet = class(Tl3ProtoObject, IdaResultSet, IdaResultBuffer)
  procedure Create(const aDataConverter: IhtDataConverter;
   const aSAB: SAB;
   aSelectFields: TdaSelectFieldList;
   Unidirectional: Boolean);
  function Make(const aDataConverter: IhtDataConverter;
   const aSAB: SAB;
   aSelectFields: TdaSelectFieldList;
   Unidirectional: Boolean): IdaResultSet;
  procedure Next;
  function EOF: Boolean;
  function IsEmpty: Boolean;
  function Field: IdaField;
  procedure RegisterField(const aField: IdaField);
  procedure UnregisterField(const aField: IdaField);
  function FieldBufferPtr(FieldIndex: Integer): Pointer;
 end;//ThtResultSet
 
implementation

uses
 l3ImplUses
 , l3Base
 , HT_DLL
 , dt_Err
 , SysUtils
 , dt_Types
 , htField
 , l3Types
;

end.
