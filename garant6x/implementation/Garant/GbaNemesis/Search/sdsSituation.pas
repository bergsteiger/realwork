unit sdsSituation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/sdsSituation.pas"
// Начат: 2005/08/02 12:26:58
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TsdsSituation
//
// бизнес объект сборки дерево атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  SearchInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  QueryCardInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  l3TreeInterfaces,
  SimpleListInterfaces {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _InitDataType_ = IdeSearch;
 _SetType_ = IsdsSituation;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 _CurrentChangedListener_Parent_ = _vcmFormSetDataSourceWithoutData_;
 {$Include ..\Search\CurrentChangedListener.imp.pas}
 TsdsSituation = {ucc} class(_CurrentChangedListener_, IsdsSituation, IucpFilters {from IsdsSituation}, IbsCurrentChangedListener {from IsdsSituation}, IbsSelectedAttributes {from IsdsSituation})
  {* бизнес объект сборки дерево атрибутов }
 private
 // private fields
   f_dsFilters : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFilters}
   f_dsTreeAttributeFirstLevel : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTreeAttributeFirstLevel}
   f_dsSaveLoad : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSaveLoad}
   f_dsSelectedAttributes : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSelectedAttributes}
   f_dsTreeAttributeSelect : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTreeAttributeSelect}
   f_dsAttributeSelect : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsAttributeSelect}
 protected
 // realized methods
   procedure Open;
     {* открыть форму фильтры }
   function pm_GetSearch: IdeSearch;
   function pm_GetDsFilters: IdsFilters;
   function DoGet_dsFilters: IdsFilters;
   function pm_GetDsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   function DoGet_dsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function DoGet_dsSaveLoad: IdsSaveLoad;
   function pm_GetDsSelectedAttributes: IdsSelectedAttributes;
   function DoGet_dsSelectedAttributes: IdsSelectedAttributes;
   function pm_GetDsTreeAttributeSelect: IdsTreeAttributeSelect;
   function DoGet_dsTreeAttributeSelect: IdsTreeAttributeSelect;
   function pm_GetDsAttributeSelect: IdsAttributeSelect;
   function DoGet_dsAttributeSelect: IdsAttributeSelect;
 public
 // realized methods
   procedure UpdateSelectedAttributes;
     {* обновить данные в форме выбранных атрибутов }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IucpFilters: IucpFilters;
   function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
   function As_IbsSelectedAttributes: IbsSelectedAttributes;
 end;//TsdsSituation
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  dsTreeAttributeSelect,
  dsSelectedAttributes,
  deSelectedAttributes,
  dsSaveLoad,
  dsTreeAttributeFirstLevel,
  dsFilters,
  afwFacade,
  nsConst,
  dsAttributeSelect,
  deSearch
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  SysUtils,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

type _Instance_R_ = TsdsSituation;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

{$Include ..\Search\CurrentChangedListener.imp.pas}

// start class TsdsSituation

procedure TsdsSituation.Open;
//#UC START# *47FB2086026D_493027CE015A_var*
//#UC END# *47FB2086026D_493027CE015A_var*
begin
//#UC START# *47FB2086026D_493027CE015A_impl*
 if f_dsFilters.IsEmpty then
 begin
  f_dsFilters.NeedMake := vcm_nmForce;
  Refresh;
 end;//if f_dsFilters.IsEmpty then
//#UC END# *47FB2086026D_493027CE015A_impl*
end;//TsdsSituation.Open

function TsdsSituation.pm_GetSearch: IdeSearch;
//#UC START# *492EF70F0275_493027CE015Aget_var*
//#UC END# *492EF70F0275_493027CE015Aget_var*
begin
//#UC START# *492EF70F0275_493027CE015Aget_impl*
 Result := InitialUseCaseData;
//#UC END# *492EF70F0275_493027CE015Aget_impl*
end;//TsdsSituation.pm_GetSearch

function TsdsSituation.pm_GetDsFilters: IdsFilters;
//#UC START# *492EF8440252_493027CE015Aget_var*
//#UC END# *492EF8440252_493027CE015Aget_var*
begin
 if (f_dsFilters = nil) then
 begin
  f_dsFilters := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EF8440252_493027CE015Aget_init*
  f_dsFilters.NeedMake := vcm_nmYes;
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EF8440252_493027CE015Aget_init*
 end;//f_dsFilters = nil
 if f_dsFilters.IsEmpty
  //#UC START# *492EF8440252_493027CE015Aget_need*
    and ((afw.Settings.LoadBoolean(pi_Search_Sheets_Filters, dv_Search_Sheets_Filters) and
         (f_dsFilters.NeedMake = vcm_nmYes)) or (f_dsFilters.NeedMake = vcm_nmForce))
  // - условие создания ViewArea
  //#UC END# *492EF8440252_493027CE015Aget_need*
  then
   f_dsFilters.Referred := DoGet_dsFilters;
 Result := IdsFilters(f_dsFilters.Referred);
