{$IfNDef vcmFormDataSourceWithData_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceWithData.imp.pas"
// Стереотип: "Impurity"

{$Define vcmFormDataSourceWithData_imp}

{$If NOT Defined(NoVCM)}
type
 // _InitDataType_

 _vcmFormDataSourceWithData_ = class(_vcmFormDataSourceWithData_Parent_)
  private
   f_PartData: _InitDataType_;
    {* Поле для свойства PartData }
  protected
   procedure DoInit; virtual;
   procedure GotData; virtual;
    {* - данные изменились. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   constructor Create(const aDataSource: _UseCaseControllerType_;
    const aData: _InitDataType_); reintroduce;
    {* Конструктор }
   class function Make(const aDataSource: _UseCaseControllerType_;
    const aData: _InitDataType_): _FormDataSourceType_; reintroduce;
  protected
   property PartData: _InitDataType_
    read f_PartData;
 end;//_vcmFormDataSourceWithData_

{$Else NOT Defined(NoVCM)}

_vcmFormDataSourceWithData_ = _vcmFormDataSourceWithData_Parent_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormDataSourceWithData_imp}

{$IfNDef vcmFormDataSourceWithData_imp_impl}

{$Define vcmFormDataSourceWithData_imp_impl}

{$If NOT Defined(NoVCM)}
constructor _vcmFormDataSourceWithData_.Create(const aDataSource: _UseCaseControllerType_;
 const aData: _InitDataType_);
 {* Конструктор }
//#UC START# *492ACF1E01C2_501802270075_var*
//#UC END# *492ACF1E01C2_501802270075_var*
begin
//#UC START# *492ACF1E01C2_501802270075_impl*
 inherited Create(aDataSource);
 f_PartData := aData;
 DoInit;
//#UC END# *492ACF1E01C2_501802270075_impl*
end;//_vcmFormDataSourceWithData_.Create

class function _vcmFormDataSourceWithData_.Make(const aDataSource: _UseCaseControllerType_;
 const aData: _InitDataType_): _FormDataSourceType_;
var
 l_Inst : _vcmFormDataSourceWithData_;
begin
 l_Inst := Create(aDataSource, aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_vcmFormDataSourceWithData_.Make

procedure _vcmFormDataSourceWithData_.DoInit;
//#UC START# *492BF7900310_501802270075_var*
//#UC END# *492BF7900310_501802270075_var*
begin
//#UC START# *492BF7900310_501802270075_impl*
 // - ничего не делаем
//#UC END# *492BF7900310_501802270075_impl*
end;//_vcmFormDataSourceWithData_.DoInit

procedure _vcmFormDataSourceWithData_.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_501802270075_var*
//#UC END# *492ACF630072_501802270075_var*
begin
//#UC START# *492ACF630072_501802270075_impl*
 // - ничего не делаем
//#UC END# *492ACF630072_501802270075_impl*
end;//_vcmFormDataSourceWithData_.GotData

procedure _vcmFormDataSourceWithData_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_501802270075_var*
//#UC END# *479731C50290_501802270075_var*
begin
//#UC START# *479731C50290_501802270075_impl*
 f_PartData := nil;
 inherited;
//#UC END# *479731C50290_501802270075_impl*
end;//_vcmFormDataSourceWithData_.Cleanup

procedure _vcmFormDataSourceWithData_.InitFields;
//#UC START# *47A042E100E2_501802270075_var*
//#UC END# *47A042E100E2_501802270075_var*
begin
//#UC START# *47A042E100E2_501802270075_impl*
 inherited;
 if Assigned(PartData) then
  GotData
//#UC END# *47A042E100E2_501802270075_impl*
end;//_vcmFormDataSourceWithData_.InitFields
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormDataSourceWithData_imp_impl}

{$EndIf vcmFormDataSourceWithData_imp}

