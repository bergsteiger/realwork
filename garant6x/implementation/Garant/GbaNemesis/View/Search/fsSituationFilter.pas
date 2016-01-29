unit fsSituationFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/fsSituationFilter.pas"
// Начат: 08.09.2009 15:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Основные прецеденты::Search::View::Search::Search::SituationFilter
//
// Фильтр ППС
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
  PrimSaveLoadUserTypes_slqtFilters_UserType,
  PrimAttributeSelect_utSingleSearch_UserType,
  PrimTreeAttributeSelect_astNone_UserType,
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
  Tfs_SituationFilter = {final fsf} class(TvcmFormSetFactory)
   {* Фильтр ППС }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function CfSaveLoadSlqtFiltersModalSlqtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для cfSaveLoad_slqtFilters }
   function CfAttributeSelectUtSingleSearchParentUtSingleSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для cfAttributeSelect_utSingleSearch }
   function EfTreeAttributeSelectAstNoneParentAstNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для efTreeAttributeSelect_astNone }
   function EnSelectedAttributesUtSelectedAttributesChildUtSelectedAttributesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для enSelectedAttributes_utSelectedAttributes }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_SituationFilter;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_SituationFilter
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


// start class Tfs_SituationFilter

var g_Tfs_SituationFilter : Tfs_SituationFilter = nil;

procedure Tfs_SituationFilterFree;
begin
 l3Free(g_Tfs_SituationFilter);
end;

class function Tfs_SituationFilter.Instance: Tfs_SituationFilter;
begin
 if (g_Tfs_SituationFilter = nil) then
 begin
  l3System.AddExitProc(Tfs_SituationFilterFree);
  g_Tfs_SituationFilter := Create;
 end;
 Result := g_Tfs_SituationFilter;
end;

var
    { Локализуемые строки SituationFilterCaptionLocalConstants }
   str_fsSituationFilterCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSituationFilterCaption'; rValue : 'Фильтр ППС');
    { Заголовок фабрики сборки форм "SituationFilter" }

// start class Tfs_SituationFilter

function Tfs_SituationFilter.CfSaveLoadSlqtFiltersModalSlqtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
//#UC START# *4D80F0E80360NeedMake_impl*
   aNew := l_UseCase.dsSaveLoad;
//#UC END# *4D80F0E80360NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationFilter.CfSaveLoadSlqtFiltersModalSlqtFiltersNeedMakeForm

function Tfs_SituationFilter.CfAttributeSelectUtSingleSearchParentUtSingleSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
//#UC START# *4D80F2B30142NeedMake_impl*
   aNew := l_UseCase.dsSelectedAttributes;
//#UC END# *4D80F2B30142NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationFilter.CfAttributeSelectUtSingleSearchParentUtSingleSearchNeedMakeForm

function Tfs_SituationFilter.EfTreeAttributeSelectAstNoneParentAstNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
//#UC START# *4D80F31E0351NeedMake_impl*
   aNew := l_UseCase.dsTreeAttributeSelect;
//#UC END# *4D80F31E0351NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationFilter.EfTreeAttributeSelectAstNoneParentAstNoneNeedMakeForm

function Tfs_SituationFilter.EnSelectedAttributesUtSelectedAttributesChildUtSelectedAttributesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsSituation;
begin
 if Supports(aDataSource, IsdsSituation, l_UseCase) then
  try
//#UC START# *4D80F6EF005ENeedMake_impl*
   aNew := l_UseCase.dsTreeAttributeSelect;
//#UC END# *4D80F6EF005ENeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SituationFilter.EnSelectedAttributesUtSelectedAttributesChildUtSelectedAttributesNeedMakeForm

class function Tfs_SituationFilter.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_SituationFilter <> nil;
end;//Tfs_SituationFilter.Exists

procedure Tfs_SituationFilter.InitFields;
 {-}
begin
 inherited;
 with AddZone('cfSaveLoad_slqtFilters', vcm_ztModal, fm_cfSaveLoad) do
 begin
  UserType := slqtFilters;
  with AddZone('cfAttributeSelect_utSingleSearch', vcm_ztParent, fm_cfAttributeSelect) do
  begin
   UserType := utSingleSearch;
   with AddZone('efTreeAttributeSelect_astNone', vcm_ztParent, fm_efTreeAttributeSelect) do
   begin
    UserType := astNone;
    OnNeedMakeForm := EfTreeAttributeSelectAstNoneParentAstNoneNeedMakeForm;
   end;
   with AddZone('enSelectedAttributes_utSelectedAttributes', vcm_ztChild, fm_enSelectedAttributes) do
   begin
    UserType := utSelectedAttributes;
    OnNeedMakeForm := EnSelectedAttributesUtSelectedAttributesChildUtSelectedAttributesNeedMakeForm;
   end;
   OnNeedMakeForm := CfAttributeSelectUtSingleSearchParentUtSingleSearchNeedMakeForm;
  end;
  OnNeedMakeForm := CfSaveLoadSlqtFiltersModalSlqtFiltersNeedMakeForm;
 end;
 Caption := str_fsSituationFilterCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_SituationFilter.InitFields

{$If not defined(NoVCM)}
class function Tfs_SituationFilter.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_SituationFilter.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsSituationFilterCaption
 str_fsSituationFilterCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.