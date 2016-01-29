unit k2VariantImpl;

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , k2Interfaces
 , l3Variant
 , Classes
 , l3Interfaces
;

type
 Tk2VariantImpl = class(Tl3DataContainerWithoutIUnknownPrim, Ik2Variant)
  procedure Create(aTag: Tl3Variant);
  function Make(aTag: Tl3Variant): Ik2Variant; overload;
  function Make(aValue: Integer): Ik2Variant; overload;
  function Kind: Tk2VarKind;
  function AsString: Tl3PrimString;
  function AsInteger: Integer;
  function AsStream: TStream;
  function AsVariant: Tl3Variant;
 end;//Tk2VariantImpl
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Stream
 , k2String_Const
 , k2Base
 , k2NullTagImpl
 , k2Long_Const
;

end.
