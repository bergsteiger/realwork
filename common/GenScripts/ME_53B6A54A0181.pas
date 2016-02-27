unit csDeleteDocsQueryPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csDeleteDocsQueryPrim.pas"
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
 TcsDeleteDocsQueryPrim = class(TddProcessTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsDeleteDocsQueryPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , DeleteDocsQuery_Const
;

class function TcsDeleteDocsQueryPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B6A54A0181_var*
//#UC END# *53AC03EE01FD_53B6A54A0181_var*
begin
//#UC START# *53AC03EE01FD_53B6A54A0181_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6A54A0181_impl*
end;//TcsDeleteDocsQueryPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
