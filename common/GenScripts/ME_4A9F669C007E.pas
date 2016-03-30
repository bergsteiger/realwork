unit ListAnalysisTree;
 {* Дерево анализа списка }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ListAnalysisTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ListAnalysisTree" MUID: (4A9F669C007E)

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
   expanded: ByteBool;
    {* флажок, были ли развёрнуты узлы дерева в соответствии с правилом:

Если узел пуст, он показывается свернутым с нулем напротив в скобках. Если в нем что-то есть, то разворачивается. }
  public
   NodeType_: ;
   NodeDelegateType_: ;
  public
   constructor Make(const stree); reintroduce; stdcall;
   procedure AddNotifier(var root;
    var notifier: INodeNotifier); override;
 end;//ListAnalysisTree

implementation

uses
 l3ImplUses
 , ApplicationHelper
;

constructor ListAnalysisTree.Make(const stree);
//#UC START# *4A9F727601E7_4A9F669C007E_var*
//#UC END# *4A9F727601E7_4A9F669C007E_var*
begin
//#UC START# *4A9F727601E7_4A9F669C007E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9F727601E7_4A9F669C007E_impl*
end;//ListAnalysisTree.Make

procedure ListAnalysisTree.AddNotifier(var root;
 var notifier: INodeNotifier);
//#UC START# *46011F130203_4A9F669C007E_var*
//#UC END# *46011F130203_4A9F669C007E_var*
begin
//#UC START# *46011F130203_4A9F669C007E_impl*
 !!! Needs to be implemented !!!
//#UC END# *46011F130203_4A9F669C007E_impl*
end;//ListAnalysisTree.AddNotifier

end.
