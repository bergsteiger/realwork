unit atOperationBase;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atOperationBase.pas"
// Стереотип: "UtilityPack"

interface

uses
 l3IntfUses
 , l3_Base
 , atExecutionContext
 , atOperationParametersList
 , atOperationParameter
 , atOperationEnv
 , SysUtils
 , Contnrs
;

type
 EInvalidOpParams = class(Exception)
 end;//EInvalidOpParams

 TatOperationsList = class;

 TatOperationBase = class(Tl3_Base)
  private
   f_ChildOperations: TatOperationsList;
   f_ExecutionContext: TatExecutionContext;
    {* Поле для свойства ExecutionContext }
  protected
   f_ParamList: TatOperationParametersList;
  protected
   function pm_GetParameters(const aName: AnsiString): TatOperationParameter;
   function pm_GetEnv: TatOperationEnv;
   procedure InitParamList; virtual;
   procedure ExecuteSelf; virtual; abstract;
   procedure ExecuteChilds; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function GetName: AnsiString; virtual;
   procedure Execute(eCtxt: TatExecutionContext);
   procedure AddChild(childOperation: TatOperationBase);
   procedure AfterFillingParamList; virtual;
    {* Вызывается генератором сценария после заполнения значений параметров.
Если операции надо что-то инициализировать, и для этого нужны значения параметров из сценария. }
  protected
   property ExecutionContext: TatExecutionContext
    read f_ExecutionContext
    write f_ExecutionContext;
   property Env: TatOperationEnv
    read pm_GetEnv;
  public
   property Parameters[const aName: AnsiString]: TatOperationParameter
    read pm_GetParameters;
 end;//TatOperationBase

 _ObjectListElement_ = TatOperationBase;
 _atTypedObjectList_Parent_ = TObjectList;
 {$Include w:\quality\test\garant6x\AdapterTest\MixIns\atTypedObjectList.imp.pas}
 TatOperationsList = class(_atTypedObjectList_)
 end;//TatOperationsList

 CTatOperationBase = class of TatOperationBase;

implementation

uses
 l3ImplUses
 , Math
 , atLogger
;

function TatOperationBase.pm_GetParameters(const aName: AnsiString): TatOperationParameter;
//#UC START# *4808A004003A_48076E9D013Eget_var*
//#UC END# *4808A004003A_48076E9D013Eget_var*
begin
//#UC START# *4808A004003A_48076E9D013Eget_impl*
    Result := f_ParamList.ParamByName[aName];
//#UC END# *4808A004003A_48076E9D013Eget_impl*
end;//TatOperationBase.pm_GetParameters

function TatOperationBase.pm_GetEnv: TatOperationEnv;
//#UC START# *5396F1F60329_48076E9D013Eget_var*
//#UC END# *5396F1F60329_48076E9D013Eget_var*
begin
//#UC START# *5396F1F60329_48076E9D013Eget_impl*
  Result := TatOperationEnv.Instance;
//#UC END# *5396F1F60329_48076E9D013Eget_impl*
end;//TatOperationBase.pm_GetEnv

procedure TatOperationBase.InitParamList;
//#UC START# *48089F3701B4_48076E9D013E_var*
//#UC END# *48089F3701B4_48076E9D013E_var*
begin
//#UC START# *48089F3701B4_48076E9D013E_impl*
  with f_ParamList do
    Add( ParamType.Create('iterations', 'Количество итераций', '1') );
//#UC END# *48089F3701B4_48076E9D013E_impl*
end;//TatOperationBase.InitParamList

procedure TatOperationBase.ExecuteChilds;
//#UC START# *48089F660238_48076E9D013E_var*
    var
      i, childsCount : integer;
//#UC END# *48089F660238_48076E9D013E_var*
begin
//#UC START# *48089F660238_48076E9D013E_impl*
  childsCount := f_ChildOperations.Count;
  if (childsCount <> 0) then
  begin
    Logger.Info('Начинаем выполнять детей операции "' + GetName + '"');
    for i := 0 to childsCount-1 do
      f_ChildOperations.Items[i].Execute(ExecutionContext);
    Logger.Info('Закончили выполнять детей операции "' + GetName + '"');
  end;
