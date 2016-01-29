unit k2TypeModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypeModelPart.pas"
// Начат: 13.04.2010 16:59
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2TypeModelPart
//
// Часть Tk2Type, перенесённая на модель
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Types,
  k2Prim,
  l3Variant
  ;

type
 Tk2TypeModelPart = class(Tk2TypePrim)
  {* Часть Tk2Type, перенесённая на модель }
 public
 // public methods
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
  k2Tags,
  l3String,
  k2SortTagsList,
  k2String_Const,
  k2Base,
  l3IID,
  l3InterfacesMisc
  ;

// start class Tk2TypeModelPart

function Tk2TypeModelPart.CompareTags(A: Tl3Variant;
  B: Tl3Variant;
  aSortIndex: Tl3SortIndex): Integer;
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