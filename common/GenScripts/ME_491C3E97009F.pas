unit dsConsultation;
 {* БОС запроса на консультацию }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultation.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConsultationDomainInterfaces
 , bsTypes
 , l3IID
 , nevTools
 , DocumentAndListInterfaces
 , l3Types
 , DocumentInterfaces
 , WorkWithListInterfaces
 , nsDocumentLikeStateHolder
 , afwInterfaces
 , l3Interfaces
 , FoldersDomainInterfaces
 , UnderControlUnit
 , DocumentUnit
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , UnderControlInterfaces
;

type
 _FormDataSourceType_ = IdsConsultation;
 {$Include dsBaseDocumentPrim.imp.pas}
 TdsConsultation = class(_dsBaseDocumentPrim_, IdsConsultation)
  {* БОС запроса на консультацию }
  private
   f_ShowingStatus: TbsConsultationStatuses;
   Consultation: IsdsConsultation;
  protected
   function pm_GetShowingStatus: TbsConsultationStatuses;
   procedure InitFields; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   function MakeContainer: InevDocumentContainer; override;
    {* Конструирует контейнер документа }
 end;//TdsConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , ConsultingUnit
 , nsConsultationDocumentContainerNew
 , bsUtils
 , BaseTypesUnit
 , bsConvert
 , l3Utils
 , deDocInfo
 , nsTypes
 , nsDocInfoHAFMacroReplacer
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsFolderFilterInfo
 , l3InterfacesMisc
 , afwFacade
 , IOUnit
;

type _Instance_R_ = TdsConsultation;

{$Include dsBaseDocumentPrim.imp.pas}

function TdsConsultation.pm_GetShowingStatus: TbsConsultationStatuses;
//#UC START# *491C3FAA009D_491C3E97009Fget_var*
//#UC END# *491C3FAA009D_491C3E97009Fget_var*
begin
//#UC START# *491C3FAA009D_491C3E97009Fget_impl*
 Result := f_ShowingStatus;
//#UC END# *491C3FAA009D_491C3E97009Fget_impl*
end;//TdsConsultation.pm_GetShowingStatus

procedure TdsConsultation.InitFields;
//#UC START# *47A042E100E2_491C3E97009F_var*
//#UC END# *47A042E100E2_491C3E97009F_var*
begin
//#UC START# *47A042E100E2_491C3E97009F_impl*
 inherited;
 f_ShowingStatus := ucc_Consultation.bsConsultation.Status;
//#UC END# *47A042E100E2_491C3E97009F_impl*
end;//TdsConsultation.InitFields

function TdsConsultation.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_491C3E97009F_var*
//#UC END# *4A60B23E00C3_491C3E97009F_var*
begin
//#UC START# *4A60B23E00C3_491C3E97009F_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and (ucc_Consultation.bsConsultation <> nil) then
  if IID.EQ(IConsultation) then
  begin
   Assert(false, 'Ну и кому такой запрос IConsultation понадобился? Пользуйтесь ucc_Consultation.bsConsultation.Data');
   IConsultation(Obj) := ucc_Consultation.bsConsultation.Data;
   if (IConsultation(Obj) <> nil) then
    Result.SetOk;
  end;//IID.EQ(IConsultation)
//#UC END# *4A60B23E00C3_491C3E97009F_impl*
end;//TdsConsultation.COMQueryInterface

function TdsConsultation.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_491C3E97009F_var*
//#UC END# *4C6AB38800F3_491C3E97009F_var*
begin
//#UC START# *4C6AB38800F3_491C3E97009F_impl*
(* if (Consultation.Status * c_bsShowQueryForConsultations <> []) then
  Result := inherited MakeContainer
 else*)
  Result := TnsConsultationDocumentContainerNew.Make(DocInfo, ucc_Consultation.bsConsultation.Data);
//#UC END# *4C6AB38800F3_491C3E97009F_impl*
end;//TdsConsultation.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
