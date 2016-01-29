unit DelegateNodeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DelegateNodeBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  reeBase,
  RealNodeBase,
  DefaultNodeBase,
  DynamicTreeDefinesUnit
  ;

type
 DelegateNodeBase = {abstract} class(DefaultNodeBase)
 protected
 // property methods
   function pm_GetHasFilteredChildren: Boolean; virtual;
   procedure pm_SetHasFilteredChildren(aValue: Boolean); virtual;
   procedure pm_SetMasterNode(aValue: RealNodeBase); virtual;
 protected
 // realized methods
   procedure GetServerPointer; override;
   function NodeName: PAnsiChar; override;
   function ApplyChangeDelta(var delta): Boolean; override;
 protected
 // overridden protected methods
   function HasParentFlag(flag: TFlagMask): Boolean; override;
   function GetFlagCount(flag: TFlagMask): Cardinal; override;
   function HasChildrenFlag(flag: TFlagMask): Boolean; override;
   function GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal; override;
 public
 // overridden public methods
   procedure SetAllFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function SetFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): Boolean; override;
   function GetFlags: TFlagMask; override;
   function HasFlag(flag: TFlagMask): Boolean; override;
 protected
 // protected methods
   function CachedMasterNode: RealNodeBase; overload;  virtual;
   function CachedMasterNode: RealNodeBase; overload;  virtual;
 public
 // public methods
   constructor Make(var owner_tree: TreeBase); virtual;
   procedure DrawNode(level: unsigned integer;
    index: unsigned integer); virtual;
 protected
 // protected properties
   property has_filtered_children: Boolean
     read pm_GetHasFilteredChildren
     write pm_SetHasFilteredChildren;
 public
 // public properties
   property master_node: RealNodeBase
     write pm_SetMasterNode;
 end;//DelegateNodeBase

implementation

// start class DelegateNodeBase

function DelegateNodeBase.pm_GetHasFilteredChildren: Boolean;
//#UC START# *45FAC21A0148_45F6C139000Fget_var*
//#UC END# *45FAC21A0148_45F6C139000Fget_var*
begin
//#UC START# *45FAC21A0148_45F6C139000Fget_impl*
 Result := f_has_filtered_children
//#UC END# *45FAC21A0148_45F6C139000Fget_impl*
end;//DelegateNodeBase.pm_GetHasFilteredChildren

procedure DelegateNodeBase.pm_SetHasFilteredChildren(aValue: Boolean);
//#UC START# *45FAC21A0148_45F6C139000Fset_var*
//#UC END# *45FAC21A0148_45F6C139000Fset_var*
begin
//#UC START# *45FAC21A0148_45F6C139000Fset_impl*
 f_has_filtered_children := aValue
//#UC END# *45FAC21A0148_45F6C139000Fset_impl*
end;//DelegateNodeBase.pm_SetHasFilteredChildren

procedure DelegateNodeBase.pm_SetMasterNode(aValue: RealNodeBase);
//#UC START# *47D6BA2603CF_45F6C139000Fset_var*
//#UC END# *47D6BA2603CF_45F6C139000Fset_var*
begin
//#UC START# *47D6BA2603CF_45F6C139000Fset_impl*
 f_master_node := aValue
//#UC END# *47D6BA2603CF_45F6C139000Fset_impl*
end;//DelegateNodeBase.pm_SetMasterNode

constructor DelegateNodeBase.Make(var owner_tree: TreeBase);
//#UC START# *45FA90EF02AF_45F6C139000F_var*
//#UC END# *45FA90EF02AF_45F6C139000F_var*
begin
//#UC START# *45FA90EF02AF_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA90EF02AF_45F6C139000F_impl*
end;//DelegateNodeBase.Make

procedure DelegateNodeBase.DrawNode(level: unsigned integer;
  index: unsigned integer);
//#UC START# *45FAC1A40222_45F6C139000F_var*
//#UC END# *45FAC1A40222_45F6C139000F_var*
begin
//#UC START# *45FAC1A40222_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FAC1A40222_45F6C139000F_impl*
end;//DelegateNodeBase.DrawNode

function DelegateNodeBase.CachedMasterNode: RealNodeBase;
//#UC START# *47D6B83A00BD_45F6C139000F_var*
//#UC END# *47D6B83A00BD_45F6C139000F_var*
begin
//#UC START# *47D6B83A00BD_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6B83A00BD_45F6C139000F_impl*
end;//DelegateNodeBase.CachedMasterNode

