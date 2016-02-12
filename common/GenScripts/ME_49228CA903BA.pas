unit sdsConsultation;
 {* ������ ������ ���������� "������������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\sdsConsultation.pas"
// ���������: "UseCaseControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConsultationDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3IID
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = IbsConsultation;
 _SetType_ = IsdsConsultation;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsConsultation = class(_vcmFormSetDataSourceWithoutData_, IsdsConsultation, IsdsGotoPointDataMaker)
  {* ������ ������ ���������� "������������" }
  private
   f_IsListChanged: Boolean;
   f_NeedMark: Boolean;
   f_Consultation: IbsConsultation;
    {* ���� ��� �������� Consultation }
   f_dsConsultation: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ dsConsultation }
   f_dsList: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ dsList }
   f_DSConsultationMark: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ DSConsultationMark }
  protected
   function As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
    {* ����� ���������� ������ ���������� � IsdsGotoPointDataMaker }
   function MakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo;
    {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
           ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
   function pm_GetdsConsultation: IdsConsultation;
   function pm_GetdsList: IdsDocumentList;
   function pm_GetDSConsultationMark(aForce: Boolean): IdsConsultationMark;
   procedure GiveMark; { can raise EbsConsultationAlreadyMark, EbsConsultationWasDeleted }
    {* ���� ������.
           ��������� ����������:
           - EbsConsultationAlreadyMark }
   function NeedGiveMark: Boolean;
   procedure ConfirmPayment(anAccept: Boolean); { can raise EbsPaymentForbidden, EbsConsultationWasDeleted, EbsConsultationAlreadyConfirmed }
    {* ����������� ������ ������������. ��/���;
           ����������:
             - EbsPaymentForbidden }
   procedure UpdateAnswer;
    {* ���������� ����� }
   procedure ListChanged;
    {* ������ ���������� ������������ ������� �������������. ������������
           ��� ������������ ������������ }
   procedure ConsultationWasMarked(const aConsultation: IsdsConsultation);
    {* ������������ ���� �������. ��� ������ ����� ������������ ������� �
           ������, ��� ���� ��� �� ������������ ������� �� ������ � �� �����
           ����������, ����� ������ ������� ������� }
   procedure MarkSended;
   function Get_bsConsultation: IbsConsultation;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - ���������� ����� ��������� ������ �������������. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* ������� ������ �� ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* ���������� ������� ���������� }
  protected
   property Consultation: IbsConsultation
    read f_Consultation;
 end;//TsdsConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsConsultation
 , deDocInfo
 , dsConsultationMark
 , dsConsultationList
 , deDocumentList
 , DynamicDocListUnit
 , bsTypes
 , ConsultingUnit
 , bsConsultationManager
 , l3Base
 , SysUtils
 , bsUtils
 , DebugStr
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If not Declared(_SetDataType_)}type _SetDataType_ = IvcmData;{$IfEnd}

type _Instance_R_ = TsdsConsultation;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

function TsdsConsultation.As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
 {* ����� ���������� ������ ���������� � IsdsGotoPointDataMaker }
begin
 Result := Self;
end;//TsdsConsultation.As_IsdsGotoPointDataMaker

