unit nscTasksPanelRootNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTasksPanelRootNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::TasksPanel::TnscTasksPanelRootNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  l3TreeInterfaces,
  l3NodesModelPart,
  l3Tree_TLB
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscTasksPanelRootNode = class(Tl3RootNode)
 protected
 // overridden protected methods
   function DoCompareChild(const aChildrenNode1: Il3Node;
     const aChildrenNode2: Il3Node): Integer; override;
 public
 // public methods
   class function Make: Il3SimpleRootNode;
 end;//TnscTasksPanelRootNode
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  SysUtils,
  l3Base,
  nscTaskPanelInterfaces
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscTasksPanelRootNode

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

{$IfEnd} //Nemesis

end.