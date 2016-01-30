unit nscCustomChatMemoProcessor;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoProcessor.pas"
// Стереотип: "SimpleClass"

{$Include nscDefine.inc}

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
;
{$IfEnd} // Defined(Nemesis)

end.
