unit atOperationParameter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atOperationParameter.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atNamedParameter
;

type
 TatOperationParameter = class(TatNamedParameter)
  protected
   function pm_GetIsRequired: Boolean;
   function pm_GetValue: Variant; override;
   procedure pm_SetValue(const aValue: Variant); override;
  public
   property IsRequired: Boolean
    read pm_GetIsRequired;
 end;//TatOperationParameter

implementation

uses
 l3ImplUses
 , atOperationEnv
 , Variants
;

function TatOperationParameter.pm_GetIsRequired: Boolean;
//#UC START# *48089A77026D_48089A46022Dget_var*
//#UC END# *48089A77026D_48089A46022Dget_var*
begin
//#UC START# *48089A77026D_48089A46022Dget_impl*
  Result := NOT IsDefaultSet;
//#UC END# *48089A77026D_48089A46022Dget_impl*
end;//TatOperationParameter.pm_GetIsRequired

function TatOperationParameter.pm_GetValue: Variant;
//#UC START# *48086F180372_48089A46022Dget_var*
//#UC END# *48086F180372_48089A46022Dget_var*
begin
//#UC START# *48086F180372_48089A46022Dget_impl*
  Result := inherited pm_GetValue ;
  if VarType(Result) = varString then
    Result := TatOperationEnv.Instance.ExpandString(Result);
//#UC END# *48086F180372_48089A46022Dget_impl*
end;//TatOperationParameter.pm_GetValue

procedure TatOperationParameter.pm_SetValue(const aValue: Variant);
//#UC START# *48086F180372_48089A46022Dset_var*
//#UC END# *48086F180372_48089A46022Dset_var*
begin
//#UC START# *48086F180372_48089A46022Dset_impl*
  inherited pm_SetValue(aValue);
//#UC END# *48086F180372_48089A46022Dset_impl*
end;//TatOperationParameter.pm_SetValue

end.
