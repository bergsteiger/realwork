unit dsConsultation;
 {* ��� ������� �� ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultation.pas"
// ���������: "ViewAreaControllerImp"
// ������� ������: "TdsConsultation" MUID: (491C3E97009F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConsultationDomainInterfaces
 , bsTypes
 , l3IID
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentAndListInterfaces
 , l3Types
 , DocumentInterfaces
 , WorkWithListInterfaces
 , nsDocumentLikeStateHolder
 , afwInterfaces
 , l3Interfaces
 , FoldersDomainInterfaces
 , UnderControlUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , bsTypesNew
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , UnderControlInterfaces
;

type
 _FormDataSourceType_ = IdsConsultation;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 TdsConsultation = class(_dsBaseDocumentPrim_, IdsConsultation)
  {* ��� ������� �� ������������ }
  private
   f_ShowingStatus: TbsConsultationStatuses;
   ucc_Consultation: IsdsConsultation;
  protected
   function pm_GetShowingStatus: TbsConsultationStatuses;
   procedure InitFields; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* ���������� ������� ���������� }
   function MakeContainer: InevDocumentContainer; override;
    {* ������������ ��������� ��������� }
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* �������������� ������ �� ��������� ������������� ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* ������� ������ �� ��������� ������������� ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
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

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

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
 {* ���������� ������� ���������� }
//#UC START# *4A60B23E00C3_491C3E97009F_var*
//#UC END# *4A60B23E00C3_491C3E97009F_var*
begin
//#UC START# *4A60B23E00C3_491C3E97009F_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and (ucc_Consultation.bsConsultation <> nil) then
  if IID.EQ(IConsultation) then
  begin
   Assert(false, '�� � ���� ����� ������ IConsultation �����������? ����������� ucc_Consultation.bsConsultation.Data');
   IConsultation(Obj) := ucc_Consultation.bsConsultation.Data;
   if (IConsultation(Obj) <> nil) then
    Result.SetOk;
  end;//IID.EQ(IConsultation)
//#UC END# *4A60B23E00C3_491C3E97009F_impl*
end;//TdsConsultation.COMQueryInterface

function TdsConsultation.MakeContainer: InevDocumentContainer;
 {* ������������ ��������� ��������� }
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

{$If NOT Defined(NoVCM)}
procedure TdsConsultation.InitRefs(const aDS: IvcmFormSetDataSource);
 {* �������������� ������ �� ��������� ������������� ���������� }
begin
 inherited;
 Supports(aDS, IsdsConsultation, ucc_Consultation);
end;//TdsConsultation.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsConsultation.ClearRefs;
 {* ������� ������ �� ��������� ������������� ���������� }
begin
 inherited;
 ucc_Consultation := nil;
end;//TdsConsultation.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
