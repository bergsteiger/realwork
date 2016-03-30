unit TipsUnit;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\TipsUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Tips" MUID: (47B30C7D02F3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicTreeUnit
;

type
 ITipsManager = interface
  {* Менеджер Советов дня }
  ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
  function GetTipsTreeRoot: INodeBase; stdcall; { can raise CanNotFindData }
  function GetCurrentTip: INodeIndexPath; stdcall;
   {* Получить текущий (по сценарию) Совет дня }
  function IsExist: ByteBool; stdcall;
  property TipsTreeRoot: INodeBase
   read GetTipsTreeRoot;
   {* Рут дерева совет дня }
 end;//ITipsManager

implementation

uses
 l3ImplUses
;

end.
