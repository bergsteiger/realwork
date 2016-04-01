unit NOT_COMPLETED_csContainerTask;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csContainerTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsContainerTask" MUID: (56FE5C970264)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , l3Variant
 , k2Base
;

type
 TcsContainerTask = class(TddProcessTask)
  protected
   function pm_GetTasks: Tl3Tag;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Tasks: Tl3Tag
    read pm_GetTasks;
 end;//TcsContainerTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ContainerTask_Const
;

function TcsContainerTask.pm_GetTasks: Tl3Tag;
//#UC START# *807379469BD5_56FE5C970264get_var*
//#UC END# *807379469BD5_56FE5C970264get_var*
begin
//#UC START# *807379469BD5_56FE5C970264get_impl*
 !!! Needs to be implemented !!!
//#UC END# *807379469BD5_56FE5C970264get_impl*
end;//TcsContainerTask.pm_GetTasks

class function TcsContainerTask.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_56FE5C970264_var*
//#UC END# *53AC03EE01FD_56FE5C970264_var*
begin
//#UC START# *53AC03EE01FD_56FE5C970264_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_56FE5C970264_impl*
end;//TcsContainerTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
