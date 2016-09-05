unit ddServerStatusRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddServerStatusRequestPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddServerStatusRequestPrim" MUID: (53B6843E03A3)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
 , k2Base
;

type
 TddServerStatusRequestPrim = class(TddRequestTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddServerStatusRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ServerStatusRequest_Const
 //#UC START# *53B6843E03A3impl_uses*
 //#UC END# *53B6843E03A3impl_uses*
;

class function TddServerStatusRequestPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typServerStatusRequest;
end;//TddServerStatusRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
