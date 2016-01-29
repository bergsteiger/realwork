unit evList_InterfaceFactory;
 {* Фабрика интерфейсов для списка строк }

// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: evList_InterfaceFactory
// Начат: 18.06.2008 15:13

{$Include evDefine.inc}

interface

{$IfDef Archi}
uses
  evListBlock
  ;

type
 TevListInterfaceFactory = evListBlock.TevListInterfaceFactory;
  {* Фабрика интерфейсов для списка строк }
{$EndIf Archi}

implementation

end.