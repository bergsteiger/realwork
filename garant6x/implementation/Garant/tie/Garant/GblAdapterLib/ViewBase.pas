unit ViewBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ViewBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::ViewBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  FlagNodeBase,
  reeBase,
  DynamicTreeDefinesUnit,
  DefaultNodeBase
  ;

type
 ViewBase = {abstract} class(TreeBase)
 protected
 // property methods
   function pm_GetMode: TFlagMask; virtual;
   function pm_GetParentTreeRoot: DefaultNodeBase; virtual;
   function pm_GetMaximumLevelsRestriction: unsigned integer; virtual;
   function pm_GetAutoOpen: Boolean; virtual;
 protected
 // realized methods
   function GetChangeMutex: mutex; override;
   function pm_GetTreeName: AnsiString; override;
 protected
 // overridden protected methods
   function MasterTree: TreeBase; override;
 public
 // overridden public methods
   function IsMode(shared_flags: TFlagMask): Boolean; override;
   procedure LoadNodesFromServer(parent_point;
    child_point;
    from: Integer;
    in_block_position: Cardinal;
    var current_stub); override; // can raise InvalidOwnerTree
   function GetSharedMode: TFlagMask; override;
   procedure ExpandAll(expand: Boolean); override;
 public
 // public methods
   constructor Make; virtual;
   procedure BuildNode(snode;
    var current_stub: FlagNodeBase); virtual;
   procedure Init(mode: TFlagMask;
    levels: unsigned integer;
    auto_open: Boolean;
    parent_tree: TreeBase;
    server_tree); virtual;
 protected
 // protected properties
   property mode: TFlagMask
     read pm_GetMode;
   property parent_tree_root: DefaultNodeBase
     read pm_GetParentTreeRoot;
   property maximum_levels_restriction: unsigned integer
     read pm_GetMaximumLevelsRestriction;
   property auto_open: Boolean
     read pm_GetAutoOpen;
 end;//ViewBase

implementation

uses
  RealNodeBase,
  ApplicationHelper
  ;

// start class ViewBase

function ViewBase.pm_GetMode: TFlagMask;
//#UC START# *46025C6602BF_45F57B6C0128get_var*
//#UC END# *46025C6602BF_45F57B6C0128get_var*
begin
//#UC START# *46025C6602BF_45F57B6C0128get_impl*
 Result := f_mode
//#UC END# *46025C6602BF_45F57B6C0128get_impl*
end;//ViewBase.pm_GetMode

function ViewBase.pm_GetParentTreeRoot: DefaultNodeBase;
//#UC START# *46025C860251_45F57B6C0128get_var*
//#UC END# *46025C860251_45F57B6C0128get_var*
begin
//#UC START# *46025C860251_45F57B6C0128get_impl*
 Result := f_parent_tree_root
//#UC END# *46025C860251_45F57B6C0128get_impl*
end;//ViewBase.pm_GetParentTreeRoot

function ViewBase.pm_GetMaximumLevelsRestriction: unsigned integer;
//#UC START# *46025C9E01D4_45F57B6C0128get_var*
//#UC END# *46025C9E01D4_45F57B6C0128get_var*
begin
//#UC START# *46025C9E01D4_45F57B6C0128get_impl*
 Result := f_maximum_levels_restriction
//#UC END# *46025C9E01D4_45F57B6C0128get_impl*
end;//ViewBase.pm_GetMaximumLevelsRestriction

function ViewBase.pm_GetAutoOpen: Boolean;
//#UC START# *46025CBB01B5_45F57B6C0128get_var*
//#UC END# *46025CBB01B5_45F57B6C0128get_var*
begin
//#UC START# *46025CBB01B5_45F57B6C0128get_impl*
 Result := f_auto_open
//#UC END# *46025CBB01B5_45F57B6C0128get_impl*
end;//ViewBase.pm_GetAutoOpen

constructor ViewBase.Make;
//#UC START# *46025BAC02FD_45F57B6C0128_var*
//#UC END# *46025BAC02FD_45F57B6C0128_var*
begin
//#UC START# *46025BAC02FD_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *46025BAC02FD_45F57B6C0128_impl*
end;//ViewBase.Make

procedure ViewBase.BuildNode(snode;
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
  server_tree);
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

function ViewBase.pm_GetTreeName: AnsiString;
//#UC START# *4948E2B2038D_45F57B6C0128get_var*
//#UC END# *4948E2B2038D_45F57B6C0128get_var*
begin
//#UC START# *4948E2B2038D_45F57B6C0128get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4948E2B2038D_45F57B6C0128get_impl*
end;//ViewBase.pm_GetTreeName

function ViewBase.IsMode(shared_flags: TFlagMask): Boolean;
//#UC START# *4601221600DA_45F57B6C0128_var*
//#UC END# *4601221600DA_45F57B6C0128_var*
begin
//#UC START# *4601221600DA_45F57B6C0128_impl*
 !!! Needs to be implemented !!!
//#UC END# *4601221600DA_45F57B6C0128_impl*
end;//ViewBase.IsMode

procedure ViewBase.LoadNodesFromServer(parent_point;
  child_point;
  from: Integer;
  in_block_position: Cardinal;
  var current_stub); // can raise InvalidOwnerTree
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