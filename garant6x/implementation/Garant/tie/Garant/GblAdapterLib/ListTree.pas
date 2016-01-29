unit ListTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ListTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  ree,
  ViewBase
  ;

type
 ListTree = class(Tree)
 private
 // private fields
   node_pointer_2_block_position : NodePointerMap;
 protected
 // overridden protected methods
   function AllocNewView: ViewBase; override;
 public
 // public methods
   constructor Make(active_changeable: Boolean); virtual;
   procedure AddBlockPosition(pointer;
    position: Cardinal);
   function GetBlockPosition(pointer): Cardinal;
   procedure ClearBlockPositions;
 end;//ListTree

implementation

uses
  ApplicationHelper,
  ListTreeView
  ;

// start class ListTree

constructor ListTree.Make(active_changeable: Boolean);
//#UC START# *4603AC6A0320_4603A0B8004B_var*
//#UC END# *4603AC6A0320_4603A0B8004B_var*
begin
//#UC START# *4603AC6A0320_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603AC6A0320_4603A0B8004B_impl*
end;//ListTree.Make

procedure ListTree.AddBlockPosition(pointer;
  position: Cardinal);
//#UC START# *4603C5FF036D_4603A0B8004B_var*
//#UC END# *4603C5FF036D_4603A0B8004B_var*
begin
//#UC START# *4603C5FF036D_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603C5FF036D_4603A0B8004B_impl*
end;//ListTree.AddBlockPosition

function ListTree.GetBlockPosition(pointer): Cardinal;
//#UC START# *4603C55B00DE_4603A0B8004B_var*
//#UC END# *4603C55B00DE_4603A0B8004B_var*
begin
//#UC START# *4603C55B00DE_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603C55B00DE_4603A0B8004B_impl*
end;//ListTree.GetBlockPosition

procedure ListTree.ClearBlockPositions;
//#UC START# *4603C5490003_4603A0B8004B_var*
//#UC END# *4603C5490003_4603A0B8004B_var*
begin
//#UC START# *4603C5490003_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603C5490003_4603A0B8004B_impl*
end;//ListTree.ClearBlockPositions

function ListTree.AllocNewView: ViewBase;
//#UC START# *460127E400EA_4603A0B8004B_var*
//#UC END# *460127E400EA_4603A0B8004B_var*
begin
//#UC START# *460127E400EA_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_4603A0B8004B_impl*
end;//ListTree.AllocNewView

end.