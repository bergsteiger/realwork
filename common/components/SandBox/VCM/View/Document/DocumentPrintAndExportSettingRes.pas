unit DocumentPrintAndExportSettingRes;
 {* Ресурсы для настройки "Печать и экспорт" }

// Модуль: "w:\common\components\SandBox\VCM\View\Document\DocumentPrintAndExportSettingRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DocumentPrintAndExportSettingRes" MUID: (BF4B3EC98238)

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки PrintAndExportName }
 str_PrintAndExport: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport'; rValue : 'Печать и экспорт');
  {* Печать и экспорт }
 {* Локализуемые строки PrintAndExportValues }
 str_PrintAndExport_Default: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Default'; rValue : 'Использовать для экспорта и печати размер шрифта, отображаемого на экране');
  {* Использовать для экспорта и печати размер шрифта, отображаемого на экране }
 str_PrintAndExport_Custom: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Custom'; rValue : 'Использовать для экспорта и печати следующий размер шрифта');
  {* Использовать для экспорта и печати следующий размер шрифта }
 pi_Document_PrintAndExport = 'Документ/Печать и экспорт';
  {* Идентификатор настройки "Печать и экспорт" }
 pi_Document_PrintAndExport_Default = 'Документ/Печать и экспорт/Использовать для экспорта и печати размер шрифта, отображаемого на экране';
  {* Идентификатор настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
 pi_Document_PrintAndExport_Custom = 'Документ/Печать и экспорт/Использовать для экспорта и печати следующий размер шрифта';
  {* Идентификатор настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }

implementation

uses
 l3ImplUses
;

initialization
 str_PrintAndExport.Init;
 {* Инициализация str_PrintAndExport }
 str_PrintAndExport_Default.Init;
 {* Инициализация str_PrintAndExport_Default }
 str_PrintAndExport_Custom.Init;
 {* Инициализация str_PrintAndExport_Custom }

end.