function DelegateNodeBase.CachedMasterNode: RealNodeBase;
//#UC START# *47D6BE690392_45F6C139000F_var*
//#UC END# *47D6BE690392_45F6C139000F_var*
begin
//#UC START# *47D6BE690392_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6BE690392_45F6C139000F_impl*
end;//DelegateNodeBase.CachedMasterNode

procedure DelegateNodeBase.GetServerPointer;
//#UC START# *45F94B820290_45F6C139000F_var*
//#UC END# *45F94B820290_45F6C139000F_var*
begin
//#UC START# *45F94B820290_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B820290_45F6C139000F_impl*
end;//DelegateNodeBase.GetServerPointer

function DelegateNodeBase.NodeName: PAnsiChar;
//#UC START# *45F94D570138_45F6C139000F_var*
//#UC END# *45F94D570138_45F6C139000F_var*
begin
//#UC START# *45F94D570138_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D570138_45F6C139000F_impl*
end;//DelegateNodeBase.NodeName

function DelegateNodeBase.ApplyChangeDelta(var delta): Boolean;
//#UC START# *45F95B9A0000_45F6C139000F_var*
//#UC END# *45F95B9A0000_45F6C139000F_var*
begin
//#UC START# *45F95B9A0000_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95B9A0000_45F6C139000F_impl*
end;//DelegateNodeBase.ApplyChangeDelta

procedure DelegateNodeBase.SetAllFlag(flag: TFlagMask;
  value: Boolean;
  with_notify: Boolean);
//#UC START# *45F80922032C_45F6C139000F_var*
//#UC END# *45F80922032C_45F6C139000F_var*
begin
//#UC START# *45F80922032C_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80922032C_45F6C139000F_impl*
end;//DelegateNodeBase.SetAllFlag

function DelegateNodeBase.SetFlag(flag: TFlagMask;
  value: Boolean;
  with_notify: Boolean): Boolean;
//#UC START# *45F8123602DE_45F6C139000F_var*
//#UC END# *45F8123602DE_45F6C139000F_var*
begin
//#UC START# *45F8123602DE_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F6C139000F_impl*
end;//DelegateNodeBase.SetFlag

function DelegateNodeBase.GetFlags: TFlagMask;
//#UC START# *45F8124B0138_45F6C139000F_var*
//#UC END# *45F8124B0138_45F6C139000F_var*
begin
//#UC START# *45F8124B0138_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8124B0138_45F6C139000F_impl*
end;//DelegateNodeBase.GetFlags

function DelegateNodeBase.HasFlag(flag: TFlagMask): Boolean;
//#UC START# *45F9305601F4_45F6C139000F_var*
//#UC END# *45F9305601F4_45F6C139000F_var*
begin
//#UC START# *45F9305601F4_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9305601F4_45F6C139000F_impl*
end;//DelegateNodeBase.HasFlag

function DelegateNodeBase.HasParentFlag(flag: TFlagMask): Boolean;
//#UC START# *45F951DC0242_45F6C139000F_var*
//#UC END# *45F951DC0242_45F6C139000F_var*
begin
//#UC START# *45F951DC0242_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F951DC0242_45F6C139000F_impl*
end;//DelegateNodeBase.HasParentFlag

function DelegateNodeBase.GetFlagCount(flag: TFlagMask): Cardinal;
//#UC START# *45F9522101A5_45F6C139000F_var*
//#UC END# *45F9522101A5_45F6C139000F_var*
begin
//#UC START# *45F9522101A5_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9522101A5_45F6C139000F_impl*
end;//DelegateNodeBase.GetFlagCount

function DelegateNodeBase.HasChildrenFlag(flag: TFlagMask): Boolean;
//#UC START# *45FA5936035B_45F6C139000F_var*
//#UC END# *45FA5936035B_45F6C139000F_var*
begin
//#UC START# *45FA5936035B_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FA5936035B_45F6C139000F_impl*
end;//DelegateNodeBase.HasChildrenFlag

function DelegateNodeBase.GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal;
//#UC START# *4677A98A0290_45F6C139000F_var*
//#UC END# *4677A98A0290_45F6C139000F_var*
begin
//#UC START# *4677A98A0290_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4677A98A0290_45F6C139000F_impl*
end;//DelegateNodeBase.GetFirstLevelChildrenFlagCount

end.