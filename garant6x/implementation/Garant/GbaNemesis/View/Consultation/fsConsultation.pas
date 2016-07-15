unit fsConsultation;
 {* ������ ��� ������ ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\fsConsultation.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "Consultation" MUID: (4AA5360E0197)
// ��� ����: "Tfs_Consultation"

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
 , DocumentUserTypes_dftConsultation_UserType
 , Common_FormDefinitions_Controls
 , ConsultationDomainInterfaces
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , ListUserTypes_lftConsultation_UserType
 , PrimConsultationMark_utcmMain_UserType
;

type
 Tfs_Consultation = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ ��� ������ ������������ }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextParentDftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Text }
   function ListChildLftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� List }
   function MarkModalUtcmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Mark }
   class function Instance: Tfs_Consultation;
    {* ����� ��������� ���������� ���������� Tfs_Consultation }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tfs_Consultation
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
var g_Tfs_Consultation: Tfs_Consultation = nil;
 {* ��������� ���������� Tfs_Consultation }

const
 {* ������������ ������ ConsultationCaptionLocalConstants }
 str_fsConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsConsultationCaption'; rValue : '������������');
  {* ��������� ������� ������ ���� "Consultation" }

procedure Tfs_ConsultationFree;
 {* ����� ������������ ���������� ���������� Tfs_Consultation }
begin
 l3Free(g_Tfs_Consultation);
end;//Tfs_ConsultationFree

function Tfs_Consultation.TextParentDftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Text }
var
 l_UseCase : IsdsConsultation;
begin
 if Supports(aDataSource, IsdsConsultation, l_UseCase) then
  try
  //#UC START# *4FFADAFD02F1NeedMake_impl*
   aNew := l_UseCase.dsConsultation;
  //#UC END# *4FFADAFD02F1NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Consultation.TextParentDftConsultationNeedMakeForm

function Tfs_Consultation.ListChildLftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� List }
var
 l_UseCase : IsdsConsultation;
begin
 if Supports(aDataSource, IsdsConsultation, l_UseCase) then
  try
  //#UC START# *4FFADCDA016FNeedMake_impl*
   aNew := l_UseCase.dsList;
  //#UC END# *4FFADCDA016FNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Consultation.ListChildLftConsultationNeedMakeForm

function Tfs_Consultation.MarkModalUtcmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Mark }
var
 l_UseCase : IsdsConsultation;
begin
 if Supports(aDataSource, IsdsConsultation, l_UseCase) then
  try
  //#UC START# *4FFADD000158NeedMake_impl*
   aNew := l_UseCase.dsConsultationMark[false];
  //#UC END# *4FFADD000158NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Consultation.MarkModalUtcmMainNeedMakeForm

class function Tfs_Consultation.Instance: Tfs_Consultation;
 {* ����� ��������� ���������� ���������� Tfs_Consultation }
begin
 if (g_Tfs_Consultation = nil) then
 begin
  l3System.AddExitProc(Tfs_ConsultationFree);
  g_Tfs_Consultation := Create;
 end;
 Result := g_Tfs_Consultation;
end;//Tfs_Consultation.Instance

class function Tfs_Consultation.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_Consultation <> nil;
end;//Tfs_Consultation.Exists

procedure Tfs_Consultation.InitFields;
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftConsultation;
  OnNeedMakeForm := TextParentDftConsultationNeedMakeForm;
 end;
 with AddZone('List', vcm_ztChild, fm_efList) do
 begin
  UserType := lftConsultation;
  OnNeedMakeForm := ListChildLftConsultationNeedMakeForm;
 end;
 with AddZone('Mark', vcm_ztModal, fm_en_ConsultationMark) do
 begin
  UserType := utcmMain;
  OnNeedMakeForm := MarkModalUtcmMainNeedMakeForm;
 end;
 Caption := str_fsConsultationCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Consultation.InitFields

class function Tfs_Consultation.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Consultation.GetInstance

initialization
 str_fsConsultationCaption.Init;
 {* ������������� str_fsConsultationCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
