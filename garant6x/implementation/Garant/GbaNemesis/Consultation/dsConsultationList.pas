unit dsConsultationList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Consultation"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/dsConsultationList.pas"
// �����: 2006/10/06 13:46:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������������� �������::Consultation::Consultation::Consultation::TdsConsultationList
//
// ������ ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsDocumentList,
  ConsultationDomainInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsConsultationList = {vac} class(TdsDocumentList)
  {* ������ ������������ }
 private
 // private fields
   ucc_Consultation : IsdsConsultation;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // overridden protected methods
   procedure DoDeleteNodes; override;
     {* - ������� ����. ��� ���������� � ��������. }
 end;//TdsConsultationList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsConsultationList

procedure TdsConsultationList.DoDeleteNodes;
//#UC START# *47F61AD5022A_4926BD6800C8_var*
//#UC END# *47F61AD5022A_4926BD6800C8_var*
begin
//#UC START# *47F61AD5022A_4926BD6800C8_impl*
 inherited;
 if (ucc_Consultation <> nil) then
  ucc_Consultation.ListChanged;
//#UC END# *47F61AD5022A_4926BD6800C8_impl*
end;//TdsConsultationList.DoDeleteNodes

procedure TdsConsultationList.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsConsultation, ucc_Consultation);
end;

procedure TdsConsultationList.ClearRefs;
begin
 inherited;
 ucc_Consultation := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.