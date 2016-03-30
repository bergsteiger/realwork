unit FlagNodeBase;
 {* нода с флагами }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FlagNodeBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "FlagNodeBase" MUID: (45F52C0602BF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeDefinesUnit
 , DynamicTreeUnit
 //#UC START# *45F52C0602BFintf_uses*
 //#UC END# *45F52C0602BFintf_uses*
;

type
 //#UC START# *45F52C0602BFci*
 //#UC END# *45F52C0602BFci*
 //#UC START# *45F52C0602BFcit*
 //#UC END# *45F52C0602BFcit*
 FlagNodeBase = {abstract} class
  {* нода с флагами }
  protected
   procedure SetFlags(aValue: TFlagMask); virtual; stdcall;
   constructor Make; reintroduce; virtual; stdcall;
  public
   procedure SetMyParent(var parent); virtual; stdcall;
   procedure GetMyParent; virtual; stdcall;
   procedure SetAllFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); virtual; abstract; stdcall;
   function InternalSetAllFlag(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; virtual; abstract; stdcall;
    {* возвращает количество взведённых (изменённых?) флагов. }
   function SetFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): ByteBool; virtual; stdcall;
   function HasFlag(flag: TFlagMask): ByteBool; virtual; stdcall;
   function GetFlags: TFlagMask; virtual; stdcall;
   procedure MakeVisible; virtual; stdcall;
   function IsVisible: ByteBool; virtual; stdcall;
   function GetNodeByVisibleIndex(index: TVisibleIndex): FlagNodeBase; virtual; stdcall;
   function NextWithFlag(flag: TFlagMask;
    skip_stub: Boolean = False): FlagNodeBase; virtual; stdcall;
   function NextVisible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual; stdcall;
   function PlaneNext(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual; stdcall;
   function PlaneNextBack(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual; stdcall;
   function PrevVisible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual; stdcall;
   function PrevVisibleStop(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; virtual; stdcall;
   function NextOneLevel(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; virtual; stdcall;
   function PrevOneLevel(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; virtual; stdcall;
   function AllVisibleChildrenCount: size; virtual; stdcall;
    {* // TODO: hide in cache }
   procedure SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); virtual; abstract; stdcall;
   function InternalSetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; virtual; abstract; stdcall;
  public
   property Flags: TFlagMask
    write SetFlags;
 //#UC START# *45F52C0602BFpubl*
 //#UC END# *45F52C0602BFpubl*
 end;//FlagNodeBase

implementation

uses
 l3ImplUses
 //#UC START# *45F52C0602BFimpl_uses*
 //#UC END# *45F52C0602BFimpl_uses*
;

procedure FlagNodeBase.SetFlags(aValue: TFlagMask);
//#UC START# *45F80BA20280_45F52C0602BFset_var*
//#UC END# *45F80BA20280_45F52C0602BFset_var*
begin
//#UC START# *45F80BA20280_45F52C0602BFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80BA20280_45F52C0602BFset_impl*
end;//FlagNodeBase.SetFlags

constructor FlagNodeBase.Make;
//#UC START# *45F803B0000F_45F52C0602BF_var*
//#UC END# *45F803B0000F_45F52C0602BF_var*
begin
//#UC START# *45F803B0000F_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F803B0000F_45F52C0602BF_impl*
end;//FlagNodeBase.Make

procedure FlagNodeBase.SetMyParent(var parent);
//#UC START# *45F8046500FA_45F52C0602BF_var*
//#UC END# *45F8046500FA_45F52C0602BF_var*
begin
//#UC START# *45F8046500FA_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8046500FA_45F52C0602BF_impl*
end;//FlagNodeBase.SetMyParent

procedure FlagNodeBase.GetMyParent;
//#UC START# *45F8049F0128_45F52C0602BF_var*
//#UC END# *45F8049F0128_45F52C0602BF_var*
begin
//#UC START# *45F8049F0128_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8049F0128_45F52C0602BF_impl*
end;//FlagNodeBase.GetMyParent

function FlagNodeBase.SetFlag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean): ByteBool;
//#UC START# *45F8123602DE_45F52C0602BF_var*
//#UC END# *45F8123602DE_45F52C0602BF_var*
begin
//#UC START# *45F8123602DE_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F52C0602BF_impl*
end;//FlagNodeBase.SetFlag

function FlagNodeBase.HasFlag(flag: TFlagMask): ByteBool;
//#UC START# *45F9305601F4_45F52C0602BF_var*
//#UC END# *45F9305601F4_45F52C0602BF_var*
begin
//#UC START# *45F9305601F4_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9305601F4_45F52C0602BF_impl*
end;//FlagNodeBase.HasFlag

function FlagNodeBase.GetFlags: TFlagMask;
//#UC START# *45F8124B0138_45F52C0602BF_var*
//#UC END# *45F8124B0138_45F52C0602BF_var*
begin
//#UC START# *45F8124B0138_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8124B0138_45F52C0602BF_impl*
end;//FlagNodeBase.GetFlags

procedure FlagNodeBase.MakeVisible;
//#UC START# *45F812D20290_45F52C0602BF_var*
//#UC END# *45F812D20290_45F52C0602BF_var*
begin
//#UC START# *45F812D20290_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F812D20290_45F52C0602BF_impl*
end;//FlagNodeBase.MakeVisible

function FlagNodeBase.IsVisible: ByteBool;
//#UC START# *45F8145B0203_45F52C0602BF_var*
//#UC END# *45F8145B0203_45F52C0602BF_var*
begin
//#UC START# *45F8145B0203_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8145B0203_45F52C0602BF_impl*
end;//FlagNodeBase.IsVisible

function FlagNodeBase.GetNodeByVisibleIndex(index: TVisibleIndex): FlagNodeBase;
//#UC START# *45F8151D02CE_45F52C0602BF_var*
//#UC END# *45F8151D02CE_45F52C0602BF_var*
begin
//#UC START# *45F8151D02CE_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8151D02CE_45F52C0602BF_impl*
end;//FlagNodeBase.GetNodeByVisibleIndex

function FlagNodeBase.NextWithFlag(flag: TFlagMask;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F815330251_45F52C0602BF_var*
//#UC END# *45F815330251_45F52C0602BF_var*
begin
//#UC START# *45F815330251_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F815330251_45F52C0602BF_impl*
end;//FlagNodeBase.NextWithFlag

function FlagNodeBase.NextVisible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F0B02BF_45F52C0602BF_var*
//#UC END# *45F81F0B02BF_45F52C0602BF_var*
begin
//#UC START# *45F81F0B02BF_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F0B02BF_45F52C0602BF_impl*
end;//FlagNodeBase.NextVisible

function FlagNodeBase.PlaneNext(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F6B01C5_45F52C0602BF_var*
//#UC END# *45F81F6B01C5_45F52C0602BF_var*
begin
//#UC START# *45F81F6B01C5_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F6B01C5_45F52C0602BF_impl*
end;//FlagNodeBase.PlaneNext

function FlagNodeBase.PlaneNextBack(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9071F035B_45F52C0602BF_var*
//#UC END# *45F9071F035B_45F52C0602BF_var*
begin
//#UC START# *45F9071F035B_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9071F035B_45F52C0602BF_impl*
end;//FlagNodeBase.PlaneNextBack

function FlagNodeBase.PrevVisible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9074B034B_45F52C0602BF_var*
//#UC END# *45F9074B034B_45F52C0602BF_var*
begin
//#UC START# *45F9074B034B_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9074B034B_45F52C0602BF_impl*
end;//FlagNodeBase.PrevVisible

function FlagNodeBase.PrevVisibleStop(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9077A003E_45F52C0602BF_var*
//#UC END# *45F9077A003E_45F52C0602BF_var*
begin
//#UC START# *45F9077A003E_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9077A003E_45F52C0602BF_impl*
end;//FlagNodeBase.PrevVisibleStop

function FlagNodeBase.NextOneLevel(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F90792004E_45F52C0602BF_var*
//#UC END# *45F90792004E_45F52C0602BF_var*
begin
//#UC START# *45F90792004E_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F90792004E_45F52C0602BF_impl*
end;//FlagNodeBase.NextOneLevel

function FlagNodeBase.PrevOneLevel(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F907B000EA_45F52C0602BF_var*
//#UC END# *45F907B000EA_45F52C0602BF_var*
begin
//#UC START# *45F907B000EA_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F907B000EA_45F52C0602BF_impl*
end;//FlagNodeBase.PrevOneLevel

function FlagNodeBase.AllVisibleChildrenCount: size;
 {* // TODO: hide in cache }
//#UC START# *45F907DE033C_45F52C0602BF_var*
//#UC END# *45F907DE033C_45F52C0602BF_var*
begin
//#UC START# *45F907DE033C_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F907DE033C_45F52C0602BF_impl*
end;//FlagNodeBase.AllVisibleChildrenCount

//#UC START# *45F52C0602BFimpl*
//#UC END# *45F52C0602BFimpl*

end.
