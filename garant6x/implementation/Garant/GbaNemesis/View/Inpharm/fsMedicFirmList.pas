unit fsMedicFirmList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicFirmList.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "MedicFirmList" MUID: (4AA7A19E01D0)
// Имя типа: "Tfs_MedicFirmList"

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
 , PrimMedicFirmList_mflMain_UserType
 , Common_FormDefinitions_Controls
 , MedicInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , DocumentInterfaces
 , PreviewInterfaces
 , l3Interfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , nsTypesNew
 , PrimMedicListSynchroView_mlsfMedicFirm_UserType
 , afwInterfaces
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , bsTypes
 , DynamicTreeUnit
 , DocumentUnit
 , nevTools
 , FoldersDomainInterfaces
 , FiltersUnit
 , DocumentAndListInterfaces
 , nsTypes
 , bsTypesNew
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 Tfs_MedicFirmList = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function MedicFirmListParentMflMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для MedicFirmList }
   function MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для MedicListSynchroView }
   function TextChildDftMedicFirmSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function ListChildLftProducedDrugsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   class function Instance: Tfs_MedicFirmList;
    {* Метод получения экземпляра синглетона Tfs_MedicFirmList }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_MedicFirmList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA7A19E01D0impl_uses*
 //#UC END# *4AA7A19E01D0impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_MedicFirmList: Tfs_MedicFirmList = nil;
 {* Экземпляр синглетона Tfs_MedicFirmList }

const
 {* Локализуемые строки MedicFirmListCaptionLocalConstants }
 str_fsMedicFirmListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmListCaption'; rValue : 'Фармацевтические фирмы');
  {* Заголовок фабрики сборки форм "MedicFirmList" }

procedure Tfs_MedicFirmListFree;
 {* Метод освобождения экземпляра синглетона Tfs_MedicFirmList }
begin
 l3Free(g_Tfs_MedicFirmList);
end;//Tfs_MedicFirmListFree

function Tfs_MedicFirmList.MedicFirmListParentMflMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для MedicFirmList }
var
 l_UseCase : IsdsMedicFirmList;
begin
 if Supports(aDataSource, IsdsMedicFirmList, l_UseCase) then
  try
   aNew := l_UseCase.dsFirmList;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicFirmList.MedicFirmListParentMflMainNeedMakeForm

function Tfs_MedicFirmList.MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для MedicListSynchroView }
var
 l_UseCase : IsdsMedicFirmList;
begin
 if Supports(aDataSource, IsdsMedicFirmList, l_UseCase) then
  try
   aNew := l_UseCase.dsSynchroView;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_MedicFirmList.MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm

function Tfs_MedicFirmList.TextChildDftMedicFirmSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
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
end;//Tfs_MedicFirmList.TextChildDftMedicFirmSynchroViewNeedMakeForm

function Tfs_MedicFirmList.ListChildLftProducedDrugsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
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
end;//Tfs_MedicFirmList.ListChildLftProducedDrugsSynchroFormNeedMakeForm

function Tfs_MedicFirmList.AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
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
end;//Tfs_MedicFirmList.AttributesChildFAttributeSynchroViewNeedMakeForm

class function Tfs_MedicFirmList.Instance: Tfs_MedicFirmList;
 {* Метод получения экземпляра синглетона Tfs_MedicFirmList }
begin
 if (g_Tfs_MedicFirmList = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicFirmListFree);
  g_Tfs_MedicFirmList := Create;
 end;
 Result := g_Tfs_MedicFirmList;
end;//Tfs_MedicFirmList.Instance

class function Tfs_MedicFirmList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_MedicFirmList <> nil;
end;//Tfs_MedicFirmList.Exists

procedure Tfs_MedicFirmList.InitFields;
begin
 inherited;
 with AddZone('MedicFirmList', vcm_ztParent, fm_en_MedicFirmList) do
 begin
  UserType := mflMain;
  OnNeedMakeForm := MedicFirmListParentMflMainNeedMakeForm;
 end;
 with AddZone('MedicListSynchroView', vcm_ztChild, fm_en_MedicListSynchroView) do
 begin
  UserType := mlsfMedicFirm;
  with AddZone('Text', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftMedicFirmSynchroView;
   OnNeedMakeForm := TextChildDftMedicFirmSynchroViewNeedMakeForm;
  end;
  with AddZone('List', vcm_ztChild, fm_efList) do
  begin
   UserType := lftProducedDrugsSynchroForm;
   OnNeedMakeForm := ListChildLftProducedDrugsSynchroFormNeedMakeForm;
  end;
  with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
  begin
   UserType := fAttributeSynchroView;
   OnNeedMakeForm := AttributesChildFAttributeSynchroViewNeedMakeForm;
  end;
  OnNeedMakeForm := MedicListSynchroViewChildMlsfMedicFirmNeedMakeForm;
 end;
 Caption := str_fsMedicFirmListCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_MedicFirmList.InitFields

class function Tfs_MedicFirmList.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_MedicFirmList.GetInstance

initialization
 str_fsMedicFirmListCaption.Init;
 {* Инициализация str_fsMedicFirmListCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
