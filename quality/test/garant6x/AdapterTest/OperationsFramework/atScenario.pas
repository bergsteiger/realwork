unit atScenario;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atScenario.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatScenario" MUID: (4808A3EC021F)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatScenario = class(TatOperationBase)
  private
   f_IsAlwaysRun: Boolean;
  protected
   procedure ExecuteSelf; override;
   procedure InitFields; override;
   procedure InitParamList; override;
 end;//TatScenario

implementation

uses
 l3ImplUses
 , atOperationParameter
 , atCRC32
 , SysUtils
 , Windows
 , atLogger
;

procedure TatScenario.ExecuteSelf;
//#UC START# *48089F460352_4808A3EC021F_var*
    var
      randomSeed : Integer;
      isRandomSeedByLogin : Boolean;
      login : String;
//#UC END# *48089F460352_4808A3EC021F_var*
begin
//#UC START# *48089F460352_4808A3EC021F_impl*
    inherited;
    //
    if (NOT f_IsAlwaysRun) then
    begin
      f_IsAlwaysRun := true;
      //
      Logger.Info('Process ID: %d', [GetCurrentProcessId]);
      //
      with ExecutionContext do
      begin
        MinDelay := Parameters['min_delay'].AsInt;
        MaxDelay := Parameters['max_delay'].AsInt;
        UserWorkContext.DocHistoryLength := Parameters['documents_history'].AsInt;
        UserWorkContext.ListHistoryLength := Parameters['list_history'].AsInt;
      end;
      //
      isRandomSeedByLogin := Parameters['is_random_seed_by_login'].AsBool;
      if (isRandomSeedByLogin) then
      begin
        login := AnsiUpperCase(ExecutionContext.F_LoginData.Login);
        RandSeed := Longint(ComputeCRC32(PChar(login), Length(login)));
      end
      else
      begin
        randomSeed := Parameters['random_seed'].AsInt;
        if (randomSeed <> -1) then
          RandSeed := randomSeed
        else
          Randomize;
      end;

    end;
//#UC END# *48089F460352_4808A3EC021F_impl*
end;//TatScenario.ExecuteSelf

procedure TatScenario.InitFields;
//#UC START# *47A042E100E2_4808A3EC021F_var*
//#UC END# *47A042E100E2_4808A3EC021F_var*
begin
//#UC START# *47A042E100E2_4808A3EC021F_impl*
  inherited;
  f_IsAlwaysRun := false;
//#UC END# *47A042E100E2_4808A3EC021F_impl*
end;//TatScenario.InitFields

procedure TatScenario.InitParamList;
//#UC START# *48089F3701B4_4808A3EC021F_var*
//#UC END# *48089F3701B4_4808A3EC021F_var*
begin
//#UC START# *48089F3701B4_4808A3EC021F_impl*
    inherited;
    with f_ParamList do
    begin
      f_ParamList.Add( ParamType.Create('min_delay', 'Минимальная случайная задержка', '0') );
      f_ParamList.Add( ParamType.Create('max_delay', 'Максимальная случайная задержка', '0') );
      f_ParamList.Add( ParamType.Create('list_history', 'Длина истории списков', '1') );
      f_ParamList.Add( ParamType.Create('documents_history', 'Длина истории документов', '1') );
      f_ParamList.Add( ParamType.Create('random_seed', 'Начальное состояние генератора случайных чисел', '-1') );
      f_ParamList.Add( ParamType.Create('is_random_seed_by_login', 'Начальное состояние генератора случайных чисел вычислять из имени пользователя', 'false') );
    end;
//#UC END# *48089F3701B4_4808A3EC021F_impl*
end;//TatScenario.InitParamList

end.
