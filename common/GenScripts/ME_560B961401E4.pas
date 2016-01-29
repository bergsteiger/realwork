unit pgResultSet;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , LibPQ
 , daSelectFieldList
 , daFieldList
 , pgInterfaces
 , pgConnection
 , daParamList
;

type
 TpgResultSet = class(Tl3ProtoObject, IdaResultSet, IdaResultBuffer)
  procedure Create(aConnection: TpgConnection;
   const aDataConverter: IpgDataConverter;
   const aQueryName: AnsiString;
   aParams: TdaParamList;
   aSelectFields: TdaSelectFieldList;
   Unidirectional: Boolean);
  function Make(aConnection: TpgConnection;
   const aDataConverter: IpgDataConverter;
   const aQueryName: AnsiString;
   aParams: TdaParamList;
   aSelectFields: TdaSelectFieldList;
   Unidirectional: Boolean): IdaResultSet;
  procedure Next;
  function EOF: Boolean;
  function IsEmpty: Boolean;
  function Field: IdaField;
  procedure RegisterField(const aField: IdaField);
  procedure UnregisterField(const aField: IdaField);
  function FieldBufferPtr(FieldIndex: Integer): Pointer;
 end;//TpgResultSet
 
implementation

uses
 l3ImplUses
 , SysUtils
 , pgField
 , l3Types
;

end.
