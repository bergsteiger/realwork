unit mmmTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/mmmTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::MedicMainMenu::TmmmTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Tree_TLB,
  nsBaseMainMenuTree,
  nsTypes,
  l3StringIDEx
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TmmmTree = class(TnsBaseMainMenuTree)
 protected
 // protected methods
   procedure AddItem(const aRoot: Il3RootNode;
    aNode: TnsMedicMainMenuNodeType;
    const aCaption: Tl3StringIDEx);
   class procedure NsAddMainMenuDocumentItem(const aRoot: Il3RootNode;
    MenuItem: Integer;
    const aDocuments: array of Integer);
 end;//TmmmTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsMainMenuNode,
  nsUtils,
  DocumentUnit,
  nsConst,
  nsDocumentMainMenuNode
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TmmmTree

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

class procedure TmmmTree.NsAddMainMenuDocumentItem(const aRoot: Il3RootNode;
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
end;//TmmmTree.NsAddMainMenuDocumentItem

{$IfEnd} //not Admin AND not Monitorings

end.