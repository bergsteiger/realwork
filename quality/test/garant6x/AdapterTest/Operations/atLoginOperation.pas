unit atLoginOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atLoginOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatLoginOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatLoginOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatLoginOperation

implementation

uses
  atOperationEnv
  ;

// start class TatLoginOperation

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