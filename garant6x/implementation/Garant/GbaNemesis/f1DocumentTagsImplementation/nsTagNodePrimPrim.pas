unit nsTagNodePrimPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagNodePrimPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsTagNodePrimPrim" MUID: (4C6D0FD10112)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsBaseTagNode
 , k2Base
 , l3Variant
;

type
 TnsTagNodePrimPrim = {abstract} class(TnsBaseTagNode)
  protected
   function BaseGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean;
   procedure StoreIntAtom(aProp: Tk2Prop;
    aValue: Integer);
   procedure StoreTagAtom(aProp: Tk2Prop;
    aValue: Tl3Variant);
 end;//TnsTagNodePrimPrim

implementation

uses
 l3ImplUses
 , k2BaseStruct
 //#UC START# *4C6D0FD10112impl_uses*
 //#UC END# *4C6D0FD10112impl_uses*
;

function TnsTagNodePrimPrim.BaseGetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *4C6D103002F8_4C6D0FD10112_var*
//#UC END# *4C6D103002F8_4C6D0FD10112_var*
begin
//#UC START# *4C6D103002F8_4C6D0FD10112_impl*
 Result := inherited GetSubAtom(aProp, Data)
//#UC END# *4C6D103002F8_4C6D0FD10112_impl*
end;//TnsTagNodePrimPrim.BaseGetSubAtom

procedure TnsTagNodePrimPrim.StoreIntAtom(aProp: Tk2Prop;
 aValue: Integer);
//#UC START# *4E68A61B0222_4C6D0FD10112_var*
var
 l_Tag : Tl3Variant;
//#UC END# *4E68A61B0222_4C6D0FD10112_var*
begin
//#UC START# *4E68A61B0222_4C6D0FD10112_impl*
 if Tk2Type(aProp.AtomType).IsOrd then
  l_Tag := aProp.MakeTag(aValue).AsObject
 else
 begin
  Assert(false);
  l_Tag := nil{Tk2Type(aProp.AtomType)._IntToTag(aValue)};
 end;//Tk2Type(aProp.AtomType).IsOrd
 StoreTagAtom(aProp, l_Tag);
//#UC END# *4E68A61B0222_4C6D0FD10112_impl*
end;//TnsTagNodePrimPrim.StoreIntAtom

procedure TnsTagNodePrimPrim.StoreTagAtom(aProp: Tk2Prop;
 aValue: Tl3Variant);
//#UC START# *4E68A69B0273_4C6D0FD10112_var*
var
 l_P : _PropLoc_;
//#UC END# *4E68A69B0273_4C6D0FD10112_var*
begin
//#UC START# *4E68A69B0273_4C6D0FD10112_impl*
 l_P{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := aProp;
 l_P.rOp := nil;
 l_P{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := true;
 SetSubAtom(_PropIn_(l_P), aValue);
//#UC END# *4E68A69B0273_4C6D0FD10112_impl*
end;//TnsTagNodePrimPrim.StoreTagAtom

end.
