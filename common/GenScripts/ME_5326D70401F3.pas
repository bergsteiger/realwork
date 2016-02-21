unit l3Variants;

// ћодуль: "w:\common\components\rtl\Garant\L3\l3Variants.pas"
// —тереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
;

 (*
 Ml3Variant = interface
  function pm_GetAsWStr: Tl3WString;
  function pm_GetAsString: AnsiString;
  function AsBool: Boolean;
   {* преобразовать к Boolean. }
  function AsLong: Integer;
  function IsNull: Boolean;
   {* пустой тег? }
  function IsTransparent: Boolean;
   {* тег "прозрачный"? }
  function IsValid: Boolean;
   {* тег имеет значение? }
  function IsStream(out theStream: IStream): Boolean;
   {* ѕровер€ет может ли тег приводитьс€ к потоку. » приводит к потоку - если указатель на поток - не нулевой. }
  function MarkModified: Boolean;
  property AsWStr: Tl3WString
   read pm_GetAsWStr;
   {* свойство дл€ преобразовани€ к типу Tl3PCharLen }
  property AsString: AnsiString
   read pm_GetAsString;
   {* свойство дл€ преобразовани€ к строкам Delphi }
 end;//Ml3Variant
 *)

 (*
 Mk2AtomHolder = interface
  function HasSubAtom(anIndex: Integer): Boolean;
 end;//Mk2AtomHolder
 *)

 (*
 Mk2TypeInfo = interface
  {* »нформаци€ о типе }
  function IsOrd: Boolean;
 end;//Mk2TypeInfo
 *)

implementation

uses
 l3ImplUses
;

end.
