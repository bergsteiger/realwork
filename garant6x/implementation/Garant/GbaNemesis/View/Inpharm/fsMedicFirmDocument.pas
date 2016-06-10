unit fsMedicFirmDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/fsMedicFirmDocument.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::MedicFirmDocument
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
  DocumentUserTypes_dftMedicFirm_UserType,
  l3StringIDEx,
  ListUserTypes_lftProducedDrugs_UserType,
  AttributesUserTypes_fDocAttribute_UserType,
  Common_FormDefinitions_Controls,
  BaseDocumentWithAttributesInterfaces
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
  nsTypesNew,
  nsTypes,
  DynamicTreeUnit,
  PreviewInterfaces,
  l3InternalInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_MedicFirmDocument = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function TextParentDftMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Text }
   function ListChildLftProducedDrugsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для List }
   function AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Attributes }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_MedicFirmDocument;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_MedicFirmDocument
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


// start class Tfs_MedicFirmDocument

var g_Tfs_MedicFirmDocument : Tfs_MedicFirmDocument = nil;

procedure Tfs_MedicFirmDocumentFree;
begin
 l3Free(g_Tfs_MedicFirmDocument);
end;

class function Tfs_MedicFirmDocument.Instance: Tfs_MedicFirmDocument;
begin
 if (g_Tfs_MedicFirmDocument = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicFirmDocumentFree);
  g_Tfs_MedicFirmDocument := Create;
 end;
 Result := g_Tfs_MedicFirmDocument;
end;

var
    { Локализуемые строки MedicFirmDocumentCaptionLocalConstants }
   str_fsMedicFirmDocumentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmDocumentCaption'; rValue : 'Описание фирмы');
    { Заголовок фабрики сборки форм "MedicFirmDocument" }

// start class Tfs_MedicFirmDocument

function Tfs_MedicFirmDocument.TextParentDftMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_MedicFirmDocument.TextParentDftMedicFirmNeedMakeForm

function Tfs_MedicFirmDocument.ListChildLftProducedDrugsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_MedicFirmDocument.ListChildLftProducedDrugsNeedMakeForm

function Tfs_MedicFirmDocument.AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_MedicFirmDocument.AttributesChildFDocAttributeNeedMakeForm

class function Tfs_MedicFirmDocument.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_MedicFirmDocument <> nil;
end;//Tfs_MedicFirmDocument.Exists

procedure Tfs_MedicFirmDocument.InitFields;
 {-}
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftMedicFirm;
  OnNeedMakeForm := TextParentDftMedicFirmNeedMakeForm;
 end;
 with AddZone('List', vcm_ztChild, fm_efList) do
 begin
  UserType := lftProducedDrugs;
  OnNeedMakeForm := ListChildLftProducedDrugsNeedMakeForm;
 end;
 with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
 begin
  UserType := fDocAttribute;
  OnNeedMakeForm := AttributesChildFDocAttributeNeedMakeForm;
 end;
 Caption := str_fsMedicFirmDocumentCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_MedicFirmDocument.InitFields

{$If not defined(NoVCM)}
class function Tfs_MedicFirmDocument.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_MedicFirmDocument.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsMedicFirmDocumentCaption
 str_fsMedicFirmDocumentCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.