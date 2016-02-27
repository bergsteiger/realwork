unit ddRunCommandTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddRunCommandTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
 , dt_Types
;

type
 TddRunCommandTaskPrim = class(TddProcessTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
   constructor Create(aUserID: TUserID); override;
 end;//TddRunCommandTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , evdTaskTypes
 , RunCommandTask_Const
;

class function TddRunCommandTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B6A75A024C_var*
//#UC END# *53AC03EE01FD_53B6A75A024C_var*
begin
//#UC START# *53AC03EE01FD_53B6A75A024C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6A75A024C_impl*
end;//TddRunCommandTaskPrim.GetTaggedDataType

constructor TddRunCommandTaskPrim.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53B6A75A024C_var*
//#UC END# *53B3D8A8011F_53B6A75A024C_var*
begin
//#UC START# *53B3D8A8011F_53B6A75A024C_impl*
 inherited;
 //TaskType := cs_ttRunCommand;
//#UC END# *53B3D8A8011F_53B6A75A024C_impl*
end;//TddRunCommandTaskPrim.Create
{$IfEnd} // NOT Defined(Nemesis)

end.
