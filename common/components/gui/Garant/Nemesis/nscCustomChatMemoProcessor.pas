unit nscCustomChatMemoProcessor;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoProcessor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscCustomChatMemoProcessor" MUID: (4A8C13FD0044)

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
;
{$IfEnd} // Defined(Nemesis)

end.
