unit fsSituationFilter;
 {* Фильтр ППС }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsSituationFilter.pas"
// Стереотип: "VCMFormSetFactory"

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
 // efTreeAttributeSelect_astNone

 // enSelectedAttributes_utSelectedAttributes

 // cfAttributeSelect_utSingleSearch

 // cfSaveLoad_slqtFilters

 Tfs_SituationFilter = {final} class(TvcmFormSetFactory)
  {* Фильтр ППС }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function cfSaveLoad_slqtFilters_Modal_slqtFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для cfSaveLoad_slqtFilters }
   function cfAttributeSelect_utSingleSearch_Parent_utSingleSearch_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для cfAttributeSelect_utSingleSearch }
   function efTreeAttributeSelect_astNone_Parent_astNone_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для efTreeAttributeSelect_astNone }
   function enSelectedAttributes_utSelectedAttributes_Child_utSelectedAttributes_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для enSelectedAttributes_utSelectedAttributes }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_SituationFilter;
    {* Метод получения экземпляра синглетона Tfs_SituationFilter }
 end;//Tfs_SituationFilter
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
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

function Tfs_SituationFilter.cfSaveLoad_slqtFilters_Modal_slqtFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для cfSaveLoad_slqtFilters }
//#UC START# *FDEBC9EA7063_4AA7A4E3032E_var*
//#UC END# *FDEBC9EA7063_4AA7A4E3032E_var*
begin
//#UC START# *FDEBC9EA7063_4AA7A4E3032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *FDEBC9EA7063_4AA7A4E3032E_impl*
end;//Tfs_SituationFilter.cfSaveLoad_slqtFilters_Modal_slqtFilters_NeedMakeForm

function Tfs_SituationFilter.cfAttributeSelect_utSingleSearch_Parent_utSingleSearch_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для cfAttributeSelect_utSingleSearch }
//#UC START# *842ABD7395D7_4AA7A4E3032E_var*
//#UC END# *842ABD7395D7_4AA7A4E3032E_var*
begin
//#UC START# *842ABD7395D7_4AA7A4E3032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *842ABD7395D7_4AA7A4E3032E_impl*
end;//Tfs_SituationFilter.cfAttributeSelect_utSingleSearch_Parent_utSingleSearch_NeedMakeForm

function Tfs_SituationFilter.efTreeAttributeSelect_astNone_Parent_astNone_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для efTreeAttributeSelect_astNone }
//#UC START# *E8A4848313E4_4AA7A4E3032E_var*
//#UC END# *E8A4848313E4_4AA7A4E3032E_var*
begin
//#UC START# *E8A4848313E4_4AA7A4E3032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *E8A4848313E4_4AA7A4E3032E_impl*
end;//Tfs_SituationFilter.efTreeAttributeSelect_astNone_Parent_astNone_NeedMakeForm

function Tfs_SituationFilter.enSelectedAttributes_utSelectedAttributes_Child_utSelectedAttributes_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для enSelectedAttributes_utSelectedAttributes }
//#UC START# *D3C8F83B0BBB_4AA7A4E3032E_var*
//#UC END# *D3C8F83B0BBB_4AA7A4E3032E_var*
begin
//#UC START# *D3C8F83B0BBB_4AA7A4E3032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *D3C8F83B0BBB_4AA7A4E3032E_impl*
end;//Tfs_SituationFilter.enSelectedAttributes_utSelectedAttributes_Child_utSelectedAttributes_NeedMakeForm

class function Tfs_SituationFilter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_SituationFilter <> nil;
end;//Tfs_SituationFilter.Exists

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

procedure Tfs_SituationFilter.InitFields;
//#UC START# *47A042E100E2_4AA7A4E3032E_var*
//#UC END# *47A042E100E2_4AA7A4E3032E_var*
begin
//#UC START# *47A042E100E2_4AA7A4E3032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA7A4E3032E_impl*
end;//Tfs_SituationFilter.InitFields

class function Tfs_SituationFilter.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA7A4E3032E_var*
//#UC END# *4FFE854A009B_4AA7A4E3032E_var*
begin
//#UC START# *4FFE854A009B_4AA7A4E3032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA7A4E3032E_impl*
end;//Tfs_SituationFilter.GetInstance

initialization
 str_fsSituationFilterCaption.Init;
 {* Инициализация str_fsSituationFilterCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
