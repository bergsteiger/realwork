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
   class function Instance: Tfs_DrugDocument;
    {* Метод получения экземпляра синглетона Tfs_DrugDocument }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_DrugDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA12BE1014Fimpl_uses*
 //#UC END# *4AA12BE1014Fimpl_uses*
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

function Tfs_DrugDocument.TextParentDftDrugNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
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
 {* Обработчик OnNeedMakeForm для Attributes }
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
 {* Обработчик OnNeedMakeForm для Contents }
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
 {* Обработчик OnNeedMakeForm для Synonyms }
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

class function Tfs_DrugDocument.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_DrugDocument <> nil;
end;//Tfs_DrugDocument.Exists

procedure Tfs_DrugDocument.InitFields;
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

class function Tfs_DrugDocument.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_DrugDocument.GetInstance

initialization
 str_fsDrugDocumentCaption.Init;
 {* Инициализация str_fsDrugDocumentCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
