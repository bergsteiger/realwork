unit alcuExecutorWithTaskList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuExecutorWithTaskList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::CoreExecutors::TalcuExecutorWithTaskList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  l3ProtoObject
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuTaskList
  {$IfEnd} //AppServerSide AND ServerTasks
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuExecutorWithTaskList = class(Tl3ProtoObject)
 private
 // private fields
   f_TaskList : TalcuTaskList;
    {* Поле для свойства TaskList}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aTaskList: TalcuTaskList); reintroduce;
 protected
 // protected properties
   property TaskList: TalcuTaskList
     read f_TaskList;
 end;//TalcuExecutorWithTaskList
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuExecutorWithTaskList

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
//#UC START# *479731C50290_54748D2A0111_var*
//#UC END# *479731C50290_54748D2A0111_var*
begin
//#UC START# *479731C50290_54748D2A0111_impl*
 FreeAndNil(f_TaskList);
 inherited;
//#UC END# *479731C50290_54748D2A0111_impl*
end;//TalcuExecutorWithTaskList.Cleanup

{$IfEnd} //ServerTasks

end.