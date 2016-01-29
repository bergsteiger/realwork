unit dsConsultationMark;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/dsConsultationMark.pas"
// Начат: 2006/04/07 08:16:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TdsConsultationMark
//
// БОС оценки консультации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3_String,
  bsTypes,
  ConsultationDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsConsultationMark;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsConsultationMark = {final vac} class(_vcmFormDataSourcePrim_, IdsConsultationMark)
  {* БОС оценки консультации }
 private
 // private fields
   f_Comment : Tl3_String;
   f_Mark : TbsConsultationMark;
   ucc_Consultation : IsdsConsultation;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   procedure Send;
     {* послать оценку }
   function pm_GetMark: TbsConsultationMark;
   procedure pm_SetMark(aValue: TbsConsultationMark);
   function pm_GetComment: Tl3WString;
   procedure pm_SetComment(const aValue: Tl3WString);
   function pm_GetCanSend: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//TdsConsultationMark
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  ConsultingUnit,
  bsConvert,
  DataAdapter,
  nsTypes,
  l3InterfacesMisc,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsConsultationMark;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsConsultationMark

procedure TdsConsultationMark.Send;
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

procedure TdsConsultationMark.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsConsultation, ucc_Consultation);
end;

procedure TdsConsultationMark.ClearRefs;
begin
 inherited;
 ucc_Consultation := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.