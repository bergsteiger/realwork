{$IfNDef vcmTinyUseCaseController_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmTinyUseCaseController.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmTinyUseCaseController
//
// ��������� ���������� ��� ������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmTinyUseCaseController_imp}
{$If not defined(NoVCM)}
 _InitDataType_ = IUnknown;
 {$Include ..\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 _vcmTinyUseCaseController_ = {mixin} class(_vcmFormSetDataSourceWithoutData_)
  {* ��������� ���������� ��� ������ ������ }
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: _SetType_; reintroduce;
 end;//_vcmTinyUseCaseController_
{$Else}

 {$Include ..\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 _vcmTinyUseCaseController_ = _vcmFormSetDataSourceWithoutData_;

{$IfEnd} //not NoVCM

{$Else vcmTinyUseCaseController_imp}

{$If not defined(NoVCM)}


{$Include ..\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

// start class _vcmTinyUseCaseController_

constructor _vcmTinyUseCaseController_.Create;
//#UC START# *4947799403BE_494778CD004F_var*
//#UC END# *4947799403BE_494778CD004F_var*
begin
//#UC START# *4947799403BE_494778CD004F_impl*
 inherited Create(nil);
//#UC END# *4947799403BE_494778CD004F_impl*
end;//_vcmTinyUseCaseController_.Create

class function _vcmTinyUseCaseController_.Make: _SetType_;
var
 l_Inst : _vcmTinyUseCaseController_;
begin
 l_Inst := Create;
 try
  Result := _Instance_R_(l_Inst);
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$IfEnd} //not NoVCM

{$EndIf vcmTinyUseCaseController_imp}
