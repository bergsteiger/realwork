unit ddTaskResultRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddTaskResultRequestPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTaskResultRequestPrim" MUID: (53B6855302D9)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , askRequest
 , k2Base
;

type
 TddTaskResultRequestPrim = class(TaskRequest)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddTaskResultRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , TaskResultRequest_Const
 //#UC START# *53B6855302D9impl_uses*
 //#UC END# *53B6855302D9impl_uses*
;

class function TddTaskResultRequestPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typTaskResultRequest;
end;//TddTaskResultRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
