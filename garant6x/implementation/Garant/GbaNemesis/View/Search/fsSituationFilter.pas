unit fsSituationFilter;
 {* Фильтр ППС }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsSituationFilter.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "SituationFilter" MUID: (4AA7A4E3032E)
// Имя типа: "Tfs_SituationFilter"

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
 , PrimSaveLoadUserTypes_slqtFilters_UserType
 , Search_FormDefinitions_Controls
 , QueryCardInterfaces
 , SearchInterfaces
 , SimpleListInterfaces
 , l3TreeInterfaces
 , PrimAttributeSelect_utSingleSearch_UserType
 , SearchLite_FormDefinitions_Controls
 , PrimTreeAttributeSelect_astNone_UserType
 , PrimSelectedAttributes_utSelectedAttributes_UserType
;

type
 Tfs_SituationFilter = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Фильтр ППС }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
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
   class function Instance: Tfs_SituationFilter;
    {* Метод получения экземпляра синглетона Tfs_SituationFilter }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_SituationFilter
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA7A4E3032Eimpl_uses*
 //#UC END# *4AA7A4E3032Eimpl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_SituationFilter: Tfs_SituationFilter = nil;
 {* Экземпляр синглетона Tfs_SituationFilter }

const
 {* Локализуемые строки SituationFilterCaptionLocalConstants }
 str_fsSituationFilterCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSituationFilterCaption'; rValue : 'Фильтр ППС');
  {* Заголовок фабрики сборки форм "SituationFilter" }

procedure Tfs_SituationFilterFree;
 {* Метод освобождения экземпляра синглетона Tfs_SituationFilter }
begin
 l3Free(g_Tfs_SituationFilter);
end;//Tfs_SituationFilterFree

function Tfs_SituationFilter.CfSaveLoadSlqtFiltersModalSlqtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для cfSaveLoad_slqtFilters }
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
 {* Обработчик OnNeedMakeForm для cfAttributeSelect_utSingleSearch }
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
 {* Обработчик OnNeedMakeForm для efTreeAttributeSelect_astNone }
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
 {* Обработчик OnNeedMakeForm для enSelectedAttributes_utSelectedAttributes }
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

class function Tfs_SituationFilter.Instance: Tfs_SituationFilter;
 {* Метод получения экземпляра синглетона Tfs_SituationFilter }
begin
 if (g_Tfs_SituationFilter = nil) then
 begin
  l3System.AddExitProc(Tfs_SituationFilterFree);
  g_Tfs_SituationFilter := Create;
 end;
 Result := g_Tfs_SituationFilter;
end;//Tfs_SituationFilter.Instance

class function Tfs_SituationFilter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_SituationFilter <> nil;
end;//Tfs_SituationFilter.Exists

procedure Tfs_SituationFilter.InitFields;
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

class function Tfs_SituationFilter.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_SituationFilter.GetInstance

initialization
 str_fsSituationFilterCaption.Init;
 {* Инициализация str_fsSituationFilterCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
