unit evStylesPrintAndExportFontSizeSettingRes;

interface

uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

type
 PrintAndExportFontSizeEnum = (
  {* Ключи для настройки "Использовать для экспорта и печати следующий размер шрифта" }
  KEY_PrintAndExportFontSize_pef8
   {* 8 }
  , KEY_PrintAndExportFontSize_pef9
   {* 9 }
  , KEY_PrintAndExportFontSize_pef10
   {* 10 }
  , KEY_PrintAndExportFontSize_pef11
   {* 11 }
  , KEY_PrintAndExportFontSize_pef12
   {* 12 }
  , KEY_PrintAndExportFontSize_pef14
   {* 14 }
  , KEY_PrintAndExportFontSize_pef16
   {* 16 }
 );//PrintAndExportFontSizeEnum
 
 PrintAndExportFontSizeValuesMapHelper = class
  {* Утилитный класс для преобразования значений PrintAndExportFontSizeValuesMap }
  procedure FillStrings(const aStrings: IafwStrings);
   {* Заполнение списка строк значениями }
  function DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
   {* Преобразование строкового значения к порядковому }
 end;//PrintAndExportFontSizeValuesMapHelper
 
 TPrintAndExportFontSizeValuesMapImplPrim = class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для PrintAndExportFontSizeValuesMap }
  function Make: Il3IntegerValueMap;
   {* Фабричный метод для TPrintAndExportFontSizeValuesMapImplPrim }
  function MapID: Tl3ValueMapID;
   {* Идентификатор мапы. }
  procedure GetDisplayNames(const aList: Il3StringsEx);
   {* заполняет список значениями "UI-строка" }
  function MapSize: Integer;
   {* количество элементов в мапе. }
  function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function ValueToDisplayName(aValue: Integer): Il3CString;
 end;//TPrintAndExportFontSizeValuesMapImplPrim
 
 TPrintAndExportFontSizeValuesMapImpl = class(TPrintAndExportFontSizeValuesMapImplPrim)
  {* Класс для реализации мапы для PrintAndExportFontSizeValuesMap }
  function Make: Il3IntegerValueMap;
   {* Фабричный метод для TPrintAndExportFontSizeValuesMapImpl }
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TPrintAndExportFontSizeValuesMapImpl
 
implementation

uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
 , l3Base
;

end.
