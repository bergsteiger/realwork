{$IfNDef dsEdition_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editions"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/dsEdition.imp.pas"
// �����: 30.07.2009 15:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������������� �������::CompareEditions::Editions::Editions::dsEdition
//
// ������� ������� �����, ��� ������ � ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsEdition_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _VScroll_Parent_ = _vcmFormDataSource_;
 {$Include ..\Editions\VScroll.imp.pas}
 _dsEdition_ = {abstract vac} class(_VScroll_, IdsEdition, InsVScrollListener {from IdsEdition})
  {* ������� ������� �����, ��� ������ � ���������� }
 protected
  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
 protected
 // protected fields
   ucc_CompareEditions : IsdsCompareEditions;
    {* ��������� ��������� ��������}
 protected
 // ������ �������������� � ����������� �����������
   function As_InsVScrollListener: InsVScrollListener;
 end;//_dsEdition_
{$Else}

 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _VScroll_Parent_ = _vcmFormDataSource_;
 {$Include ..\Editions\VScroll.imp.pas}
 _dsEdition_ = _VScroll_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dsEdition_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

{$Include ..\Editions\VScroll.imp.pas}

// start class _dsEdition_

procedure _dsEdition_.Cleanup;
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

procedure _dsEdition_.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsCompareEditions, ucc_CompareEditions);
end;

procedure _dsEdition_.ClearRefs;
begin
 inherited;
 ucc_CompareEditions := nil;
end;

// ������ �������������� � ����������� �����������

function _dsEdition_.As_InsVScrollListener: InsVScrollListener;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dsEdition_imp}
