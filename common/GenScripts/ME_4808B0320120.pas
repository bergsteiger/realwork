unit atSleepOperation;

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atSleepOperation.pas"
// ���������: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatSleepOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
 end;//TatSleepOperation

implementation

uses
 l3ImplUses
 , SysUtils
 , atLogger
;

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
          Logger.Warning('����������� ����� ������ �������������!');
          l_SleepTime := 0;
        end;
      end
      else
        l_SleepTime := l_MinSleepTime + Random(l_MaxSleepTime - l_MinSleepTime + 1);
    //
    Logger.Info('�������� �� ' + IntToStr(l_SleepTime) + ' ��.');
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
      Add( ParamType.Create('sleep_time', '����� �������� � �������������', '0') );
      Add( ParamType.Create('min_sleep_time', '����������� ����� �������� � �������������', '0') );
      Add( ParamType.Create('max_sleep_time', '������������ ����� �������� � �������������', '0') );
    end;
//#UC END# *48089F3701B4_4808B0320120_impl*
end;//TatSleepOperation.InitParamList

end.
