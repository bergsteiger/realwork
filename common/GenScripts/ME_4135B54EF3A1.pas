unit NOT_COMPLETED_MainMenuChangeableMainMenuTypeSettingRes;
 {* Ресурсы для настройки "Тип изменяемой части основного меню" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\NOT_COMPLETED_MainMenuChangeableMainMenuTypeSettingRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "MainMenuChangeableMainMenuTypeSettingRes" MUID: (4135B54EF3A1)

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
 {* Локализуемые строки ChangeableMainMenuTypeName }
 str_ChangeableMainMenuType: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType'; rValue : 'Тип изменяемой части основного меню');
  {* Тип изменяемой части основного меню }
 pi_MainMenu_ChangeableMainMenuType = '/Тип изменяемой части основного меню';
  {* Идентификатор настройки "Тип изменяемой части основного меню" }
 dv_MainMenu_ChangeableMainMenuType = 0;
  {* Значение по-умолчанию настройки "Тип изменяемой части основного меню" }
 {* Локализуемые строки ChangeableMainMenuTypeValues }
 str_ChangeableMainMenuType_ST_FINANCE: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_FINANCE'; rValue : 'Налоги и финансы');
  {* Налоги и финансы }
 str_ChangeableMainMenuType_ST_HR: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_HR'; rValue : 'Раздел для кадровиков');
  {* Раздел для кадровиков }
 str_ChangeableMainMenuType_ST_LEGAL: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_LEGAL'; rValue : 'Раздел для юристов');
  {* Раздел для юристов }
 str_ChangeableMainMenuType_ST_BUDGET_ORGS: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_BUDGET_ORGS'; rValue : 'Бюджетные организаций');
  {* Бюджетные организаций }

type
 ChangeableMainMenuTypeEnum = (
  {* Ключи для настройки "Тип изменяемой части основного меню" }
  KEY_ChangeableMainMenuType_ST_FINANCE
   {* Налоги и финансы }
  , KEY_ChangeableMainMenuType_ST_HR
   {* Раздел для кадровиков }
  , KEY_ChangeableMainMenuType_ST_LEGAL
   {* Раздел для юристов }
  , KEY_ChangeableMainMenuType_ST_BUDGET_ORGS
   {* Бюджетные организаций }
 );//ChangeableMainMenuTypeEnum

 ChangeableMainMenuTypeValuesMapHelper = {final} class
  {* Утилитный класс для преобразования значений ChangeableMainMenuTypeValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
    {* Преобразование строкового значения к порядковому }
 end;//ChangeableMainMenuTypeValuesMapHelper

 TChangeableMainMenuTypeValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для ChangeableMainMenuTypeValuesMap }
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
    {* Фабричный метод для TChangeableMainMenuTypeValuesMapImplPrim }
 end;//TChangeableMainMenuTypeValuesMapImplPrim

 TChangeableMainMenuTypeValuesMapImpl = {final} class(TChangeableMainMenuTypeValuesMapImplPrim)
  {* Класс для реализации мапы для ChangeableMainMenuTypeValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TChangeableMainMenuTypeValuesMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TChangeableMainMenuTypeValuesMapImpl

const
 {* Карта преобразования локализованных строк ChangeableMainMenuTypeValues }
 ChangeableMainMenuTypeValuesMap: array [ChangeableMainMenuTypeEnum] of Pl3StringIDEx = (
 @str_ChangeableMainMenuType_ST_FINANCE
 , @str_ChangeableMainMenuType_ST_HR
 , @str_ChangeableMainMenuType_ST_LEGAL
 , @str_ChangeableMainMenuType_ST_BUDGET_ORGS
 );
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

var g_TChangeableMainMenuTypeValuesMapImpl: Pointer = nil;
 {* Экземпляр синглетона TChangeableMainMenuTypeValuesMapImpl }

procedure TChangeableMainMenuTypeValuesMapImplFree;
 {* Метод освобождения экземпляра синглетона TChangeableMainMenuTypeValuesMapImpl }
begin
 IUnknown(g_TChangeableMainMenuTypeValuesMapImpl) := nil;
end;//TChangeableMainMenuTypeValuesMapImplFree

class procedure ChangeableMainMenuTypeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
//#UC START# *C12B875224F2_B9C724B3AF5F_var*
//#UC END# *C12B875224F2_B9C724B3AF5F_var*
begin
//#UC START# *C12B875224F2_B9C724B3AF5F_impl*
 !!! Needs to be implemented !!!
//#UC END# *C12B875224F2_B9C724B3AF5F_impl*
end;//ChangeableMainMenuTypeValuesMapHelper.FillStrings

class function ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
 {* Преобразование строкового значения к порядковому }
//#UC START# *7A134379805A_B9C724B3AF5F_var*
//#UC END# *7A134379805A_B9C724B3AF5F_var*
begin
//#UC START# *7A134379805A_B9C724B3AF5F_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A134379805A_B9C724B3AF5F_impl*
end;//ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue

class function TChangeableMainMenuTypeValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TChangeableMainMenuTypeValuesMapImplPrim }
var
 l_Inst : TChangeableMainMenuTypeValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TChangeableMainMenuTypeValuesMapImplPrim.Make

function TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_318BDF027E3Aget_var*
//#UC END# *46A5EFE602DE_318BDF027E3Aget_var*
begin
//#UC START# *46A5EFE602DE_318BDF027E3Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_318BDF027E3Aget_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID

procedure TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
//#UC START# *46A5F0130365_318BDF027E3A_var*
//#UC END# *46A5F0130365_318BDF027E3A_var*
begin
//#UC START# *46A5F0130365_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_318BDF027E3A_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames

function TChangeableMainMenuTypeValuesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_318BDF027E3A_var*
//#UC END# *46A5F03800A2_318BDF027E3A_var*
begin
//#UC START# *46A5F03800A2_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_318BDF027E3A_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.MapSize

function TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_318BDF027E3A_var*
//#UC END# *46A5FCF900E0_318BDF027E3A_var*
begin
//#UC START# *46A5FCF900E0_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_318BDF027E3A_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue

function TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_318BDF027E3A_var*
//#UC END# *46A5FD1B000D_318BDF027E3A_var*
begin
//#UC START# *46A5FD1B000D_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_318BDF027E3A_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName

class function TChangeableMainMenuTypeValuesMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TChangeableMainMenuTypeValuesMapImpl }
begin
 if (g_TChangeableMainMenuTypeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TChangeableMainMenuTypeValuesMapImplFree);
  Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl);
end;//TChangeableMainMenuTypeValuesMapImpl.Make

class function TChangeableMainMenuTypeValuesMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TChangeableMainMenuTypeValuesMapImpl <> nil;
end;//TChangeableMainMenuTypeValuesMapImpl.Exists

initialization
 str_ChangeableMainMenuType.Init;
 {* Инициализация str_ChangeableMainMenuType }
 str_ChangeableMainMenuType_ST_FINANCE.Init;
 {* Инициализация str_ChangeableMainMenuType_ST_FINANCE }
 str_ChangeableMainMenuType_ST_HR.Init;
 {* Инициализация str_ChangeableMainMenuType_ST_HR }
 str_ChangeableMainMenuType_ST_LEGAL.Init;
 {* Инициализация str_ChangeableMainMenuType_ST_LEGAL }
 str_ChangeableMainMenuType_ST_BUDGET_ORGS.Init;
 {* Инициализация str_ChangeableMainMenuType_ST_BUDGET_ORGS }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