function TsdsConsultation.MakeGotoPointData(const aDocument: IDocument;
 aRefType: TDocumentPositionType;
 aPos: Longword): IdeDocInfo;
 {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
           ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
//#UC START# *492597A602F6_49228CA903BA_var*
//#UC END# *492597A602F6_49228CA903BA_var*
begin
//#UC START# *492597A602F6_49228CA903BA_impl*
 Result := TdeDocInfo.Make(aDocument, TbsDocPos_C(aRefType, aPos));
//#UC END# *492597A602F6_49228CA903BA_impl*
end;//TsdsConsultation.MakeGotoPointData

function TsdsConsultation.pm_GetdsConsultation: IdsConsultation;
//#UC START# *492EB71000D6_49228CA903BAget_var*
//#UC END# *492EB71000D6_49228CA903BAget_var*
begin
//#UC START# *492EB71000D6_49228CA903BAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EB71000D6_49228CA903BAget_impl*
end;//TsdsConsultation.pm_GetdsConsultation

function TsdsConsultation.pm_GetdsList: IdsDocumentList;
//#UC START# *492EB77C0125_49228CA903BAget_var*
//#UC END# *492EB77C0125_49228CA903BAget_var*
begin
//#UC START# *492EB77C0125_49228CA903BAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EB77C0125_49228CA903BAget_impl*
end;//TsdsConsultation.pm_GetdsList

function TsdsConsultation.pm_GetDSConsultationMark(aForce: Boolean): IdsConsultationMark;
//#UC START# *492EB793009E_49228CA903BAget_var*
//#UC END# *492EB793009E_49228CA903BAget_var*
begin
//#UC START# *492EB793009E_49228CA903BAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EB793009E_49228CA903BAget_impl*
end;//TsdsConsultation.pm_GetDSConsultationMark

procedure TsdsConsultation.GiveMark; { can raise EbsConsultationAlreadyMark, EbsConsultationWasDeleted }
 {* ���� ������.
           ��������� ����������:
           - EbsConsultationAlreadyMark }
//#UC START# *492EB7BA035E_49228CA903BA_var*
//#UC END# *492EB7BA035E_49228CA903BA_var*
begin
//#UC START# *492EB7BA035E_49228CA903BA_impl*
 // ������������ ���� �������:
 if Consultation.WasDeleted then
  raise EbsConsultationWasDeleted.Create('')
 else
  // ������������ ��� ���� �������:
  if bs_csEstimationSent in Consultation.Status then
   raise EbsConsultationAlreadyMark.Create('');
 f_DSConsultationMark.NeedMake := vcm_nmForce;
 Refresh;
//#UC END# *492EB7BA035E_49228CA903BA_impl*
end;//TsdsConsultation.GiveMark

function TsdsConsultation.NeedGiveMark: Boolean;
//#UC START# *492EB82F0391_49228CA903BA_var*
//#UC END# *492EB82F0391_49228CA903BA_var*
begin
//#UC START# *492EB82F0391_49228CA903BA_impl*
 with Consultation do
  Result := (f_NeedMark and not (bs_csEstimationSent in Status)) and not WasDeleted;
//#UC END# *492EB82F0391_49228CA903BA_impl*
end;//TsdsConsultation.NeedGiveMark

procedure TsdsConsultation.ConfirmPayment(anAccept: Boolean); { can raise EbsPaymentForbidden, EbsConsultationWasDeleted, EbsConsultationAlreadyConfirmed }
 {* ����������� ������ ������������. ��/���;
           ����������:
             - EbsPaymentForbidden }
//#UC START# *492EB8620306_49228CA903BA_var*
//#UC END# *492EB8620306_49228CA903BA_var*
begin
//#UC START# *492EB8620306_49228CA903BA_impl*
 if Consultation.WasDeleted then
  raise EbsConsultationWasDeleted.Create('')
 else
  if not (bs_csPaymentRequest in Consultation.Status) then
   raise EbsConsultationAlreadyConfirmed.Create('');
 try
  Consultation.Data.PaymentConfirm(anAccept);
 except
  on EPaymentForbidden do
   raise EbsPaymentForbidden.Create('');
 end;//try..except
 // ������ ��������������, ���� ��� ��������� � ������������:
 if IsConsultationManagerAssigned then
  g_ConsultationManager.UnreadChanged;
 // ����� �������������, ����������� ����� ����������, ����������� �����������:
 UpdateAnswer;
//#UC END# *492EB8620306_49228CA903BA_impl*
end;//TsdsConsultation.ConfirmPayment

procedure TsdsConsultation.UpdateAnswer;
 {* ���������� ����� }
//#UC START# *492EB8820218_49228CA903BA_var*
//#UC END# *492EB8820218_49228CA903BA_var*
begin
//#UC START# *492EB8820218_49228CA903BA_impl*
 if Assigned(f_dsConsultation) then
  f_dsConsultation.Clear;
 if Consultation <> nil then
  Consultation.RefreshText;
 Refresh;
//#UC END# *492EB8820218_49228CA903BA_impl*
end;//TsdsConsultation.UpdateAnswer

procedure TsdsConsultation.ListChanged;
 {* ������ ���������� ������������ ������� �������������. ������������
           ��� ������������ ������������ }
//#UC START# *492EB91F0391_49228CA903BA_var*
//#UC END# *492EB91F0391_49228CA903BA_var*
begin
//#UC START# *492EB91F0391_49228CA903BA_impl*
 f_IsListChanged := True;
//#UC END# *492EB91F0391_49228CA903BA_impl*
end;//TsdsConsultation.ListChanged

procedure TsdsConsultation.ConsultationWasMarked(const aConsultation: IsdsConsultation);
 {* ������������ ���� �������. ��� ������ ����� ������������ ������� �
           ������, ��� ���� ��� �� ������������ ������� �� ������ � �� �����
           ����������, ����� ������ ������� ������� }
//#UC START# *492EB93700FF_49228CA903BA_var*
var
 l_Consultation: IbsConsultation;
//#UC END# *492EB93700FF_49228CA903BA_var*
begin
//#UC START# *492EB93700FF_49228CA903BA_impl*
 l_Consultation := aConsultation.bsConsultation;
 if (l_Consultation <> nil) then
 try
  if bsIsSame(l_Consultation.Data, Consultation.Data) and
     (bs_csEstimationSent in l_Consultation.Status) then
   MarkSended;
 finally
  l_Consultation := nil;
 end;//try..finally
//#UC END# *492EB93700FF_49228CA903BA_impl*
end;//TsdsConsultation.ConsultationWasMarked

procedure TsdsConsultation.MarkSended;
//#UC START# *492EBCE002E0_49228CA903BA_var*
//#UC END# *492EBCE002E0_49228CA903BA_var*
begin
//#UC START# *492EBCE002E0_49228CA903BA_impl*
 f_NeedMark := False;
 UpdateAnswer;
//#UC END# *492EBCE002E0_49228CA903BA_impl*
end;//TsdsConsultation.MarkSended

function TsdsConsultation.Get_bsConsultation: IbsConsultation;
//#UC START# *4F4E1E06038E_49228CA903BAget_var*
//#UC END# *4F4E1E06038E_49228CA903BAget_var*
begin
//#UC START# *4F4E1E06038E_49228CA903BAget_impl*
 Result := Self.Consultation;
//#UC END# *4F4E1E06038E_49228CA903BAget_impl*
end;//TsdsConsultation.Get_bsConsultation

procedure TsdsConsultation.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_49228CA903BA_var*
//#UC END# *479731C50290_49228CA903BA_var*
begin
//#UC START# *479731C50290_49228CA903BA_impl*
 f_Consultation := nil;
 inherited;
//#UC END# *479731C50290_49228CA903BA_impl*
end;//TsdsConsultation.Cleanup

procedure TsdsConsultation.InitFields;
//#UC START# *47A042E100E2_49228CA903BA_var*
//#UC END# *47A042E100E2_49228CA903BA_var*
begin
//#UC START# *47A042E100E2_49228CA903BA_impl*
 inherited;
 f_IsListChanged := False;
//#UC END# *47A042E100E2_49228CA903BA_impl*
end;//TsdsConsultation.InitFields

{$If NOT Defined(NoVCM)}
procedure TsdsConsultation.DataExchange;
 {* - ���������� ����� ��������� ������ �������������. }
//#UC START# *47F37DF001FE_49228CA903BA_var*
//#UC END# *47F37DF001FE_49228CA903BA_var*
begin
//#UC START# *47F37DF001FE_49228CA903BA_impl*
 f_Consultation := InitialUseCaseData;
 Assert(f_Consultation <> nil);
  Assert(Assigned(Consultation.Data), caConsultationNotReceived);
  if Consultation.Status * c_bsSetReadStatusForConsultations <> [] then
  begin
   with Consultation do
   begin
    IsStatusChached := False;
    try
     Data.Read;
      // - ��������� ������ ������������ ���������;
    finally
     IsStatusChached := True;
    end;//try..finally
   end;//with Consultation do
   if IsConsultationManagerAssigned then
    g_ConsultationManager.UnreadChanged;
  end;//if Consultation.Status * c_bsSetReadStatusForConsultations <> [] then
  f_NeedMark := Consultation.Status * c_bsNeedMarkForConsultations <> [];
//#UC END# *47F37DF001FE_49228CA903BA_impl*
end;//TsdsConsultation.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsConsultation.GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
//#UC START# *491B02D80112_49228CA903BA_var*
var
 l_Consultation   : IbsConsultation;
 l_dsConsultation : IdsConsultation;
//#UC END# *491B02D80112_49228CA903BA_var*
begin
//#UC START# *491B02D80112_49228CA903BA_impl*
 Result := false;
 if not f_IsListChanged then
 begin
   // - ���� ������ ������������ ������, �� ���������������, ���� ����
   //   ��������� �� �� ������������;
  l_Consultation := aDataSource.bsConsultation;
  if (l_Consultation <> nil) then
   Result := bsIsSame(l_Consultation.Data, Consultation.Data);
             // - �������������� ������������ ���������;
 end;//not f_IsListChanged
 if Result then
 begin
  l_dsConsultation := Self.pm_GetDsConsultation;
  Result := (l_dsConsultation <> nil) and
            (l_Consultation.Status = l_dsConsultation.ShowingStatus);
            // - ������ ������������ �� ���������;
 end;//Result
//#UC END# *491B02D80112_49228CA903BA_impl*
end;//TsdsConsultation.GetIsNeedChangePosition
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TsdsConsultation.ClearAreas;
 {* ������� ������ �� ������� ����� }
//#UC START# *4938F7E702B7_49228CA903BA_var*
//#UC END# *4938F7E702B7_49228CA903BA_var*
begin
//#UC START# *4938F7E702B7_49228CA903BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_49228CA903BA_impl*
end;//TsdsConsultation.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

function TsdsConsultation.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* ���������� ������� ���������� }
//#UC START# *4A60B23E00C3_49228CA903BA_var*
//#UC END# *4A60B23E00C3_49228CA903BA_var*
begin
//#UC START# *4A60B23E00C3_49228CA903BA_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IbsConsultation) then
  begin
   Assert(false, '�� ����������� �������� IbsConsultation � IsdsConsultation, ����� Supports. ����������� ��������� bsConsultation �� IsdsConsultation');
   IbsConsultation(Obj) := Consultation;
   Result.SetOK;
  end;//IID.EQ(IbsConsultation)
//#UC END# *4A60B23E00C3_49228CA903BA_impl*
end;//TsdsConsultation.COMQueryInterface

procedure TsdsConsultation.ClearFields;
begin
 f_Consultation := nil;
 f_dsConsultation := nil;
 f_dsList := nil;
 f_DSConsultationMark := nil;
 inherited;
end;//TsdsConsultation.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
