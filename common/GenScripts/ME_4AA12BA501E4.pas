unit fsMedicDiction;
 {* Словарь медицинских терминов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicDiction.pas"
// Стереотип: "VCMFormSetFactory"

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
 , DocumentUnit
 , bsTypesNew
 , DocumentUserTypes_dftMedDictEntry_UserType
 , DocumentAndListInterfaces
 , F1Like_FormDefinitions_Controls
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 // en_CommonDiction_utMedicDiction

 // TextForm_dftMedDictEntry

 // AttributesForm_fDocAttribute

 // Child

 // DictionContainer

 Tfs_MedicDiction = {final} class(TvcmFormSetFactory)
  {* Словарь медицинских терминов }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function DictionContainer_Parent_slqtMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для DictionContainer }
   function en_CommonDiction_utMedicDiction_Navigator_utMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для en_CommonDiction_utMedicDiction }
   function TextForm_dftMedDictEntry_Parent_dftMedDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TextForm_dftMedDictEntry }
   function Child_Child_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Child }
   function AttributesForm_fDocAttribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AttributesForm_fDocAttribute }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_MedicDiction;
    {* Метод получения экземпляра синглетона Tfs_MedicDiction }
 end;//Tfs_MedicDiction
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

function Tfs_MedicDiction.DictionContainer_Parent_slqtMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DictionContainer }
//#UC START# *2E79C71E8DBE_4AA12BA501E4_var*
//#UC END# *2E79C71E8DBE_4AA12BA501E4_var*
begin
//#UC START# *2E79C71E8DBE_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E79C71E8DBE_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.DictionContainer_Parent_slqtMedicDiction_NeedMakeForm

function Tfs_MedicDiction.en_CommonDiction_utMedicDiction_Navigator_utMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для en_CommonDiction_utMedicDiction }
//#UC START# *05BB4AF4B2B3_4AA12BA501E4_var*
//#UC END# *05BB4AF4B2B3_4AA12BA501E4_var*
begin
//#UC START# *05BB4AF4B2B3_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *05BB4AF4B2B3_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.en_CommonDiction_utMedicDiction_Navigator_utMedicDiction_NeedMakeForm

function Tfs_MedicDiction.TextForm_dftMedDictEntry_Parent_dftMedDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TextForm_dftMedDictEntry }
//#UC START# *9CD5DFE766E3_4AA12BA501E4_var*
//#UC END# *9CD5DFE766E3_4AA12BA501E4_var*
begin
//#UC START# *9CD5DFE766E3_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *9CD5DFE766E3_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.TextForm_dftMedDictEntry_Parent_dftMedDictEntry_NeedMakeForm

function Tfs_MedicDiction.Child_Child_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Child }
//#UC START# *C55392708AE7_4AA12BA501E4_var*
//#UC END# *C55392708AE7_4AA12BA501E4_var*
begin
//#UC START# *C55392708AE7_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *C55392708AE7_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.Child_Child_NeedMakeForm

function Tfs_MedicDiction.AttributesForm_fDocAttribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AttributesForm_fDocAttribute }
//#UC START# *7A8349EDE74B_4AA12BA501E4_var*
//#UC END# *7A8349EDE74B_4AA12BA501E4_var*
begin
//#UC START# *7A8349EDE74B_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A8349EDE74B_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.AttributesForm_fDocAttribute_Child_fDocAttribute_NeedMakeForm

class function Tfs_MedicDiction.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_MedicDiction <> nil;
end;//Tfs_MedicDiction.Exists

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

procedure Tfs_MedicDiction.InitFields;
//#UC START# *47A042E100E2_4AA12BA501E4_var*
//#UC END# *47A042E100E2_4AA12BA501E4_var*
begin
//#UC START# *47A042E100E2_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.InitFields

class function Tfs_MedicDiction.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12BA501E4_var*
//#UC END# *4FFE854A009B_4AA12BA501E4_var*
begin
//#UC START# *4FFE854A009B_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.GetInstance

initialization
 str_fsMedicDictionCaption.Init;
 {* Инициализация str_fsMedicDictionCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
