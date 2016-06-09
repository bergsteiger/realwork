unit evStylesPrintAndExportFontSizeSettingRes;
 {* Ресурсы для настройки "Использовать для экспорта и печати следующий размер шрифта" }

// Модуль: "w:\common\components\gui\Garant\Everest\evStylesPrintAndExportFontSizeSettingRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evStylesPrintAndExportFontSizeSettingRes" MUID: (C9ADD4944F97)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

const
 {* Локализуемые строки PrintAndExportFontSizeName }
 str_PrintAndExportFontSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize'; rValue : 'Использовать для экспорта и печати следующий размер шрифта');
  {* Использовать для экспорта и печати следующий размер шрифта }
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
var
 l_Index: PrintAndExportFontSizeEnum;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(PrintAndExportFontSizeValuesMap[l_Index].AsCStr);
end;//PrintAndExportFontSizeValuesMapHelper.FillStrings

class function PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
 {* Преобразование строкового значения к порядковому }
var
 l_Index: PrintAndExportFontSizeEnum;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, PrintAndExportFontSizeValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "PrintAndExportFontSizeValuesMap"', [l3Str(aDisplayName)]);
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
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID

procedure TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
begin
 PrintAndExportFontSizeValuesMapHelper.FillStrings(aList);
end;//TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames

function TPrintAndExportFontSizeValuesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
begin
 Result := Ord(High(PrintAndExportFontSizeEnum)) - Ord(Low(PrintAndExportFontSizeEnum));
end;//TPrintAndExportFontSizeValuesMapImplPrim.MapSize

function TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue

function TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(PrintAndExportFontSizeEnum)));
 Assert(aValue <= Ord(High(PrintAndExportFontSizeEnum)));
 Result := PrintAndExportFontSizeValuesMap[PrintAndExportFontSizeEnum(aValue)].AsCStr;
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
 str_PrintAndExportFontSize.Init;
 {* Инициализация str_PrintAndExportFontSize }
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

end.
