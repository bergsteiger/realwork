unit daFieldDescription;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TdaFieldDescription = class(Tl3ProtoObject, IdaFieldDescription)
  procedure Create(const aName: AnsiString;
   const aDesc: AnsiString;
   aRequired: Boolean;
   aType: TdaDataType;
   aSize: Integer);
  function Make(const aName: AnsiString;
   const aDesc: AnsiString;
   aRequired: Boolean;
   aType: TdaDataType;
   aSize: Integer): IdaFieldDescription;
  function Name: AnsiString;
  function Description: AnsiString;
  function DataType: TdaDataType;
  function Required: Boolean;
  function Table: IdaTableDescription;
   {* Должно быть Weak }
  function Index: Integer;
  procedure BindToTable(const aTable: IdaTableDescription;
   anIndex: Integer);
  function SIze: Integer;
 end;//TdaFieldDescription
 
implementation

uses
 l3ImplUses
;

end.
