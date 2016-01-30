unit atScenarioPlayer;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atScenarioPlayer.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atScenario
 , atExecutionContext
;

type
 TatScenarioPlayer = class(TObject)
  private
   f_Scenario: TatScenario;
  public
   F_ExecutionContext: TatExecutionContext;
  public
   constructor Create(scenario: TatScenario); reintroduce;
   procedure Execute;
   destructor Destroy; override;
 end;//TatScenarioPlayer

implementation

uses
 l3ImplUses
 , SysUtils
;

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
