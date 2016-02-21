unit nsContentsRoot;
 {* Корень оглавления. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsContentsRoot.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsContentsNode
 , l3TreeInterfaces
;

type
 TnsContentsRoot = class(TnsContentsNode, Il3SimpleRootNode)
  {* Корень оглавления. }
  protected
   function CanExpandCollapseAll: Boolean;
   procedure ExpandCollapseAll(anExpand: Boolean);
 end;//TnsContentsRoot

implementation

uses
 l3ImplUses
;

function TnsContentsRoot.CanExpandCollapseAll: Boolean;
//#UC START# *4772433F0008_4682822A00FA_var*
//#UC END# *4772433F0008_4682822A00FA_var*
begin
//#UC START# *4772433F0008_4682822A00FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772433F0008_4682822A00FA_impl*
end;//TnsContentsRoot.CanExpandCollapseAll

procedure TnsContentsRoot.ExpandCollapseAll(anExpand: Boolean);
//#UC START# *47724349030A_4682822A00FA_var*
//#UC END# *47724349030A_4682822A00FA_var*
begin
//#UC START# *47724349030A_4682822A00FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *47724349030A_4682822A00FA_impl*
end;//TnsContentsRoot.ExpandCollapseAll

end.
