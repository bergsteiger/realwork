unit ListAnalysisTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ListAnalysisTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListAnalysisTree
//
// Дерево анализа списка
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
  DynamicTreeUnit
  ;

type
 ListAnalysisTree = {final} class
  {* Дерево анализа списка }
 private
 // private fields
   expanded : Boolean;
    {* флажок, были ли развёрнуты узлы дерева в соответствии с правилом:

Если узел пуст, он показывается свернутым с нулем напротив в скобках. Если в нем что-то есть, то разворачивается.}
 public
 // overridden public methods
   procedure AddNotifier(var root;
    var notifier: INodeNotifier); override;
 public
 // public methods
   constructor Make(stree);
 end;//ListAnalysisTree

implementation

uses
  ApplicationHelper
  ;

// start class ListAnalysisTree

constructor ListAnalysisTree.Make(stree);
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