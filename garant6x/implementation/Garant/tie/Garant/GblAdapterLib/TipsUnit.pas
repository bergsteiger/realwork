unit TipsUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/TipsUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// Совет дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  DynamicTreeUnit
  ;

type
 ITipsManager = interface(IUnknown)
  {* Менеджер Советов дня }
   ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
   function GetTipsTreeRoot: INodeBase; stdcall;
   procedure GetCurrentTip(out aRet {: INodeIndexPath}); stdcall;
     {* Получить текущий (по сценарию) Совет дня }
   function IsExist: ByteBool; stdcall;
   property tips_tree_root: INodeBase
     read GetTipsTreeRoot;
     {* Рут дерева совет дня }
 end;//ITipsManager

implementation

end.