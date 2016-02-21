unit dsConsultationMark;
 {* БОС оценки консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultationMark.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConsultationDomainInterfaces
 , l3_String
 , bsTypes
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsConsultationMark = {final} class(_vcmFormDataSourcePrim_, IdsConsultationMark)
  {* БОС оценки консультации }
  private
   f_Comment: Tl3_String;
   f_Mark: TbsConsultationMark;
   Consultation: IsdsConsultation;
  protected
   procedure Send;
    {* послать оценку }
   function pm_GetMark: TbsConsultationMark;
   procedure pm_SetMark(aValue: TbsConsultationMark);
   function pm_GetComment: Tl3WString;
   procedure pm_SetComment(const aValue: Tl3WString);
   function pm_GetCanSend: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//TdsConsultationMark
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , ConsultingUnit
 , bsConvert
 , DataAdapter
 , nsTypes
 , l3InterfacesMisc
 , SysUtils
;

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsConsultationMark;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

procedure TdsConsultationMark.Send;
 {* послать оценку }
//#UC START# *49216508016D_49216B3C02E8_var*
var
 l_Estimation : IEstimation;
//#UC END# *49216508016D_49216B3C02E8_var*
begin
//#UC START# *49216508016D_49216B3C02E8_impl*
 if (ucc_Consultation <> nil) AND (ucc_Consultation.bsConsultation <> nil) then
 begin
  with ucc_Consultation.bsConsultation.Data do
  begin
   CreateEstimation(l_Estimation);
   try
    with l_Estimation do
    begin
     SetValue(bsBusinessToAdapter(f_Mark));
     SetText(nsIStr(f_Comment.AsWStr));
    end;//with l_Estimation do
    SendEstimation(l_Estimation);
    if (ucc_Consultation <> nil) then
     ucc_Consultation.MarkSended;
   finally
    l_Estimation := nil;
   end;{try..finally}
  end;//with ucc_Consultation.bsConsultation.Data do
 end;//ucc_Consultation.bsConsultation <> nil
//#UC END# *49216508016D_49216B3C02E8_impl*
end;//TdsConsultationMark.Send

function TdsConsultationMark.pm_GetMark: TbsConsultationMark;
//#UC START# *49216542034E_49216B3C02E8get_var*
//#UC END# *49216542034E_49216B3C02E8get_var*
begin
//#UC START# *49216542034E_49216B3C02E8get_impl*
 Result := f_Mark;
//#UC END# *49216542034E_49216B3C02E8get_impl*
end;//TdsConsultationMark.pm_GetMark

procedure TdsConsultationMark.pm_SetMark(aValue: TbsConsultationMark);
//#UC START# *49216542034E_49216B3C02E8set_var*
//#UC END# *49216542034E_49216B3C02E8set_var*
begin
//#UC START# *49216542034E_49216B3C02E8set_impl*
 f_Mark := aValue;
//#UC END# *49216542034E_49216B3C02E8set_impl*
end;//TdsConsultationMark.pm_SetMark

function TdsConsultationMark.pm_GetComment: Tl3WString;
//#UC START# *49216552037B_49216B3C02E8get_var*
//#UC END# *49216552037B_49216B3C02E8get_var*
begin
//#UC START# *49216552037B_49216B3C02E8get_impl*
 Result := f_Comment.AsWStr;
//#UC END# *49216552037B_49216B3C02E8get_impl*
end;//TdsConsultationMark.pm_GetComment

procedure TdsConsultationMark.pm_SetComment(const aValue: Tl3WString);
//#UC START# *49216552037B_49216B3C02E8set_var*
//#UC END# *49216552037B_49216B3C02E8set_var*
begin
//#UC START# *49216552037B_49216B3C02E8set_impl*
 l3Set(f_Comment, aValue);
//#UC END# *49216552037B_49216B3C02E8set_impl*
end;//TdsConsultationMark.pm_SetComment

function TdsConsultationMark.pm_GetCanSend: Boolean;
//#UC START# *49216566017F_49216B3C02E8get_var*
//#UC END# *49216566017F_49216B3C02E8get_var*
begin
//#UC START# *49216566017F_49216B3C02E8get_impl*
 Result := f_Mark <> bs_cmNone;
//#UC END# *49216566017F_49216B3C02E8get_impl*
end;//TdsConsultationMark.pm_GetCanSend

procedure TdsConsultationMark.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49216B3C02E8_var*
//#UC END# *479731C50290_49216B3C02E8_var*
begin
//#UC START# *479731C50290_49216B3C02E8_impl*
 l3Free(f_Comment);
 inherited;
//#UC END# *479731C50290_49216B3C02E8_impl*
end;//TdsConsultationMark.Cleanup

procedure TdsConsultationMark.InitFields;
//#UC START# *47A042E100E2_49216B3C02E8_var*
//#UC END# *47A042E100E2_49216B3C02E8_var*
begin
//#UC START# *47A042E100E2_49216B3C02E8_impl*
 inherited;
 f_Mark := bs_cmNone;
//#UC END# *47A042E100E2_49216B3C02E8_impl*
end;//TdsConsultationMark.InitFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
