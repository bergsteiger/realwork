unit alcuExecutorWithTaskList;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuExecutorWithTaskList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuExecutorWithTaskList" MUID: (54748D2A0111)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If Defined(AppServerSide)}
 , alcuTaskList
 {$IfEnd} // Defined(AppServerSide)
;

type
 TalcuExecutorWithTaskList = class(Tl3ProtoObject)
  private
   f_TaskList: TalcuTaskList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aTaskList: TalcuTaskList); reintroduce;
  protected
   property TaskList: TalcuTaskList
    read f_TaskList;
 end;//TalcuExecutorWithTaskList
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *54748D2A0111impl_uses*
 //#UC END# *54748D2A0111impl_uses*
;

constructor TalcuExecutorWithTaskList.Create(aTaskList: TalcuTaskList);
//#UC START# *5465DA0F0245_54748D2A0111_var*
//#UC END# *5465DA0F0245_54748D2A0111_var*
begin
//#UC START# *5465DA0F0245_54748D2A0111_impl*
 inherited Create;
 aTaskList.SetRefTo(f_TaskList);
//#UC END# *5465DA0F0245_54748D2A0111_impl*
end;//TalcuExecutorWithTaskList.Create

procedure TalcuExecutorWithTaskList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54748D2A0111_var*
//#UC END# *479731C50290_54748D2A0111_var*
begin
//#UC START# *479731C50290_54748D2A0111_impl*
 FreeAndNil(f_TaskList);
 inherited;
//#UC END# *479731C50290_54748D2A0111_impl*
end;//TalcuExecutorWithTaskList.Cleanup
{$IfEnd} // Defined(ServerTasks)

end.
