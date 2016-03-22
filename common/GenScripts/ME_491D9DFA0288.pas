unit atSynchroPoint;
 {* "Точка синхронизации". Для синхронизации типа "дойти до определенного места и ждать пока все не достигнут этого места". }

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atSynchroPoint.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSynchroPoint" MUID: (491D9DFA0288)

interface

uses
 l3IntfUses
 , l3_Base
 , atNamedMutex
 , atSharedBuffer
 , SyncObjs
;

type
 PSyncData = ^TSyncData;

 TSyncData = record
  Total: Integer;
  Waiting: Integer;
 end;//TSyncData

 TatSynchroPoint = class(Tl3_Base)
  {* "Точка синхронизации". Для синхронизации типа "дойти до определенного места и ждать пока все не достигнут этого места". }
  private
   f_Mutex: TatNamedMutex;
   f_SharedBuf: TatSharedBuffer;
   f_SyncData: PSyncData;
   f_ContinueEvent: TEvent;
  private
   procedure Register; virtual;
   procedure Unregister; virtual;
   function ContinueIfSynchronized: Boolean; virtual;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aName: AnsiString); reintroduce;
   function Synchronize(aTimeOut: LongWord): Boolean; virtual;
    {* Функция возвращает управление либо после успешной синхронизации (когда все дошли до вызова Synchronize), либо по истечении таймаута. В первом случае резельтат - true, во втором - false. }
 end;//TatSynchroPoint

implementation

uses
 l3ImplUses
 , SysUtils
;

constructor TatSynchroPoint.Create(const aName: AnsiString);
//#UC START# *491DA1A60030_491D9DFA0288_var*
//#UC END# *491DA1A60030_491D9DFA0288_var*
begin
//#UC START# *491DA1A60030_491D9DFA0288_impl*
  inherited Create;
  //
  f_Mutex := TatNamedMutex.Create(aName);
  f_ContinueEvent := TEvent.Create(nil, true, false, '{DE90ACF0-3AB6-4004-B9BF-24A328D271A4}_' +aName);
  // хранилище для данных синхронизации
  f_SharedBuf := TatSharedBuffer.Create(aName, SizeOf(TSyncData));
  f_SyncData := f_SharedBuf.Value;
  // регистрируемся в точке синхронизации
  Register;
//#UC END# *491DA1A60030_491D9DFA0288_impl*
end;//TatSynchroPoint.Create

function TatSynchroPoint.Synchronize(aTimeOut: LongWord): Boolean;
 {* Функция возвращает управление либо после успешной синхронизации (когда все дошли до вызова Synchronize), либо по истечении таймаута. В первом случае резельтат - true, во втором - false. }
//#UC START# *491DA82B01A2_491D9DFA0288_var*
//#UC END# *491DA82B01A2_491D9DFA0288_var*
begin
//#UC START# *491DA82B01A2_491D9DFA0288_impl*
  if f_Mutex.Acquire then
    try
      // увеличиваем количество ждущих на единицу (самого себй)
      Assert(f_SyncData.Waiting >= 0, 'invalid f_SyncData.Waiting');
      Inc(f_SyncData.Waiting);
      // проверяем, синхронизировались ли
      ContinueIfSynchronized;
    finally
      f_Mutex.Release;
    end;
  // ждем синхонизации
  Result := f_ContinueEvent.WaitFor(aTimeOut) = wrSignaled;
  // если не дождались то убираем себя из списка ждущих
  if NOT Result then
    if f_Mutex.Acquire then
      try
        if (f_SyncData.Waiting > 0) then
          Dec(f_SyncData.Waiting);
      finally
        f_Mutex.Release;
      end;
//#UC END# *491DA82B01A2_491D9DFA0288_impl*
end;//TatSynchroPoint.Synchronize

procedure TatSynchroPoint.Register;
//#UC START# *491DAE930239_491D9DFA0288_var*
//#UC END# *491DAE930239_491D9DFA0288_var*
begin
//#UC START# *491DAE930239_491D9DFA0288_impl*
  if f_Mutex.Acquire then
    try
      Inc(f_SyncData.Total);
    finally
      f_Mutex.Release;
    end;
//#UC END# *491DAE930239_491D9DFA0288_impl*
end;//TatSynchroPoint.Register

procedure TatSynchroPoint.Unregister;
//#UC START# *491DAE9E02BF_491D9DFA0288_var*
//#UC END# *491DAE9E02BF_491D9DFA0288_var*
begin
//#UC START# *491DAE9E02BF_491D9DFA0288_impl*
  if f_Mutex.Acquire then
    try
      Dec(f_SyncData.Total);
      // а теперь проверяем, может все ждали только нас, в этом случае надо отпустить всех
      ContinueIfSynchronized;
    finally
      f_Mutex.Release;
    end;
//#UC END# *491DAE9E02BF_491D9DFA0288_impl*
end;//TatSynchroPoint.Unregister

function TatSynchroPoint.ContinueIfSynchronized: Boolean;
//#UC START# *491DB4E001EF_491D9DFA0288_var*
//#UC END# *491DB4E001EF_491D9DFA0288_var*
begin
//#UC START# *491DB4E001EF_491D9DFA0288_impl*
  Assert(f_SyncData.Waiting <= f_SyncData.Total, 'f_SyncData.Waiting > f_SyncData.Total !');
  Result := f_SyncData.Waiting = f_SyncData.Total;
  if Result then
  begin // если больше некого ждать
    f_ContinueEvent.SetEvent; // то поднимаем event
    f_SyncData.Waiting := 0; // и обнуляем число ждущих
  end
  else if (f_ContinueEvent.WaitFor(0) = wrSignaled) then
    f_ContinueEvent.ResetEvent; // если есть кого ждать и event не сброшен, то сбрасываем
//#UC END# *491DB4E001EF_491D9DFA0288_impl*
end;//TatSynchroPoint.ContinueIfSynchronized

procedure TatSynchroPoint.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_491D9DFA0288_var*
//#UC END# *479731C50290_491D9DFA0288_var*
begin
//#UC START# *479731C50290_491D9DFA0288_impl*
  Unregister;
  FreeAndNil(f_Mutex);
  FreeAndNil(f_ContinueEvent);
  FreeAndNil(f_SharedBuf);
  inherited;
//#UC END# *479731C50290_491D9DFA0288_impl*
end;//TatSynchroPoint.Cleanup

end.
