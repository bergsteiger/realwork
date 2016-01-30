unit alcuExecutorWithIncomingTaskList;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuExecutorWithIncomingTaskList.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , ddServerTaskList
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuExecutorWithIncomingTaskList = class(Tl3ProtoObject)
  private
   f_IncomingList: TddServerTaskList;
    {* Поле для свойства IncomingList }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aList: TddServerTaskList); reintroduce;
  protected
   property IncomingList: TddServerTaskList
    read f_IncomingList;
 end;//TalcuExecutorWithIncomingTaskList
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
;

constructor TalcuExecutorWithIncomingTaskList.Create(aList: TddServerTaskList);
//#UC START# *54856F0B019F_54856E500154_var*
//#UC END# *54856F0B019F_54856E500154_var*
begin
//#UC START# *54856F0B019F_54856E500154_impl*
 inherited Create;
 aList.SetRefTo(f_IncomingList);
//#UC END# *54856F0B019F_54856E500154_impl*
end;//TalcuExecutorWithIncomingTaskList.Create

procedure TalcuExecutorWithIncomingTaskList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54856E500154_var*
//#UC END# *479731C50290_54856E500154_var*
begin
//#UC START# *479731C50290_54856E500154_impl*
 FreeAndNil(f_IncomingList);
 inherited;
//#UC END# *479731C50290_54856E500154_impl*
end;//TalcuExecutorWithIncomingTaskList.Cleanup
{$IfEnd} // Defined(ServerTasks)

end.
