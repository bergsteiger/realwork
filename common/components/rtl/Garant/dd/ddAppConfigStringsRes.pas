unit ddAppConfigStringsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd$AppConfig"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/dd/ddAppConfigStringsRes.pas"
// Начат: 15.03.2010 19:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd$AppConfig::AppConfig::ddAppConfigStringsRes
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
 str_ddcmCheckButton : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmCheckButton'; rValue : 'Проверка');
  { 'Проверка' }
 str_ddcmSoundFiles : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmSoundFiles'; rValue : 'Звуковые файлы (*.wav)|*.wav');
  { 'Звуковые файлы (*.wav)|*.wav' }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_ddcmCheckButton
 str_ddcmCheckButton.Init;
// Инициализация str_ddcmSoundFiles
 str_ddcmSoundFiles.Init;

end.