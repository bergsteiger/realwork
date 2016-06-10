unit sdsSituation;
 {* бизнес объект сборки дерево атрибутов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\sdsSituation.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsSituation" MUID: (493027CE015A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , QueryCardInterfaces
 , SearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , SimpleListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
 , l3TreeInterfaces
;

type
 _InitDataType_ = IdeSearch;
 _SetType_ = IsdsSituation;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 _CurrentChangedListener_Parent_ = _vcmFormSetDataSourceWithoutData_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\CurrentChangedListener.imp.pas}
 TsdsSituation = class(_CurrentChangedListener_, IsdsSituation, IucpFilters, IbsCurrentChangedListener, IbsSelectedAttributes)
  {* бизнес объект сборки дерево атрибутов }
  private
   f_dsFilters: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFilters }
   f_dsTreeAttributeFirstLevel: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTreeAttributeFirstLevel }
   f_dsSaveLoad: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSaveLoad }
   f_dsSelectedAttributes: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsSelectedAttributes }
   f_dsTreeAttributeSelect: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTreeAttributeSelect }
   f_dsAttributeSelect: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsAttributeSelect }
  protected
   function As_IucpFilters: IucpFilters;
    {* Метод приведения нашего интерфейса к IucpFilters }
   function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
    {* Метод приведения нашего интерфейса к IbsCurrentChangedListener }
   function As_IbsSelectedAttributes: IbsSelectedAttributes;
    {* Метод приведения нашего интерфейса к IbsSelectedAttributes }
   procedure Open;
    {* открыть форму фильтры }
   function pm_GetSearch: IdeSearch;
   function pm_GetDsFilters: IdsFilters;
   function DoGet_DsFilters: IdsFilters;
   function pm_GetDsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   function DoGet_DsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function DoGet_DsSaveLoad: IdsSaveLoad;
   function pm_GetDsSelectedAttributes: IdsSelectedAttributes;
   function DoGet_DsSelectedAttributes: IdsSelectedAttributes;
   function pm_GetDsTreeAttributeSelect: IdsTreeAttributeSelect;
   function DoGet_DsTreeAttributeSelect: IdsTreeAttributeSelect;
   function pm_GetDsAttributeSelect: IdsAttributeSelect;
   function DoGet_DsAttributeSelect: IdsAttributeSelect;
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure UpdateSelectedAttributes;
    {* обновить данные в форме выбранных атрибутов }
 end;//TsdsSituation
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , dsTreeAttributeSelect
 , dsSelectedAttributes
 , deSelectedAttributes
 , dsSaveLoad
 , dsTreeAttributeFirstLevel
 , dsFilters
 , afwFacade
 , nsConst
 , dsAttributeSelect
 , deSearch
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TsdsSituation;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\CurrentChangedListener.imp.pas}

function TsdsSituation.As_IucpFilters: IucpFilters;
 {* Метод приведения нашего интерфейса к IucpFilters }
begin
 Result := Self;
end;//TsdsSituation.As_IucpFilters

function TsdsSituation.As_IbsCurrentChangedListener: IbsCurrentChangedListener;
 {* Метод приведения нашего интерфейса к IbsCurrentChangedListener }
begin
 Result := Self;
end;//TsdsSituation.As_IbsCurrentChangedListener

function TsdsSituation.As_IbsSelectedAttributes: IbsSelectedAttributes;
 {* Метод приведения нашего интерфейса к IbsSelectedAttributes }
begin
 Result := Self;
end;//TsdsSituation.As_IbsSelectedAttributes

procedure TsdsSituation.Open;
 {* открыть форму фильтры }
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
end;//TsdsSituation.pm_GetDsFilters

function TsdsSituation.DoGet_DsFilters: IdsFilters;
//#UC START# *492EF8440252_493027CE015Aarea_var*
//#UC END# *492EF8440252_493027CE015Aarea_var*
begin
//#UC START# *492EF8440252_493027CE015Aarea_impl*
 Result := TdsFilters.Make(Self);
//#UC END# *492EF8440252_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_DsFilters

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
end;//TsdsSituation.pm_GetDsTreeAttributeFirstLevel

function TsdsSituation.DoGet_DsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
//#UC START# *492EF877026C_493027CE015Aarea_var*
//#UC END# *492EF877026C_493027CE015Aarea_var*
begin
//#UC START# *492EF877026C_493027CE015Aarea_impl*
 Result := TdsTreeAttributeFirstLevel.Make(Self, TdeSearch.Clone(InitialUseCaseData));
