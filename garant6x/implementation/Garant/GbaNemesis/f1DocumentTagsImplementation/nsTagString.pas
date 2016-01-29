unit nsTagString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsTagString.pas"
// Начат: 2005/06/23 16:38:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::TnsTagString
//
// Строка, представляющая строковый атрибут тега
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsString,
  k2Base,
  k2TagList,
  k2Prim,
  k2BaseStruct,
  l3Variant,
  l3Interfaces,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

 {$Define k2TagIsString}

 {$Define k2Tag_No_f_TagType}

type
 _k2Tag_Parent_ = TnsNewString;
 {$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}
 TnsTagString = class(_k2Tag_)
  {* Строка, представляющая строковый атрибут тега }
 protected
 // realized methods
   {$If not defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} //not k2TagIsAtomic
 protected
 // overridden protected methods
   procedure InitFields; override;
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
 public
 // overridden public methods
   function Clone: Pointer; override;
     {* Создайт копию строки. }
 end;//TnsTagString

implementation

uses
  l3_String,
  k2String_Const,
  k2String,
  k2Tags,
  l3Dict,
  k2Const,
  l3Const,
  SysUtils,
  l3String,
  k2Except,
  k2Strings,
  TypInfo,
  l3Stream,
  l3Base,
  k2Facade,
  Classes,
  k2OList_Const,
  k2Dictionary,
  k2NonOptimizeContext,
  k2VariantImpl,
  k2Bool_Const,
  k2List,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = TnsTagString;

{$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}

// start class TnsTagString

{$If not defined(k2TagIsAtomic)}
function TnsTagString.SetAtomPrim(const aProp: _PropIn_;
  var V: Tk2Values): Boolean;
//#UC START# *49A545580241_467FCA0F01C6_var*
//#UC END# *49A545580241_467FCA0F01C6_var*
begin
//#UC START# *49A545580241_467FCA0F01C6_impl*
 Assert(false);
//#UC END# *49A545580241_467FCA0F01C6_impl*
end;//TnsTagString.SetAtomPrim
{$IfEnd} //not k2TagIsAtomic

procedure TnsTagString.InitFields;
//#UC START# *47A042E100E2_467FCA0F01C6_var*
//#UC END# *47A042E100E2_467FCA0F01C6_var*
begin
//#UC START# *47A042E100E2_467FCA0F01C6_impl*
 inherited;
 //f_TagType := k2_typString;
//#UC END# *47A042E100E2_467FCA0F01C6_impl*
end;//TnsTagString.InitFields

function TnsTagString.Clone: Pointer;
//#UC START# *47BC3FC40111_467FCA0F01C6_var*
//#UC END# *47BC3FC40111_467FCA0F01C6_var*
begin
//#UC START# *47BC3FC40111_467FCA0F01C6_impl*
 Result := Tk2String.Create;
 Tk2String(Result).AssignString(Self);
//#UC END# *47BC3FC40111_467FCA0F01C6_impl*
end;//TnsTagString.Clone

function TnsTagString.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_467FCA0F01C6_var*
//#UC END# *532AE8F2009A_467FCA0F01C6_var*
begin
//#UC START# *532AE8F2009A_467FCA0F01C6_impl*
 Result := false;
//#UC END# *532AE8F2009A_467FCA0F01C6_impl*
end;//TnsTagString.GetIsOrd

function TnsTagString.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_467FCA0F01C6_var*
//#UC END# *533121AF0203_467FCA0F01C6_var*
begin
//#UC START# *533121AF0203_467FCA0F01C6_impl*
 Result := k2_typString;
//#UC END# *533121AF0203_467FCA0F01C6_impl*
end;//TnsTagString.GetTagType

end.