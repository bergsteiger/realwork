unit fsSituationSearch;
 {* ППС 6.х }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsSituationSearch.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "SituationSearch" MUID: (4AA7A4D603C1)
// Имя типа: "Tfs_SituationSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimSaveLoadUserTypes_slqtKW_UserType
 , Search_FormDefinitions_Controls
 , QueryCardInterfaces
 , SearchInterfaces
 , SimpleListInterfaces
 , l3TreeInterfaces
 , FiltersUserTypes_utFilters_UserType
 , Common_FormDefinitions_Controls
 , PrimTreeAttributeFirstLevel_flSituation_UserType
 , PrimAttributeSelect_utSingleSearch_UserType
 , SearchLite_FormDefinitions_Controls
 , PrimTreeAttributeSelect_astNone_UserType
 , PrimSelectedAttributes_utSelectedAttributes_UserType
;

type
 Tfs_SituationSearch = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ППС 6.х }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function SaveLoadParentSlqtKWNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SaveLoad }
   function AttributeSelectParentUtSingleSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AttributeSelect }
   function TreeAttributeSelectParentAstNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TreeAttributeSelect }
   function SelectedAttributesChildUtSelectedAttributesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SelectedAttributes }
   function FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Filters }
   function TreeAttributeFirstLevelNavigatorFlSituationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TreeAttributeFirstLevel }
   class function Instance: Tfs_SituationSearch;
    {* Метод получения экземпляра синглетона Tfs_SituationSearch }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_SituationSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA7A4D603C1impl_uses*
 //#UC END# *4AA7A4D603C1impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_SituationSearch: Tfs_SituationSearch = nil;
 {* Экземпляр синглетона Tfs_SituationSearch }

const
 {* Локализуемые строки SituationSearchCaptionLocalConstants }
 str_fsSituationSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSituationSearchCaption'; rValue : 'ППС 6.х');
  {* Заголовок фабрики сборки форм "SituationSearch" }

procedure Tfs_SituationSearchFree;
 {* Метод освобождения экземпляра синглетона Tfs_SituationSearch }
begin
 l3Free(g_Tfs_SituationSearch);
end;//Tfs_SituationSearchFree

function Tfs_SituationSearch.SaveLoadParentSlqtKWNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SaveLoad }
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
  //#UC START# *4D80CC1002D6NeedMake_impl*
   aNew := l_UseCase.dsSaveLoad;
  //#UC END# *4D80CC1002D6NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationSearch.SaveLoadParentSlqtKWNeedMakeForm

function Tfs_SituationSearch.AttributeSelectParentUtSingleSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AttributeSelect }
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
  //#UC START# *4D80CC820003NeedMake_impl*
   aNew := l_UseCase.dsAttributeSelect;
  //#UC END# *4D80CC820003NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationSearch.AttributeSelectParentUtSingleSearchNeedMakeForm

function Tfs_SituationSearch.TreeAttributeSelectParentAstNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TreeAttributeSelect }
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
  //#UC START# *4D80CCDD0117NeedMake_impl*
   aNew := l_UseCase.dsTreeAttributeSelect;
  //#UC END# *4D80CCDD0117NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationSearch.TreeAttributeSelectParentAstNoneNeedMakeForm

function Tfs_SituationSearch.SelectedAttributesChildUtSelectedAttributesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SelectedAttributes }
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
  //#UC START# *4D80CCF40025NeedMake_impl*
   aNew := l_UseCase.dsSelectedAttributes;
  //#UC END# *4D80CCF40025NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationSearch.SelectedAttributesChildUtSelectedAttributesNeedMakeForm

function Tfs_SituationSearch.FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Filters }
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
  //#UC START# *4D80CC20008BNeedMake_impl*
   aNew := l_UseCase.dsFilters;
  //#UC END# *4D80CC20008BNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationSearch.FiltersNavigatorUtFiltersNeedMakeForm

function Tfs_SituationSearch.TreeAttributeFirstLevelNavigatorFlSituationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TreeAttributeFirstLevel }
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
  //#UC START# *4D80CC2E03BCNeedMake_impl*
   aNew := l_UseCase.dsTreeAttributeFirstLevel;
  //#UC END# *4D80CC2E03BCNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationSearch.TreeAttributeFirstLevelNavigatorFlSituationNeedMakeForm

class function Tfs_SituationSearch.Instance: Tfs_SituationSearch;
 {* Метод получения экземпляра синглетона Tfs_SituationSearch }
begin
 if (g_Tfs_SituationSearch = nil) then
 begin
  l3System.AddExitProc(Tfs_SituationSearchFree);
  g_Tfs_SituationSearch := Create;
 end;
 Result := g_Tfs_SituationSearch;
end;//Tfs_SituationSearch.Instance

class function Tfs_SituationSearch.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_SituationSearch <> nil;
end;//Tfs_SituationSearch.Exists

procedure Tfs_SituationSearch.InitFields;
begin
 inherited;
 with AddZone('SaveLoad', vcm_ztParent, fm_cfSaveLoad) do
 begin
  UserType := slqtKW;
  with AddZone('AttributeSelect', vcm_ztParent, fm_cfAttributeSelect) do
  begin
   UserType := utSingleSearch;
   with AddZone('TreeAttributeSelect', vcm_ztParent, fm_efTreeAttributeSelect) do
   begin
    UserType := astNone;
    OnNeedMakeForm := TreeAttributeSelectParentAstNoneNeedMakeForm;
   end;
   with AddZone('SelectedAttributes', vcm_ztChild, fm_enSelectedAttributes) do
   begin
    UserType := utSelectedAttributes;
    OnNeedMakeForm := SelectedAttributesChildUtSelectedAttributesNeedMakeForm;
   end;
   OnNeedMakeForm := AttributeSelectParentUtSingleSearchNeedMakeForm;
  end;
  OnNeedMakeForm := SaveLoadParentSlqtKWNeedMakeForm;
 end;
 with AddZone('Filters', vcm_ztNavigator, fm_enFilters) do
 begin
  UserType := utFilters;
  OnNeedMakeForm := FiltersNavigatorUtFiltersNeedMakeForm;
 end;
 with AddZone('TreeAttributeFirstLevel', vcm_ztNavigator, fm_efTreeAttributeFirstLevel) do
 begin
  UserType := flSituation;
  ActivateIfUpdate := wafAlways;
  OnNeedMakeForm := TreeAttributeFirstLevelNavigatorFlSituationNeedMakeForm;
 end;
 Caption := str_fsSituationSearchCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_SituationSearch.InitFields

class function Tfs_SituationSearch.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_SituationSearch.GetInstance

initialization
 str_fsSituationSearchCaption.Init;
 {* Инициализация str_fsSituationSearchCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
