unit evStylesPrintAndExportSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evStylesPrintAndExportSettingRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::StyleTable::evStylesPrintAndExportSettingRes
//
// Ресурсы для настройки "Печать и экспорт"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3StringIDEx
  ;

const
  { PrintAndExportKey }
 pi_evStyles_PrintAndExport = 'Стили/Печать и экспорт';
  { Идентификатор настройки "Печать и экспорт" }
 pi_evStyles_PrintAndExport_Default = 'Стили/Печать и экспорт/Использовать для экспорта и печати размер шрифта, отображаемого на экране';
  { Идентификатор настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
 pi_evStyles_PrintAndExport_Custom = 'Стили/Печать и экспорт/Использовать для экспорта и печати следующий размер шрифта';
  { Идентификатор настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }

var
  { Локализуемые строки PrintAndExportName }
 str_PrintAndExport : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport'; rValue : 'Печать и экспорт');
  { Печать и экспорт }

var
  { Локализуемые строки PrintAndExportValues }
 str_PrintAndExport_Default : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Default'; rValue : 'Использовать для экспорта и печати размер шрифта, отображаемого на экране');
  { Использовать для экспорта и печати размер шрифта, отображаемого на экране }
 str_PrintAndExport_Custom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Custom'; rValue : 'Использовать для экспорта и печати следующий размер шрифта');
  { Использовать для экспорта и печати следующий размер шрифта }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_PrintAndExport
 str_PrintAndExport.Init;
// Инициализация str_PrintAndExport_Default
 str_PrintAndExport_Default.Init;
// Инициализация str_PrintAndExport_Custom
 str_PrintAndExport_Custom.Init;

end.