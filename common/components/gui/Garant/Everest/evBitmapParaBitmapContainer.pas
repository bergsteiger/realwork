unit evBitmapParaBitmapContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evBitmapParaBitmapContainer.pas"
// Начат: 25.02.2000 10:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Standard::TevBitmapParaBitmapContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base,
  l3IEBitmapContainer,
  k2TagList,
  k2Prim,
  k2BaseStruct,
  l3Variant,
  l3Interfaces,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

 {$Define k2TagNoAssign}

 {$Define k2Tag_No_f_TagType}

type
 _k2Tag_Parent_ = Tl3IEBitmapContainer;
 {$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}
 TevBitmapParaBitmapContainer = class(_k2Tag_)
 protected
 // realized methods
   {$If not defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} //not k2TagIsAtomic
 protected
 // overridden protected methods
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
 public
 // public methods
   constructor Create(aType: Tk2Type); reintroduce;
 end;//TevBitmapParaBitmapContainer

implementation

uses
  BitmapPara_Const,
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
  k2String,
  k2List,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = TevBitmapParaBitmapContainer;

{$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}

// start class TevBitmapParaBitmapContainer

constructor TevBitmapParaBitmapContainer.Create(aType: Tk2Type);
//#UC START# *53075BB9030D_4858153B023B_var*
//#UC END# *53075BB9030D_4858153B023B_var*
begin
//#UC START# *53075BB9030D_4858153B023B_impl*
 inherited Create;
 //f_TagType := aType;
//#UC END# *53075BB9030D_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.Create

{$If not defined(k2TagIsAtomic)}
function TevBitmapParaBitmapContainer.SetAtomPrim(const aProp: _PropIn_;
  var V: Tk2Values): Boolean;
//#UC START# *49A545580241_4858153B023B_var*
//#UC END# *49A545580241_4858153B023B_var*
begin
//#UC START# *49A545580241_4858153B023B_impl*
 Assert(false);
 Result := false;
//#UC END# *49A545580241_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.SetAtomPrim
{$IfEnd} //not k2TagIsAtomic

function TevBitmapParaBitmapContainer.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_4858153B023B_var*
//#UC END# *532AE8F2009A_4858153B023B_var*
begin
//#UC START# *532AE8F2009A_4858153B023B_impl*
 Result := false;
//#UC END# *532AE8F2009A_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.GetIsOrd

function TevBitmapParaBitmapContainer.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_4858153B023B_var*
//#UC END# *533121AF0203_4858153B023B_var*
begin
//#UC START# *533121AF0203_4858153B023B_impl*
 Result := k2_typBitmapPara_Object;
//#UC END# *533121AF0203_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.GetTagType

end.