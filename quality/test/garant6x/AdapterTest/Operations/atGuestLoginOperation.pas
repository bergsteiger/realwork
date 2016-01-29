unit atGuestLoginOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atGuestLoginOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatGuestLoginOperation
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
 TatGuestLoginOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatGuestLoginOperation

implementation

uses
  atOperationEnv
  ;

// start class TatGuestLoginOperation

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