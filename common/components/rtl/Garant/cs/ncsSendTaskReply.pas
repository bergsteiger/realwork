unit ncsSendTaskReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsSendTaskReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsSendTaskReply" MUID: (54855C4200D7)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsSendTaskReply = class(TncsReply)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
 end;//TncsSendTaskReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csSendTaskReply_Const
;

function TncsSendTaskReply.pm_GetIsSuccess: Boolean;
//#UC START# *C8A43DA1739F_54855C4200D7get_var*
//#UC END# *C8A43DA1739F_54855C4200D7get_var*
begin
//#UC START# *C8A43DA1739F_54855C4200D7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C8A43DA1739F_54855C4200D7get_impl*
end;//TncsSendTaskReply.pm_GetIsSuccess

procedure TncsSendTaskReply.pm_SetIsSuccess(aValue: Boolean);
//#UC START# *C8A43DA1739F_54855C4200D7set_var*
//#UC END# *C8A43DA1739F_54855C4200D7set_var*
begin
//#UC START# *C8A43DA1739F_54855C4200D7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C8A43DA1739F_54855C4200D7set_impl*
end;//TncsSendTaskReply.pm_SetIsSuccess

class function TncsSendTaskReply.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54855C4200D7_var*
//#UC END# *53AC03EE01FD_54855C4200D7_var*
begin
//#UC START# *53AC03EE01FD_54855C4200D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54855C4200D7_impl*
end;//TncsSendTaskReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
