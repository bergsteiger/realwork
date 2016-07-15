unit fsMedicFirmDocument;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicFirmDocument.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "MedicFirmDocument" MUID: (4AA12BC400A6)
// ��� ����: "Tfs_MedicFirmDocument"

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
 , l3Interfaces
 , bsTypesNew
 , ListUserTypes_lftProducedDrugs_UserType
 , MedicInterfaces
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , DynamicTreeUnit
 , l3TreeInterfaces
 , PreviewInterfaces
 , l3InternalInterfaces
 , FiltersUnit
 , nsTypesNew
 , nsTypes
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 Tfs_MedicFirmDocument = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextParentDftMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Text }
   function ListChildLftProducedDrugsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� List }
   function AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Attributes }
   class function Instance: Tfs_MedicFirmDocument;
    {* ����� ��������� ���������� ���������� Tfs_MedicFirmDocument }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tfs_MedicFirmDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_MedicFirmDocument: Tfs_MedicFirmDocument = nil;
 {* ��������� ���������� Tfs_MedicFirmDocument }

const
 {* ������������ ������ MedicFirmDocumentCaptionLocalConstants }
 str_fsMedicFirmDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmDocumentCaption'; rValue : '�������� �����');
  {* ��������� ������� ������ ���� "MedicFirmDocument" }

procedure Tfs_MedicFirmDocumentFree;
 {* ����� ������������ ���������� ���������� Tfs_MedicFirmDocument }
begin
 l3Free(g_Tfs_MedicFirmDocument);
end;//Tfs_MedicFirmDocumentFree

function Tfs_MedicFirmDocument.TextParentDftMedicFirmNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Text }
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
end;//Tfs_MedicFirmDocument.TextParentDftMedicFirmNeedMakeForm

function Tfs_MedicFirmDocument.ListChildLftProducedDrugsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� List }
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
end;//Tfs_MedicFirmDocument.ListChildLftProducedDrugsNeedMakeForm

function Tfs_MedicFirmDocument.AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Attributes }
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
end;//Tfs_MedicFirmDocument.AttributesChildFDocAttributeNeedMakeForm

class function Tfs_MedicFirmDocument.Instance: Tfs_MedicFirmDocument;
 {* ����� ��������� ���������� ���������� Tfs_MedicFirmDocument }
begin
 if (g_Tfs_MedicFirmDocument = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicFirmDocumentFree);
  g_Tfs_MedicFirmDocument := Create;
 end;
 Result := g_Tfs_MedicFirmDocument;
end;//Tfs_MedicFirmDocument.Instance

class function Tfs_MedicFirmDocument.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_MedicFirmDocument <> nil;
end;//Tfs_MedicFirmDocument.Exists

procedure Tfs_MedicFirmDocument.InitFields;
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftMedicFirm;
  OnNeedMakeForm := TextParentDftMedicFirmNeedMakeForm;
 end;
 with AddZone('List', vcm_ztChild, fm_efList) do
 begin
  UserType := lftProducedDrugs;
  OnNeedMakeForm := ListChildLftProducedDrugsNeedMakeForm;
 end;
 with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
 begin
  UserType := fDocAttribute;
  OnNeedMakeForm := AttributesChildFDocAttributeNeedMakeForm;
 end;
 Caption := str_fsMedicFirmDocumentCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_MedicFirmDocument.InitFields

class function Tfs_MedicFirmDocument.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_MedicFirmDocument.GetInstance

initialization
 str_fsMedicFirmDocumentCaption.Init;
 {* ������������� str_fsMedicFirmDocumentCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
