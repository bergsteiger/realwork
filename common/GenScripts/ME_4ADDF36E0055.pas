unit NOT_FINISHED_l3VirtualNode;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3VirtualNode.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3NodesModelPart
 , l3Tree_TLB
 , l3TreeInterfaces
;

type
 Tl3CustomVirtualNode = class(Tl3CustomNode)
  protected
   procedure Set_ChildNode(const aValue: Il3Node); virtual;
   function ChildNodeClass: Rl3CustomVirtualNode; virtual;
   function ParentNodeClass: Rl3CustomVirtualNode; virtual;
   procedure Set_ParentNode(const aValue: Il3Node); virtual; abstract;
   procedure Set_PrevNode(const aValue: Il3Node); virtual; abstract;
   procedure Set_NextNode(const aValue: Il3Node); virtual; abstract;
   procedure Remove; overload;
    {* удалить узел из дерева. }
   function Get_AllChildrenCount: Integer;
   function Get_NextNode: Il3Node;
   function Get_PrevNode: Il3Node;
   function Get_ParentNode: Il3Node;
   function Get_ChildNode: Il3Node;
   function DoGetIndexInParent: Integer; override;
   function Get_ParentNode: Il3Node; override;
   function Get_ChildNode: Il3Node; override;
   function Get_NextNode: Il3Node; override;
   function Get_PrevNode: Il3Node; override;
   function GetLevelForParent(const aNode: Il3SimpleNode): Integer; override;
   function pm_GetFlag(anIndex: Integer): Boolean; override;
   procedure pm_SetFlag(anIndex: Integer;
    aValue: Boolean); override;
   function IsFirstNode: Boolean; override;
   function IsLastNode: Boolean; override;
   procedure Remove; override;
   function IterateChild(Action: Tl3NodeAction;
    IterMode: Integer;
    const aFromNode: Il3Node = nil): Il3Node; override;
   function DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer; override;
   procedure DoReleaseChilds; override;
   procedure DoIncAllChildrenCount(aInc: Integer); override;
   function DoGetChildByNumber(aNum: Integer): Il3Node; override;
   function DoIterate(Action: Tl3NodeAction;
    IterMode: Integer = 0;
    const aFromNode: Il3Node = nil): Il3Node; override;
   function DoInsertChildBefore(const aNextChild: Il3Node;
    const aChild: Il3Node): Il3Node; override;
  public
   procedure ReleaseChildsPrim; override;
 end;//Tl3CustomVirtualNode

 Rl3CustomVirtualNode = class of Tl3CustomVirtualNode;

 Tl3VirtualFlagsNode = class(Tl3CustomVirtualNode)
  protected
   procedure Set_ParentNode(const aValue: Il3Node); override;
   procedure Set_PrevNode(const aValue: Il3Node); override;
   procedure Set_NextNode(const aValue: Il3Node); override;
 end;//Tl3VirtualFlagsNode

implementation

uses
 l3ImplUses
;

procedure Tl3CustomVirtualNode.Set_ChildNode(const aValue: Il3Node);
//#UC START# *4ADEEFA00164_4ADDF3930121_var*
//#UC END# *4ADEEFA00164_4ADDF3930121_var*
begin
//#UC START# *4ADEEFA00164_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADEEFA00164_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.Set_ChildNode

function Tl3CustomVirtualNode.ChildNodeClass: Rl3CustomVirtualNode;
//#UC START# *4B1CE7F6012A_4ADDF3930121_var*
//#UC END# *4B1CE7F6012A_4ADDF3930121_var*
begin
//#UC START# *4B1CE7F6012A_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B1CE7F6012A_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.ChildNodeClass

function Tl3CustomVirtualNode.ParentNodeClass: Rl3CustomVirtualNode;
//#UC START# *4B1CE80502F1_4ADDF3930121_var*
//#UC END# *4B1CE80502F1_4ADDF3930121_var*
begin
//#UC START# *4B1CE80502F1_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B1CE80502F1_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.ParentNodeClass

procedure Tl3CustomVirtualNode.Remove;
 {* удалить узел из дерева. }
//#UC START# *47710C6002AA_4ADDF3930121_var*
//#UC END# *47710C6002AA_4ADDF3930121_var*
begin
//#UC START# *47710C6002AA_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710C6002AA_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.Remove

function Tl3CustomVirtualNode.Get_AllChildrenCount: Integer;
//#UC START# *47710E730361_4ADDF3930121get_var*
//#UC END# *47710E730361_4ADDF3930121get_var*
begin
//#UC START# *47710E730361_4ADDF3930121get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710E730361_4ADDF3930121get_impl*
end;//Tl3CustomVirtualNode.Get_AllChildrenCount

