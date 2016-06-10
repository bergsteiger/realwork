unit nsTextWithCommentsRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsTextWithCommentsRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsTextWithCommentsRes" MUID: (4D5A701702B4)

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
 {* Локализуемые строки Local }
 str_pi_Document_ShowVersionsComment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionsComment'; rValue : 'Показывать информацию об изменениях в тексте документа');
  {* 'Показывать информацию об изменениях в тексте документа' }
 str_pi_Document_ShowVersionsComment_Hint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionsComment_Hint'; rValue : 'Показывать информацию об изменениях в тексте документа');
  {* 'Показывать информацию об изменениях в тексте документа' }
 str_pi_Document_SubPanel_ShowVersionComments: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_SubPanel_ShowVersionComments'; rValue : 'Информация об изменениях');
  {* 'Информация об изменениях' }
 str_pi_Document_ShowVersionCommentsLinkBehaviour: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionCommentsLinkBehaviour'; rValue : 'По ссылке в информации об изменениях в тексте документа открывать');
  {* 'По ссылке в информации об изменениях в тексте документа открывать' }
 {* Локализуемые строки ShowVersionComments }
 str_svcCollapsed: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svcCollapsed'; rValue : 'В свернутом виде');
  {* 'В свернутом виде' }
 str_svcExpanded: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svcExpanded'; rValue : 'В развернутом виде');
  {* 'В развернутом виде' }
 {* Карта преобразования локализованных строк ShowVersionComments }
 ShowVersionCommentsMap: array [Boolean] of Pl3StringIDEx = (
 @str_svcCollapsed
 , @str_svcExpanded
 );
 {* Локализуемые строки VersionCommentsLinkBegaviour }
 str_vclbComparison: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vclbComparison'; rValue : 'Сравнение редакций');
  {* 'Сравнение редакций' }
 str_vclbText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vclbText'; rValue : 'Текст редакции');
  {* 'Текст редакции' }
 {* Карта преобразования локализованных строк VersionCommentsLinkBegaviour }
 VersionCommentsLinkBegaviourMap: array [Boolean] of Pl3StringIDEx = (
 @str_vclbComparison
 , @str_vclbText
 );

type
 ShowVersionCommentsMapHelper = {final} class
  {* Утилитный класс для преобразования значений ShowVersionCommentsMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
    {* Преобразование строкового значения к порядковому }
 end;//ShowVersionCommentsMapHelper

 TShowVersionCommentsMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для ShowVersionCommentsMap }
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
    {* Фабричный метод для TShowVersionCommentsMapImplPrim }
 end;//TShowVersionCommentsMapImplPrim

 TShowVersionCommentsMapImpl = {final} class(TShowVersionCommentsMapImplPrim)
  {* Класс для реализации мапы для ShowVersionCommentsMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TShowVersionCommentsMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TShowVersionCommentsMapImpl

 VersionCommentsLinkBegaviourMapHelper = {final} class
  {* Утилитный класс для преобразования значений VersionCommentsLinkBegaviourMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
    {* Преобразование строкового значения к порядковому }
 end;//VersionCommentsLinkBegaviourMapHelper

 TVersionCommentsLinkBegaviourMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* Класс для реализации мапы для VersionCommentsLinkBegaviourMap }
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
    {* Фабричный метод для TVersionCommentsLinkBegaviourMapImplPrim }
 end;//TVersionCommentsLinkBegaviourMapImplPrim

 TVersionCommentsLinkBegaviourMapImpl = {final} class(TVersionCommentsLinkBegaviourMapImplPrim)
  {* Класс для реализации мапы для VersionCommentsLinkBegaviourMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* Фабричный метод для TVersionCommentsLinkBegaviourMapImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TVersionCommentsLinkBegaviourMapImpl
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

var g_TShowVersionCommentsMapImpl: Pointer = nil;
 {* Экземпляр синглетона TShowVersionCommentsMapImpl }
var g_TVersionCommentsLinkBegaviourMapImpl: Pointer = nil;
 {* Экземпляр синглетона TVersionCommentsLinkBegaviourMapImpl }

procedure TShowVersionCommentsMapImplFree;
 {* Метод освобождения экземпляра синглетона TShowVersionCommentsMapImpl }
begin
 IUnknown(g_TShowVersionCommentsMapImpl) := nil;
end;//TShowVersionCommentsMapImplFree

procedure TVersionCommentsLinkBegaviourMapImplFree;
 {* Метод освобождения экземпляра синглетона TVersionCommentsLinkBegaviourMapImpl }
begin
 IUnknown(g_TVersionCommentsLinkBegaviourMapImpl) := nil;
end;//TVersionCommentsLinkBegaviourMapImplFree

class procedure ShowVersionCommentsMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
var
 l_Index: Boolean;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ShowVersionCommentsMap[l_Index].AsCStr);
end;//ShowVersionCommentsMapHelper.FillStrings

class function ShowVersionCommentsMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* Преобразование строкового значения к порядковому }
var
 l_Index: Boolean;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ShowVersionCommentsMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ShowVersionCommentsMap"', [l3Str(aDisplayName)]);
end;//ShowVersionCommentsMapHelper.DisplayNameToValue

class function TShowVersionCommentsMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TShowVersionCommentsMapImplPrim }
var
 l_Inst : TShowVersionCommentsMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TShowVersionCommentsMapImplPrim.Make

