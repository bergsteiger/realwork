unit csRemoteDictEditQueryPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csRemoteDictEditQueryPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsRemoteDictEditQueryPrim = class(TddProcessTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsRemoteDictEditQueryPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , RemoteDictEditQuery_Const
;

class function TcsRemoteDictEditQueryPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B27AE70084_var*
//#UC END# *53AC03EE01FD_53B27AE70084_var*
begin
//#UC START# *53AC03EE01FD_53B27AE70084_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B27AE70084_impl*
end;//TcsRemoteDictEditQueryPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
