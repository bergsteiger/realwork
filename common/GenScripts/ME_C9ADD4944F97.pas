unit evStylesPrintAndExportFontSizeSettingRes;
 {* Ресурсы для настройки "Использовать для экспорта и печати следующий размер шрифта" }

// Модуль: "w:\common\components\gui\Garant\Everest\evStylesPrintAndExportFontSizeSettingRes.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

const
 pi_evStyles_PrintAndExportFontSize = 'Стили/Использовать для экспорта и печати следующий размер шрифта';
  {* Идентификатор настройки "Использовать для экспорта и печати следующий размер шрифта" }
 dv_evStyles_PrintAndExportFontSize = 0;
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
 {* Карта преобразования локализованных строк PrintAndExportFontSizeValues }
 PrintAndExportFontSizeValuesMap: array [0 .. 7] of Pl3StringIDEx = ( );
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
   class function Instance: TPrintAndExportFontSizeValuesMapImpl;
    {* Метод получения экземпляра синглетона TPrintAndExportFontSizeValuesMapImpl }
 end;//TPrintAndExportFontSizeValuesMapImpl

implementation

uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
 , l3Base
;

var g_TPrintAndExportFontSizeValuesMapImpl: TPrintAndExportFontSizeValuesMapImpl = nil;
 {* Экземпляр синглетона TPrintAndExportFontSizeValuesMapImpl }

procedure TPrintAndExportFontSizeValuesMapImplFree;
 {* Метод освобождения экземпляра синглетона TPrintAndExportFontSizeValuesMapImpl }
begin
 l3Free(g_TPrintAndExportFontSizeValuesMapImpl);
end;//TPrintAndExportFontSizeValuesMapImplFree

class procedure PrintAndExportFontSizeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
//#UC START# *1884DBA9EBBD_2F2551498AA7_var*
//#UC END# *1884DBA9EBBD_2F2551498AA7_var*
begin
//#UC START# *1884DBA9EBBD_2F2551498AA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *1884DBA9EBBD_2F2551498AA7_impl*
end;//PrintAndExportFontSizeValuesMapHelper.FillStrings

class function PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
 {* Преобразование строкового значения к порядковому }
//#UC START# *401032D7711F_2F2551498AA7_var*
//#UC END# *401032D7711F_2F2551498AA7_var*
begin
//#UC START# *401032D7711F_2F2551498AA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *401032D7711F_2F2551498AA7_impl*
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
//#UC START# *46A5EFE602DE_E7E820B69587get_var*
//#UC END# *46A5EFE602DE_E7E820B69587get_var*
begin
//#UC START# *46A5EFE602DE_E7E820B69587get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_E7E820B69587get_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID

procedure TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
//#UC START# *46A5F0130365_E7E820B69587_var*
//#UC END# *46A5F0130365_E7E820B69587_var*
begin
//#UC START# *46A5F0130365_E7E820B69587_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_E7E820B69587_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames

function TPrintAndExportFontSizeValuesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_E7E820B69587_var*
//#UC END# *46A5F03800A2_E7E820B69587_var*
begin
//#UC START# *46A5F03800A2_E7E820B69587_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_E7E820B69587_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.MapSize

function TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_E7E820B69587_var*
//#UC END# *46A5FCF900E0_E7E820B69587_var*
begin
//#UC START# *46A5FCF900E0_E7E820B69587_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_E7E820B69587_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue

function TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_E7E820B69587_var*
//#UC END# *46A5FD1B000D_E7E820B69587_var*
begin
//#UC START# *46A5FD1B000D_E7E820B69587_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_E7E820B69587_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName

class function TPrintAndExportFontSizeValuesMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TPrintAndExportFontSizeValuesMapImpl }
var
 l_Inst : TPrintAndExportFontSizeValuesMapImpl;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrintAndExportFontSizeValuesMapImpl.Make

class function TPrintAndExportFontSizeValuesMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TPrintAndExportFontSizeValuesMapImpl <> nil;
end;//TPrintAndExportFontSizeValuesMapImpl.Exists

class function TPrintAndExportFontSizeValuesMapImpl.Instance: TPrintAndExportFontSizeValuesMapImpl;
 {* Метод получения экземпляра синглетона TPrintAndExportFontSizeValuesMapImpl }
begin
 if (g_TPrintAndExportFontSizeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TPrintAndExportFontSizeValuesMapImplFree);
  g_TPrintAndExportFontSizeValuesMapImpl := Create;
 end;
 Result := g_TPrintAndExportFontSizeValuesMapImpl;
end;//TPrintAndExportFontSizeValuesMapImpl.Instance

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
