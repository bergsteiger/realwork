unit ListTree;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ListTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ListTree" MUID: (4603A0B8004B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ree
 , ViewBase
;

type
 ListTree = class(Tree)
  private
   node_pointer_2_block_position: NodePointerMap;
  public
   NodeDelegateType_: ;
  protected
   function alloc_new_view: ViewBase; override;
  public
   constructor make(active_changeable: Boolean); reintroduce; virtual;
   procedure add_block_position(const pointer;
    position: Cardinal);
   function get_block_position(const pointer): Cardinal;
   procedure clear_block_positions;
 end;//ListTree

implementation

uses
 l3ImplUses
 , ApplicationHelper
 , ListTreeView
;

constructor ListTree.make(active_changeable: Boolean);
//#UC START# *4603AC6A0320_4603A0B8004B_var*
//#UC END# *4603AC6A0320_4603A0B8004B_var*
begin
//#UC START# *4603AC6A0320_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603AC6A0320_4603A0B8004B_impl*
end;//ListTree.make

procedure ListTree.add_block_position(const pointer;
 position: Cardinal);
//#UC START# *4603C5FF036D_4603A0B8004B_var*
//#UC END# *4603C5FF036D_4603A0B8004B_var*
begin
//#UC START# *4603C5FF036D_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603C5FF036D_4603A0B8004B_impl*
end;//ListTree.add_block_position

function ListTree.get_block_position(const pointer): Cardinal;
//#UC START# *4603C55B00DE_4603A0B8004B_var*
//#UC END# *4603C55B00DE_4603A0B8004B_var*
begin
//#UC START# *4603C55B00DE_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603C55B00DE_4603A0B8004B_impl*
end;//ListTree.get_block_position

procedure ListTree.clear_block_positions;
//#UC START# *4603C5490003_4603A0B8004B_var*
//#UC END# *4603C5490003_4603A0B8004B_var*
begin
//#UC START# *4603C5490003_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603C5490003_4603A0B8004B_impl*
end;//ListTree.clear_block_positions

function ListTree.alloc_new_view: ViewBase;
//#UC START# *460127E400EA_4603A0B8004B_var*
//#UC END# *460127E400EA_4603A0B8004B_var*
begin
//#UC START# *460127E400EA_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_4603A0B8004B_impl*
end;//ListTree.alloc_new_view

end.
