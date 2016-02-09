unit csTaskResult;

// Модуль: "w:\common\components\rtl\Garant\EVD\csTaskResult.pas"
// Стереотип: "SimpleClass"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , TaskResult_Const
 , k2Base
 , Classes
;

type
 TcsTaskResultClass = class of TcsTaskResult;

 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include evdTagHolder.imp.pas}
 TcsTaskResult = class(_evdTagHolder_)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
 end;//TcsTaskResult

implementation

uses
 l3ImplUses
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
;

{$Include evdTagHolder.imp.pas}

function TcsTaskResult.pm_GetTaskID: AnsiString;
//#UC START# *96286EAE2E82_53E0D4F50178get_var*
//#UC END# *96286EAE2E82_53E0D4F50178get_var*
begin
//#UC START# *96286EAE2E82_53E0D4F50178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *96286EAE2E82_53E0D4F50178get_impl*
end;//TcsTaskResult.pm_GetTaskID

procedure TcsTaskResult.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *96286EAE2E82_53E0D4F50178set_var*
//#UC END# *96286EAE2E82_53E0D4F50178set_var*
begin
//#UC START# *96286EAE2E82_53E0D4F50178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *96286EAE2E82_53E0D4F50178set_impl*
end;//TcsTaskResult.pm_SetTaskID

class function TcsTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53E0D4F50178_var*
//#UC END# *53AC03EE01FD_53E0D4F50178_var*
begin
//#UC START# *53AC03EE01FD_53E0D4F50178_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53E0D4F50178_impl*
end;//TcsTaskResult.GetTaggedDataType

end.
