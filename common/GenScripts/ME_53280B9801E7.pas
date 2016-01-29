unit k2TagPrim.imp;

interface

uses
 l3IntfUses
 , k2Base
 , k2BaseStruct
 , l3Variant
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

 {$Define l3Items_NoSort}
 
type
 _k2TagPrim_ = class(_k2Int64Holder_, Ml3VariantMirror)
  function IterateInnerChildrenOnWrite: Boolean;
  function HackChildren: Tk2TagList;
  procedure CheckChildInsert(var anIndex: Integer;
   var aChild: Tl3Variant;
   const anOp: Ik2Op);
  procedure ChildAdded(aProp: Tk2ArrayProperty;
   aChild: Tl3Variant;
   anIndex: Integer;
   aTotal: Integer;
   const anOpPack: Il3OpPack);
  function DoSetAtom(const aProp: _PropIn_;
   aValue: Tl3Variant): Boolean;
  function GetOwnAttrValue(aProp: Tk2Prop;
   out theValue: Tl3Variant): Boolean;
  function GetAttrValue(aProp: Tk2Prop;
   out theValue: Tl3Variant): Boolean;
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
  function GetHasSubAtom(aProp: Tk2Prop): Boolean;
  function GetSubAtom(aProp: Tk2Prop;
   out Data: Tl3Variant): Boolean;
  procedure SetSubAtom(const aProp: _PropIn_;
   aValue: Tl3Variant);
 end;//_k2TagPrim_
 
implementation

uses
 l3ImplUses
 , k2NullTagImpl
 , k2Interfaces
 , k2NonOptimizeContext
 , k2Dictionary
 , k2DictionaryPrim
 , k2Tags
 , k2InterfaceFactory
 , k2List
;

end.
