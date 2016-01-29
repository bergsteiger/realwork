unit k2ParentedTypedSmallListTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2ParentedTypedSmallListTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2ParentedTypedSmallListTag
//
// Список тегов со ссылкой на родителя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2TypedSmallListTag,
  l3Variant
  ;

type
 _k2ParentedTagObject_Parent_ = Tk2TypedSmallListTag;
 {$Include ..\K2\k2ParentedTagObject.imp.pas}
 Tk2ParentedTypedSmallListTag = class(_k2ParentedTagObject_)
  {* Список тегов со ссылкой на родителя }
 end;//Tk2ParentedTypedSmallListTag

implementation

uses
  k2Base,
  k2NullTagImpl
  ;

{$Include ..\K2\k2ParentedTagObject.imp.pas}

end.