//#UC END# *492EF877026C_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_DsTreeAttributeFirstLevel

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
end;//TsdsSituation.pm_GetDsSaveLoad

function TsdsSituation.DoGet_DsSaveLoad: IdsSaveLoad;
//#UC START# *492EF8AA024F_493027CE015Aarea_var*
//#UC END# *492EF8AA024F_493027CE015Aarea_var*
begin
//#UC START# *492EF8AA024F_493027CE015Aarea_impl*
 Result := TdsSaveLoad.Make(Self);
//#UC END# *492EF8AA024F_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_DsSaveLoad

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
end;//TsdsSituation.pm_GetDsSelectedAttributes

function TsdsSituation.DoGet_DsSelectedAttributes: IdsSelectedAttributes;
//#UC START# *492EF8E10244_493027CE015Aarea_var*
//#UC END# *492EF8E10244_493027CE015Aarea_var*
begin
//#UC START# *492EF8E10244_493027CE015Aarea_impl*
 Result := TdsSelectedAttributes.Make(Self,
   TdeSelectedAttributes.Make(pm_GetDSTreeAttributeSelect.RefreshValues, InitialUseCaseData.Tag));
//#UC END# *492EF8E10244_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_DsSelectedAttributes

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
end;//TsdsSituation.pm_GetDsTreeAttributeSelect

function TsdsSituation.DoGet_DsTreeAttributeSelect: IdsTreeAttributeSelect;
//#UC START# *492EF8F20381_493027CE015Aarea_var*
//#UC END# *492EF8F20381_493027CE015Aarea_var*
begin
//#UC START# *492EF8F20381_493027CE015Aarea_impl*
 Result := TdsTreeAttributeSelect.Make(Self, TdeSearch.Clone(InitialUseCaseData));
//#UC END# *492EF8F20381_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_DsTreeAttributeSelect

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
end;//TsdsSituation.pm_GetDsAttributeSelect

function TsdsSituation.DoGet_DsAttributeSelect: IdsAttributeSelect;
//#UC START# *493027030386_493027CE015Aarea_var*
//#UC END# *493027030386_493027CE015Aarea_var*
begin
//#UC START# *493027030386_493027CE015Aarea_impl*
 Result := TdsAttributeSelect.Make(Self, TdeSearch.Clone(InitialUseCaseData));
//#UC END# *493027030386_493027CE015Aarea_impl*
end;//TsdsSituation.DoGet_DsAttributeSelect

procedure TsdsSituation.UpdateSelectedAttributes;
 {* обновить данные в форме выбранных атрибутов }
//#UC START# *4959149300F9_493027CE015A_var*
//#UC END# *4959149300F9_493027CE015A_var*
begin
//#UC START# *4959149300F9_493027CE015A_impl*
 if (f_dsSelectedAttributes <> nil) then
  f_dsSelectedAttributes.Referred := nil;
 Refresh;
//#UC END# *4959149300F9_493027CE015A_impl*
end;//TsdsSituation.UpdateSelectedAttributes

procedure TsdsSituation.ClearFields;
begin
 f_dsFilters := nil;
 f_dsTreeAttributeFirstLevel := nil;
 f_dsSaveLoad := nil;
 f_dsSelectedAttributes := nil;
 f_dsTreeAttributeSelect := nil;
 f_dsAttributeSelect := nil;
 inherited;
end;//TsdsSituation.ClearFields

procedure TsdsSituation.ClearAreas;
 {* Очищает ссылки на области ввода }
begin
 if (f_dsFilters <> nil) then f_dsFilters.Referred := nil;
 if (f_dsTreeAttributeFirstLevel <> nil) then f_dsTreeAttributeFirstLevel.Referred := nil;
 if (f_dsSaveLoad <> nil) then f_dsSaveLoad.Referred := nil;
 if (f_dsSelectedAttributes <> nil) then f_dsSelectedAttributes.Referred := nil;
 if (f_dsTreeAttributeSelect <> nil) then f_dsTreeAttributeSelect.Referred := nil;
 if (f_dsAttributeSelect <> nil) then f_dsAttributeSelect.Referred := nil;
 inherited;
end;//TsdsSituation.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
