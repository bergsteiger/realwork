unit daTableDescription;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , daFieldDescriptionList
;

type
 TdaTableDescription = class(Tl3ProtoObject, IdaTableDescription)
  procedure Create(aKind: TdaTables;
   const aCode: AnsiString;
   const aName: AnsiString;
   const aDescription: AnsiString;
   const aScheme: AnsiString;
   aDublicate: Boolean;
   aFake: Boolean);
  procedure AddField(const aField: IdaFieldDescription);
  function Description: AnsiString;
  function IsDublicate: Boolean;
   {* Дубликат таблицы для связки в запросах (HT по другому не умеет) }
  function IsFake: Boolean;
   {* Совсем виртуальная таблица }
  function Kind: TdaTables;
  function Field: IdaFieldDescription;
  function Code: AnsiString;
  procedure IterateFieldsF;
  function Name: AnsiString;
  function Scheme: AnsiString;
 end;//TdaTableDescription
 
implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
 , Classes
;

end.
