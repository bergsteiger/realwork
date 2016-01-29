unit MainMenuChangeableMainMenuTypeSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/MainMenuChangeableMainMenuTypeSettingRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::MainMenuChangeableMainMenuTypeSettingRes
//
// Ресурсы для настройки "Тип изменяемой части основного меню"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  afwInterfaces,
  l3CProtoObject,
  l3StringIDEx
  ;

type
 ChangeableMainMenuTypeEnum = (
  {* Ключи для настройки "Тип изменяемой части основного меню" }
   KEY_ChangeableMainMenuType_ST_FINANCE // Налоги и финансы
 , KEY_ChangeableMainMenuType_ST_HR // Раздел для кадровиков
 , KEY_ChangeableMainMenuType_ST_LEGAL // Раздел для юристов
 , KEY_ChangeableMainMenuType_ST_BUDGET_ORGS // Бюджетные организаций
 );//ChangeableMainMenuTypeEnum

const
  { ChangeableMainMenuTypeKey }
 pi_MainMenu_ChangeableMainMenuType = '/Тип изменяемой части основного меню';
  { Идентификатор настройки "Тип изменяемой части основного меню" }
 dv_MainMenu_ChangeableMainMenuType = 0;
  { Значение по-умолчанию настройки "Тип изменяемой части основного меню" }

var
  { Локализуемые строки ChangeableMainMenuTypeName }
 str_ChangeableMainMenuType : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType'; rValue : 'Тип изменяемой части основного меню');
  { Тип изменяемой части основного меню }

var
  { Локализуемые строки ChangeableMainMenuTypeValues }
 str_ChangeableMainMenuType_ST_FINANCE : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_FINANCE'; rValue : 'Налоги и финансы');
  { Налоги и финансы }
 str_ChangeableMainMenuType_ST_HR : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_HR'; rValue : 'Раздел для кадровиков');
  { Раздел для кадровиков }
 str_ChangeableMainMenuType_ST_LEGAL : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_LEGAL'; rValue : 'Раздел для юристов');
  { Раздел для юристов }
 str_ChangeableMainMenuType_ST_BUDGET_ORGS : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_BUDGET_ORGS'; rValue : 'Бюджетные организаций');
  { Бюджетные организаций }

const
  { Карта преобразования локализованных строк ChangeableMainMenuTypeValues }
 ChangeableMainMenuTypeValuesMap : array [ChangeableMainMenuTypeEnum] of Pl3StringIDEx = (
  @str_ChangeableMainMenuType_ST_FINANCE
  , @str_ChangeableMainMenuType_ST_HR
  , @str_ChangeableMainMenuType_ST_LEGAL
  , @str_ChangeableMainMenuType_ST_BUDGET_ORGS
 );//ChangeableMainMenuTypeValuesMap

type
 ChangeableMainMenuTypeValuesMapHelper = {final} class
  {* Утилитный класс для преобразования значений ChangeableMainMenuTypeValuesMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
     {* Преобразование строкового значения к порядковому }
 end;//ChangeableMainMenuTypeValuesMapHelper

 TChangeableMainMenuTypeValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для ChangeableMainMenuTypeValuesMap }
 protected
 // realized methods
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
     {* заполняет список значениями "UI-строка" }
   function MapSize: Integer;
     {* количество элементов в мапе. }
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* Фабричный метод для TChangeableMainMenuTypeValuesMapImplPrim }
 end;//TChangeableMainMenuTypeValuesMapImplPrim

 TChangeableMainMenuTypeValuesMapImpl = {final} class(TChangeableMainMenuTypeValuesMapImplPrim)
  {* Класс для реализации мапы для ChangeableMainMenuTypeValuesMap }
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* Фабричный метод для TChangeableMainMenuTypeValuesMapImpl }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 end;//TChangeableMainMenuTypeValuesMapImpl
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID,
  l3String,
  SysUtils,
  l3Base
  ;

// start class ChangeableMainMenuTypeValuesMapHelper

class procedure ChangeableMainMenuTypeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: ChangeableMainMenuTypeEnum;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ChangeableMainMenuTypeValuesMap[l_Index].AsCStr);
end;//ChangeableMainMenuTypeValuesMapHelper.FillStrings

class function ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
var
 l_Index: ChangeableMainMenuTypeEnum;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ChangeableMainMenuTypeValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ChangeableMainMenuTypeValuesMap"', [l3Str(aDisplayName)]);
end;//ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue
// start class TChangeableMainMenuTypeValuesMapImplPrim

class function TChangeableMainMenuTypeValuesMapImplPrim.Make: Il3IntegerValueMap;
var
 l_Inst : TChangeableMainMenuTypeValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID

procedure TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {-}
begin
 ChangeableMainMenuTypeValuesMapHelper.FillStrings(aList);
end;//TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames

function TChangeableMainMenuTypeValuesMapImplPrim.MapSize: Integer;
 {-}
begin
 Result := Ord(High(ChangeableMainMenuTypeEnum)) - Ord(Low(ChangeableMainMenuTypeEnum));
end;//TChangeableMainMenuTypeValuesMapImplPrim.MapSize

function TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
 {-}
begin
 Result := Ord(ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue

function TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
 {-}
begin
 Assert(aValue >= Ord(Low(ChangeableMainMenuTypeEnum)));
 Assert(aValue <= Ord(High(ChangeableMainMenuTypeEnum)));
 Result := ChangeableMainMenuTypeValuesMap[ChangeableMainMenuTypeEnum(aValue)].AsCStr;
end;//TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName
// start class TChangeableMainMenuTypeValuesMapImpl

var g_TChangeableMainMenuTypeValuesMapImpl : Pointer = nil;

procedure TChangeableMainMenuTypeValuesMapImplFree;
begin
 IUnknown(g_TChangeableMainMenuTypeValuesMapImpl) := nil;
end;


class function TChangeableMainMenuTypeValuesMapImpl.Make: Il3IntegerValueMap;
begin
 if (g_TChangeableMainMenuTypeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TChangeableMainMenuTypeValuesMapImplFree);
  Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl);
end;

class function TChangeableMainMenuTypeValuesMapImpl.Exists: Boolean;
 {-}
begin
 Result := g_TChangeableMainMenuTypeValuesMapImpl <> nil;
end;//TChangeableMainMenuTypeValuesMapImpl.Exists
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ChangeableMainMenuType
 str_ChangeableMainMenuType.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ChangeableMainMenuType_ST_FINANCE
 str_ChangeableMainMenuType_ST_FINANCE.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ChangeableMainMenuType_ST_HR
 str_ChangeableMainMenuType_ST_HR.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ChangeableMainMenuType_ST_LEGAL
 str_ChangeableMainMenuType_ST_LEGAL.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ChangeableMainMenuType_ST_BUDGET_ORGS
 str_ChangeableMainMenuType_ST_BUDGET_ORGS.Init;
{$IfEnd} //not Admin AND not Monitorings

end.