unit dsConsultationList;
 {* список консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultationList.pas"
// Стереотип: "ViewAreaControllerImp"

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
  {* список консультации }
  private
   Consultation: IsdsConsultation;
  protected
   procedure DoDeleteNodes; override;
    {* - удалить узлы. Для перекрытия в потомках. }
 end;//TdsConsultationList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

procedure TdsConsultationList.DoDeleteNodes;
 {* - удалить узлы. Для перекрытия в потомках. }
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
