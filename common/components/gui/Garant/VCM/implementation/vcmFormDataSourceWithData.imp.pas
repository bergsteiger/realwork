{$IfNDef vcmFormDataSourceWithData_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSourceWithData.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSourceWithData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormDataSourceWithData_imp}
{$If not defined(NoVCM)}
 _vcmFormDataSourceWithData_ = {mixin} class(_vcmFormDataSourceWithData_Parent_)
 private
 // private fields
   f_PartData : _InitDataType_;
    {* Поле для свойства PartData}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   procedure DoInit; virtual;
   procedure GotData; virtual;
     {* - данные изменились. }
 public
 // public methods
   constructor Create(const aDataSource: _UseCaseControllerType_;
    const aData: _InitDataType_); reintroduce;
     {* Конструктор }
   class function Make(const aDataSource: _UseCaseControllerType_;
    const aData: _InitDataType_): _FormDataSourceType_; reintroduce;
 protected
 // protected properties
   property PartData: _InitDataType_
     read f_PartData;
 end;//_vcmFormDataSourceWithData_
{$Else}

 _vcmFormDataSourceWithData_ = _vcmFormDataSourceWithData_Parent_;

{$IfEnd} //not NoVCM

{$Else vcmFormDataSourceWithData_imp}

{$If not defined(NoVCM)}

// start class _vcmFormDataSourceWithData_

constructor _vcmFormDataSourceWithData_.Create(const aDataSource: _UseCaseControllerType_;
  const aData: _InitDataType_);
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
  Result := _Instance_R_(l_Inst);
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure _vcmFormDataSourceWithData_.DoInit;
//#UC START# *492BF7900310_501802270075_var*
//#UC END# *492BF7900310_501802270075_var*
begin
//#UC START# *492BF7900310_501802270075_impl*
 // - ничего не делаем
//#UC END# *492BF7900310_501802270075_impl*
end;//_vcmFormDataSourceWithData_.DoInit

procedure _vcmFormDataSourceWithData_.GotData;
//#UC START# *492ACF630072_501802270075_var*
//#UC END# *492ACF630072_501802270075_var*
begin
//#UC START# *492ACF630072_501802270075_impl*
 // - ничего не делаем
//#UC END# *492ACF630072_501802270075_impl*
end;//_vcmFormDataSourceWithData_.GotData

procedure _vcmFormDataSourceWithData_.Cleanup;
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

{$IfEnd} //not NoVCM

{$EndIf vcmFormDataSourceWithData_imp}
