unit ViewBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ViewBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ViewBase" MUID: (45F57B6C0128)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , reeBase
 , DynamicTreeDefinesUnit
 , DefaultNodeBase
 , FlagNodeBase
;

type
 ViewBase = {abstract} class(TreeBase)
  protected
   function GetMode: TFlagMask; virtual; stdcall;
   function GetParentTreeRoot: DefaultNodeBase; virtual; stdcall;
   function GetMaximumLevelsRestriction: unsigned integer; virtual; stdcall;
   function GetAutoOpen: ByteBool; virtual; stdcall;
   function GetTreeName: AnsiString; override;
   function MasterTree: TreeBase; override;
  public
   constructor Make; reintroduce; virtual; stdcall;
   procedure BuildNode(const snode;
    var current_stub: FlagNodeBase); virtual; stdcall;
   procedure Init(mode: TFlagMask;
    levels: unsigned integer;
    auto_open: Boolean;
    parent_tree: TreeBase;
    const server_tree); virtual; stdcall;
   function GetChangeMutex: mutex; override;
   function IsMode(shared_flags: TFlagMask): ByteBool; override;
   procedure LoadNodesFromServer(const parent_point;
    const child_point;
    from: Integer;
    in_block_position: Cardinal;
    var current_stub); override; { can raise InvalidOwnerTree }
   function GetSharedMode: TFlagMask; override;
   procedure ExpandAll(expand: Boolean); override;
  protected
   property Mode: TFlagMask
    read GetMode;
   property ParentTreeRoot: DefaultNodeBase
    read GetParentTreeRoot;
   property MaximumLevelsRestriction: unsigned integer
    read GetMaximumLevelsRestriction;
   property AutoOpen: ByteBool
    read GetAutoOpen;
 end;//ViewBase

implementation

uses
 l3ImplUses
 , DelegateNodeBase
 , RealNodeBase
 , ApplicationHelper
;

type
 TreeBaseFriend = {abstract} class(TreeBase)
  {* Друг к классу TreeBase }
 end;//TreeBaseFriend

 DelegateNodeBaseFriend = {abstract} class(DelegateNodeBase)
  {* Друг к классу DelegateNodeBase }
 end;//DelegateNodeBaseFriend

function ViewBase.GetMode: TFlagMask;
//#UC START# *46025C6602BF_45F57B6C0128get_var*
//#UC END# *46025C6602BF_45F57B6C0128get_var*
begin
//#UC START# *46025C6602BF_45F57B6C0128get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025C6602BF_45F57B6C0128get_impl*
end;//ViewBase.GetMode

function ViewBase.GetParentTreeRoot: DefaultNodeBase;
//#UC START# *46025C860251_45F57B6C0128get_var*
//#UC END# *46025C860251_45F57B6C0128get_var*
begin
//#UC START# *46025C860251_45F57B6C0128get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025C860251_45F57B6C0128get_impl*
end;//ViewBase.GetParentTreeRoot

function ViewBase.GetMaximumLevelsRestriction: unsigned integer;
//#UC START# *46025C9E01D4_45F57B6C0128get_var*
//#UC END# *46025C9E01D4_45F57B6C0128get_var*
begin
//#UC START# *46025C9E01D4_45F57B6C0128get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025C9E01D4_45F57B6C0128get_impl*
end;//ViewBase.GetMaximumLevelsRestriction

function ViewBase.GetAutoOpen: ByteBool;
//#UC START# *46025CBB01B5_45F57B6C0128get_var*
//#UC END# *46025CBB01B5_45F57B6C0128get_var*
begin
//#UC START# *46025CBB01B5_45F57B6C0128get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025CBB01B5_45F57B6C0128get_impl*
end;//ViewBase.GetAutoOpen

constructor ViewBase.Make;
//#UC START# *46025BAC02FD_45F57B6C0128_var*
//#UC END# *46025BAC02FD_45F57B6C0128_var*
begin
//#UC START# *46025BAC02FD_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025BAC02FD_45F57B6C0128_impl*
end;//ViewBase.Make

procedure ViewBase.BuildNode(const snode;
 var current_stub: FlagNodeBase);
//#UC START# *46272A80037A_45F57B6C0128_var*
//#UC END# *46272A80037A_45F57B6C0128_var*
begin
//#UC START# *46272A80037A_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46272A80037A_45F57B6C0128_impl*
end;//ViewBase.BuildNode

procedure ViewBase.Init(mode: TFlagMask;
 levels: unsigned integer;
 auto_open: Boolean;
 parent_tree: TreeBase;
 const server_tree);
//#UC START# *46025D6F0000_45F57B6C0128_var*
//#UC END# *46025D6F0000_45F57B6C0128_var*
begin
//#UC START# *46025D6F0000_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025D6F0000_45F57B6C0128_impl*
end;//ViewBase.Init

function ViewBase.GetChangeMutex: mutex;
//#UC START# *460139CE02BF_45F57B6C0128_var*
//#UC END# *460139CE02BF_45F57B6C0128_var*
begin
//#UC START# *460139CE02BF_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *460139CE02BF_45F57B6C0128_impl*
end;//ViewBase.GetChangeMutex

function ViewBase.GetTreeName: AnsiString;
//#UC START# *4948E2B2038D_45F57B6C0128get_var*
//#UC END# *4948E2B2038D_45F57B6C0128get_var*
begin
//#UC START# *4948E2B2038D_45F57B6C0128get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4948E2B2038D_45F57B6C0128get_impl*
end;//ViewBase.GetTreeName

function ViewBase.IsMode(shared_flags: TFlagMask): ByteBool;
//#UC START# *4601221600DA_45F57B6C0128_var*
//#UC END# *4601221600DA_45F57B6C0128_var*
begin
//#UC START# *4601221600DA_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601221600DA_45F57B6C0128_impl*
end;//ViewBase.IsMode

procedure ViewBase.LoadNodesFromServer(const parent_point;
 const child_point;
 from: Integer;
 in_block_position: Cardinal;
 var current_stub); { can raise InvalidOwnerTree }
//#UC START# *46012392006D_45F57B6C0128_var*
//#UC END# *46012392006D_45F57B6C0128_var*
begin
//#UC START# *46012392006D_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012392006D_45F57B6C0128_impl*
end;//ViewBase.LoadNodesFromServer

function ViewBase.GetSharedMode: TFlagMask;
//#UC START# *4601240A033C_45F57B6C0128_var*
//#UC END# *4601240A033C_45F57B6C0128_var*
begin
//#UC START# *4601240A033C_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601240A033C_45F57B6C0128_impl*
end;//ViewBase.GetSharedMode

procedure ViewBase.ExpandAll(expand: Boolean);
//#UC START# *460127560261_45F57B6C0128_var*
//#UC END# *460127560261_45F57B6C0128_var*
begin
//#UC START# *460127560261_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *460127560261_45F57B6C0128_impl*
end;//ViewBase.ExpandAll

function ViewBase.MasterTree: TreeBase;
//#UC START# *46012787038A_45F57B6C0128_var*
//#UC END# *46012787038A_45F57B6C0128_var*
begin
//#UC START# *46012787038A_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46012787038A_45F57B6C0128_impl*
end;//ViewBase.MasterTree

end.
