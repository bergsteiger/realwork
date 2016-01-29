unit fsDrugDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/fsDrugDocument.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::DrugDocument
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
  DocumentUserTypes_dftDrug_UserType,
  l3StringIDEx,
  ListUserTypes_lftDrugInternationalNameSynonyms_UserType,
  AttributesUserTypes_fDocAttribute_UserType,
  ContentsUserTypes_utDrugContents_UserType,
  Common_FormDefinitions_Controls,
  WorkWithDocumentInterfaces,
  BaseDocumentWithAttributesInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  DocumentInterfaces,
  DocumentUnit,
  bsTypesNew,
  nevTools,
  bsTypes,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3Interfaces,
  l3InternalInterfaces,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  F1TagDataProviderInterface,
  nsTypesNew,
  DynamicDocListUnit,
  PrimPrimListInterfaces,
  FiltersUnit,
  nsTypes,
  DynamicTreeUnit,
  PreviewInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_DrugDocument = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function TextParentDftDrugNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Text }
   function AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Attributes }
   function ContentsNavigatorUtDrugContentsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Contents }
   function SynonymsChildLftDrugInternationalNameSynonymsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Synonyms }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_DrugDocument;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_DrugDocument
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


// start class Tfs_DrugDocument

var g_Tfs_DrugDocument : Tfs_DrugDocument = nil;

procedure Tfs_DrugDocumentFree;
begin
 l3Free(g_Tfs_DrugDocument);
end;

class function Tfs_DrugDocument.Instance: Tfs_DrugDocument;
begin
 if (g_Tfs_DrugDocument = nil) then
 begin
  l3System.AddExitProc(Tfs_DrugDocumentFree);
  g_Tfs_DrugDocument := Create;
 end;
 Result := g_Tfs_DrugDocument;
end;

var
    { Локализуемые строки DrugDocumentCaptionLocalConstants }
   str_fsDrugDocumentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDrugDocumentCaption'; rValue : 'Препарат');
    { Заголовок фабрики сборки форм "DrugDocument" }

// start class Tfs_DrugDocument

function Tfs_DrugDocument.TextParentDftDrugNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
//#UC START# *4FFB02470382NeedMake_impl*
 aNew := l_UseCase.dsDocument;
//#UC END# *4FFB02470382NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugDocument.TextParentDftDrugNeedMakeForm

function Tfs_DrugDocument.AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocumentWithAttributes;
begin
 if Supports(aDataSource, IsdsBaseDocumentWithAttributes, l_UseCase) then
  try
//#UC START# *4FFB028A009FNeedMake_impl*
 aNew := l_UseCase.dsAttributes;
//#UC END# *4FFB028A009FNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugDocument.AttributesChildFDocAttributeNeedMakeForm

function Tfs_DrugDocument.ContentsNavigatorUtDrugContentsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IucpDocumentWithContents;
begin
 if Supports(aDataSource, IucpDocumentWithContents, l_UseCase) then
  try
//#UC START# *4FFB02B80287NeedMake_impl*
 aNew := l_UseCase.dsContents;
//#UC END# *4FFB02B80287NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugDocument.ContentsNavigatorUtDrugContentsNeedMakeForm

function Tfs_DrugDocument.SynonymsChildLftDrugInternationalNameSynonymsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDrugDocument;
begin
 if Supports(aDataSource, IsdsBaseDrugDocument, l_UseCase) then
  try
//#UC START# *4FFB033F01E9NeedMake_impl*
 aNew := l_UseCase.dsDrugInternationalNameSynonims;
//#UC END# *4FFB033F01E9NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DrugDocument.SynonymsChildLftDrugInternationalNameSynonymsNeedMakeForm

class function Tfs_DrugDocument.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_DrugDocument <> nil;
end;//Tfs_DrugDocument.Exists

procedure Tfs_DrugDocument.InitFields;
 {-}
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftDrug;
  OnNeedMakeForm := TextParentDftDrugNeedMakeForm;
 end;
 with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
 begin
  UserType := fDocAttribute;
  OnNeedMakeForm := AttributesChildFDocAttributeNeedMakeForm;
 end;
 with AddZone('Contents', vcm_ztNavigator, fm_ContentsForm) do
 begin
  UserType := utDrugContents;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := ContentsNavigatorUtDrugContentsNeedMakeForm;
 end;
 with AddZone('Synonyms', vcm_ztChild, fm_efList) do
 begin
  UserType := lftDrugInternationalNameSynonyms;
  OnNeedMakeForm := SynonymsChildLftDrugInternationalNameSynonymsNeedMakeForm;
 end;
 Caption := str_fsDrugDocumentCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_DrugDocument.InitFields

{$If not defined(NoVCM)}
class function Tfs_DrugDocument.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_DrugDocument.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsDrugDocumentCaption
 str_fsDrugDocumentCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.