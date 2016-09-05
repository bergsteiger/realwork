unit fsMedicDiction;
 {* Словарь медицинских терминов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicDiction.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "MedicDiction" MUID: (4AA12BA501E4)
// Имя типа: "Tfs_MedicDiction"

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
 , Common_FormDefinitions_Controls
 , DictionContainerUserTypes_slqtMedicDiction_UserType
 , CommonDictionInterfaces
 , PrimCommonDiction_utMedicDiction_UserType
 , DocumentInterfaces
 , DynamicTreeUnit
 , QueryCardInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , DocumentUserTypes_dftMedDictEntry_UserType
 , F1Like_FormDefinitions_Controls
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 Tfs_MedicDiction = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Словарь медицинских терминов }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
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
   class function Instance: Tfs_MedicDiction;
    {* Метод получения экземпляра синглетона Tfs_MedicDiction }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_MedicDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA12BA501E4impl_uses*
 //#UC END# *4AA12BA501E4impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_MedicDiction: Tfs_MedicDiction = nil;
 {* Экземпляр синглетона Tfs_MedicDiction }

const
 {* Локализуемые строки MedicDictionCaptionLocalConstants }
 str_fsMedicDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicDictionCaption'; rValue : 'Словарь медицинских терминов');
  {* Заголовок фабрики сборки форм "MedicDiction" }

procedure Tfs_MedicDictionFree;
 {* Метод освобождения экземпляра синглетона Tfs_MedicDiction }
begin
 l3Free(g_Tfs_MedicDiction);
end;//Tfs_MedicDictionFree

function Tfs_MedicDiction.DictionContainerParentSlqtMedicDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
end;//Tfs_MedicDiction.DictionContainerParentSlqtMedicDictionNeedMakeForm

function Tfs_MedicDiction.EnCommonDictionUtMedicDictionNavigatorUtMedicDictionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для en_CommonDiction_utMedicDiction }
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
 {* Обработчик OnNeedMakeForm для TextForm_dftMedDictEntry }
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
end;//Tfs_MedicDiction.ChildChildNeedMakeForm

function Tfs_MedicDiction.AttributesFormFDocAttributeChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AttributesForm_fDocAttribute }
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

class function Tfs_MedicDiction.Instance: Tfs_MedicDiction;
 {* Метод получения экземпляра синглетона Tfs_MedicDiction }
begin
 if (g_Tfs_MedicDiction = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicDictionFree);
  g_Tfs_MedicDiction := Create;
 end;
 Result := g_Tfs_MedicDiction;
end;//Tfs_MedicDiction.Instance

class function Tfs_MedicDiction.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_MedicDiction <> nil;
end;//Tfs_MedicDiction.Exists

procedure Tfs_MedicDiction.InitFields;
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

class function Tfs_MedicDiction.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_MedicDiction.GetInstance

initialization
 str_fsMedicDictionCaption.Init;
 {* Инициализация str_fsMedicDictionCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