end;

function TsdsSituation.DoGet_dsFilters: IdsFilters;
//#UC START# *492EF8440252_493027CE015Aarea_var*
//#UC END# *492EF8440252_493027CE015Aarea_var*
begin
//#UC START# *492EF8440252_493027CE015Aarea_impl*
 Result := TdsFilters.Make(Self);
//#UC END# *492EF8440252_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_dsFilters

function TsdsSituation.pm_GetDsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
//#UC START# *492EF877026C_493027CE015Aget_var*
//#UC END# *492EF877026C_493027CE015Aget_var*
begin
 if (f_dsTreeAttributeFirstLevel = nil) then
 begin
  f_dsTreeAttributeFirstLevel := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EF877026C_493027CE015Aget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EF877026C_493027CE015Aget_init*
 end;//f_dsTreeAttributeFirstLevel = nil
 if f_dsTreeAttributeFirstLevel.IsEmpty
  //#UC START# *492EF877026C_493027CE015Aget_need*
  // - условие создания ViewArea
  //#UC END# *492EF877026C_493027CE015Aget_need*
  then
   f_dsTreeAttributeFirstLevel.Referred := DoGet_dsTreeAttributeFirstLevel;
 Result := IdsTreeAttributeFirstLevel(f_dsTreeAttributeFirstLevel.Referred);
end;

function TsdsSituation.DoGet_dsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
//#UC START# *492EF877026C_493027CE015Aarea_var*
//#UC END# *492EF877026C_493027CE015Aarea_var*
begin
//#UC START# *492EF877026C_493027CE015Aarea_impl*
 Result := TdsTreeAttributeFirstLevel.Make(Self, TdeSearch.Clone(InitialUseCaseData));
//#UC END# *492EF877026C_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_dsTreeAttributeFirstLevel

function TsdsSituation.pm_GetDsSaveLoad: IdsSaveLoad;
//#UC START# *492EF8AA024F_493027CE015Aget_var*
//#UC END# *492EF8AA024F_493027CE015Aget_var*
begin
 if (f_dsSaveLoad = nil) then
 begin
  f_dsSaveLoad := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EF8AA024F_493027CE015Aget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EF8AA024F_493027CE015Aget_init*
 end;//f_dsSaveLoad = nil
 if f_dsSaveLoad.IsEmpty
  //#UC START# *492EF8AA024F_493027CE015Aget_need*
  // - условие создания ViewArea
  //#UC END# *492EF8AA024F_493027CE015Aget_need*
  then
   f_dsSaveLoad.Referred := DoGet_dsSaveLoad;
 Result := IdsSaveLoad(f_dsSaveLoad.Referred);
end;

function TsdsSituation.DoGet_dsSaveLoad: IdsSaveLoad;
//#UC START# *492EF8AA024F_493027CE015Aarea_var*
//#UC END# *492EF8AA024F_493027CE015Aarea_var*
begin
//#UC START# *492EF8AA024F_493027CE015Aarea_impl*
 Result := TdsSaveLoad.Make(Self);
//#UC END# *492EF8AA024F_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_dsSaveLoad

function TsdsSituation.pm_GetDsSelectedAttributes: IdsSelectedAttributes;
//#UC START# *492EF8E10244_493027CE015Aget_var*
//#UC END# *492EF8E10244_493027CE015Aget_var*
begin
 if (f_dsSelectedAttributes = nil) then
 begin
  f_dsSelectedAttributes := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EF8E10244_493027CE015Aget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EF8E10244_493027CE015Aget_init*
 end;//f_dsSelectedAttributes = nil
 if f_dsSelectedAttributes.IsEmpty
  //#UC START# *492EF8E10244_493027CE015Aget_need*
  // - условие создания ViewArea
  //#UC END# *492EF8E10244_493027CE015Aget_need*
  then
   f_dsSelectedAttributes.Referred := DoGet_dsSelectedAttributes;
 Result := IdsSelectedAttributes(f_dsSelectedAttributes.Referred);
end;

function TsdsSituation.DoGet_dsSelectedAttributes: IdsSelectedAttributes;
//#UC START# *492EF8E10244_493027CE015Aarea_var*
//#UC END# *492EF8E10244_493027CE015Aarea_var*
begin
//#UC START# *492EF8E10244_493027CE015Aarea_impl*
 Result := TdsSelectedAttributes.Make(Self,
   TdeSelectedAttributes.Make(pm_GetDSTreeAttributeSelect.RefreshValues, InitialUseCaseData.Tag));
