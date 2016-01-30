unit nscTasksPanelRootNode;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanelRootNode.pas"
// Стереотип: "SimpleClass"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3NodesModelPart
 , l3TreeInterfaces
 , l3Tree_TLB
;

type
 TnscTasksPanelRootNode = class(Tl3RootNode)
  protected
   function DoCompareChild(const aChildrenNode1: Il3Node;
    const aChildrenNode2: Il3Node): Integer; override;
  public
   class function Make: Il3SimpleRootNode;
 end;//TnscTasksPanelRootNode
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , nscTaskPanelInterfaces
;

class function TnscTasksPanelRootNode.Make: Il3SimpleRootNode;
//#UC START# *508F978501B3_508EBDB503D2_var*
var
 l_Class: TnscTasksPanelRootNode;
//#UC END# *508F978501B3_508EBDB503D2_var*
begin
//#UC START# *508F978501B3_508EBDB503D2_impl*
 l_Class := Create;
 try
  Supports(l_Class, Il3SimpleRootNode, Result);
 finally
  l3Free(l_Class);
 end;//try..finally
//#UC END# *508F978501B3_508EBDB503D2_impl*
end;//TnscTasksPanelRootNode.Make

function TnscTasksPanelRootNode.DoCompareChild(const aChildrenNode1: Il3Node;
 const aChildrenNode2: Il3Node): Integer;
//#UC START# *54C8E03003CD_508EBDB503D2_var*
var
 l_Op1, l_Op2: InscOperationNode;
//#UC END# *54C8E03003CD_508EBDB503D2_var*
begin
//#UC START# *54C8E03003CD_508EBDB503D2_impl*
 if Supports(aChildrenNode1, InscOperationNode, l_Op1) and
  Supports(aChildrenNode2, InscOperationNode, l_Op2) then
 begin
  if l_Op1.Op.Position > l_Op2.Op.Position
   then Result := 1
   else
  if l_Op1.Op.Position < l_Op2.Op.Position
   then Result := -1
   else Result := 0;
 end else
  Result := inherited DoCompareChild(aChildrenNode1, aChildrenNode2);
//#UC END# *54C8E03003CD_508EBDB503D2_impl*
end;//TnscTasksPanelRootNode.DoCompareChild
{$IfEnd} // Defined(Nemesis)

end.
