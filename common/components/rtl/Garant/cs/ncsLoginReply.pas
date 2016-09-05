unit ncsLoginReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsLoginReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsLoginReply" MUID: (54634A7902A1)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
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
 , csLoginReply_Const
 //#UC START# *54634A7902A1impl_uses*
 //#UC END# *54634A7902A1impl_uses*
;

class function TncsLoginReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsLoginReply;
end;//TncsLoginReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