//#UC END# *48089F660238_48076E9D013E_impl*
end;//TatOperationBase.ExecuteChilds

class function TatOperationBase.GetName: AnsiString;
//#UC START# *48089F8B00C5_48076E9D013E_var*
//#UC END# *48089F8B00C5_48076E9D013E_var*
begin
//#UC START# *48089F8B00C5_48076E9D013E_impl*
  Result := Copy(ClassName, 4, Length(ClassName));
//#UC END# *48089F8B00C5_48076E9D013E_impl*
end;//TatOperationBase.GetName

procedure TatOperationBase.Execute(eCtxt: TatExecutionContext);
//#UC START# *48089FA50390_48076E9D013E_var*
    var
      i, iterCount, sleepTime : Integer;
//#UC END# *48089FA50390_48076E9D013E_var*
begin
//#UC START# *48089FA50390_48076E9D013E_impl*
  Assert(eCtxt <> nil, 'eCtxt <> nil');
  ExecutionContext := eCtxt;
  //
  sleepTime := RandomRange(eCtxt.MinDelay, eCtxt.MaxDelay);
  if (sleepTime > 0) then
  begin
    Logger.Info('Задержка на ' + IntToStr(sleepTime) + ' мс.');
    Sleep(sleepTime);
  end;
  //
  iterCount := Parameters['iterations'].AsInt;
  for i := 1 to iterCount do
  begin
    // выполняем себя
    Logger.Info('Начинаем выполнять операцию "' + GetName + '". Итерация ' + IntToStr(i) + '/' + IntToStr(iterCount));
    try
      ExecuteSelf;
    except
      on EAbort do
      begin
        Logger.Info('Выполнение операций прервано');
        Raise;
      end;
      on ex : Exception do
      begin
        Logger.Exception(ex, 'Исключение во время выполнения операции "' + GetName + '"');
        Raise;
      end;
    end;
    Logger.Info('Закончили выполнять операцию "' + GetName + '"');
    // выполняем детей
    ExecuteChilds;
  end;
//#UC END# *48089FA50390_48076E9D013E_impl*
end;//TatOperationBase.Execute

procedure TatOperationBase.AddChild(childOperation: TatOperationBase);
//#UC START# *48089FBE0004_48076E9D013E_var*
//#UC END# *48089FBE0004_48076E9D013E_var*
begin
//#UC START# *48089FBE0004_48076E9D013E_impl*
  f_ChildOperations.Add(childOperation);
//#UC END# *48089FBE0004_48076E9D013E_impl*
end;//TatOperationBase.AddChild

procedure TatOperationBase.AfterFillingParamList;
 {* Вызывается генератором сценария после заполнения значений параметров.
Если операции надо что-то инициализировать, и для этого нужны значения параметров из сценария. }
//#UC START# *492188F70140_48076E9D013E_var*
//#UC END# *492188F70140_48076E9D013E_var*
begin
//#UC START# *492188F70140_48076E9D013E_impl*
  // ничего не делаем
//#UC END# *492188F70140_48076E9D013E_impl*
end;//TatOperationBase.AfterFillingParamList

procedure TatOperationBase.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48076E9D013E_var*
//#UC END# *479731C50290_48076E9D013E_var*
begin
//#UC START# *479731C50290_48076E9D013E_impl*
  FreeAndNil(f_ParamList);
  FreeAndNil(f_ChildOperations);
  inherited;
//#UC END# *479731C50290_48076E9D013E_impl*
end;//TatOperationBase.Cleanup

procedure TatOperationBase.InitFields;
//#UC START# *47A042E100E2_48076E9D013E_var*
//#UC END# *47A042E100E2_48076E9D013E_var*
begin
//#UC START# *47A042E100E2_48076E9D013E_impl*
  inherited;
  f_ParamList := TatOperationParametersList.Create;
  f_ChildOperations := TatOperationsList.Create(true);
  InitParamList;
//#UC END# *47A042E100E2_48076E9D013E_impl*
end;//TatOperationBase.InitFields

{$Include w:\quality\test\garant6x\AdapterTest\MixIns\atTypedObjectList.imp.pas}

end.
