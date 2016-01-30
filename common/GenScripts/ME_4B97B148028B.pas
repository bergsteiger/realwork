unit nsAppConfigRes;
 {* Ресурсы для nsAppConfig }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Config\nsAppConfigRes.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 , l3StringIDEx
 , afwInterfaces
 , l3CProtoObject
;

const
 {* Локализуемые строки WordPositionNames }
 str_nsc_wpAnyPathWord: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAnyPathWord'; rValue : 'В любой части слова');
  {* 'В любой части слова' }
 str_nsc_wpAtBeginWord: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAtBeginWord'; rValue : 'С начала слова');
  {* 'С начала слова' }
 str_nsc_wpAtBeginString: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAtBeginString'; rValue : 'С начала строки');
  {* 'С начала строки' }
 {* Карта преобразования локализованных строк WordPositionNames }
 AnyPathWord: Pl3StringIDEx = str_nsc_wpAnyPathWord;
 AtBeginWord: Pl3StringIDEx = str_nsc_wpAtBeginWord;
 AtBeginString: Pl3StringIDEx = str_nsc_wpAtBeginString;
 {* Локализуемые строки TreeLevelDistNames }
 str_nsc_tldAllLevels: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_tldAllLevels'; rValue : 'Во всех уровнях');
  {* 'Во всех уровнях' }
 str_nsc_tldOneLevel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_tldOneLevel'; rValue : 'В пределах одного уровня');
  {* 'В пределах одного уровня' }
 {* Карта преобразования локализованных строк TreeLevelDistNames }
 AllLevels: Pl3StringIDEx = str_nsc_tldAllLevels;
 OneLevel: Pl3StringIDEx = str_nsc_tldOneLevel;
 {* Локализуемые строки WordOrderNames }
 str_nsc_woAnyOrder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_woAnyOrder'; rValue : 'В любом порядке');
  {* 'В любом порядке' }
 str_nsc_woAsWrote: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_woAsWrote'; rValue : 'С учетом порядка');
  {* 'С учетом порядка' }
 {* Карта преобразования локализованных строк WordOrderNames }
 AnyOrder: Pl3StringIDEx = str_nsc_woAnyOrder;
 AsWrote: Pl3StringIDEx = str_nsc_woAsWrote;
 {* Локализуемые строки ContextParamsMessages }
 str_nsc_cpmTreeLevelDistHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmTreeLevelDistHint'; rValue : 'Находятся ли искомые слова на разных уровнях иерархического дерева или в пределах одного уровня');
  {* 'Находятся ли искомые слова на разных уровнях иерархического дерева или в пределах одного уровня' }
 str_nsc_cpmWordOrderHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmWordOrderHint'; rValue : 'Должны ли слова строго следовать друг за другом или нет');
  {* 'Должны ли слова строго следовать друг за другом или нет' }
 str_nsc_cpmWordPositionHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmWordPositionHint'; rValue : 'Положение контекста в слове, строке');
  {* 'Положение контекста в слове, строке' }

