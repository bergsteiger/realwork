unit atGuestLoginOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atGuestLoginOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatGuestLoginOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
 end;//TatGuestLoginOperation

implementation

uses
 l3ImplUses
 , atOperationEnv
;

procedure TatGuestLoginOperation.ExecuteSelf;
//#UC START# *48089F460352_4808AF7B0011_var*
//#UC END# *48089F460352_4808AF7B0011_var*
begin
//#UC START# *48089F460352_4808AF7B0011_impl*
  inherited;
  with ExecutionContext do begin
    Env.EnvVar[ENV_F1_USER_NAME] := GblAdapterWorker.GuestLogin;
    UserWorkContext.CurrFolder := GblAdapterWorker.MyDocuments;
  end;  
//#UC END# *48089F460352_4808AF7B0011_impl*
end;//TatGuestLoginOperation.ExecuteSelf

end.
