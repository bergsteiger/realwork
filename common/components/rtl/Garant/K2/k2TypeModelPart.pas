unit k2TypeModelPart;
 {* Часть Tk2Type, перенесённая на модель }

// Модуль: "w:\common\components\rtl\Garant\K2\k2TypeModelPart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2TypeModelPart" MUID: (4BC46A770394)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

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
  public
   function CompareTags(A: Tl3Variant;
    B: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer; virtual;
    {* Сравнивает теги }
   function CompareTagWithInt(aTag: Tl3Variant;
    aValue: Integer;
    anIndex: Integer): Integer; virtual;
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
 , l3IID
 , l3InterfacesMisc
 //#UC START# *4BC46A770394impl_uses*
 //#UC END# *4BC46A770394impl_uses*
;

function Tk2TypeModelPart.CompareTags(A: Tl3Variant;
 B: Tl3Variant;
 aSortIndex: Tl3SortIndex): Integer;
 {* Сравнивает теги }
//#UC START# *4BC477E60259_4BC46A770394_var*

 function ComplexCompare(anIndex : Integer): Integer;
   {-}
 var
  l_Index : Integer;
  l_B     : TLongArray;
  l_T     : Integer;
  l_I     : Integer;
 begin
  Result := 0;
  l_B := Tk2SortTagsList.Instance.Items[anIndex - k2_tiComplexBase];
  for l_Index := Low(l_B) to High(l_B) do
  begin
   l_I := l_B[l_Index];
   l_T := Abs(l_I);
   if Tk2Type(A.TagType).Prop[l_T].AtomType.IsKindOf(k2_typString) then
    Result := l3Compare(A.PCharLenA[l_T], B.PCharLenA[l_T])
   else
    Result := A.IntA[l_T] - B.IntA[l_T];
   if (Result <> 0) then
   begin
    if (l_I < 0) then
     Result := -Result;
    break;
   end;//Result <> 0
  end;//for l_Index
 end;

//#UC END# *4BC477E60259_4BC46A770394_var*
begin
//#UC START# *4BC477E60259_4BC46A770394_impl*
 if (aSortIndex < 0) then
 begin
  Assert(false);
  Result := -1;
 end//aSortIndex < 0
 else
 begin
  if (A.AsObject = B.AsObject) then
   Result := 0
  else
  if (aSortIndex >= k2_tiComplexBase) then
   Result := ComplexCompare(aSortIndex)
  else
  if Tk2Type(A.TagType).Prop[aSortIndex].AtomType.IsKindOf(k2_typString) then
   Result := l3Compare(A.PCharLenA[aSortIndex], B.PCharLenA[aSortIndex])
  else
   Result := CompareTagWithInt(A, B.IntA[aSortIndex], aSortIndex);
 end;//aSortIndex < 0
//#UC END# *4BC477E60259_4BC46A770394_impl*
end;//Tk2TypeModelPart.CompareTags

function Tk2TypeModelPart.CompareTagWithInt(aTag: Tl3Variant;
 aValue: Integer;
 anIndex: Integer): Integer;
 {* Сравнивает тег с целым }
//#UC START# *4BC47828023F_4BC46A770394_var*
//#UC END# *4BC47828023F_4BC46A770394_var*
begin
//#UC START# *4BC47828023F_4BC46A770394_impl*
 if (anIndex < 0) then
 begin
  Assert(false);
  Result := -1;
 end//anIndex < 0
 else
 if (anIndex >= k2_tiComplexBase) then
 begin
  Assert(false);
  Result := -1;
 end//anIndex >= k2_tiComplexBase
 else
  Result := aTag.IntA[anIndex] - aValue;
//#UC END# *4BC47828023F_4BC46A770394_impl*
end;//Tk2TypeModelPart.CompareTagWithInt

end.
