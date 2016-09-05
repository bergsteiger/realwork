unit DelegateNodeBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DelegateNodeBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "DelegateNodeBase" MUID: (45F6C139000F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DefaultNodeBase
 , RealNodeBase
 , reeBase
 , DynamicTreeDefinesUnit
;

type
 DelegateNodeBase = {abstract} class(DefaultNodeBase)
  protected
   function GetHasFilteredChildren: ByteBool; virtual; stdcall;
   procedure SetHasFilteredChildren(const aValue: ByteBool); virtual; stdcall;
   procedure SetMasterNode(aValue: RealNodeBase); virtual; stdcall;
   function CachedMasterNode: RealNodeBase; overload; virtual; stdcall;
   function CachedMasterNode: RealNodeBase; overload; virtual; stdcall;
   function ApplyChangeDelta(var delta): ByteBool; override;
   function HasParentFlag(flag: TFlagMask): ByteBool; override;
   function GetFlagCount(flag: TFlagMask): Cardinal; override;
   function HasChildrenFlag(flag: TFlagMask): ByteBool; override;
   function GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal; override;
  public
   constructor Make(var owner_tree: TreeBase); reintroduce; virtual; stdcall;
   procedure DrawNode(level: unsigned integer;
    index: unsigned integer); virtual; stdcall;
   procedure GetServerPointer; override;
   function NodeName: PAnsiChar; override;
   procedure SetAllFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function SetFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): ByteBool; override;
   function GetFlags: TFlagMask; override;
   function HasFlag(flag: TFlagMask): ByteBool; override;
  protected
   property HasFilteredChildren: ByteBool
    read GetHasFilteredChildren
    write SetHasFilteredChildren;
  public
   property MasterNode: RealNodeBase
    write SetMasterNode;
 end;//DelegateNodeBase

implementation

uses
 l3ImplUses
 //#UC START# *45F6C139000Fimpl_uses*
 //#UC END# *45F6C139000Fimpl_uses*
;

type
 RealNodeBaseFriend = {abstract} class(RealNodeBase)
  {* Друг к классу RealNodeBase }
 end;//RealNodeBaseFriend

function DelegateNodeBase.GetHasFilteredChildren: ByteBool;
//#UC START# *45FAC21A0148_45F6C139000Fget_var*
//#UC END# *45FAC21A0148_45F6C139000Fget_var*
begin
//#UC START# *45FAC21A0148_45F6C139000Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FAC21A0148_45F6C139000Fget_impl*
end;//DelegateNodeBase.GetHasFilteredChildren

procedure DelegateNodeBase.SetHasFilteredChildren(const aValue: ByteBool);
//#UC START# *45FAC21A0148_45F6C139000Fset_var*
//#UC END# *45FAC21A0148_45F6C139000Fset_var*
begin
//#UC START# *45FAC21A0148_45F6C139000Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FAC21A0148_45F6C139000Fset_impl*
end;//DelegateNodeBase.SetHasFilteredChildren

procedure DelegateNodeBase.SetMasterNode(aValue: RealNodeBase);
//#UC START# *47D6BA2603CF_45F6C139000Fset_var*
//#UC END# *47D6BA2603CF_45F6C139000Fset_var*
begin
//#UC START# *47D6BA2603CF_45F6C139000Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D6BA2603CF_45F6C139000Fset_impl*
end;//DelegateNodeBase.SetMasterNode

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

function DelegateNodeBase.ApplyChangeDelta(var delta): ByteBool;
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
 with_notify: Boolean): ByteBool;
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

function DelegateNodeBase.HasFlag(flag: TFlagMask): ByteBool;
//#UC START# *45F9305601F4_45F6C139000F_var*
//#UC END# *45F9305601F4_45F6C139000F_var*
begin
//#UC START# *45F9305601F4_45F6C139000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9305601F4_45F6C139000F_impl*
end;//DelegateNodeBase.HasFlag

function DelegateNodeBase.HasParentFlag(flag: TFlagMask): ByteBool;
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

function DelegateNodeBase.HasChildrenFlag(flag: TFlagMask): ByteBool;
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
