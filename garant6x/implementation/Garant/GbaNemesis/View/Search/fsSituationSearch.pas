unit fsSituationSearch;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/fsSituationSearch.pas"
// Начат: 2005/08/02 12:31:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Основные прецеденты::Search::View::Search::Search::SituationSearch
//
// ППС 6.х
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  QueryCardInterfaces,
  l3StringIDEx,
  PrimSaveLoadUserTypes_slqtKW_UserType,
  PrimAttributeSelect_utSingleSearch_UserType,
  PrimTreeAttributeSelect_astNone_UserType,
  PrimTreeAttributeFirstLevel_flSituation_UserType,
  FiltersUserTypes_utFilters_UserType,
  Common_FormDefinitions_Controls,
  Search_FormDefinitions_Controls,
  PrimSelectedAttributes_utSelectedAttributes_UserType,
  SearchLite_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  SimpleListInterfaces {a},
  SearchInterfaces {a},
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_SituationSearch = {final fsf} class(TvcmFormSetFactory)
   {* ППС 6.х }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
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
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_SituationSearch;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_SituationSearch
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_SituationSearch

var g_Tfs_SituationSearch : Tfs_SituationSearch = nil;

procedure Tfs_SituationSearchFree;
begin
 l3Free(g_Tfs_SituationSearch);
end;

class function Tfs_SituationSearch.Instance: Tfs_SituationSearch;
begin
 if (g_Tfs_SituationSearch = nil) then
 begin
  l3System.AddExitProc(Tfs_SituationSearchFree);
  g_Tfs_SituationSearch := Create;
 end;
 Result := g_Tfs_SituationSearch;
end;

var
    { Локализуемые строки SituationSearchCaptionLocalConstants }
   str_fsSituationSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSituationSearchCaption'; rValue : 'ППС 6.х');
    { Заголовок фабрики сборки форм "SituationSearch" }

// start class Tfs_SituationSearch

function Tfs_SituationSearch.SaveLoadParentSlqtKWNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
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

class function Tfs_SituationSearch.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_SituationSearch <> nil;
end;//Tfs_SituationSearch.Exists

procedure Tfs_SituationSearch.InitFields;
 {-}
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

{$If not defined(NoVCM)}
class function Tfs_SituationSearch.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_SituationSearch.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsSituationSearchCaption
 str_fsSituationSearchCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.