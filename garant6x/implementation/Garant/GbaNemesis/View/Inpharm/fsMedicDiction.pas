unit fsMedicDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/fsMedicDiction.pas"
// Начат: 2008/02/20 13:21:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::MedicDiction
//
// Словарь медицинских терминов
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
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftMedDictEntry_UserType,
  l3StringIDEx,
  AttributesUserTypes_fDocAttribute_UserType,
  PrimCommonDiction_utMedicDiction_UserType,
  Common_FormDefinitions_Controls,
  BaseDocumentWithAttributesInterfaces,
  DictionContainerUserTypes_slqtMedicDiction_UserType,
  F1Like_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  DocumentInterfaces,
  DocumentUnit,
  bsTypesNew,
  DynamicTreeUnit,
  QueryCardInterfaces,
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
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_MedicDiction = {final fsf} class(TvcmFormSetFactory)
   {* Словарь медицинских терминов }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function DictionContainerParentSlqtMedicDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для DictionContainer }
   function EnCommonDictionUtMedicDictionNavigatorUtMedicDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для en_CommonDiction_utMedicDiction }
   function TextFormDftMedDictEntryParentDftMedDictEntryNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для TextForm_dftMedDictEntry }
   function ChildChildNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Child }
   function AttributesFormFDocAttributeChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для AttributesForm_fDocAttribute }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_MedicDiction;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_MedicDiction
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


// start class Tfs_MedicDiction

var g_Tfs_MedicDiction : Tfs_MedicDiction = nil;

procedure Tfs_MedicDictionFree;
begin
 l3Free(g_Tfs_MedicDiction);
end;

class function Tfs_MedicDiction.Instance: Tfs_MedicDiction;
begin
 if (g_Tfs_MedicDiction = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicDictionFree);
  g_Tfs_MedicDiction := Create;
 end;
 Result := g_Tfs_MedicDiction;
end;

var
    { Локализуемые строки MedicDictionCaptionLocalConstants }
   str_fsMedicDictionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicDictionCaption'; rValue : 'Словарь медицинских терминов');
    { Заголовок фабрики сборки форм "MedicDiction" }

// start class Tfs_MedicDiction

function Tfs_MedicDiction.DictionContainerParentSlqtMedicDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCommonDiction;
begin
 if Supports(aDataSource, IsdsCommonDiction, l_UseCase) then
  try
   aNew := l_UseCase.dsSaveLoad;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicDiction.DictionContainerParentSlqtMedicDictionNeedMakeForm

function Tfs_MedicDiction.EnCommonDictionUtMedicDictionNavigatorUtMedicDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCommonDiction;
begin
 if Supports(aDataSource, IsdsCommonDiction, l_UseCase) then
  try
//#UC START# *4D81DA3B0293NeedMake_impl*
   aNew := l_UseCase.dsContents;
//#UC END# *4D81DA3B0293NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicDiction.EnCommonDictionUtMedicDictionNavigatorUtMedicDictionNeedMakeForm

function Tfs_MedicDiction.TextFormDftMedDictEntryParentDftMedDictEntryNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
//#UC START# *4D81D98202EBNeedMake_impl*
   aNew := l_UseCase.dsDocument;
//#UC END# *4D81D98202EBNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicDiction.TextFormDftMedDictEntryParentDftMedDictEntryNeedMakeForm

function Tfs_MedicDiction.ChildChildNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCommonDiction;
begin
 if Supports(aDataSource, IsdsCommonDiction, l_UseCase) then
  try
   aNew := l_UseCase.dsChild;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicDiction.ChildChildNeedMakeForm

function Tfs_MedicDiction.AttributesFormFDocAttributeChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocumentWithAttributes;
begin
 if Supports(aDataSource, IsdsBaseDocumentWithAttributes, l_UseCase) then
  try
//#UC START# *4D81DAB70277NeedMake_impl*
   aNew := l_UseCase.dsAttributes;
//#UC END# *4D81DAB70277NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicDiction.AttributesFormFDocAttributeChildFDocAttributeNeedMakeForm

class function Tfs_MedicDiction.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_MedicDiction <> nil;
end;//Tfs_MedicDiction.Exists

procedure Tfs_MedicDiction.InitFields;
 {-}
begin
 inherited;
 with AddZone('DictionContainer', vcm_ztParent, fm_DictionContainerForm) do
 begin
  UserType := slqtMedicDiction;
  with AddZone('en_CommonDiction_utMedicDiction', vcm_ztNavigator, fm_en_CommonDiction) do
  begin
   UserType := utMedicDiction;
   ActivateIfUpdate := wafAlways;
   OnNeedMakeForm := EnCommonDictionUtMedicDictionNavigatorUtMedicDictionNeedMakeForm;
  end;
  with AddZone('TextForm_dftMedDictEntry', vcm_ztParent, fm_TextForm) do
  begin
   UserType := dftMedDictEntry;
   OnNeedMakeForm := TextFormDftMedDictEntryParentDftMedDictEntryNeedMakeForm;
  end;
  with AddZone('Child', vcm_ztChild, fm_ChildForm) do
  begin
   UserType := 0;
   with AddZone('AttributesForm_fDocAttribute', vcm_ztChild, fm_AttributesForm) do
   begin
    UserType := fDocAttribute;
    OnNeedMakeForm := AttributesFormFDocAttributeChildFDocAttributeNeedMakeForm;
   end;
   OnNeedMakeForm := ChildChildNeedMakeForm;
  end;
  OnNeedMakeForm := DictionContainerParentSlqtMedicDictionNeedMakeForm;
 end;
 Caption := str_fsMedicDictionCaption.AsCStr;
 OwnerForm := 0;
 DefaultStatusForm := 1;
end;//Tfs_MedicDiction.InitFields

{$If not defined(NoVCM)}
class function Tfs_MedicDiction.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_MedicDiction.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsMedicDictionCaption
 str_fsMedicDictionCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.