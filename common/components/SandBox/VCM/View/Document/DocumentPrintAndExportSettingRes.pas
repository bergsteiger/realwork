unit DocumentPrintAndExportSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "DocumentPrintAndExportSettingRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: UtilityPack::Class Shared Delphi Sand Box$UC::Document::View::Document::DocumentPrintAndExportSettingRes
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
 pi_Document_PrintAndExport = 'Документ/Печать и экспорт';
  { Идентификатор настройки "Печать и экспорт" }
 pi_Document_PrintAndExport_Default = 'Документ/Печать и экспорт/Использовать для экспорта и печати размер шрифта, отображаемого на экране';
  { Идентификатор настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
 pi_Document_PrintAndExport_Custom = 'Документ/Печать и экспорт/Использовать для экспорта и печати следующий размер шрифта';
  { Идентификатор настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }

var
  { Локализуемые строки PrintAndExportValues }
 str_PrintAndExport_Default : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Default'; rValue : 'Использовать для экспорта и печати размер шрифта, отображаемого на экране');
  { Использовать для экспорта и печати размер шрифта, отображаемого на экране }
 str_PrintAndExport_Custom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Custom'; rValue : 'Использовать для экспорта и печати следующий размер шрифта');
  { Использовать для экспорта и печати следующий размер шрифта }

var
  { Локализуемые строки PrintAndExportName }
 str_PrintAndExport : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport'; rValue : 'Печать и экспорт');
  { Печать и экспорт }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_PrintAndExport_Default
 str_PrintAndExport_Default.Init;
// Инициализация str_PrintAndExport_Custom
 str_PrintAndExport_Custom.Init;
// Инициализация str_PrintAndExport
 str_PrintAndExport.Init;

end.