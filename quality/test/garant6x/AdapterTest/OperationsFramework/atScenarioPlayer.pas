unit atScenarioPlayer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/OperationsFramework/atScenarioPlayer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::OperationsFramework::TatScenarioPlayer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atExecutionContext,
  atScenario
  ;

type
 TatScenarioPlayer = class(TObject)
 private
 // private fields
   f_Scenario : TatScenario;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public fields
   F_ExecutionContext : TatExecutionContext;
 public
 // public methods
   constructor Create(scenario: TatScenario); reintroduce;
   procedure Execute;
 end;//TatScenarioPlayer

implementation

uses
  SysUtils
  ;

// start class TatScenarioPlayer

constructor TatScenarioPlayer.Create(scenario: TatScenario);
//#UC START# *4808A73202A6_4808A6A50028_var*
//#UC END# *4808A73202A6_4808A6A50028_var*
begin
//#UC START# *4808A73202A6_4808A6A50028_impl*
    inherited Create;
    f_Scenario := scenario;
    F_ExecutionContext := TatExecutionContext.Create
//#UC END# *4808A73202A6_4808A6A50028_impl*
end;//TatScenarioPlayer.Create

procedure TatScenarioPlayer.Execute;
//#UC START# *4808A7470307_4808A6A50028_var*
//#UC END# *4808A7470307_4808A6A50028_var*
begin
//#UC START# *4808A7470307_4808A6A50028_impl*
  try
    f_Scenario.Execute(F_ExecutionContext);
  except
    on EAbort do Exit;
  end;  
//#UC END# *4808A7470307_4808A6A50028_impl*
end;//TatScenarioPlayer.Execute

destructor TatScenarioPlayer.Destroy;
//#UC START# *48077504027E_4808A6A50028_var*
//#UC END# *48077504027E_4808A6A50028_var*
begin
//#UC START# *48077504027E_4808A6A50028_impl*
    FreeAndNil(F_ExecutionContext);
    inherited;
//#UC END# *48077504027E_4808A6A50028_impl*
end;//TatScenarioPlayer.Destroy

end.