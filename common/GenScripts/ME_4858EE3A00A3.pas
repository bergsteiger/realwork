unit NOT_FINISHED_evList_InterfaceFactory;
 {* Фабрика интерфейсов для списка строк }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evList_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevList" MUID: (4858EE3A00A3)
// Имя типа: "TevListInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor) AND Defined(Archi)}
uses
 l3IntfUses
 , evPara_InterfaceFactory
;

type
 TevListInterfaceFactory = class(TevParaInterfaceFactory)
  {* Фабрика интерфейсов для списка строк }
 end;//TevListInterfaceFactory
{$IfEnd} // Defined(k2ForEditor) AND Defined(Archi)

implementation

{$If Defined(k2ForEditor) AND Defined(Archi)}
uses
 l3ImplUses
 , arList_Const
;

{$IfEnd} // Defined(k2ForEditor) AND Defined(Archi)
end.