type
 WordPositionNamesMapHelper = {final} class
  {* Утилитный класс для преобразования значений WordPositionNamesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordPosition;
    {* Преобразование строкового значения к порядковому }
 end;//WordPositionNamesMapHelper

 TWordPositionNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для WordPositionNamesMap }
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
    {* Фабричный метод для TWordPositionNamesMapImplPrim }
 end;//TWordPositionNamesMapImplPrim

 TWordPositionNamesMapImpl = {final} class(TWordPositionNamesMapImplPrim)
  {* Класс для реализации мапы для WordPositionNamesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TWordPositionNamesMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TWordPositionNamesMapImpl;
    {* Метод получения экземпляра синглетона TWordPositionNamesMapImpl }
 end;//TWordPositionNamesMapImpl

 TreeLevelDistNamesMapHelper = {final} class
  {* Утилитный класс для преобразования значений TreeLevelDistNamesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3TreeLevelDist;
    {* Преобразование строкового значения к порядковому }
 end;//TreeLevelDistNamesMapHelper

 TTreeLevelDistNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для TreeLevelDistNamesMap }
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
    {* Фабричный метод для TTreeLevelDistNamesMapImplPrim }
 end;//TTreeLevelDistNamesMapImplPrim

 TTreeLevelDistNamesMapImpl = {final} class(TTreeLevelDistNamesMapImplPrim)
  {* Класс для реализации мапы для TreeLevelDistNamesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TTreeLevelDistNamesMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TTreeLevelDistNamesMapImpl;
    {* Метод получения экземпляра синглетона TTreeLevelDistNamesMapImpl }
 end;//TTreeLevelDistNamesMapImpl

 WordOrderNamesMapHelper = {final} class
  {* Утилитный класс для преобразования значений WordOrderNamesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordOrder;
    {* Преобразование строкового значения к порядковому }
 end;//WordOrderNamesMapHelper

 TWordOrderNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для WordOrderNamesMap }
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
    {* Фабричный метод для TWordOrderNamesMapImplPrim }
 end;//TWordOrderNamesMapImplPrim

 TWordOrderNamesMapImpl = {final} class(TWordOrderNamesMapImplPrim)
  {* Класс для реализации мапы для WordOrderNamesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TWordOrderNamesMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TWordOrderNamesMapImpl;
    {* Метод получения экземпляра синглетона TWordOrderNamesMapImpl }
 end;//TWordOrderNamesMapImpl
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

var g_TWordPositionNamesMapImpl: TWordPositionNamesMapImpl = nil;
 {* Экземпляр синглетона TWordPositionNamesMapImpl }
var g_TTreeLevelDistNamesMapImpl: TTreeLevelDistNamesMapImpl = nil;
 {* Экземпляр синглетона TTreeLevelDistNamesMapImpl }
var g_TWordOrderNamesMapImpl: TWordOrderNamesMapImpl = nil;
 {* Экземпляр синглетона TWordOrderNamesMapImpl }

procedure TWordPositionNamesMapImplFree;
 {* Метод освобождения экземпляра синглетона TWordPositionNamesMapImpl }
begin
 l3Free(g_TWordPositionNamesMapImpl);
end;//TWordPositionNamesMapImplFree

procedure TTreeLevelDistNamesMapImplFree;
 {* Метод освобождения экземпляра синглетона TTreeLevelDistNamesMapImpl }
begin
 l3Free(g_TTreeLevelDistNamesMapImpl);
end;//TTreeLevelDistNamesMapImplFree

procedure TWordOrderNamesMapImplFree;
 {* Метод освобождения экземпляра синглетона TWordOrderNamesMapImpl }
begin
 l3Free(g_TWordOrderNamesMapImpl);
end;//TWordOrderNamesMapImplFree

class procedure WordPositionNamesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
//#UC START# *C2DB53EB6783_54A4B8A0B9D2_var*
//#UC END# *C2DB53EB6783_54A4B8A0B9D2_var*
begin
//#UC START# *C2DB53EB6783_54A4B8A0B9D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *C2DB53EB6783_54A4B8A0B9D2_impl*
end;//WordPositionNamesMapHelper.FillStrings

class function WordPositionNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordPosition;
 {* Преобразование строкового значения к порядковому }
//#UC START# *AF278AD4DE32_54A4B8A0B9D2_var*
//#UC END# *AF278AD4DE32_54A4B8A0B9D2_var*
begin
//#UC START# *AF278AD4DE32_54A4B8A0B9D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *AF278AD4DE32_54A4B8A0B9D2_impl*
end;//WordPositionNamesMapHelper.DisplayNameToValue

class function TWordPositionNamesMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TWordPositionNamesMapImplPrim }
var
 l_Inst : TWordPositionNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWordPositionNamesMapImplPrim.Make

function TWordPositionNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_0D20FE889A83get_var*
//#UC END# *46A5EFE602DE_0D20FE889A83get_var*
begin
//#UC START# *46A5EFE602DE_0D20FE889A83get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_0D20FE889A83get_impl*
end;//TWordPositionNamesMapImplPrim.pm_GetMapID

procedure TWordPositionNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
//#UC START# *46A5F0130365_0D20FE889A83_var*
//#UC END# *46A5F0130365_0D20FE889A83_var*
begin
//#UC START# *46A5F0130365_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.GetDisplayNames

function TWordPositionNamesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_0D20FE889A83_var*
//#UC END# *46A5F03800A2_0D20FE889A83_var*
begin
//#UC START# *46A5F03800A2_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.MapSize

function TWordPositionNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_0D20FE889A83_var*
//#UC END# *46A5FCF900E0_0D20FE889A83_var*
begin
//#UC START# *46A5FCF900E0_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.DisplayNameToValue

function TWordPositionNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_0D20FE889A83_var*
//#UC END# *46A5FD1B000D_0D20FE889A83_var*
begin
//#UC START# *46A5FD1B000D_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.ValueToDisplayName

class function TWordPositionNamesMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TWordPositionNamesMapImpl }
var
 l_Inst : TWordPositionNamesMapImpl;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWordPositionNamesMapImpl.Make

class function TWordPositionNamesMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TWordPositionNamesMapImpl <> nil;
end;//TWordPositionNamesMapImpl.Exists

class function TWordPositionNamesMapImpl.Instance: TWordPositionNamesMapImpl;
 {* Метод получения экземпляра синглетона TWordPositionNamesMapImpl }
begin
 if (g_TWordPositionNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TWordPositionNamesMapImplFree);
  g_TWordPositionNamesMapImpl := Create;
 end;
 Result := g_TWordPositionNamesMapImpl;
end;//TWordPositionNamesMapImpl.Instance

class procedure TreeLevelDistNamesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
//#UC START# *968A40ED5C3C_444575E246EA_var*
//#UC END# *968A40ED5C3C_444575E246EA_var*
begin
//#UC START# *968A40ED5C3C_444575E246EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *968A40ED5C3C_444575E246EA_impl*
end;//TreeLevelDistNamesMapHelper.FillStrings

class function TreeLevelDistNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3TreeLevelDist;
 {* Преобразование строкового значения к порядковому }
//#UC START# *C310C0288899_444575E246EA_var*
//#UC END# *C310C0288899_444575E246EA_var*
begin
//#UC START# *C310C0288899_444575E246EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *C310C0288899_444575E246EA_impl*
end;//TreeLevelDistNamesMapHelper.DisplayNameToValue

class function TTreeLevelDistNamesMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TTreeLevelDistNamesMapImplPrim }
var
 l_Inst : TTreeLevelDistNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TTreeLevelDistNamesMapImplPrim.Make

function TTreeLevelDistNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_5EAAE9B60711get_var*
//#UC END# *46A5EFE602DE_5EAAE9B60711get_var*
begin
//#UC START# *46A5EFE602DE_5EAAE9B60711get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_5EAAE9B60711get_impl*
end;//TTreeLevelDistNamesMapImplPrim.pm_GetMapID

procedure TTreeLevelDistNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
//#UC START# *46A5F0130365_5EAAE9B60711_var*
//#UC END# *46A5F0130365_5EAAE9B60711_var*
begin
//#UC START# *46A5F0130365_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.GetDisplayNames

function TTreeLevelDistNamesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_5EAAE9B60711_var*
//#UC END# *46A5F03800A2_5EAAE9B60711_var*
begin
//#UC START# *46A5F03800A2_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.MapSize

function TTreeLevelDistNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_5EAAE9B60711_var*
//#UC END# *46A5FCF900E0_5EAAE9B60711_var*
begin
//#UC START# *46A5FCF900E0_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.DisplayNameToValue

function TTreeLevelDistNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_5EAAE9B60711_var*
//#UC END# *46A5FD1B000D_5EAAE9B60711_var*
begin
//#UC START# *46A5FD1B000D_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.ValueToDisplayName

class function TTreeLevelDistNamesMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TTreeLevelDistNamesMapImpl }
var
 l_Inst : TTreeLevelDistNamesMapImpl;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TTreeLevelDistNamesMapImpl.Make

class function TTreeLevelDistNamesMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TTreeLevelDistNamesMapImpl <> nil;
end;//TTreeLevelDistNamesMapImpl.Exists

class function TTreeLevelDistNamesMapImpl.Instance: TTreeLevelDistNamesMapImpl;
 {* Метод получения экземпляра синглетона TTreeLevelDistNamesMapImpl }
begin
 if (g_TTreeLevelDistNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TTreeLevelDistNamesMapImplFree);
  g_TTreeLevelDistNamesMapImpl := Create;
 end;
 Result := g_TTreeLevelDistNamesMapImpl;
