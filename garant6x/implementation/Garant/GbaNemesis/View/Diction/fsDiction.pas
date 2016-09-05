unit fsDiction;
 {* Сборка форм толкового словаря }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\fsDiction.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "Diction" MUID: (4A9D19450248)
// Имя типа: "Tfs_Diction"

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
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DictionContainerUserTypes_slqtDiction_UserType
 , Common_FormDefinitions_Controls
 , CommonDictionInterfaces
 , DocumentUserTypes_dftDictEntry_UserType
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , PrimDiction_utDiction_UserType
 , l3InternalInterfaces
 , l3TreeInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , PrimChild_cutForDiction_UserType
 , F1Like_FormDefinitions_Controls
 , DocumentUserTypes_dftDictSubEntry_UserType
 , DictionInterfaces
 , DictionInterfacesPrim
 , DynamicTreeUnit
 , QueryCardInterfaces
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 Tfs_Diction = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Сборка форм толкового словаря }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
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
   procedure DoGetMainImageIndex(aSender: TObject;
    const aDataSource: IvcmFormSetDataSource;
    var aImageIndex: Integer);
    {* Обработчик OnGetMainImageIndex для Diction$FS }
   procedure DoGetMainCaption(aSender: TObject;
    const aDataSource: IvcmFormSetDataSource;
    var aCaption: Il3CString);
    {* Обработчик GetMainCaption для Diction$FS }
   class function Instance: Tfs_Diction;
    {* Метод получения экземпляра синглетона Tfs_Diction }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_Diction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , bsUtils
 , SysUtils
 , nsDocumentTools
 , l3String
 , l3Base
 //#UC START# *4A9D19450248impl_uses*
 //#UC END# *4A9D19450248impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_Diction: Tfs_Diction = nil;
 {* Экземпляр синглетона Tfs_Diction }

const
 {* Локализуемые строки Tab consts }
 str_DictionFormSetCaptionPrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DictionFormSetCaptionPrefix'; rValue : 'Текст словарной статьи');
  {* 'Текст словарной статьи' }
 {* Локализуемые строки Diction }
 str_fsDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDictionCaption'; rValue : 'Толковый словарь');
  {* Заголовок фабрики сборки форм "Diction$FS" }

procedure Tfs_DictionFree;
 {* Метод освобождения экземпляра синглетона Tfs_Diction }
begin
 l3Free(g_Tfs_Diction);
end;//Tfs_DictionFree

function Tfs_Diction.DictionContainerParentSlqtDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DictionContainer }
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
 {* Обработчик OnNeedMakeForm для DictEntry }
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
 {* Обработчик OnNeedMakeForm для Diction }
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
 {* Обработчик OnNeedMakeForm для Child }
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
 {* Обработчик OnNeedMakeForm для DictSubEntry }
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
 {* Обработчик OnFormCount для DictSubEntry }
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
 {* Обработчик OnNeedMakeForm для Attribute }
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

procedure Tfs_Diction.DoGetMainImageIndex(aSender: TObject;
 const aDataSource: IvcmFormSetDataSource;
 var aImageIndex: Integer);
 {* Обработчик OnGetMainImageIndex для Diction$FS }
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
 {* Обработчик GetMainCaption для Diction$FS }
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

class function Tfs_Diction.Instance: Tfs_Diction;
 {* Метод получения экземпляра синглетона Tfs_Diction }
begin
 if (g_Tfs_Diction = nil) then
 begin
  l3System.AddExitProc(Tfs_DictionFree);
  g_Tfs_Diction := Create;
 end;
 Result := g_Tfs_Diction;
end;//Tfs_Diction.Instance

class function Tfs_Diction.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Diction <> nil;
end;//Tfs_Diction.Exists

procedure Tfs_Diction.InitFields;
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

class function Tfs_Diction.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Diction.GetInstance

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

function Tfs_Diction.DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352FB03A1_4A9D19450248_var*
//#UC END# *54B352FB03A1_4A9D19450248_var*
begin
//#UC START# *54B352FB03A1_4A9D19450248_impl*
 Result := DoMakeFormSetCaption(aDataSource);
//#UC END# *54B352FB03A1_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetTabHint

initialization
 str_DictionFormSetCaptionPrefix.Init;
 {* Инициализация str_DictionFormSetCaptionPrefix }
 str_fsDictionCaption.Init;
 {* Инициализация str_fsDictionCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
