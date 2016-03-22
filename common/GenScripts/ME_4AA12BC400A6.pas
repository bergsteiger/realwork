unit fsMedicFirmDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicFirmDocument.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "MedicFirmDocument" MUID: (4AA12BC400A6)
// Имя типа: "Tfs_MedicFirmDocument"

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
 , DocumentUserTypes_dftMedicFirm_UserType
 , Common_FormDefinitions_Controls
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
 , ListUserTypes_lftProducedDrugs_UserType
 , MedicInterfaces
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , DynamicTreeUnit
 , l3TreeInterfaces
 , PreviewInterfaces
 , l3InternalInterfaces
 , FiltersUnit
 , nsTypes
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 // Text

 // List

 // Attributes

 Tfs_MedicFirmDocument = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dftMedicFirm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function List_Child_lftProducedDrugs_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_MedicFirmDocument;
    {* Метод получения экземпляра синглетона Tfs_MedicFirmDocument }
 end;//Tfs_MedicFirmDocument
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
var g_Tfs_MedicFirmDocument: Tfs_MedicFirmDocument = nil;
 {* Экземпляр синглетона Tfs_MedicFirmDocument }

const
 {* Локализуемые строки MedicFirmDocumentCaptionLocalConstants }
 str_fsMedicFirmDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmDocumentCaption'; rValue : 'Описание фирмы');
  {* Заголовок фабрики сборки форм "MedicFirmDocument" }

procedure Tfs_MedicFirmDocumentFree;
 {* Метод освобождения экземпляра синглетона Tfs_MedicFirmDocument }
begin
 l3Free(g_Tfs_MedicFirmDocument);
end;//Tfs_MedicFirmDocumentFree

function Tfs_MedicFirmDocument.Text_Parent_dftMedicFirm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *D85D66FEA6B3_4AA12BC400A6_var*
//#UC END# *D85D66FEA6B3_4AA12BC400A6_var*
begin
//#UC START# *D85D66FEA6B3_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *D85D66FEA6B3_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.Text_Parent_dftMedicFirm_NeedMakeForm

function Tfs_MedicFirmDocument.List_Child_lftProducedDrugs_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
//#UC START# *994991B7C174_4AA12BC400A6_var*
//#UC END# *994991B7C174_4AA12BC400A6_var*
begin
//#UC START# *994991B7C174_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *994991B7C174_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.List_Child_lftProducedDrugs_NeedMakeForm

function Tfs_MedicFirmDocument.Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *7DB1333E9147_4AA12BC400A6_var*
//#UC END# *7DB1333E9147_4AA12BC400A6_var*
begin
//#UC START# *7DB1333E9147_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *7DB1333E9147_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.Attributes_Child_fDocAttribute_NeedMakeForm

class function Tfs_MedicFirmDocument.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_MedicFirmDocument <> nil;
end;//Tfs_MedicFirmDocument.Exists

class function Tfs_MedicFirmDocument.Instance: Tfs_MedicFirmDocument;
 {* Метод получения экземпляра синглетона Tfs_MedicFirmDocument }
begin
 if (g_Tfs_MedicFirmDocument = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicFirmDocumentFree);
  g_Tfs_MedicFirmDocument := Create;
 end;
 Result := g_Tfs_MedicFirmDocument;
end;//Tfs_MedicFirmDocument.Instance

procedure Tfs_MedicFirmDocument.InitFields;
//#UC START# *47A042E100E2_4AA12BC400A6_var*
//#UC END# *47A042E100E2_4AA12BC400A6_var*
begin
//#UC START# *47A042E100E2_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.InitFields

class function Tfs_MedicFirmDocument.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12BC400A6_var*
//#UC END# *4FFE854A009B_4AA12BC400A6_var*
begin
//#UC START# *4FFE854A009B_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.GetInstance

initialization
 str_fsMedicFirmDocumentCaption.Init;
 {* Инициализация str_fsMedicFirmDocumentCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