end;//TTreeLevelDistNamesMapImpl.Instance

class procedure WordOrderNamesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
//#UC START# *6E3894B77C4A_2C955AD033BA_var*
//#UC END# *6E3894B77C4A_2C955AD033BA_var*
begin
//#UC START# *6E3894B77C4A_2C955AD033BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E3894B77C4A_2C955AD033BA_impl*
end;//WordOrderNamesMapHelper.FillStrings

class function WordOrderNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordOrder;
 {* Преобразование строкового значения к порядковому }
//#UC START# *4CD8F3EDFF4B_2C955AD033BA_var*
//#UC END# *4CD8F3EDFF4B_2C955AD033BA_var*
begin
//#UC START# *4CD8F3EDFF4B_2C955AD033BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CD8F3EDFF4B_2C955AD033BA_impl*
end;//WordOrderNamesMapHelper.DisplayNameToValue

class function TWordOrderNamesMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TWordOrderNamesMapImplPrim }
var
 l_Inst : TWordOrderNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWordOrderNamesMapImplPrim.Make

function TWordOrderNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_1E42BDDCD137get_var*
//#UC END# *46A5EFE602DE_1E42BDDCD137get_var*
begin
//#UC START# *46A5EFE602DE_1E42BDDCD137get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_1E42BDDCD137get_impl*
end;//TWordOrderNamesMapImplPrim.pm_GetMapID

procedure TWordOrderNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
//#UC START# *46A5F0130365_1E42BDDCD137_var*
//#UC END# *46A5F0130365_1E42BDDCD137_var*
begin
//#UC START# *46A5F0130365_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.GetDisplayNames

function TWordOrderNamesMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_1E42BDDCD137_var*
//#UC END# *46A5F03800A2_1E42BDDCD137_var*
begin
//#UC START# *46A5F03800A2_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.MapSize

function TWordOrderNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_1E42BDDCD137_var*
//#UC END# *46A5FCF900E0_1E42BDDCD137_var*
begin
//#UC START# *46A5FCF900E0_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.DisplayNameToValue

function TWordOrderNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_1E42BDDCD137_var*
//#UC END# *46A5FD1B000D_1E42BDDCD137_var*
begin
//#UC START# *46A5FD1B000D_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.ValueToDisplayName

class function TWordOrderNamesMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TWordOrderNamesMapImpl }
var
 l_Inst : TWordOrderNamesMapImpl;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWordOrderNamesMapImpl.Make

class function TWordOrderNamesMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TWordOrderNamesMapImpl <> nil;
end;//TWordOrderNamesMapImpl.Exists

class function TWordOrderNamesMapImpl.Instance: TWordOrderNamesMapImpl;
 {* Метод получения экземпляра синглетона TWordOrderNamesMapImpl }
begin
 if (g_TWordOrderNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TWordOrderNamesMapImplFree);
  g_TWordOrderNamesMapImpl := Create;
 end;
 Result := g_TWordOrderNamesMapImpl;
end;//TWordOrderNamesMapImpl.Instance

initialization
 str_nsc_wpAnyPathWord.Init;
 {* Инициализация str_nsc_wpAnyPathWord }
 str_nsc_wpAtBeginWord.Init;
 {* Инициализация str_nsc_wpAtBeginWord }
 str_nsc_wpAtBeginString.Init;
 {* Инициализация str_nsc_wpAtBeginString }
 str_nsc_tldAllLevels.Init;
 {* Инициализация str_nsc_tldAllLevels }
 str_nsc_tldOneLevel.Init;
 {* Инициализация str_nsc_tldOneLevel }
 str_nsc_woAnyOrder.Init;
 {* Инициализация str_nsc_woAnyOrder }
 str_nsc_woAsWrote.Init;
 {* Инициализация str_nsc_woAsWrote }
 str_nsc_cpmTreeLevelDistHint.Init;
 {* Инициализация str_nsc_cpmTreeLevelDistHint }
 str_nsc_cpmWordOrderHint.Init;
 {* Инициализация str_nsc_cpmWordOrderHint }
 str_nsc_cpmWordPositionHint.Init;
 {* Инициализация str_nsc_cpmWordPositionHint }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
