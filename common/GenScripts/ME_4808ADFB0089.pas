unit atLoginOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atLoginOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatLoginOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
 end;//TatLoginOperation

implementation

uses
 l3ImplUses
 , atOperationEnv
;

procedure TatLoginOperation.ExecuteSelf;
//#UC START# *48089F460352_4808ADFB0089_var*
//#UC END# *48089F460352_4808ADFB0089_var*
begin
//#UC START# *48089F460352_4808ADFB0089_impl*
  inherited;
  with ExecutionContext do
  begin
    GblAdapterWorker.ForceLogin(F_LoginData.Login, F_LoginData.Password);
    Env.EnvVar[ENV_F1_USER_NAME] := F_LoginData.Login;
    UserWorkContext.CurrFolder := GblAdapterWorker.MyDocuments;
  end;
//#UC END# *48089F460352_4808ADFB0089_impl*
end;//TatLoginOperation.ExecuteSelf

end.
