unit ncsLoginReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsLoginReply.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , csLoginReply_Const
 , k2Base
;

type
 TncsLoginReply = class(TncsReply)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TncsLoginReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

class function TncsLoginReply.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54634A7902A1_var*
//#UC END# *53AC03EE01FD_54634A7902A1_var*
begin
//#UC START# *53AC03EE01FD_54634A7902A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54634A7902A1_impl*
end;//TncsLoginReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
