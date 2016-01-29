unit NodeServerTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/NodeServerTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeServerTree
//
// Адаптерное дерево, с кешом сервантов (эмуляция мультифабрики)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  NotifyUnit,
  reeBase,
  ree,
  SearchDefinesUnit
  ;

type
//#UC START# *45F7C10C005Dci*
//#UC END# *45F7C10C005Dci*
 NodeServerTree = {abstract} class(Tree, IListener)
  {* Адаптерное дерево, с кешом сервантов (эмуляция мультифабрики) }
 protected
 // realized methods
   procedure Fire(const aNotify: INotification); stdcall;
 public
 // public methods
   class function MakeTree(name: TAttributeTag): TreeBase; virtual;
//#UC START# *45F7C10C005Dpubl*
//#UC END# *45F7C10C005Dpubl*
 end;//NodeServerTree

implementation

// start class NodeServerTree

class function NodeServerTree.MakeTree(name: TAttributeTag): TreeBase;
//#UC START# *45F7C1B5035B_45F7C10C005D_var*
//#UC END# *45F7C1B5035B_45F7C10C005D_var*
begin
//#UC START# *45F7C1B5035B_45F7C10C005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F7C1B5035B_45F7C10C005D_impl*
end;//NodeServerTree.MakeTree

procedure NodeServerTree.Fire(const aNotify: INotification);
//#UC START# *45EEDE9D01C5_45F7C10C005D_var*
//#UC END# *45EEDE9D01C5_45F7C10C005D_var*
begin
//#UC START# *45EEDE9D01C5_45F7C10C005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *45EEDE9D01C5_45F7C10C005D_impl*
end;//NodeServerTree.Fire

//#UC START# *45F7C10C005Dimpl*
//#UC END# *45F7C10C005Dimpl*

end.