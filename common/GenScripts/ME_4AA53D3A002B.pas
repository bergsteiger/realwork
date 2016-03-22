unit fsSendConsultation;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\fsSendConsultation.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "SendConsultation" MUID: (4AA53D3A002B)
// ��� ����: "Tfs_SendConsultation"

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
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 , Search_FormDefinitions_Controls
 , ConsultationInterfaces
 , QueryCardInterfaces
 , PrimQueryCard_utqcSendConsultation_UserType
;

type
 // QueryCard

 // SaveLoad

 Tfs_SendConsultation = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function SaveLoad_Parent_slqtConsult_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� SaveLoad }
   function QueryCard_Parent_utqcSendConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� QueryCard }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: Tfs_SendConsultation;
    {* ����� ��������� ���������� ���������� Tfs_SendConsultation }
 end;//Tfs_SendConsultation
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
var g_Tfs_SendConsultation: Tfs_SendConsultation = nil;
 {* ��������� ���������� Tfs_SendConsultation }

const
 {* ������������ ������ QueryCardCaptionLocalConstants }
 str_fszQueryCard_Parent_utqcSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszQueryCard_Parent_utqcSendConsultationCaption'; rValue : '����� � �������� ����������');
  {* ��������� ���� "QueryCard" ������� ������ ���� "SendConsultation" }
 {* ������������ ������ SendConsultationCaptionLocalConstants }
 str_fsSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSendConsultationCaption'; rValue : '�������� ���������');
  {* ��������� ������� ������ ���� "SendConsultation" }

procedure Tfs_SendConsultationFree;
 {* ����� ������������ ���������� ���������� Tfs_SendConsultation }
begin
 l3Free(g_Tfs_SendConsultation);
end;//Tfs_SendConsultationFree

function Tfs_SendConsultation.SaveLoad_Parent_slqtConsult_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� SaveLoad }
//#UC START# *CAD3716E6F7B_4AA53D3A002B_var*
//#UC END# *CAD3716E6F7B_4AA53D3A002B_var*
begin
//#UC START# *CAD3716E6F7B_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *CAD3716E6F7B_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.SaveLoad_Parent_slqtConsult_NeedMakeForm

function Tfs_SendConsultation.QueryCard_Parent_utqcSendConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� QueryCard }
//#UC START# *0BD7FE614FE1_4AA53D3A002B_var*
//#UC END# *0BD7FE614FE1_4AA53D3A002B_var*
begin
//#UC START# *0BD7FE614FE1_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *0BD7FE614FE1_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.QueryCard_Parent_utqcSendConsultation_NeedMakeForm

class function Tfs_SendConsultation.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_SendConsultation <> nil;
end;//Tfs_SendConsultation.Exists

class function Tfs_SendConsultation.Instance: Tfs_SendConsultation;
 {* ����� ��������� ���������� ���������� Tfs_SendConsultation }
begin
 if (g_Tfs_SendConsultation = nil) then
 begin
  l3System.AddExitProc(Tfs_SendConsultationFree);
  g_Tfs_SendConsultation := Create;
 end;
 Result := g_Tfs_SendConsultation;
end;//Tfs_SendConsultation.Instance

procedure Tfs_SendConsultation.InitFields;
//#UC START# *47A042E100E2_4AA53D3A002B_var*
//#UC END# *47A042E100E2_4AA53D3A002B_var*
begin
//#UC START# *47A042E100E2_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.InitFields

class function Tfs_SendConsultation.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA53D3A002B_var*
//#UC END# *4FFE854A009B_4AA53D3A002B_var*
begin
//#UC START# *4FFE854A009B_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.GetInstance

initialization
 str_fszQueryCard_Parent_utqcSendConsultationCaption.Init;
 {* ������������� str_fszQueryCard_Parent_utqcSendConsultationCaption }
 str_fsSendConsultationCaption.Init;
 {* ������������� str_fsSendConsultationCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
