unit fsDrugList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsDrugList.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "DrugList" MUID: (4AA4D3F40235)
// Имя типа: "Tfs_DrugList"

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
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 , Common_FormDefinitions_Controls
 , MedicInterfaces
 , l3Interfaces
 , afwInterfaces
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , bsTypes
 , DynamicTreeUnit
 , l3TreeInterfaces
 , DocumentUnit
 , PreviewInterfaces
 , nevTools
 , DocumentInterfaces
 , l3InternalInterfaces
 , FoldersDomainInterfaces
 , FiltersUnit
 , DocumentAndListInterfaces
 , nsTypesNew
 , nsTypes
 , bsTypesNew
 , ListUserTypes_lftDrugList_UserType
 , FiltersUserTypes_utFilters_UserType
 , SimpleListInterfaces
 , ListInfoUserTypes_liListInfo_UserType
 , DocumentUserTypes_dftDrugSynchroView_UserType
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 , BaseDocumentWithAttributesInterfaces
 , BaloonWarningUserTypes_remListModified_UserType
 , nevBase
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
;

type
 Tfs_DrugList = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function SynchroChildMlsfDrugListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Synchro }
   function TextChildDftDrugSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function SynonymsChildLftDrugInternationalNameSynonymsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Synonyms }
   function AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function ListParentLftDrugListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function RemListModifiedChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListModified }
   function RemListFilteredChildRemListFilteredNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListFiltered }
   function RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
   function FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Filters }
   function ListInfoChildLiListInfoNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для ListInfo }
   class function Instance: Tfs_DrugList;
    {* Метод получения экземпляра синглетона Tfs_DrugList }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_DrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA4D3F40235impl_uses*
 //#UC END# *4AA4D3F40235impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_DrugList: Tfs_DrugList = nil;
 {* Экземпляр синглетона Tfs_DrugList }

const
 {* Локализуемые строки DrugListCaptionLocalConstants }
 str_fsDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDrugListCaption'; rValue : 'Список препаратов');
  {* Заголовок фабрики сборки форм "DrugList" }

procedure Tfs_DrugListFree;
 {* Метод освобождения экземпляра синглетона Tfs_DrugList }
begin
 l3Free(g_Tfs_DrugList);
end;//Tfs_DrugListFree

function Tfs_DrugList.SynchroChildMlsfDrugListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Synchro }
var
 l_UseCase : IsdsDrugList;
begin
 if Supports(aDataSource, IsdsDrugList, l_UseCase) then
  try
   aNew := l_UseCase.dsSynchroView;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.SynchroChildMlsfDrugListNeedMakeForm

function Tfs_DrugList.TextChildDftDrugSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsDocument;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.TextChildDftDrugSynchroViewNeedMakeForm

function Tfs_DrugList.SynonymsChildLftDrugInternationalNameSynonymsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Synonyms }
var
 l_UseCase : IsdsBaseDrugDocument;
begin
 if Supports(aDataSource, IsdsBaseDrugDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsDrugInternationalNameSynonims;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.SynonymsChildLftDrugInternationalNameSynonymsSynchroFormNeedMakeForm

function Tfs_DrugList.AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
var
 l_UseCase : IsdsBaseDocumentWithAttributes;
begin
 if Supports(aDataSource, IsdsBaseDocumentWithAttributes, l_UseCase) then
  try
   aNew := l_UseCase.dsAttributes;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.AttributesChildFAttributeSynchroViewNeedMakeForm

function Tfs_DrugList.ListParentLftDrugListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
var
 l_UseCase : IsdsDrugList;
begin
 if Supports(aDataSource, IsdsDrugList, l_UseCase) then
  try
   aNew := l_UseCase.dsDrugList;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.ListParentLftDrugListNeedMakeForm

function Tfs_DrugList.RemListModifiedChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModified }
var
 l_UseCase : IsdsDrugList;
begin
 if Supports(aDataSource, IsdsDrugList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.RemListModifiedChildRemListModifiedNeedMakeForm

function Tfs_DrugList.RemListFilteredChildRemListFilteredNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListFiltered }
var
 l_UseCase : IsdsDrugList;
