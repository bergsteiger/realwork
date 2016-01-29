unit k2Types;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Types.pas"
// Начат: 01.12.1998 19:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::K2::k2Types
//
// Базовые типы.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Interfaces,
  l3Variant
  ;

type
 Tk2TypeKind = k2Interfaces.Tk2TypeKind;

 Tk2VarKind = l3Variant.Tk2VarKind;

 Tk2Variant = k2Interfaces.Tk2Variant;

const
  { Алиасы для значений l3Variant.Tk2VarKind }
 k2_vkInteger = l3Variant.k2_vkInteger;
 k2_vkString = l3Variant.k2_vkString;
 k2_vkTransparent = l3Variant.k2_vkTransparent;
 k2_vkStream = l3Variant.k2_vkStream;
  { Алиасы для значений k2Interfaces.Tk2TypeKind }
 k2_tkInteger = k2Interfaces.k2_tkInteger;
 k2_tkBool = k2Interfaces.k2_tkBool;
 k2_tkObject = k2Interfaces.k2_tkObject;
 k2_tkTransparent = k2Interfaces.k2_tkTransparent;
 k2_tkStream = k2Interfaces.k2_tkStream;

implementation

end.