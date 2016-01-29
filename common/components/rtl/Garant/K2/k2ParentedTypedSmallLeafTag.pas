unit k2ParentedTypedSmallLeafTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2ParentedTypedSmallLeafTag.pas"
// Начат: 20.07.2009 19:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2ParentedTypedSmallLeafTag
//
// Листьевой тег с заранее определённым типом, имеющий ссылку на родителя и могущий иметь НЕ более
// 32 (включительно) атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2TypedSmallLeafTag,
  l3Variant
  ;

type
//#UC START# *4A64874301F2ci*
 {$Define k2Tag_No_f_TagType}
//#UC END# *4A64874301F2ci*
 _k2ParentedTagObject_Parent_ = Tk2TypedSmallLeafTag;
 {$Include ..\K2\k2ParentedTagObject.imp.pas}
//#UC START# *4A64874301F2cit*
//#UC END# *4A64874301F2cit*
 Tk2ParentedTypedSmallLeafTag = class(_k2ParentedTagObject_)
  {* Листьевой тег с заранее определённым типом, имеющий ссылку на родителя и могущий иметь НЕ более 32 (включительно) атрибутов }
//#UC START# *4A64874301F2publ*
//#UC END# *4A64874301F2publ*
 end;//Tk2ParentedTypedSmallLeafTag

implementation

uses
  k2Base,
  k2NullTagImpl
  ;

{$Include ..\K2\k2ParentedTagObject.imp.pas}


//#UC START# *4A64874301F2impl*
//#UC END# *4A64874301F2impl*
end.