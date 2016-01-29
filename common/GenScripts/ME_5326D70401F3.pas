unit l3Variants;

interface

uses
 l3IntfUses
 , l3Interfaces
;

 (*
 Ml3Variant = interface
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
