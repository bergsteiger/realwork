unit k2TagBox.imp;

interface

uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
 , k2BaseTypes
 , l3Types
;

type
 _k2TagBox_ = class(_k2Int64Holder_, Il3TagRef)
  {* Реализация инструмента, работающего с тегами }
  function GetRedirect: Tl3Variant;
 end;//_k2TagBox_
 
implementation

uses
 l3ImplUses
 , k2NullTagImpl
 , k2Tags
 , k2Base
 , k2InterfaceFactory
;

type
 Tl3HackVariant = class(Tl3Variant)
 end;//Tl3HackVariant
 
end.
