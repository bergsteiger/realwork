unit fsSituationSearch;
 {* ��� 6.� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsSituationSearch.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "SituationSearch" MUID: (4AA7A4D603C1)
// ��� ����: "Tfs_SituationSearch"

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
 // TreeAttributeSelect

 // SelectedAttributes

 // AttributeSelect

 // SaveLoad

 // Filters

 // TreeAttributeFirstLevel

 Tfs_SituationSearch = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ��� 6.� }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function SaveLoad_Parent_slqtKW_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� SaveLoad }
   function AttributeSelect_Parent_utSingleSearch_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� AttributeSelect }
   function TreeAttributeSelect_Parent_astNone_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� TreeAttributeSelect }
   function SelectedAttributes_Child_utSelectedAttributes_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� SelectedAttributes }
   function Filters_Navigator_utFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Filters }
   function TreeAttributeFirstLevel_Navigator_flSituation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� TreeAttributeFirstLevel }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: Tfs_SituationSearch;
    {* ����� ��������� ���������� ���������� Tfs_SituationSearch }
 end;//Tfs_SituationSearch
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
var g_Tfs_SituationSearch: Tfs_SituationSearch = nil;
 {* ��������� ���������� Tfs_SituationSearch }

const
 {* ������������ ������ SituationSearchCaptionLocalConstants }
 str_fsSituationSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSituationSearchCaption'; rValue : '��� 6.�');
  {* ��������� ������� ������ ���� "SituationSearch" }

procedure Tfs_SituationSearchFree;
 {* ����� ������������ ���������� ���������� Tfs_SituationSearch }
begin
 l3Free(g_Tfs_SituationSearch);
end;//Tfs_SituationSearchFree

function Tfs_SituationSearch.SaveLoad_Parent_slqtKW_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� SaveLoad }
//#UC START# *7A6AB8EF02DB_4AA7A4D603C1_var*
//#UC END# *7A6AB8EF02DB_4AA7A4D603C1_var*
begin
//#UC START# *7A6AB8EF02DB_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A6AB8EF02DB_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.SaveLoad_Parent_slqtKW_NeedMakeForm

function Tfs_SituationSearch.AttributeSelect_Parent_utSingleSearch_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� AttributeSelect }
//#UC START# *2A5749137FD5_4AA7A4D603C1_var*
//#UC END# *2A5749137FD5_4AA7A4D603C1_var*
begin
//#UC START# *2A5749137FD5_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A5749137FD5_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.AttributeSelect_Parent_utSingleSearch_NeedMakeForm

function Tfs_SituationSearch.TreeAttributeSelect_Parent_astNone_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� TreeAttributeSelect }
//#UC START# *48E96E731318_4AA7A4D603C1_var*
//#UC END# *48E96E731318_4AA7A4D603C1_var*
begin
//#UC START# *48E96E731318_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E96E731318_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.TreeAttributeSelect_Parent_astNone_NeedMakeForm

function Tfs_SituationSearch.SelectedAttributes_Child_utSelectedAttributes_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� SelectedAttributes }
//#UC START# *F8D574D4A3A6_4AA7A4D603C1_var*
//#UC END# *F8D574D4A3A6_4AA7A4D603C1_var*
begin
//#UC START# *F8D574D4A3A6_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8D574D4A3A6_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.SelectedAttributes_Child_utSelectedAttributes_NeedMakeForm

function Tfs_SituationSearch.Filters_Navigator_utFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Filters }
//#UC START# *11B9DE933AA8_4AA7A4D603C1_var*
//#UC END# *11B9DE933AA8_4AA7A4D603C1_var*
begin
//#UC START# *11B9DE933AA8_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *11B9DE933AA8_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.Filters_Navigator_utFilters_NeedMakeForm

function Tfs_SituationSearch.TreeAttributeFirstLevel_Navigator_flSituation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� TreeAttributeFirstLevel }
//#UC START# *DCED9C04F161_4AA7A4D603C1_var*
//#UC END# *DCED9C04F161_4AA7A4D603C1_var*
begin
//#UC START# *DCED9C04F161_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *DCED9C04F161_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.TreeAttributeFirstLevel_Navigator_flSituation_NeedMakeForm

class function Tfs_SituationSearch.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_SituationSearch <> nil;
end;//Tfs_SituationSearch.Exists

class function Tfs_SituationSearch.Instance: Tfs_SituationSearch;
 {* ����� ��������� ���������� ���������� Tfs_SituationSearch }
begin
 if (g_Tfs_SituationSearch = nil) then
 begin
  l3System.AddExitProc(Tfs_SituationSearchFree);
  g_Tfs_SituationSearch := Create;
 end;
 Result := g_Tfs_SituationSearch;
end;//Tfs_SituationSearch.Instance

procedure Tfs_SituationSearch.InitFields;
//#UC START# *47A042E100E2_4AA7A4D603C1_var*
//#UC END# *47A042E100E2_4AA7A4D603C1_var*
begin
//#UC START# *47A042E100E2_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.InitFields

class function Tfs_SituationSearch.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA7A4D603C1_var*
//#UC END# *4FFE854A009B_4AA7A4D603C1_var*
begin
//#UC START# *4FFE854A009B_4AA7A4D603C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA7A4D603C1_impl*
end;//Tfs_SituationSearch.GetInstance

initialization
 str_fsSituationSearchCaption.Init;
 {* ������������� str_fsSituationSearchCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