begin
 if Supports(aDataSource, IsdsDrugList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.RemListFilteredChildRemListFilteredNeedMakeForm

function Tfs_DrugList.RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
var
 l_UseCase : IsdsDrugList;
begin
 if Supports(aDataSource, IsdsDrugList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm

function Tfs_DrugList.FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Filters }
var
 l_UseCase : IsdsDrugList;
begin
 if Supports(aDataSource, IsdsDrugList, l_UseCase) then
  try
   aNew := l_UseCase.dsFilters;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.FiltersNavigatorUtFiltersNeedMakeForm

function Tfs_DrugList.ListInfoChildLiListInfoNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для ListInfo }
var
 l_UseCase : IsdsDrugList;
begin
 if Supports(aDataSource, IsdsDrugList, l_UseCase) then
  try
   aNew := l_UseCase.dsListInfo;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugList.ListInfoChildLiListInfoNeedMakeForm

class function Tfs_DrugList.Instance: Tfs_DrugList;
 {* Метод получения экземпляра синглетона Tfs_DrugList }
begin
 if (g_Tfs_DrugList = nil) then
 begin
  l3System.AddExitProc(Tfs_DrugListFree);
  g_Tfs_DrugList := Create;
 end;
 Result := g_Tfs_DrugList;
end;//Tfs_DrugList.Instance

class function Tfs_DrugList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_DrugList <> nil;
end;//Tfs_DrugList.Exists

procedure Tfs_DrugList.InitFields;
begin
 inherited;
 with AddZone('Synchro', vcm_ztChild, fm_en_MedicListSynchroView) do
 begin
  UserType := mlsfDrugList;
  with AddZone('Text', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftDrugSynchroView;
   OnNeedMakeForm := TextChildDftDrugSynchroViewNeedMakeForm;
  end;
  with AddZone('Synonyms', vcm_ztChild, fm_efList) do
  begin
   UserType := lftDrugInternationalNameSynonymsSynchroForm;
   OnNeedMakeForm := SynonymsChildLftDrugInternationalNameSynonymsSynchroFormNeedMakeForm;
  end;
  with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
  begin
   UserType := fAttributeSynchroView;
   OnNeedMakeForm := AttributesChildFAttributeSynchroViewNeedMakeForm;
  end;
  OnNeedMakeForm := SynchroChildMlsfDrugListNeedMakeForm;
 end;
 with AddZone('List', vcm_ztParent, fm_efList) do
 begin
  UserType := lftDrugList;
  with AddZone('remListModified', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := remListModified;
   OnNeedMakeForm := RemListModifiedChildRemListModifiedNeedMakeForm;
  end;
  with AddZone('remListFiltered', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := remListFiltered;
   OnNeedMakeForm := RemListFilteredChildRemListFilteredNeedMakeForm;
  end;
  with AddZone('remTimeMachineWarning', vcm_ztChild, fm_WarningBaloonForm) do
  begin
   UserType := remTimeMachineWarning;
   OnNeedMakeForm := RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm;
  end;
  OnNeedMakeForm := ListParentLftDrugListNeedMakeForm;
 end;
 with AddZone('Filters', vcm_ztNavigator, fm_enFilters) do
 begin
  UserType := utFilters;
  ActivateIfUpdate := wafAlways;
  OnNeedMakeForm := FiltersNavigatorUtFiltersNeedMakeForm;
 end;
 with AddZone('ListInfo', vcm_ztChild, fm_efListInfo) do
 begin
  UserType := liListInfo;
  OnNeedMakeForm := ListInfoChildLiListInfoNeedMakeForm;
 end;
 Caption := str_fsDrugListCaption.AsCStr;
 OwnerForm := 1;
end;//Tfs_DrugList.InitFields

class function Tfs_DrugList.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_DrugList.GetInstance

initialization
 str_fsDrugListCaption.Init;
 {* Инициализация str_fsDrugListCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
