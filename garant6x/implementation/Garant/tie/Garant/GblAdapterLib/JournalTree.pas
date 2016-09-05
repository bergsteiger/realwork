unit JournalTree;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\JournalTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "JournalTree" MUID: (4A92A8F2022D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ree
;

type
 JournalTree = class
  public
   NodeDelegateType_: ;
   NodeType_: ;
  public
   constructor Make(const tree); reintroduce; stdcall;
   procedure Clear; virtual; stdcall;
    {* Очистить дерево }
 end;//JournalTree

implementation

uses
 l3ImplUses
 , ApplicationHelper
 //#UC START# *4A92A8F2022Dimpl_uses*
 //#UC END# *4A92A8F2022Dimpl_uses*
;

constructor JournalTree.Make(const tree);
//#UC START# *4A92A941032E_4A92A8F2022D_var*
//#UC END# *4A92A941032E_4A92A8F2022D_var*
begin
//#UC START# *4A92A941032E_4A92A8F2022D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A92A941032E_4A92A8F2022D_impl*
end;//JournalTree.Make

procedure JournalTree.Clear;
 {* Очистить дерево }
//#UC START# *4AF42B76023D_4A92A8F2022D_var*
//#UC END# *4AF42B76023D_4A92A8F2022D_var*
begin
//#UC START# *4AF42B76023D_4A92A8F2022D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF42B76023D_4A92A8F2022D_impl*
end;//JournalTree.Clear

end.
