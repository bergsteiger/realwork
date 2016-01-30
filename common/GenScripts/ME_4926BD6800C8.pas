unit dsConsultationList;
 {* ������ ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultationList.pas"
// ���������: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDocumentList
 , ConsultationDomainInterfaces
;

type
 TdsConsultationList = class(TdsDocumentList)
  {* ������ ������������ }
  private
   Consultation: IsdsConsultation;
  protected
   procedure DoDeleteNodes; override;
    {* - ������� ����. ��� ���������� � ��������. }
 end;//TdsConsultationList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

procedure TdsConsultationList.DoDeleteNodes;
 {* - ������� ����. ��� ���������� � ��������. }
//#UC START# *47F61AD5022A_4926BD6800C8_var*
//#UC END# *47F61AD5022A_4926BD6800C8_var*
begin
//#UC START# *47F61AD5022A_4926BD6800C8_impl*
 inherited;
 if (ucc_Consultation <> nil) then
  ucc_Consultation.ListChanged;
//#UC END# *47F61AD5022A_4926BD6800C8_impl*
end;//TdsConsultationList.DoDeleteNodes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
