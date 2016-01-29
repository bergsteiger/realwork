unit daSelectField;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TdaSelectField = class(Tl3ProtoObject, IdaSelectField, IdaFieldFromTable)
  procedure Create(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const anAlias: AnsiString);
  function Make(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const anAlias: AnsiString): IdaSelectField;
  function TableAlias: AnsiString;
  function Field: IdaFieldDescription;
  function Alias: AnsiString;
  function BuildSQLValue: AnsiString;
 end;//TdaSelectField
 
implementation

uses
 l3ImplUses
;

end.
