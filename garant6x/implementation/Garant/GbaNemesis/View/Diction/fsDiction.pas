unit fsDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/fsDiction.pas"
// Начат: 2005/10/05 14:28:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::Diction::View::Diction::Diction$FP::Diction$FS
//
// Сборка форм толкового словаря
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
  l3Interfaces
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
  DictionInterfaces,
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftDictEntry_UserType,
  DocumentUserTypes_dftDictSubEntry_UserType,
  l3StringIDEx,
  AttributesUserTypes_fDocAttribute_UserType,
  PrimDiction_utDiction_UserType,
  Common_FormDefinitions_Controls,
  BaseDocumentWithAttributesInterfaces,
  DictionContainerUserTypes_slqtDiction_UserType,
  PrimChild_cutForDiction_UserType,
  F1Like_FormDefinitions_Controls
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
  l3InternalInterfaces,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  DictionInterfacesPrim,
  DynamicTreeUnit,
  QueryCardInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_Diction = {final fsf} class(TvcmFormSetFactory)
   {* Сборка форм толкового словаря }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function DictionContainerParentSlqtDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для DictionContainer }
   function DictEntryParentDftDictEntryNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для DictEntry }
   function DictionNavigatorUtDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Diction }
   function ChildChildCutForDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Child }
   function DictSubEntryChildDftDictSubEntryNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для DictSubEntry }
   procedure DictSubEntryChildDftDictSubEntryGetFormCount(const aDataSource: IvcmFormSetDataSource;
      out aCount: Integer);
     {* Обработчик OnFormCount для DictSubEntry }
   function AttributeChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Attribute }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
   procedure DoGetMainImageIndex(aSender: TObject;
     const aDataSource: IvcmFormSetDataSource;
     var aImageIndex: Integer);
     {* Обработчик OnGetMainImageIndex для Diction$FS }
   procedure DoGetMainCaption(aSender: TObject;
     const aDataSource: IvcmFormSetDataSource;
     var aCaption: Il3CString);
     {* Обработчик GetMainCaption для Diction$FS }
  public
  // singleton factory method
    class function Instance: Tfs_Diction;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_Diction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  bsUtils,
  SysUtils,
  nsDocumentTools,
  l3String,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_Diction

var g_Tfs_Diction : Tfs_Diction = nil;

procedure Tfs_DictionFree;
begin
 l3Free(g_Tfs_Diction);
end;

class function Tfs_Diction.Instance: Tfs_Diction;
begin
 if (g_Tfs_Diction = nil) then
 begin
  l3System.AddExitProc(Tfs_DictionFree);
  g_Tfs_Diction := Create;
 end;
 Result := g_Tfs_Diction;
end;

var
    { Локализуемые строки Tab consts }
   str_DictionFormSetCaptionPrefix : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DictionFormSetCaptionPrefix'; rValue : 'Текст словарной статьи');
    { 'Текст словарной статьи' }

var
    { Локализуемые строки Diction$FSCaptionLocalConstants }
   str_fsDictionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDictionCaption'; rValue : 'Толковый словарь');
    { Заголовок фабрики сборки форм "Diction$FS" }

// start class Tfs_Diction

function Tfs_Diction.DictionContainerParentSlqtDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_Diction.DictionContainerParentSlqtDictionNeedMakeForm

function Tfs_Diction.DictEntryParentDftDictEntryNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_Diction.DictEntryParentDftDictEntryNeedMakeForm

function Tfs_Diction.DictionNavigatorUtDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsCommonDiction;
begin
 if Supports(aDataSource, IsdsCommonDiction, l_UseCase) then
  try
   aNew := l_UseCase.dsContents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Diction.DictionNavigatorUtDictionNeedMakeForm

function Tfs_Diction.ChildChildCutForDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_Diction.ChildChildCutForDictionNeedMakeForm

function Tfs_Diction.DictSubEntryChildDftDictSubEntryNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDiction;
begin
 if Supports(aDataSource, IsdsDiction, l_UseCase) then
  try
//#UC START# *4D776BFF024FNeedMake_impl*
   aNew := l_UseCase.dsTranslate[aSubUserType];
//#UC END# *4D776BFF024FNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Diction.DictSubEntryChildDftDictSubEntryNeedMakeForm

procedure Tfs_Diction.DictSubEntryChildDftDictSubEntryGetFormCount(const aDataSource: IvcmFormSetDataSource;
  out aCount: Integer);
//#UC START# *CF6948E21F14_4A9D19450248_var*
var
 l_SDS: IsdsDiction;
//#UC END# *CF6948E21F14_4A9D19450248_var*
begin
//#UC START# *CF6948E21F14_4A9D19450248_impl*
 aCount := 0;
 if Supports(aDataSource, IsdsDiction, l_SDS) then
 try
  aCount := l_SDS.TranslationForms;
 finally
  l_SDS := nil;
 end;//try..finally
//#UC END# *CF6948E21F14_4A9D19450248_impl*
end;//Tfs_Diction.DictSubEntryChildDftDictSubEntryGetFormCount

function Tfs_Diction.AttributeChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_Diction.AttributeChildFDocAttributeNeedMakeForm

