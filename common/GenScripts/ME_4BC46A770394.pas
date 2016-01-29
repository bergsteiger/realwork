unit k2TypeModelPart;

interface

uses
 l3IntfUses
 , k2Prim
 , l3Variant
 , l3Types
;

type
 Tk2TypeModelPart = class(Tk2TypePrim)
  {* Часть Tk2Type, перенесённая на модель }
  function CompareTags(A: Tl3Variant;
   B: Tl3Variant;
   aSortIndex: Tl3SortIndex): Integer;
   {* Сравнивает теги }
  function CompareTagWithInt(aTag: Tl3Variant;
   aValue: Integer;
   anIndex: Integer): Integer;
   {* Сравнивает тег с целым }
 end;//Tk2TypeModelPart
 
implementation

uses
 l3ImplUses
 , k2SortTagsList
 , k2String_Const
 , k2Base
 , k2Tags
 , l3String
;

end.
