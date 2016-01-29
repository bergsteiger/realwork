unit atSleepOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atSleepOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatSleepOperation
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
 TatSleepOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatSleepOperation

implementation

uses
  SysUtils,
  atLogger
  ;

// start class TatSleepOperation

procedure TatSleepOperation.ExecuteSelf;
//#UC START# *48089F460352_4808B0320120_var*
    var
      l_SleepTime, l_MinSleepTime, l_MaxSleepTime : Integer;
//#UC END# *48089F460352_4808B0320120_var*
begin
//#UC START# *48089F460352_4808B0320120_impl*
    inherited;
    l_SleepTime := Parameters['sleep_time'].AsInt;
    l_MinSleepTime := Parameters['min_sleep_time'].AsInt;
    l_MaxSleepTime := Parameters['max_sleep_time'].AsInt;
    //
    if (l_MinSleepTime <> 0) OR (l_MaxSleepTime <> 0) then
      if (l_MinSleepTime > l_MaxSleepTime) then
      begin
        if (l_MaxSleepTime = 0) then
          l_SleepTime := l_MinSleepTime
        else
        begin
          Logger.Warning('Минимальное время больше максимального!');
          l_SleepTime := 0;
        end;
      end
      else
        l_SleepTime := l_MinSleepTime + Random(l_MaxSleepTime - l_MinSleepTime + 1);
    //
    Logger.Info('Засыпаем на ' + IntToStr(l_SleepTime) + ' мс.');
    Sleep(l_SleepTime);
//#UC END# *48089F460352_4808B0320120_impl*
end;//TatSleepOperation.ExecuteSelf

procedure TatSleepOperation.InitParamList;
//#UC START# *48089F3701B4_4808B0320120_var*
//#UC END# *48089F3701B4_4808B0320120_var*
begin
//#UC START# *48089F3701B4_4808B0320120_impl*
    inherited;
    with f_ParamList do
    begin
      Add( ParamType.Create('sleep_time', 'Время задержки в миллисекундах', '0') );
      Add( ParamType.Create('min_sleep_time', 'Минимальное время задержки в миллисекундах', '0') );
      Add( ParamType.Create('max_sleep_time', 'Максимальное время задержки в миллисекундах', '0') );
    end;
//#UC END# *48089F3701B4_4808B0320120_impl*
end;//TatSleepOperation.InitParamList

end.