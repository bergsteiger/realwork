unit fsDrugDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsDrugDocument.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "DrugDocument" MUID: (4AA12BE1014F)
// Имя типа: "Tfs_DrugDocument"

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
 , DocumentUserTypes_dftDrug_UserType
 , Common_FormDefinitions_Controls
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , DocumentUnit
 , bsTypesNew
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
 , ContentsUserTypes_utDrugContents_UserType
 , WorkWithDocumentInterfaces
 , nevTools
 , ListUserTypes_lftDrugInternationalNameSynonyms_UserType
 , MedicInterfaces
;

type
 // Text

 // Attributes

 // Contents

 // Synonyms

 Tfs_DrugDocument = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dftDrug_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function Contents_Navigator_utDrugContents_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Contents }
   function Synonyms_Child_lftDrugInternationalNameSynonyms_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Synonyms }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_DrugDocument;
    {* Метод получения экземпляра синглетона Tfs_DrugDocument }
 end;//Tfs_DrugDocument
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
var g_Tfs_DrugDocument: Tfs_DrugDocument = nil;
 {* Экземпляр синглетона Tfs_DrugDocument }

const
 {* Локализуемые строки DrugDocumentCaptionLocalConstants }
 str_fsDrugDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDrugDocumentCaption'; rValue : 'Препарат');
  {* Заголовок фабрики сборки форм "DrugDocument" }

procedure Tfs_DrugDocumentFree;
 {* Метод освобождения экземпляра синглетона Tfs_DrugDocument }
begin
 l3Free(g_Tfs_DrugDocument);
end;//Tfs_DrugDocumentFree

function Tfs_DrugDocument.Text_Parent_dftDrug_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *3DC42139205B_4AA12BE1014F_var*
//#UC END# *3DC42139205B_4AA12BE1014F_var*
begin
//#UC START# *3DC42139205B_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *3DC42139205B_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Text_Parent_dftDrug_NeedMakeForm

function Tfs_DrugDocument.Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *E2D36E154285_4AA12BE1014F_var*
//#UC END# *E2D36E154285_4AA12BE1014F_var*
begin
//#UC START# *E2D36E154285_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *E2D36E154285_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Attributes_Child_fDocAttribute_NeedMakeForm

function Tfs_DrugDocument.Contents_Navigator_utDrugContents_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Contents }
//#UC START# *D6D6612D957E_4AA12BE1014F_var*
//#UC END# *D6D6612D957E_4AA12BE1014F_var*
begin
//#UC START# *D6D6612D957E_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6D6612D957E_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Contents_Navigator_utDrugContents_NeedMakeForm

function Tfs_DrugDocument.Synonyms_Child_lftDrugInternationalNameSynonyms_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Synonyms }
//#UC START# *2B6BF0B8EC3B_4AA12BE1014F_var*
//#UC END# *2B6BF0B8EC3B_4AA12BE1014F_var*
begin
//#UC START# *2B6BF0B8EC3B_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *2B6BF0B8EC3B_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Synonyms_Child_lftDrugInternationalNameSynonyms_NeedMakeForm

class function Tfs_DrugDocument.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_DrugDocument <> nil;
end;//Tfs_DrugDocument.Exists

class function Tfs_DrugDocument.Instance: Tfs_DrugDocument;
 {* Метод получения экземпляра синглетона Tfs_DrugDocument }
begin
 if (g_Tfs_DrugDocument = nil) then
 begin
  l3System.AddExitProc(Tfs_DrugDocumentFree);
  g_Tfs_DrugDocument := Create;
 end;
 Result := g_Tfs_DrugDocument;
end;//Tfs_DrugDocument.Instance

procedure Tfs_DrugDocument.InitFields;
//#UC START# *47A042E100E2_4AA12BE1014F_var*
//#UC END# *47A042E100E2_4AA12BE1014F_var*
begin
//#UC START# *47A042E100E2_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.InitFields

class function Tfs_DrugDocument.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12BE1014F_var*
//#UC END# *4FFE854A009B_4AA12BE1014F_var*
begin
//#UC START# *4FFE854A009B_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.GetInstance

initialization
 str_fsDrugDocumentCaption.Init;
 {* Инициализация str_fsDrugDocumentCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