function Tl3CustomVirtualNode.Get_NextNode: Il3Node;
//#UC START# *4771102F01C3_4ADDF3930121get_var*
//#UC END# *4771102F01C3_4ADDF3930121get_var*
begin
//#UC START# *4771102F01C3_4ADDF3930121get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771102F01C3_4ADDF3930121get_impl*
end;//Tl3CustomVirtualNode.Get_NextNode

function Tl3CustomVirtualNode.Get_PrevNode: Il3Node;
//#UC START# *477110580184_4ADDF3930121get_var*
//#UC END# *477110580184_4ADDF3930121get_var*
begin
//#UC START# *477110580184_4ADDF3930121get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110580184_4ADDF3930121get_impl*
end;//Tl3CustomVirtualNode.Get_PrevNode

function Tl3CustomVirtualNode.Get_ParentNode: Il3Node;
//#UC START# *4771108100D0_4ADDF3930121get_var*
//#UC END# *4771108100D0_4ADDF3930121get_var*
begin
//#UC START# *4771108100D0_4ADDF3930121get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771108100D0_4ADDF3930121get_impl*
end;//Tl3CustomVirtualNode.Get_ParentNode

function Tl3CustomVirtualNode.Get_ChildNode: Il3Node;
//#UC START# *477110A2026C_4ADDF3930121get_var*
//#UC END# *477110A2026C_4ADDF3930121get_var*
begin
//#UC START# *477110A2026C_4ADDF3930121get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110A2026C_4ADDF3930121get_impl*
end;//Tl3CustomVirtualNode.Get_ChildNode

function Tl3CustomVirtualNode.DoGetIndexInParent: Integer;
//#UC START# *54C78A1E033E_4ADDF3930121_var*
//#UC END# *54C78A1E033E_4ADDF3930121_var*
begin
//#UC START# *54C78A1E033E_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78A1E033E_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.DoGetIndexInParent

function Tl3CustomVirtualNode.Get_ParentNode: Il3Node;
//#UC START# *54C78E1002BE_4ADDF3930121_var*
//#UC END# *54C78E1002BE_4ADDF3930121_var*
begin
//#UC START# *54C78E1002BE_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78E1002BE_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.Get_ParentNode

function Tl3CustomVirtualNode.Get_ChildNode: Il3Node;
//#UC START# *54C78E2702B3_4ADDF3930121_var*
//#UC END# *54C78E2702B3_4ADDF3930121_var*
begin
//#UC START# *54C78E2702B3_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78E2702B3_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.Get_ChildNode

function Tl3CustomVirtualNode.Get_NextNode: Il3Node;
//#UC START# *54C78E370213_4ADDF3930121_var*
//#UC END# *54C78E370213_4ADDF3930121_var*
begin
//#UC START# *54C78E370213_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78E370213_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.Get_NextNode

function Tl3CustomVirtualNode.Get_PrevNode: Il3Node;
//#UC START# *54C78E440118_4ADDF3930121_var*
//#UC END# *54C78E440118_4ADDF3930121_var*
begin
//#UC START# *54C78E440118_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78E440118_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.Get_PrevNode

function Tl3CustomVirtualNode.GetLevelForParent(const aNode: Il3SimpleNode): Integer;
//#UC START# *54C78EA30198_4ADDF3930121_var*
//#UC END# *54C78EA30198_4ADDF3930121_var*
begin
//#UC START# *54C78EA30198_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78EA30198_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.GetLevelForParent

function Tl3CustomVirtualNode.pm_GetFlag(anIndex: Integer): Boolean;
//#UC START# *54C78F15023E_4ADDF3930121get_var*
//#UC END# *54C78F15023E_4ADDF3930121get_var*
begin
//#UC START# *54C78F15023E_4ADDF3930121get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78F15023E_4ADDF3930121get_impl*
end;//Tl3CustomVirtualNode.pm_GetFlag

procedure Tl3CustomVirtualNode.pm_SetFlag(anIndex: Integer;
 aValue: Boolean);
//#UC START# *54C78F15023E_4ADDF3930121set_var*
//#UC END# *54C78F15023E_4ADDF3930121set_var*
begin
//#UC START# *54C78F15023E_4ADDF3930121set_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78F15023E_4ADDF3930121set_impl*
end;//Tl3CustomVirtualNode.pm_SetFlag

function Tl3CustomVirtualNode.IsFirstNode: Boolean;
//#UC START# *54C78F5702CE_4ADDF3930121_var*
//#UC END# *54C78F5702CE_4ADDF3930121_var*
begin
//#UC START# *54C78F5702CE_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78F5702CE_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.IsFirstNode

