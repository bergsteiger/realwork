unit l3AsincMessageWindowRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3AsincMessageWindowRes.pas"
// Начат: 18.10.2010
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3AsincMessageWindowRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3StringIDEx
  ;

var
  { Локализуемые строки Local }
 str_l3mmLongOperation : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmLongOperation'; rValue : 'Выполняется длительная операция...');
  { 'Выполняется длительная операция...' }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_l3mmLongOperation
 str_l3mmLongOperation.Init;

end.