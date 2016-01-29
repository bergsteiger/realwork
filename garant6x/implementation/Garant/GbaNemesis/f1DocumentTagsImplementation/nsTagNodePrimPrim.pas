unit nsTagNodePrimPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsTagNodePrimPrim.pas"
// Начат: 10.08.2010 15:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsTagNodePrimPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsBaseTagNode,
  k2Base,
  l3Variant
  ;

type
 TnsTagNodePrimPrim = {abstract} class(TnsBaseTagNode)
 protected
 // protected methods
   function BaseGetSubAtom(aProp: Tk2Prop;
     out Data: Tl3Variant): Boolean;
   procedure StoreIntAtom(aProp: Tk2Prop;
     aValue: Integer);
   procedure StoreTagAtom(aProp: Tk2Prop;
     aValue: Tl3Variant);
 end;//TnsTagNodePrimPrim

implementation

uses
  k2BaseStruct
  ;

// start class TnsTagNodePrimPrim

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