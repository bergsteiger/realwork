unit l3ProtoObjectComparable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoObjectComparable.pas"
// Начат: 16.02.2011 19:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::OVP::Tl3ProtoObjectComparable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject
  ;

type
 Tl3ProtoObjectComparable = class(Tl3ProtoObject)
 public
 // public methods
   function CompareWith(anOther: Tl3ProtoObjectComparable): Integer; virtual; abstract;
 end;//Tl3ProtoObjectComparable

implementation

end.