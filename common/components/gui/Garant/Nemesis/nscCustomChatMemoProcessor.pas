unit nscCustomChatMemoProcessor;

// ������: "w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoProcessor.pas"
// ���������: "SimpleClass"
// ������� ������: "TnscCustomChatMemoProcessor" MUID: (4A8C13FD0044)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evMemoProcessor
;

type
 TnscCustomChatMemoProcessor = class(TevMemoProcessor)
 end;//TnscCustomChatMemoProcessor
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *4A8C13FD0044impl_uses*
 //#UC END# *4A8C13FD0044impl_uses*
;
{$IfEnd} // Defined(Nemesis)

end.
