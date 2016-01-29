unit ddAppConfigListsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd$AppConfig"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/dd/ddAppConfigListsRes.pas"
// Начат: 15.10.201. 19:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd$AppConfig::AppConfig::ddAppConfigListsRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { Локализуемые строки ConfigMessages }
 str_ddcmAddConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmAddConfigValue'; rValue : 'Добавить');
  { 'Добавить' }
 str_ddcmChangeConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmChangeConfigValue'; rValue : 'Исправить');
  { 'Исправить' }
 str_ddcmDeleteConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmDeleteConfigValue'; rValue : 'Удалить');
  { 'Удалить' }
 str_ddcmConfirmDeleteConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmConfirmDeleteConfigValue'; rValue : 'Вы действительно хотите удалить элемент "%s"?');
  { 'Вы действительно хотите удалить элемент "%s"?' }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_ddcmAddConfigValue
 str_ddcmAddConfigValue.Init;
// Инициализация str_ddcmChangeConfigValue
 str_ddcmChangeConfigValue.Init;
// Инициализация str_ddcmDeleteConfigValue
 str_ddcmDeleteConfigValue.Init;
// Инициализация str_ddcmConfirmDeleteConfigValue
 str_ddcmConfirmDeleteConfigValue.Init;

end.