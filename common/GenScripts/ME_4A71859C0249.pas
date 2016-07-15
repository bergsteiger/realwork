{$IfNDef dsEdition_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEdition.imp.pas"
// ���������: "ViewAreaControllerImp"
// ������� ������: "dsEdition" MUID: (4A71859C0249)
// ��� ����: "_dsEdition_"

{$Define dsEdition_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _VScroll_Parent_ = _vcmFormDataSource_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\VScroll.imp.pas}
 _dsEdition_ = {abstract} class(_VScroll_, IdsEdition, InsVScrollListener)
  {* ������� ������� �����, ��� ������ � ���������� }
  protected
   ucc_CompareEditions: IsdsCompareEditions;
    {* ��������� ��������� �������� }
  protected
   function As_InsVScrollListener: InsVScrollListener;
    {* ����� ���������� ������ ���������� � InsVScrollListener }
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* �������������� ������ �� ��������� ������������� ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* ������� ������ �� ��������� ������������� ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_dsEdition_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
_VScroll_Parent_ = _vcmFormDataSource_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\VScroll.imp.pas}
_dsEdition_ = _VScroll_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsEdition_imp}

{$IfNDef dsEdition_imp_impl}

{$Define dsEdition_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\VScroll.imp.pas}

function _dsEdition_.As_InsVScrollListener: InsVScrollListener;
 {* ����� ���������� ������ ���������� � InsVScrollListener }
begin
 Result := Self;
end;//_dsEdition_.As_InsVScrollListener

procedure _dsEdition_.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4A71859C0249_var*
//#UC END# *479731C50290_4A71859C0249_var*
begin
//#UC START# *479731C50290_4A71859C0249_impl*
 UseCaseController.As_Il3ChangeNotifier.Unsubscribe(InsVScrollListener(Self));
 inherited;
//#UC END# *479731C50290_4A71859C0249_impl*
end;//_dsEdition_.Cleanup

procedure _dsEdition_.InitFields;
//#UC START# *47A042E100E2_4A71859C0249_var*
//#UC END# *47A042E100E2_4A71859C0249_var*
begin
//#UC START# *47A042E100E2_4A71859C0249_impl*
 inherited;
 UseCaseController.As_Il3ChangeNotifier.Subscribe(InsVScrollListener(Self));
//#UC END# *47A042E100E2_4A71859C0249_impl*
end;//_dsEdition_.InitFields

{$If NOT Defined(NoVCM)}
procedure _dsEdition_.InitRefs(const aDS: IvcmFormSetDataSource);
 {* �������������� ������ �� ��������� ������������� ���������� }
begin
 inherited;
 Supports(aDS, IsdsCompareEditions, ucc_CompareEditions);
end;//_dsEdition_.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _dsEdition_.ClearRefs;
 {* ������� ������ �� ��������� ������������� ���������� }
begin
 inherited;
 ucc_CompareEditions := nil;
end;//_dsEdition_.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf dsEdition_imp_impl}

{$EndIf dsEdition_imp}

