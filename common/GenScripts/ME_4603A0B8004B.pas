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
   function AllocNewView: ViewBase; override;
  public
   constructor Make(active_changeable: Boolean); reintroduce; virtual; stdcall;
   procedure AddBlockPosition(const pointer;
    position: Cardinal); stdcall;
   function GetBlockPosition(const pointer): Cardinal; stdcall;
   procedure ClearBlockPositions; stdcall;
 end;//ListTree

implementation

uses
 l3ImplUses
 , ApplicationHelper
 , ListTreeView
;

constructor ListTree.Make(active_changeable: Boolean);
//#UC START# *4603AC6A0320_4603A0B8004B_var*
//#UC END# *4603AC6A0320_4603A0B8004B_var*
begin
//#UC START# *4603AC6A0320_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603AC6A0320_4603A0B8004B_impl*
end;//ListTree.Make

procedure ListTree.AddBlockPosition(const pointer;
 position: Cardinal);
//#UC START# *4603C5FF036D_4603A0B8004B_var*
//#UC END# *4603C5FF036D_4603A0B8004B_var*
begin
//#UC START# *4603C5FF036D_4603A0B8004B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4603C5FF036D_4603A0B8004B_impl*
end;//ListTree.AddBlockPosition

function ListTree.GetBlockPosition(const pointer): Cardinal;
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
