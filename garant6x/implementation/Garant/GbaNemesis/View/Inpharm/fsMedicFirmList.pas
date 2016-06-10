unit fsMedicFirmList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/fsMedicFirmList.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::MedicFirmList
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
  DocumentUserTypes_dftMedicFirmSynchroView_UserType,
  l3StringIDEx,
  ListUserTypes_lftProducedDrugsSynchroForm_UserType,
  AttributesUserTypes_fAttributeSynchroView_UserType,
  PrimMedicListSynchroView_mlsfMedicFirm_UserType,
  PrimMedicFirmList_mflMain_UserType,
  Common_FormDefinitions_Controls,
  BaseDocumentWithAttributesInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  l3InternalInterfaces,
  l3TreeInterfaces,
  DocumentInterfaces,
  PreviewInterfaces,
  l3Interfaces,
  nsTypesNew
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  nevTools,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  afwInterfaces,
  FoldersDomainInterfaces,
  DynamicDocListUnit,
  PrimPrimListInterfaces,
  FiltersUnit,
  nsTypes,
  DynamicTreeUnit
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_MedicFirmList = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function MedicFirmListParentMflMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для MedicFirmList }
   function MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для MedicListSynchroView }
   function TextChildDftMedicFirmSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Text }
   function ListChildLftProducedDrugsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для List }
   function AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Attributes }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_MedicFirmList;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_MedicFirmList
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


// start class Tfs_MedicFirmList

var g_Tfs_MedicFirmList : Tfs_MedicFirmList = nil;

procedure Tfs_MedicFirmListFree;
begin
 l3Free(g_Tfs_MedicFirmList);
end;

class function Tfs_MedicFirmList.Instance: Tfs_MedicFirmList;
begin
 if (g_Tfs_MedicFirmList = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicFirmListFree);
  g_Tfs_MedicFirmList := Create;
 end;
 Result := g_Tfs_MedicFirmList;
end;

var
    { Локализуемые строки MedicFirmListCaptionLocalConstants }
   str_fsMedicFirmListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmListCaption'; rValue : 'Фармацевтические фирмы');
    { Заголовок фабрики сборки форм "MedicFirmList" }

// start class Tfs_MedicFirmList

function Tfs_MedicFirmList.MedicFirmListParentMflMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsMedicFirmList;
begin
 if Supports(aDataSource, IsdsMedicFirmList, l_UseCase) then
  try
   aNew := l_UseCase.dsFirmList;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicFirmList.MedicFirmListParentMflMainNeedMakeForm

function Tfs_MedicFirmList.MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsMedicFirmList;
begin
 if Supports(aDataSource, IsdsMedicFirmList, l_UseCase) then
  try
   aNew := l_UseCase.dsSynchroView;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicFirmList.MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm

function Tfs_MedicFirmList.TextChildDftMedicFirmSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_MedicFirmList.TextChildDftMedicFirmSynchroViewNeedMakeForm

function Tfs_MedicFirmList.ListChildLftProducedDrugsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsMedicFirmDocumentPrim;
begin
 if Supports(aDataSource, IsdsMedicFirmDocumentPrim, l_UseCase) then
  try
   aNew := l_UseCase.dsDrugList;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicFirmList.ListChildLftProducedDrugsSynchroFormNeedMakeForm

function Tfs_MedicFirmList.AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_MedicFirmList.AttributesChildFAttributeSynchroViewNeedMakeForm

class function Tfs_MedicFirmList.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_MedicFirmList <> nil;
end;//Tfs_MedicFirmList.Exists

procedure Tfs_MedicFirmList.InitFields;
 {-}
begin
 inherited;
 with AddZone('MedicFirmList', vcm_ztParent, fm_en_MedicFirmList) do
 begin
  UserType := mflMain;
  OnNeedMakeForm := MedicFirmListParentMflMainNeedMakeForm;
 end;
 with AddZone('MedicListSynchroView', vcm_ztChild, fm_en_MedicListSynchroView) do
 begin
  UserType := mlsfMedicFirm;
  with AddZone('Text', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftMedicFirmSynchroView;
   OnNeedMakeForm := TextChildDftMedicFirmSynchroViewNeedMakeForm;
  end;
  with AddZone('List', vcm_ztChild, fm_efList) do
  begin
   UserType := lftProducedDrugsSynchroForm;
   OnNeedMakeForm := ListChildLftProducedDrugsSynchroFormNeedMakeForm;
  end;
  with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
  begin
   UserType := fAttributeSynchroView;
   OnNeedMakeForm := AttributesChildFAttributeSynchroViewNeedMakeForm;
  end;
  OnNeedMakeForm := MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm;
 end;
 Caption := str_fsMedicFirmListCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_MedicFirmList.InitFields

{$If not defined(NoVCM)}
class function Tfs_MedicFirmList.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_MedicFirmList.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsMedicFirmListCaption
 str_fsMedicFirmListCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.