unit ListAnalysisTree;
 {* Дерево анализа списка }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ListAnalysisTree.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ree
 , DynamicTreeUnit
;

type
 ListAnalysisTree = {final} class
  {* Дерево анализа списка }
  private
   expanded: Boolean;
    {* флажок, были ли развёрнуты узлы дерева в соответствии с правилом:

Если узел пуст, он показывается свернутым с нулем напротив в скобках. Если в нем что-то есть, то разворачивается. }
  public
   NodeType_: ;
   NodeDelegateType_: ;
  public
   constructor make(const stree); reintroduce;
   procedure add_notifier(var root;
    var notifier: INodeNotifier); override;
 end;//ListAnalysisTree

implementation

uses
 l3ImplUses
 , ApplicationHelper
;

constructor ListAnalysisTree.make(const stree);
//#UC START# *4A9F727601E7_4A9F669C007E_var*
//#UC END# *4A9F727601E7_4A9F669C007E_var*
begin
//#UC START# *4A9F727601E7_4A9F669C007E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9F727601E7_4A9F669C007E_impl*
end;//ListAnalysisTree.make

procedure ListAnalysisTree.add_notifier(var root;
 var notifier: INodeNotifier);
//#UC START# *46011F130203_4A9F669C007E_var*
//#UC END# *46011F130203_4A9F669C007E_var*
begin
//#UC START# *46011F130203_4A9F669C007E_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F130203_4A9F669C007E_impl*
end;//ListAnalysisTree.add_notifier

end.