//#UC END# *492EF8E10244_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_dsSelectedAttributes

function TsdsSituation.pm_GetDsTreeAttributeSelect: IdsTreeAttributeSelect;
//#UC START# *492EF8F20381_493027CE015Aget_var*
//#UC END# *492EF8F20381_493027CE015Aget_var*
begin
 if (f_dsTreeAttributeSelect = nil) then
 begin
  f_dsTreeAttributeSelect := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EF8F20381_493027CE015Aget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EF8F20381_493027CE015Aget_init*
 end;//f_dsTreeAttributeSelect = nil
 if f_dsTreeAttributeSelect.IsEmpty
  //#UC START# *492EF8F20381_493027CE015Aget_need*
  // - условие создания ViewArea
  //#UC END# *492EF8F20381_493027CE015Aget_need*
  then
   f_dsTreeAttributeSelect.Referred := DoGet_dsTreeAttributeSelect;
 Result := IdsTreeAttributeSelect(f_dsTreeAttributeSelect.Referred);
end;

function TsdsSituation.DoGet_dsTreeAttributeSelect: IdsTreeAttributeSelect;
//#UC START# *492EF8F20381_493027CE015Aarea_var*
//#UC END# *492EF8F20381_493027CE015Aarea_var*
begin
//#UC START# *492EF8F20381_493027CE015Aarea_impl*
 Result := TdsTreeAttributeSelect.Make(Self, TdeSearch.Clone(InitialUseCaseData));
//#UC END# *492EF8F20381_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_dsTreeAttributeSelect

function TsdsSituation.pm_GetDsAttributeSelect: IdsAttributeSelect;
//#UC START# *493027030386_493027CE015Aget_var*
//#UC END# *493027030386_493027CE015Aget_var*
begin
 if (f_dsAttributeSelect = nil) then
 begin
  f_dsAttributeSelect := TvcmViewAreaControllerRef.Make;
  //#UC START# *493027030386_493027CE015Aget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *493027030386_493027CE015Aget_init*
 end;//f_dsAttributeSelect = nil
 if f_dsAttributeSelect.IsEmpty
  //#UC START# *493027030386_493027CE015Aget_need*
  // - условие создания ViewArea
  //#UC END# *493027030386_493027CE015Aget_need*
  then
   f_dsAttributeSelect.Referred := DoGet_dsAttributeSelect;
 Result := IdsAttributeSelect(f_dsAttributeSelect.Referred);
end;

function TsdsSituation.DoGet_dsAttributeSelect: IdsAttributeSelect;
//#UC START# *493027030386_493027CE015Aarea_var*
//#UC END# *493027030386_493027CE015Aarea_var*
begin
//#UC START# *493027030386_493027CE015Aarea_impl*
 Result := TdsAttributeSelect.Make(Self, TdeSearch.Clone(InitialUseCaseData));
//#UC END# *493027030386_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_dsAttributeSelect

procedure TsdsSituation.UpdateSelectedAttributes;
//#UC START# *4959149300F9_493027CE015A_var*
//#UC END# *4959149300F9_493027CE015A_var*
begin
//#UC START# *4959149300F9_493027CE015A_impl*
 if (f_dsSelectedAttributes <> nil) then
  f_dsSelectedAttributes.Referred := nil;
 Refresh;
//#UC END# *4959149300F9_493027CE015A_impl*
end;//TsdsSituation.UpdateSelectedAttributes

{$If not defined(NoVCM)}
procedure TsdsSituation.ClearAreas;
 {-}
begin
 if (f_dsFilters <> nil) then f_dsFilters.Referred := nil;
 if (f_dsTreeAttributeFirstLevel <> nil) then f_dsTreeAttributeFirstLevel.Referred := nil;
 if (f_dsSaveLoad <> nil) then f_dsSaveLoad.Referred := nil;
 if (f_dsSelectedAttributes <> nil) then f_dsSelectedAttributes.Referred := nil;
 if (f_dsTreeAttributeSelect <> nil) then f_dsTreeAttributeSelect.Referred := nil;
 if (f_dsAttributeSelect <> nil) then f_dsAttributeSelect.Referred := nil;
 inherited;
end;//TsdsSituation.ClearAreas
{$IfEnd} //not NoVCM

// Методы преобразования к реализуемым интерфейсам

function TsdsSituation.As_IucpFilters: IucpFilters;
begin
 Result := Self;
end;

function TsdsSituation.As_IbsCurrentChangedListener: IbsCurrentChangedListener;
begin
 Result := Self;
end;

function TsdsSituation.As_IbsSelectedAttributes: IbsSelectedAttributes;
begin
 Result := Self;
end;

{$IfEnd} //not Admin

end.