function Tl3CustomVirtualNode.IsLastNode: Boolean;
//#UC START# *54C78F8902C6_4ADDF3930121_var*
//#UC END# *54C78F8902C6_4ADDF3930121_var*
begin
//#UC START# *54C78F8902C6_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C78F8902C6_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.IsLastNode

procedure Tl3CustomVirtualNode.Remove;
//#UC START# *54C791DB001D_4ADDF3930121_var*
//#UC END# *54C791DB001D_4ADDF3930121_var*
begin
//#UC START# *54C791DB001D_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C791DB001D_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.Remove

function Tl3CustomVirtualNode.IterateChild(Action: Tl3NodeAction;
 IterMode: Integer;
 const aFromNode: Il3Node = nil): Il3Node;
//#UC START# *54C8DFF102DD_4ADDF3930121_var*
//#UC END# *54C8DFF102DD_4ADDF3930121_var*
begin
//#UC START# *54C8DFF102DD_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8DFF102DD_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.IterateChild

function Tl3CustomVirtualNode.DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer;
//#UC START# *54C8E1F30128_4ADDF3930121_var*
//#UC END# *54C8E1F30128_4ADDF3930121_var*
begin
//#UC START# *54C8E1F30128_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8E1F30128_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.DoGetNumInParent

procedure Tl3CustomVirtualNode.DoReleaseChilds;
//#UC START# *54C8E22F0223_4ADDF3930121_var*
//#UC END# *54C8E22F0223_4ADDF3930121_var*
begin
//#UC START# *54C8E22F0223_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8E22F0223_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.DoReleaseChilds

procedure Tl3CustomVirtualNode.ReleaseChildsPrim;
//#UC START# *54C8E23B01AB_4ADDF3930121_var*
//#UC END# *54C8E23B01AB_4ADDF3930121_var*
begin
//#UC START# *54C8E23B01AB_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8E23B01AB_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.ReleaseChildsPrim

procedure Tl3CustomVirtualNode.DoIncAllChildrenCount(aInc: Integer);
//#UC START# *54C8E4A8037A_4ADDF3930121_var*
//#UC END# *54C8E4A8037A_4ADDF3930121_var*
begin
//#UC START# *54C8E4A8037A_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8E4A8037A_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.DoIncAllChildrenCount

function Tl3CustomVirtualNode.DoGetChildByNumber(aNum: Integer): Il3Node;
//#UC START# *54C8E5660144_4ADDF3930121_var*
//#UC END# *54C8E5660144_4ADDF3930121_var*
begin
//#UC START# *54C8E5660144_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8E5660144_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.DoGetChildByNumber

function Tl3CustomVirtualNode.DoIterate(Action: Tl3NodeAction;
 IterMode: Integer = 0;
 const aFromNode: Il3Node = nil): Il3Node;
//#UC START# *54C8E5AF00F8_4ADDF3930121_var*
//#UC END# *54C8E5AF00F8_4ADDF3930121_var*
begin
//#UC START# *54C8E5AF00F8_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8E5AF00F8_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.DoIterate

function Tl3CustomVirtualNode.DoInsertChildBefore(const aNextChild: Il3Node;
 const aChild: Il3Node): Il3Node;
//#UC START# *54C8E60703B6_4ADDF3930121_var*
//#UC END# *54C8E60703B6_4ADDF3930121_var*
begin
//#UC START# *54C8E60703B6_4ADDF3930121_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C8E60703B6_4ADDF3930121_impl*
end;//Tl3CustomVirtualNode.DoInsertChildBefore

procedure Tl3VirtualFlagsNode.Set_ParentNode(const aValue: Il3Node);
//#UC START# *4DFF154E0063_4ADDF380009E_var*
//#UC END# *4DFF154E0063_4ADDF380009E_var*
begin
//#UC START# *4DFF154E0063_4ADDF380009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DFF154E0063_4ADDF380009E_impl*
end;//Tl3VirtualFlagsNode.Set_ParentNode

procedure Tl3VirtualFlagsNode.Set_PrevNode(const aValue: Il3Node);
//#UC START# *4DFF15710135_4ADDF380009E_var*
//#UC END# *4DFF15710135_4ADDF380009E_var*
begin
//#UC START# *4DFF15710135_4ADDF380009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DFF15710135_4ADDF380009E_impl*
end;//Tl3VirtualFlagsNode.Set_PrevNode

procedure Tl3VirtualFlagsNode.Set_NextNode(const aValue: Il3Node);
//#UC START# *4DFF15B3015B_4ADDF380009E_var*
//#UC END# *4DFF15B3015B_4ADDF380009E_var*
begin
//#UC START# *4DFF15B3015B_4ADDF380009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DFF15B3015B_4ADDF380009E_impl*
end;//Tl3VirtualFlagsNode.Set_NextNode

end.
