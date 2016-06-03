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
   function pm_GetDsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function pm_GetDsSelectedAttributes: IdsSelectedAttributes;
   function pm_GetDsTreeAttributeSelect: IdsTreeAttributeSelect;
   function pm_GetDsAttributeSelect: IdsAttributeSelect;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
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
//#UC START# *492EF8440252_493027CE015Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EF8440252_493027CE015Aget_impl*
end;//TsdsSituation.pm_GetDsFilters

function TsdsSituation.pm_GetDsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
//#UC START# *492EF877026C_493027CE015Aget_var*
//#UC END# *492EF877026C_493027CE015Aget_var*
begin
//#UC START# *492EF877026C_493027CE015Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EF877026C_493027CE015Aget_impl*
end;//TsdsSituation.pm_GetDsTreeAttributeFirstLevel

function TsdsSituation.pm_GetDsSaveLoad: IdsSaveLoad;
//#UC START# *492EF8AA024F_493027CE015Aget_var*
//#UC END# *492EF8AA024F_493027CE015Aget_var*
begin
//#UC START# *492EF8AA024F_493027CE015Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EF8AA024F_493027CE015Aget_impl*
end;//TsdsSituation.pm_GetDsSaveLoad

function TsdsSituation.pm_GetDsSelectedAttributes: IdsSelectedAttributes;
//#UC START# *492EF8E10244_493027CE015Aget_var*
//#UC END# *492EF8E10244_493027CE015Aget_var*
begin
//#UC START# *492EF8E10244_493027CE015Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EF8E10244_493027CE015Aget_impl*
end;//TsdsSituation.pm_GetDsSelectedAttributes

function TsdsSituation.pm_GetDsTreeAttributeSelect: IdsTreeAttributeSelect;
//#UC START# *492EF8F20381_493027CE015Aget_var*
//#UC END# *492EF8F20381_493027CE015Aget_var*
begin
//#UC START# *492EF8F20381_493027CE015Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EF8F20381_493027CE015Aget_impl*
end;//TsdsSituation.pm_GetDsTreeAttributeSelect

function TsdsSituation.pm_GetDsAttributeSelect: IdsAttributeSelect;
//#UC START# *493027030386_493027CE015Aget_var*
//#UC END# *493027030386_493027CE015Aget_var*
begin
//#UC START# *493027030386_493027CE015Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *493027030386_493027CE015Aget_impl*
end;//TsdsSituation.pm_GetDsAttributeSelect

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

procedure TsdsSituation.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_493027CE015A_var*
//#UC END# *4938F7E702B7_493027CE015A_var*
begin
//#UC START# *4938F7E702B7_493027CE015A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_493027CE015A_impl*
end;//TsdsSituation.ClearAreas

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
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
