unit DocumentPrintAndExportFontSizeSettingRes;
 {* Ресурсы для настройки "Использовать для экспорта и печати следующий размер шрифта" }

// Модуль: "w:\common\components\SandBox\VCM\View\Document\DocumentPrintAndExportFontSizeSettingRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DocumentPrintAndExportFontSizeSettingRes" MUID: (F2DB96F6C0D4)

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

const
 pi_Document_PrintAndExportFontSize = 'Документ/Использовать для экспорта и печати следующий размер шрифта';
  {* Идентификатор настройки "Использовать для экспорта и печати следующий размер шрифта" }
 dv_Document_PrintAndExportFontSize = 0;
  {* Значение по-умолчанию настройки "Использовать для экспорта и печати следующий размер шрифта" }
 {* Локализуемые строки PrintAndExportFontSizeValues }
 str_PrintAndExportFontSize_pef8: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef8'; rValue : '8');
  {* 8 }
 str_PrintAndExportFontSize_pef9: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef9'; rValue : '9');
  {* 9 }
 str_PrintAndExportFontSize_pef10: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef10'; rValue : '10');
  {* 10 }
 str_PrintAndExportFontSize_pef11: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef11'; rValue : '11');
  {* 11 }
 str_PrintAndExportFontSize_pef12: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef12'; rValue : '12');
  {* 12 }
 str_PrintAndExportFontSize_pef14: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef14'; rValue : '14');
  {* 14 }
 str_PrintAndExportFontSize_pef16: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef16'; rValue : '16');
  {* 16 }
 {* Локализуемые строки PrintAndExportFontSizeName }
 str_PrintAndExportFontSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize'; rValue : 'Использовать для экспорта и печати следующий размер шрифта');
  {* Использовать для экспорта и печати следующий размер шрифта }

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

 PrintAndExportFontSizeValuesMapHelper = {final} class
  {* Утилитный класс для преобразования значений PrintAndExportFontSizeValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
    {* Преобразование строкового значения к порядковому }
 end;//PrintAndExportFontSizeValuesMapHelper

 TPrintAndExportFontSizeValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для PrintAndExportFontSizeValuesMap }
  protected
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
    {* заполняет список значениями "UI-строка" }
   function MapSize: Integer;
    {* количество элементов в мапе. }
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TPrintAndExportFontSizeValuesMapImplPrim }
 end;//TPrintAndExportFontSizeValuesMapImplPrim

 TPrintAndExportFontSizeValuesMapImpl = {final} class(TPrintAndExportFontSizeValuesMapImplPrim)
  {* Класс для реализации мапы для PrintAndExportFontSizeValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TPrintAndExportFontSizeValuesMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TPrintAndExportFontSizeValuesMapImpl

const
 {* Карта преобразования локализованных строк PrintAndExportFontSizeValues }
 PrintAndExportFontSizeValuesMap: array [PrintAndExportFontSizeEnum] of Pl3StringIDEx = (
 @str_PrintAndExportFontSize_pef8
 , @str_PrintAndExportFontSize_pef9
 , @str_PrintAndExportFontSize_pef10
 , @str_PrintAndExportFontSize_pef11
 , @str_PrintAndExportFontSize_pef12
 , @str_PrintAndExportFontSize_pef14
 , @str_PrintAndExportFontSize_pef16
 );

implementation

uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
 , l3Base
;

var g_TPrintAndExportFontSizeValuesMapImpl: Pointer = nil;
 {* Экземпляр синглетона TPrintAndExportFontSizeValuesMapImpl }

procedure TPrintAndExportFontSizeValuesMapImplFree;
 {* Метод освобождения экземпляра синглетона TPrintAndExportFontSizeValuesMapImpl }
begin
 IUnknown(g_TPrintAndExportFontSizeValuesMapImpl) := nil;
end;//TPrintAndExportFontSizeValuesMapImplFree

class procedure PrintAndExportFontSizeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
//#UC START# *4C25465FA194_7EA9EF3DF3F2_var*
//#UC END# *4C25465FA194_7EA9EF3DF3F2_var*
begin
//#UC START# *4C25465FA194_7EA9EF3DF3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C25465FA194_7EA9EF3DF3F2_impl*
end;//PrintAndExportFontSizeValuesMapHelper.FillStrings

class function PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
 {* Преобразование строкового значения к порядковому }
//#UC START# *495A60C6598A_7EA9EF3DF3F2_var*
//#UC END# *495A60C6598A_7EA9EF3DF3F2_var*
begin
//#UC START# *495A60C6598A_7EA9EF3DF3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *495A60C6598A_7EA9EF3DF3F2_impl*
end;//PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue

class function TPrintAndExportFontSizeValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TPrintAndExportFontSizeValuesMapImplPrim }
var
 l_Inst : TPrintAndExportFontSizeValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrintAndExportFontSizeValuesMapImplPrim.Make

function TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_2F2F16F4BFC4get_var*
//#UC END# *46A5EFE602DE_2F2F16F4BFC4get_var*
begin
//#UC START# *46A5EFE602DE_2F2F16F4BFC4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_2F2F16F4BFC4get_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID

procedure TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
//#UC START# *46A5F0130365_2F2F16F4BFC4_var*
//#UC END# *46A5F0130365_2F2F16F4BFC4_var*
begin
//#UC START# *46A5F0130365_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames

function TPrintAndExportFontSizeValuesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_2F2F16F4BFC4_var*
//#UC END# *46A5F03800A2_2F2F16F4BFC4_var*
begin
//#UC START# *46A5F03800A2_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.MapSize

function TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_2F2F16F4BFC4_var*
//#UC END# *46A5FCF900E0_2F2F16F4BFC4_var*
begin
//#UC START# *46A5FCF900E0_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue

function TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_2F2F16F4BFC4_var*
//#UC END# *46A5FD1B000D_2F2F16F4BFC4_var*
begin
//#UC START# *46A5FD1B000D_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName

class function TPrintAndExportFontSizeValuesMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TPrintAndExportFontSizeValuesMapImpl }
begin
 if (g_TPrintAndExportFontSizeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TPrintAndExportFontSizeValuesMapImplFree);
  Il3IntegerValueMap(g_TPrintAndExportFontSizeValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TPrintAndExportFontSizeValuesMapImpl);
end;//TPrintAndExportFontSizeValuesMapImpl.Make

class function TPrintAndExportFontSizeValuesMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TPrintAndExportFontSizeValuesMapImpl <> nil;
end;//TPrintAndExportFontSizeValuesMapImpl.Exists

initialization
 str_PrintAndExportFontSize_pef8.Init;
 {* Инициализация str_PrintAndExportFontSize_pef8 }
 str_PrintAndExportFontSize_pef9.Init;
 {* Инициализация str_PrintAndExportFontSize_pef9 }
 str_PrintAndExportFontSize_pef10.Init;
 {* Инициализация str_PrintAndExportFontSize_pef10 }
 str_PrintAndExportFontSize_pef11.Init;
 {* Инициализация str_PrintAndExportFontSize_pef11 }
 str_PrintAndExportFontSize_pef12.Init;
 {* Инициализация str_PrintAndExportFontSize_pef12 }
 str_PrintAndExportFontSize_pef14.Init;
 {* Инициализация str_PrintAndExportFontSize_pef14 }
 str_PrintAndExportFontSize_pef16.Init;
 {* Инициализация str_PrintAndExportFontSize_pef16 }
 str_PrintAndExportFontSize.Init;
 {* Инициализация str_PrintAndExportFontSize }

end.
