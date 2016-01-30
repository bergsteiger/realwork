unit csRelPublishTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csRelPublishTask.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csImport
 , RelPublishTask_Const
 , k2Base
;

type
 TcsRelPublishTask = class(TcsImportTaskItem)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsRelPublishTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

class function TcsRelPublishTask.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53BA76F9001C_var*
//#UC END# *53AC03EE01FD_53BA76F9001C_var*
begin
//#UC START# *53AC03EE01FD_53BA76F9001C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53BA76F9001C_impl*
end;//TcsRelPublishTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
