unit ddAppConfigRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd$AppConfig"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/dd/ddAppConfigRes.pas"
// Начат: 11.03.2010 18:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd$AppConfig::AppConfig::ddAppConfigRes
//
// Ресурсы для ddAppConfig
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
  { Локализуемые строки Local }
 str_ddmmSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmSettingsCaption'; rValue : 'Настройка конфигурации');
  { 'Настройка конфигурации' }
 str_ddmmErrorCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmErrorCaption'; rValue : 'Ошибка');
  { 'Ошибка' }

var
  { Локализуемые строки Errors }
 str_DifferentType : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DifferentType'; rValue : 'Тип свойства "%s" отличается от запрошенного');
  { 'Тип свойства "%s" отличается от запрошенного' }
 str_PropertyAbsent : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyAbsent'; rValue : 'Свойство "%s" отсутствует');
  { 'Свойство "%s" отсутствует' }
 str_PropertyExists : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyExists'; rValue : 'Свойство с именем "%s" уже существует');
  { 'Свойство с именем "%s" уже существует' }
 str_ListEmpty : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEmpty'; rValue : 'Конфигурация пуста');
  { 'Конфигурация пуста' }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_ddmmSettingsCaption
 str_ddmmSettingsCaption.Init;
// Инициализация str_ddmmErrorCaption
 str_ddmmErrorCaption.Init;
// Инициализация str_DifferentType
 str_DifferentType.Init;
// Инициализация str_PropertyAbsent
 str_PropertyAbsent.Init;
// Инициализация str_PropertyExists
 str_PropertyExists.Init;
// Инициализация str_ListEmpty
 str_ListEmpty.Init;

end.