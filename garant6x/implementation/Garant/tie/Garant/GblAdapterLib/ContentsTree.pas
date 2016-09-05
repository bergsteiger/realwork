unit ContentsTree;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ContentsTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ContentsTree" MUID: (4C778A2900FB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
   function AllocNewView: ViewBase; override;
  public
   constructor Make(const tree); reintroduce; stdcall;
 end;//ContentsTree

implementation

uses
 l3ImplUses
 , ContentsView
 //#UC START# *4C778A2900FBimpl_uses*
 //#UC END# *4C778A2900FBimpl_uses*
;

constructor ContentsTree.Make(const tree);
//#UC START# *4C778AE80242_4C778A2900FB_var*
//#UC END# *4C778AE80242_4C778A2900FB_var*
begin
//#UC START# *4C778AE80242_4C778A2900FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C778AE80242_4C778A2900FB_impl*
end;//ContentsTree.Make

function ContentsTree.AllocNewView: ViewBase;
//#UC START# *460127E400EA_4C778A2900FB_var*
//#UC END# *460127E400EA_4C778A2900FB_var*
begin
//#UC START# *460127E400EA_4C778A2900FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127E400EA_4C778A2900FB_impl*
end;//ContentsTree.AllocNewView

end.
