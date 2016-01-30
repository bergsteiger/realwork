unit ConsultationInterfaces;
 {* ���������� ��� ������ � �������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\ConsultationInterfaces.pas"
// ���������: "ControllerInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , QueryCardInterfaces
;

type
 IsdsQuery = interface
  {* ������ ������ ����������� "��������� ������" }
  ['{0D4BCBD4-AA04-45B7-AAF0-34CEFA6EE31C}']
  function pm_GetdsQuery: IdsQuery;
  function pm_GetdsSaveLoad: IdsSaveLoad;
  property dsQuery: IdsQuery
   read pm_GetdsQuery;
   {* ��� ����� ���������� ������� }
  property dsSaveLoad: IdsSaveLoad
   read pm_GetdsSaveLoad;
   {* ��� ���������� ���������� ������� }
 end;//IsdsQuery

 IsdsSendConsultation = interface(IsdsQuery)
  ['{B788E478-BE1E-422D-85F0-0AF63DEFB0B9}']
 end;//IsdsSendConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
