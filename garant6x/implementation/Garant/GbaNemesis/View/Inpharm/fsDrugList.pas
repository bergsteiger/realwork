unit fsDrugList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/fsDrugList.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::DrugList
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
  ,
  DocumentAndListInterfaces,
  MedicInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftDrugSynchroView_UserType,
  l3StringIDEx,
  ListUserTypes_lftDrugList_UserType,
  ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType,
  ListInfoUserTypes_liListInfo_UserType,
  AttributesUserTypes_fAttributeSynchroView_UserType,
  PrimMedicListSynchroView_mlsfDrugList_UserType,
  FiltersUserTypes_utFilters_UserType,
  Common_FormDefinitions_Controls,
  BaseDocumentWithAttributesInterfaces,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  nevTools,
  DocumentInterfaces,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3Interfaces,
  DynamicDocListUnit,
  PrimPrimListInterfaces,
  l3TreeInterfaces,
  FiltersUnit,
  nsTypes,
  DynamicTreeUnit,
  PreviewInterfaces,
  l3InternalInterfaces,
  nevBase,
  SimpleListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_DrugList = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
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
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_DrugList;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_DrugList
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


// start class Tfs_DrugList

var g_Tfs_DrugList : Tfs_DrugList = nil;

procedure Tfs_DrugListFree;
begin
 l3Free(g_Tfs_DrugList);
end;

class function Tfs_DrugList.Instance: Tfs_DrugList;
begin
 if (g_Tfs_DrugList = nil) then
 begin
  l3System.AddExitProc(Tfs_DrugListFree);
  g_Tfs_DrugList := Create;
 end;
 Result := g_Tfs_DrugList;
end;

var
    { Локализуемые строки DrugListCaptionLocalConstants }
   str_fsDrugListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDrugListCaption'; rValue : 'Список препаратов');
    { Заголовок фабрики сборки форм "DrugList" }

// start class Tfs_DrugList

function Tfs_DrugList.SynchroChildMlsfDrugListNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
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

class function Tfs_DrugList.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_DrugList <> nil;
end;//Tfs_DrugList.Exists

procedure Tfs_DrugList.InitFields;
 {-}
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

{$If not defined(NoVCM)}
class function Tfs_DrugList.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_DrugList.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsDrugListCaption
 str_fsDrugListCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.