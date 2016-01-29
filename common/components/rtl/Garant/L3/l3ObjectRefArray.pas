unit l3ObjectRefArray;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ObjectRefArray.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3ObjectRefArray
//
// "Открытый массив". Список, который автоматически расширяется при добавлении элемента за гранецей
// диапазона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObjectRefList
  ;

type
 _l3OpenArray_Parent_ = Tl3ProtoObjectRefList;
 {$Include ..\L3\l3OpenArray.imp.pas}
 Tl3ObjectRefArray = class(_l3OpenArray_)
  {* "Открытый массив". Список, который автоматически расширяется при добавлении элемента за гранецей диапазона }
 end;//Tl3ObjectRefArray

implementation

uses
  l3Base
  ;

type _Instance_R_ = Tl3ObjectRefArray;

{$Include ..\L3\l3OpenArray.imp.pas}

end.