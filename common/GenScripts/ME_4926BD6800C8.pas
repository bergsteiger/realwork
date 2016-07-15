unit dsConsultationList;
 {* список консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultationList.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsConsultationList" MUID: (4926BD6800C8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDocumentList
 , ConsultationDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TdsConsultationList = class(TdsDocumentList)
  {* список консультации }
  private
   ucc_Consultation: IsdsConsultation;
  protected
   procedure DoDeleteNodes; override;
    {* - удалить узлы. Для перекрытия в потомках. }
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsConsultationList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
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

{$If NOT Defined(NoVCM)}
procedure TdsConsultationList.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 Supports(aDS, IsdsConsultation, ucc_Consultation);
end;//TdsConsultationList.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsConsultationList.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 ucc_Consultation := nil;
end;//TdsConsultationList.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