function TShowVersionCommentsMapImplPrim.pm_GetMapID: Tl3ValueMapID;
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TShowVersionCommentsMapImplPrim.pm_GetMapID

procedure TShowVersionCommentsMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
begin
 ShowVersionCommentsMapHelper.FillStrings(aList);
end;//TShowVersionCommentsMapImplPrim.GetDisplayNames

function TShowVersionCommentsMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
begin
 Result := Ord(High(Boolean)) - Ord(Low(Boolean));
end;//TShowVersionCommentsMapImplPrim.MapSize

function TShowVersionCommentsMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(ShowVersionCommentsMapHelper.DisplayNameToValue(aDisplayName));
end;//TShowVersionCommentsMapImplPrim.DisplayNameToValue

function TShowVersionCommentsMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(Boolean)));
 Assert(aValue <= Ord(High(Boolean)));
 Result := ShowVersionCommentsMap[Boolean(aValue)].AsCStr;
end;//TShowVersionCommentsMapImplPrim.ValueToDisplayName

class function TShowVersionCommentsMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TShowVersionCommentsMapImpl }
begin
 if (g_TShowVersionCommentsMapImpl = nil) then
 begin
  l3System.AddExitProc(TShowVersionCommentsMapImplFree);
  Il3IntegerValueMap(g_TShowVersionCommentsMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TShowVersionCommentsMapImpl);
end;//TShowVersionCommentsMapImpl.Make

class function TShowVersionCommentsMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TShowVersionCommentsMapImpl <> nil;
end;//TShowVersionCommentsMapImpl.Exists

class procedure VersionCommentsLinkBegaviourMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
var
 l_Index: Boolean;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(VersionCommentsLinkBegaviourMap[l_Index].AsCStr);
end;//VersionCommentsLinkBegaviourMapHelper.FillStrings

class function VersionCommentsLinkBegaviourMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* Преобразование строкового значения к порядковому }
var
 l_Index: Boolean;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, VersionCommentsLinkBegaviourMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "VersionCommentsLinkBegaviourMap"', [l3Str(aDisplayName)]);
end;//VersionCommentsLinkBegaviourMapHelper.DisplayNameToValue

class function TVersionCommentsLinkBegaviourMapImplPrim.Make: Il3IntegerValueMap;
 {* Фабричный метод для TVersionCommentsLinkBegaviourMapImplPrim }
var
 l_Inst : TVersionCommentsLinkBegaviourMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TVersionCommentsLinkBegaviourMapImplPrim.Make

function TVersionCommentsLinkBegaviourMapImplPrim.pm_GetMapID: Tl3ValueMapID;
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TVersionCommentsLinkBegaviourMapImplPrim.pm_GetMapID

procedure TVersionCommentsLinkBegaviourMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
begin
 VersionCommentsLinkBegaviourMapHelper.FillStrings(aList);
end;//TVersionCommentsLinkBegaviourMapImplPrim.GetDisplayNames

function TVersionCommentsLinkBegaviourMapImplPrim.MapSize: Integer;
 {* количество элементов в мапе. }
begin
 Result := Ord(High(Boolean)) - Ord(Low(Boolean));
end;//TVersionCommentsLinkBegaviourMapImplPrim.MapSize

function TVersionCommentsLinkBegaviourMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(VersionCommentsLinkBegaviourMapHelper.DisplayNameToValue(aDisplayName));
end;//TVersionCommentsLinkBegaviourMapImplPrim.DisplayNameToValue

function TVersionCommentsLinkBegaviourMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(Boolean)));
 Assert(aValue <= Ord(High(Boolean)));
 Result := VersionCommentsLinkBegaviourMap[Boolean(aValue)].AsCStr;
end;//TVersionCommentsLinkBegaviourMapImplPrim.ValueToDisplayName

class function TVersionCommentsLinkBegaviourMapImpl.Make: Il3IntegerValueMap;
 {* Фабричный метод для TVersionCommentsLinkBegaviourMapImpl }
begin
 if (g_TVersionCommentsLinkBegaviourMapImpl = nil) then
 begin
  l3System.AddExitProc(TVersionCommentsLinkBegaviourMapImplFree);
  Il3IntegerValueMap(g_TVersionCommentsLinkBegaviourMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TVersionCommentsLinkBegaviourMapImpl);
end;//TVersionCommentsLinkBegaviourMapImpl.Make

class function TVersionCommentsLinkBegaviourMapImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TVersionCommentsLinkBegaviourMapImpl <> nil;
end;//TVersionCommentsLinkBegaviourMapImpl.Exists

initialization
 str_pi_Document_ShowVersionsComment.Init;
 {* Инициализация str_pi_Document_ShowVersionsComment }
 str_pi_Document_ShowVersionsComment_Hint.Init;
 {* Инициализация str_pi_Document_ShowVersionsComment_Hint }
 str_pi_Document_SubPanel_ShowVersionComments.Init;
 {* Инициализация str_pi_Document_SubPanel_ShowVersionComments }
 str_pi_Document_ShowVersionCommentsLinkBehaviour.Init;
 {* Инициализация str_pi_Document_ShowVersionCommentsLinkBehaviour }
 str_svcCollapsed.Init;
 {* Инициализация str_svcCollapsed }
 str_svcExpanded.Init;
 {* Инициализация str_svcExpanded }
 str_vclbComparison.Init;
 {* Инициализация str_vclbComparison }
 str_vclbText.Init;
 {* Инициализация str_vclbText }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