class function Tfs_Diction.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_Diction <> nil;
end;//Tfs_Diction.Exists

procedure Tfs_Diction.DoGetMainImageIndex(aSender: TObject;
  const aDataSource: IvcmFormSetDataSource;
  var aImageIndex: Integer);
//#UC START# *C82B5B254974_4A9D19450248_var*
var
 l_SDS: IsdsDiction;
//#UC END# *C82B5B254974_4A9D19450248_var*
begin
//#UC START# *C82B5B254974_4A9D19450248_impl*
 if Supports(aDataSource, IsdsDiction, l_SDS) then
  aImageIndex := bsLanguageImage(l_SDS.DefaultLanguage);
//#UC END# *C82B5B254974_4A9D19450248_impl*
end;//Tfs_Diction.DoGetMainImageIndex

procedure Tfs_Diction.DoGetMainCaption(aSender: TObject;
  const aDataSource: IvcmFormSetDataSource;
  var aCaption: Il3CString);
//#UC START# *616F19145E64_4A9D19450248_var*
var
 l_SDS: IsdsDiction;
//#UC END# *616F19145E64_4A9D19450248_var*
begin
//#UC START# *616F19145E64_4A9D19450248_impl*
 if Supports(aDataSource, IsdsDiction, l_SDS) then
  aCaption := bsLanguageCaption(l_SDS.DefaultLanguage);
//#UC END# *616F19145E64_4A9D19450248_impl*
end;//Tfs_Diction.DoGetMainCaption

procedure Tfs_Diction.InitFields;
 {-}
begin
 inherited;
 with AddZone('DictionContainer', vcm_ztParent, fm_DictionContainerForm) do
 begin
  UserType := slqtDiction;
  with AddZone('DictEntry', vcm_ztParent, fm_TextForm) do
  begin
   UserType := dftDictEntry;
   OnNeedMakeForm := DictEntryParentDftDictEntryNeedMakeForm;
  end;
  with AddZone('Diction', vcm_ztNavigator, fm_enDiction) do
  begin
   UserType := utDiction;
   ActivateIfUpdate := wafAlways;
   OnNeedMakeForm := DictionNavigatorUtDictionNeedMakeForm;
  end;
  with AddZone('Child', vcm_ztChild, fm_ChildForm) do
  begin
   UserType := cutForDiction;
   with AddZone('DictSubEntry', vcm_ztChild, fm_TextForm) do
   begin
    UserType := dftDictSubEntry;
    ActivateIfUpdate := wafAlways;
    OnFormCount := DictSubEntryChildDftDictSubEntryGetFormCount;
    OnNeedMakeForm := DictSubEntryChildDftDictSubEntryNeedMakeForm;
   end;
   with AddZone('Attribute', vcm_ztChild, fm_AttributesForm) do
   begin
    UserType := fDocAttribute;
    OnNeedMakeForm := AttributeChildFDocAttributeNeedMakeForm;
   end;
   OnNeedMakeForm := ChildChildCutForDictionNeedMakeForm;
  end;
  OnNeedMakeForm := DictionContainerParentSlqtDictionNeedMakeForm;
 end;
 Caption := str_fsDictionCaption.AsCStr;
 OwnerForm := 0;
 DefaultStatusForm := 1;
 OnGetMainImageIndex := DoGetMainImageIndex;
 OnGetMainCaption := DoGetMainCaption;
end;//Tfs_Diction.InitFields

{$If not defined(NoVCM)}
class function Tfs_Diction.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_Diction.GetInstance
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function Tfs_Diction.DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352A903E5_4A9D19450248_var*
var
 l_TabCaption: IvcmCString;
//#UC END# *54B352A903E5_4A9D19450248_var*
begin
//#UC START# *54B352A903E5_4A9D19450248_impl*
 l_TabCaption := DoMakeFormSetTabCaption(aDataSource);
 Result := l3Cat([str_DictionFormSetCaptionPrefix.AsCStr, l3CStr(' : '), l_TabCaption]);
//#UC END# *54B352A903E5_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetCaption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function Tfs_Diction.DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352D401E5_4A9D19450248_var*
var
 l_sds: IsdsDiction;
//#UC END# *54B352D401E5_4A9D19450248_var*
begin
//#UC START# *54B352D401E5_4A9D19450248_impl*
 if Supports(aDataSource, IsdsDiction, l_sds) and
    (l_sds.DocInfo <> nil) and
    (l_sds.DocInfo.Doc <> nil) then
  Result := nsGetDocumentName(l_sds.DocInfo.Doc)
 else
  Result := nil;
//#UC END# *54B352D401E5_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetTabCaption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function Tfs_Diction.DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352FB03A1_4A9D19450248_var*
//#UC END# *54B352FB03A1_4A9D19450248_var*
begin
//#UC START# *54B352FB03A1_4A9D19450248_impl*
 Result := DoMakeFormSetCaption(aDataSource);
//#UC END# *54B352FB03A1_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetTabHint
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DictionFormSetCaptionPrefix
 str_DictionFormSetCaptionPrefix.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsDictionCaption
 str_fsDictionCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.