{$IfNDef vcmTinyUseCaseController_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas"
// Стереотип: "Impurity"

{$Define vcmTinyUseCaseController_imp}

{$If NOT Defined(NoVCM)}
 _InitDataType_ = IUnknown;
 {$Include vcmFormSetDataSourceWithoutData.imp.pas}
 _vcmTinyUseCaseController_ = class(_vcmFormSetDataSourceWithoutData_)
  {* Контролер прецедента без всяких данных }
  public
   constructor Create; reintroduce;
   class function Make: _SetType_; reintroduce;
 end;//_vcmTinyUseCaseController_

{$Else NOT Defined(NoVCM)}

{$Include vcmFormSetDataSourceWithoutData.imp.pas}
_vcmTinyUseCaseController_ = _vcmFormSetDataSourceWithoutData_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmTinyUseCaseController_imp}

{$IfNDef vcmTinyUseCaseController_imp_impl}

{$Define vcmTinyUseCaseController_imp_impl}

{$If NOT Defined(NoVCM)}
type _Instance_R_ = _vcmTinyUseCaseController_;

{$Include vcmFormSetDataSourceWithoutData.imp.pas}

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
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_vcmTinyUseCaseController_.Make
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmTinyUseCaseController_imp_impl}

{$EndIf vcmTinyUseCaseController_imp}

