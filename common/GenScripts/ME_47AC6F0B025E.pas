unit k2Base;

interface

uses
 l3IntfUses
 , k2Prim
 , k2TypeModelPart
 , l3Types
 , k2AtomWrapPrim
 , l3Variant
;

type
 Tk2CustomProperty = class(Tk2CustomPropertyPrim)
  {* Базовый класс для описания свойства тега. }
  function EmptyMapping: Integer;
  function ReadOnly: Boolean;
  function MappingTarget: Integer;
  function DefaultValue: Integer;
 end;//Tk2CustomProperty
 
 Tk2Property = class(Tk2CustomProperty)
  {* Описание свойства тега. }
 end;//Tk2Property
 
 Tk2Type = class(Tk2TypeModelPart)
 end;//Tk2Type
 
 Tk2ChildrenProperty = class(Tk2CustomProperty)
 end;//Tk2ChildrenProperty
 
 Wk2Atom = class(Tk2AtomWrapPrim)
  {* Инструмент для реализации операций с тегами. }
  procedure ForceStore(aTag: Tl3Variant);
  function MarkModified(aTag: Tl3Variant): Boolean;
  function AsString(A: Tl3Variant): AnsiString;
  function StrToTag(const aValue: AnsiString): Tl3Tag;
  function ObjToTag(aValue: TObject): Il3TagRef;
  function GetAtomData(AE: Tl3Variant;
   aProp: Tk2CustomProperty;
   out Data: Tl3Variant): Boolean;
  function PreGetAtomData(AE: Tl3Variant;
   aProp: Tk2CustomProperty;
   out Data: Tl3Variant): Boolean;
 end;//Wk2Atom
 
 Tk2CustomPropertyPrim = k2Prim.Tk2CustomPropertyPrim;
 
 Tk2TypePrim = k2Prim.Tk2TypePrim;
 
 Tk2Base = k2Prim.Tk2Base;
 
 Tk2TypeTable = class(Tk2TypeTablePrim)
 end;//Tk2TypeTable
 
 Tk2Prop = Tk2CustomProperty;
 
 Tk2ArrayProperty = Tk2ChildrenProperty;
 
implementation

uses
 l3ImplUses
 , k2PropSorter
 , k2NullTagImpl
 , k2SortTagsList
;

end.
