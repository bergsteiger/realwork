unit DocumentShowChangesInfoSettingRes;
 {* Ресурсы для настройки "Показывать историю изменений в документе" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\DocumentShowChangesInfoSettingRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DocumentShowChangesInfoSettingRes" MUID: (9847AD90023A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

const
 {* Локализуемые строки ShowChangesInfoName }
 str_ShowChangesInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo'; rValue : 'Показывать историю изменений в документе');
  {* Показывать историю изменений в документе }
 pi_Document_ShowChangesInfo = 'Работа с документом/Показывать историю изменений в документе';
  {* Идентификатор настройки "Показывать историю изменений в документе" }
 dv_Document_ShowChangesInfo = False;
  {* Значение по-умолчанию настройки "Показывать историю изменений в документе" }
 {* Локализуемые строки ShowChangesInfoValues }
 str_ShowChangesInfo_Collapsed: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Collapsed'; rValue : 'В свернутом виде');
  {* В свернутом виде }
 str_ShowChangesInfo_Expanded: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Expanded'; rValue : 'В развернутом виде');
  {* В развернутом виде }
 {* Карта преобразования локализованных строк ShowChangesInfoValues }
 ShowChangesInfoValuesMap: array [Boolean] of Pl3StringIDEx = (
 @str_ShowChangesInfo_Collapsed
 , @str_ShowChangesInfo_Expanded
 );

type
 ShowChangesInfoValuesMapHelper = {final} class
  {* Утилитный класс для преобразования значений ShowChangesInfoValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
    {* Преобразование строкового значения к порядковому }
 end;//ShowChangesInfoValuesMapHelper

 TShowChangesInfoValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для ShowChangesInfoValuesMap }
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
    {* Фабричный метод для TShowChangesInfoValuesMapImplPrim }
 end;//TShowChangesInfoValuesMapImplPrim

 TShowChangesInfoValuesMapImpl = {final} class(TShowChangesInfoValuesMapImplPrim)
  {* Класс для реализации мапы для ShowChangesInfoValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TShowChangesInfoValuesMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TShowChangesInfoValuesMapImpl
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
 , l3Base
;

var g_TShowChangesInfoValuesMapImpl: Pointer = nil;
 {* Экземпляр синглетона TShowChangesInfoValuesMapImpl }

procedure TShowChangesInfoValuesMapImplFree;
 {* Метод освобождения экземпляра синглетона TShowChangesInfoValuesMapImpl }
begin
 IUnknown(g_TShowChangesInfoValuesMapImpl) := nil;
end;//TShowChangesInfoValuesMapImplFree

class procedure ShowChangesInfoValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
var
 l_Index: Boolean;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ShowChangesInfoValuesMap[l_Index].AsCStr);
end;//ShowChangesInfoValuesMapHelper.FillStrings

class function ShowChangesInfoValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* Преобразование строкового значения к порядковому }
var
 l_Index: Boolean;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ShowChangesInfoValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ShowChangesInfoValuesMap"', [l3Str(aDisplayName)]);
end;//ShowChangesInfoValuesMapHelper.DisplayNameToValue

class function TShowChangesInfoValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TShowChangesInfoValuesMapImplPrim }
var
 l_Inst : TShowChangesInfoValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TShowChangesInfoValuesMapImplPrim.Make

function TShowChangesInfoValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TShowChangesInfoValuesMapImplPrim.pm_GetMapID

procedure TShowChangesInfoValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
begin
 ShowChangesInfoValuesMapHelper.FillStrings(aList);
end;//TShowChangesInfoValuesMapImplPrim.GetDisplayNames

function TShowChangesInfoValuesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
begin
 Result := Ord(High(Boolean)) - Ord(Low(Boolean));
end;//TShowChangesInfoValuesMapImplPrim.MapSize

function TShowChangesInfoValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(ShowChangesInfoValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TShowChangesInfoValuesMapImplPrim.DisplayNameToValue

function TShowChangesInfoValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(Boolean)));
 Assert(aValue <= Ord(High(Boolean)));
 Result := ShowChangesInfoValuesMap[Boolean(aValue)].AsCStr;
end;//TShowChangesInfoValuesMapImplPrim.ValueToDisplayName

class function TShowChangesInfoValuesMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TShowChangesInfoValuesMapImpl }
begin
 if (g_TShowChangesInfoValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TShowChangesInfoValuesMapImplFree);
  Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl);
end;//TShowChangesInfoValuesMapImpl.Make

class function TShowChangesInfoValuesMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TShowChangesInfoValuesMapImpl <> nil;
end;//TShowChangesInfoValuesMapImpl.Exists

initialization
 str_ShowChangesInfo.Init;
 {* Инициализация str_ShowChangesInfo }
 str_ShowChangesInfo_Collapsed.Init;
 {* Инициализация str_ShowChangesInfo_Collapsed }
 str_ShowChangesInfo_Expanded.Init;
 {* Инициализация str_ShowChangesInfo_Expanded }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
