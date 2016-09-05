unit mmmTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmmmTree" MUID: (490C3BE30324)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsBaseMainMenuTree
 , l3Tree_TLB
 , nsTypes
 , l3StringIDEx
;

type
 TmmmTree = class(TnsBaseMainMenuTree)
  protected
   procedure AddItem(const aRoot: Il3RootNode;
    aNode: TnsMedicMainMenuNodeType;
    const aCaption: Tl3StringIDEx);
   class procedure nsAddMainMenuDocumentItem(const aRoot: Il3RootNode;
    MenuItem: Integer;
    const aDocuments: array of Integer);
 end;//TmmmTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsMainMenuNode
 , nsUtils
 , DocumentUnit
 , nsConst
 , nsDocumentMainMenuNode
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *490C3BE30324impl_uses*
 //#UC END# *490C3BE30324impl_uses*
;

procedure TmmmTree.AddItem(const aRoot: Il3RootNode;
 aNode: TnsMedicMainMenuNodeType;
 const aCaption: Tl3StringIDEx);
//#UC START# *490C3C280303_490C3BE30324_var*
//#UC END# *490C3C280303_490C3BE30324_var*
begin
//#UC START# *490C3C280303_490C3BE30324_impl*
 aRoot.InsertChild(TnsMainMenuNode.Make(Ord(aNode), aCaption.AsCStr));
//#UC END# *490C3C280303_490C3BE30324_impl*
end;//TmmmTree.AddItem

class procedure TmmmTree.nsAddMainMenuDocumentItem(const aRoot: Il3RootNode;
 MenuItem: Integer;
 const aDocuments: array of Integer);
//#UC START# *490C47F80134_490C3BE30324_var*
var
 l_Index    : Integer;
 l_Document : IDocument;
//#UC END# *490C47F80134_490C3BE30324_var*
begin
//#UC START# *490C47F80134_490C3BE30324_impl*
 for l_Index := Low(aDocuments) to High(aDocuments) do
 begin
  if nsOpenDocumentByNumber(
    aDocuments[l_Index] + c_InternalDocShift, l_Document, False) then
   aRoot.InsertChild(
    TnsDocumentMainMenuNode.Make(Ord(ns_mntDocument), l_Document));
 end;//for l_Index := Low(aDocuments) to High(aDocuments) do
//#UC END# *490C47F80134_490C3BE30324_impl*
end;//TmmmTree.nsAddMainMenuDocumentItem
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
