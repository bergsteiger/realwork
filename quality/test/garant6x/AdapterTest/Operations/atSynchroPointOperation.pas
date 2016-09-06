unit atSynchroPointOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atSynchroPointOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSynchroPointOperation" MUID: (492154F303D9)

interface

uses
 l3IntfUses
 , atOperationBase
 , atSynchroPoint
;

type
 TatSynchroPointOperation = class(TatOperationBase)
  private
   f_SynchroPoint: TatSynchroPoint;
  protected
   procedure ExecuteSelf; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitParamList; override;
  public
   procedure AfterFillingParamList; override;
    {* Вызывается генератором сценария после заполнения значений параметров.
Если операции надо что-то инициализировать, и для этого нужны значения параметров из сценария. }
 end;//TatSynchroPointOperation

implementation

uses
 l3ImplUses
 , atLogger
 , SysUtils
 //#UC START# *492154F303D9impl_uses*
 //#UC END# *492154F303D9impl_uses*
;

procedure TatSynchroPointOperation.ExecuteSelf;
//#UC START# *48089F460352_492154F303D9_var*
  var
    l_TimeOut : LongWord;
//#UC END# *48089F460352_492154F303D9_var*
begin
//#UC START# *48089F460352_492154F303D9_impl*
  if f_ParamList.ParamByName['timeout'].AsInt = -1 then
    l_TimeOut := $FFFFFFFF // бесконечно
  else
    l_TimeOut := f_ParamList.ParamByName['timeout'].AsInt;
  //
  Logger.Info('Начинаем синхронизацию на точке "%s"', [f_ParamList.ParamByName['point_name'].AsStr]);
  if f_SynchroPoint.Synchronize(l_TimeOut) then
    Logger.Info('Синхронизация прошла успешно')
  else
    Logger.Warning('Не удалось синхронизироваться за отведенное время (%u)', [l_TimeOut]);
//#UC END# *48089F460352_492154F303D9_impl*
end;//TatSynchroPointOperation.ExecuteSelf

procedure TatSynchroPointOperation.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_492154F303D9_var*
//#UC END# *479731C50290_492154F303D9_var*
begin
//#UC START# *479731C50290_492154F303D9_impl*
  FreeAndNil(f_SynchroPoint);
  inherited;
//#UC END# *479731C50290_492154F303D9_impl*
end;//TatSynchroPointOperation.Cleanup

procedure TatSynchroPointOperation.InitParamList;
//#UC START# *48089F3701B4_492154F303D9_var*
//#UC END# *48089F3701B4_492154F303D9_var*
begin
//#UC START# *48089F3701B4_492154F303D9_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('point_name', 'Имя точки синхронизации') );
    Add( ParamType.Create('timeout', 'Время в течение которого ждем достижения синхроинзации') );
  end;
//#UC END# *48089F3701B4_492154F303D9_impl*
end;//TatSynchroPointOperation.InitParamList

procedure TatSynchroPointOperation.AfterFillingParamList;
 {* Вызывается генератором сценария после заполнения значений параметров.
Если операции надо что-то инициализировать, и для этого нужны значения параметров из сценария. }
//#UC START# *492188F70140_492154F303D9_var*
//#UC END# *492188F70140_492154F303D9_var*
begin
//#UC START# *492188F70140_492154F303D9_impl*
  inherited;
  f_SynchroPoint := TatSynchroPoint.Create( f_ParamList.ParamByName['point_name'].AsStr );
//#UC END# *492188F70140_492154F303D9_impl*
end;//TatSynchroPointOperation.AfterFillingParamList

end.
