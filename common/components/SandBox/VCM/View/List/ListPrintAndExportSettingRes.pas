unit ListPrintAndExportSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "ListPrintAndExportSettingRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: UtilityPack::Class Shared Delphi Sand Box$UC::List::View::List::ListPrintAndExportSettingRes
//
// Ресурсы для настройки "Печать и экспорт"
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
  l3StringIDEx
  ;

const
  { PrintAndExportKey }
 pi_List_PrintAndExport = 'Список/Печать и экспорт';
  { Идентификатор настройки "Печать и экспорт" }
 pi_List_PrintAndExport_Default = 'Список/Печать и экспорт/Использовать для экспорта и печати размер шрифта, отображаемого на экране';
  { Идентификатор настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
 pi_List_PrintAndExport_Custom = 'Список/Печать и экспорт/Использовать для экспорта и печати следующий размер шрифта';
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