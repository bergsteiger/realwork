unit ContentsTree;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ContentsTree.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , ree
 , ViewBase
;

type
 ContentsTree = class
  public
   NodeType_: ;
   NodeDelegateType_: ;
  protected
   function alloc_new_view: ViewBase; override;
  public
   constructor make(const tree); reintroduce;
 end;//ContentsTree

implementation

uses
 l3ImplUses
 , ContentsView
;

constructor ContentsTree.make(const tree);
//#UC START# *4C778AE80242_4C778A2900FB_var*
//#UC END# *4C778AE80242_4C778A2900FB_var*
begin
//#UC START# *4C778AE80242_4C778A2900FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C778AE80242_4C778A2900FB_impl*
end;//ContentsTree.make

function ContentsTree.alloc_new_view: ViewBase;
//#UC START# *460127E400EA_4C778A2900FB_var*
//#UC END# *460127E400EA_4C778A2900FB_var*
begin
//#UC START# *460127E400EA_4C778A2900FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_4C778A2900FB_impl*
end;//ContentsTree.alloc_new_view

end.
