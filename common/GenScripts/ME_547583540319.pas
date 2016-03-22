unit ncsGetFilePartReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetFilePartReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetFilePartReply" MUID: (547583540319)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsGetFilePartReply = class(TncsReply)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
 end;//TncsGetFilePartReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetFilePartReply_Const
;

function TncsGetFilePartReply.pm_GetIsSuccess: Boolean;
//#UC START# *B1CB2F60283B_547583540319get_var*
//#UC END# *B1CB2F60283B_547583540319get_var*
begin
//#UC START# *B1CB2F60283B_547583540319get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B1CB2F60283B_547583540319get_impl*
end;//TncsGetFilePartReply.pm_GetIsSuccess

procedure TncsGetFilePartReply.pm_SetIsSuccess(aValue: Boolean);
//#UC START# *B1CB2F60283B_547583540319set_var*
//#UC END# *B1CB2F60283B_547583540319set_var*
begin
//#UC START# *B1CB2F60283B_547583540319set_impl*
 !!! Needs to be implemented !!!
//#UC END# *B1CB2F60283B_547583540319set_impl*
end;//TncsGetFilePartReply.pm_SetIsSuccess

class function TncsGetFilePartReply.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_547583540319_var*
//#UC END# *53AC03EE01FD_547583540319_var*
begin
//#UC START# *53AC03EE01FD_547583540319_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_547583540319_impl*
end;//TncsGetFilePartReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
