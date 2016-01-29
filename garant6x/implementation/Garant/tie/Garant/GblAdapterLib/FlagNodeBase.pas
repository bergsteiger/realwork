unit FlagNodeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/FlagNodeBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::FlagNodeBase
//
// нода с флагами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DynamicTreeUnit,
  DynamicTreeDefinesUnit
  ;

type
//#UC START# *45F52C0602BFci*
//#UC END# *45F52C0602BFci*
 FlagNodeBase = {abstract} class
  {* нода с флагами }
 protected
 // property methods
   procedure pm_SetFlags(aValue: TFlagMask); virtual;
 protected
 // protected methods
   constructor Make; virtual;
 public
 // public methods
   procedure SetMyParent(var parent); virtual;
   procedure GetMyParent; virtual;
   procedure SetAllFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); virtual; abstract;
   function InternalSetAllFlag(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; virtual; abstract;
     {* возвращает количество взведённых (изменённых?) флагов. }
   function SetFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): Boolean; virtual;
   function HasFlag(flag: TFlagMask): Boolean; virtual;
   function GetFlags: TFlagMask; virtual;
   procedure MakeVisible; virtual;
   function IsVisible: Boolean; virtual;
   function GetNodeByVisibleIndex(index: TVisibleIndex): FlagNodeBase; virtual;
   function NextWithFlag(flag: TFlagMask;
    skip_stub: Boolean = false): FlagNodeBase; virtual;
   function NextVisible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = false): FlagNodeBase; virtual;
   function PlaneNext(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = false): FlagNodeBase; virtual;
   function PlaneNextBack(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = false): FlagNodeBase; virtual;
   function PrevVisible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = false): FlagNodeBase; virtual;
   function PrevVisibleStop(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = false): FlagNodeBase; virtual;
   function NextOneLevel(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; virtual;
   function PrevOneLevel(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; virtual;
   function AllVisibleChildrenCount: size; virtual;
     {* // TODO: hide in cache }
   procedure SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); virtual; abstract;
   function InternalSetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; virtual; abstract;
 public
 // public properties
   property flags: TFlagMask
     write pm_SetFlags;
//#UC START# *45F52C0602BFpubl*
//#UC END# *45F52C0602BFpubl*
 end;//FlagNodeBase

implementation

// start class FlagNodeBase

procedure FlagNodeBase.pm_SetFlags(aValue: TFlagMask);
//#UC START# *45F80BA20280_45F52C0602BFset_var*
//#UC END# *45F80BA20280_45F52C0602BFset_var*
begin
//#UC START# *45F80BA20280_45F52C0602BFset_impl*
 f_flags := aValue
//#UC END# *45F80BA20280_45F52C0602BFset_impl*
end;//FlagNodeBase.pm_SetFlags

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
  with_notify: Boolean): Boolean;
//#UC START# *45F8123602DE_45F52C0602BF_var*
//#UC END# *45F8123602DE_45F52C0602BF_var*
begin
//#UC START# *45F8123602DE_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F52C0602BF_impl*
end;//FlagNodeBase.SetFlag

function FlagNodeBase.HasFlag(flag: TFlagMask): Boolean;
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

function FlagNodeBase.IsVisible: Boolean;
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
  skip_stub: Boolean = false): FlagNodeBase;
//#UC START# *45F815330251_45F52C0602BF_var*
//#UC END# *45F815330251_45F52C0602BF_var*
begin
//#UC START# *45F815330251_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F815330251_45F52C0602BF_impl*
end;//FlagNodeBase.NextWithFlag

function FlagNodeBase.NextVisible(out shift_counter: Integer;
  out for_constructed: TGCL::StaticNode_var;
  skip_stub: Boolean = false): FlagNodeBase;
//#UC START# *45F81F0B02BF_45F52C0602BF_var*
//#UC END# *45F81F0B02BF_45F52C0602BF_var*
begin
//#UC START# *45F81F0B02BF_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F0B02BF_45F52C0602BF_impl*
end;//FlagNodeBase.NextVisible

function FlagNodeBase.PlaneNext(out shift_counter: Integer;
  out for_constructed: TGCL::StaticNode_var;
  skip_stub: Boolean = false): FlagNodeBase;
//#UC START# *45F81F6B01C5_45F52C0602BF_var*
//#UC END# *45F81F6B01C5_45F52C0602BF_var*
begin
//#UC START# *45F81F6B01C5_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F6B01C5_45F52C0602BF_impl*
end;//FlagNodeBase.PlaneNext

function FlagNodeBase.PlaneNextBack(out shift_counter: Integer;
  out for_constructed: TGCL::StaticNode_var;
  skip_stub: Boolean = false): FlagNodeBase;
//#UC START# *45F9071F035B_45F52C0602BF_var*
//#UC END# *45F9071F035B_45F52C0602BF_var*
begin
//#UC START# *45F9071F035B_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9071F035B_45F52C0602BF_impl*
end;//FlagNodeBase.PlaneNextBack

function FlagNodeBase.PrevVisible(out shift_counter: Integer;
  out for_constructed: TGCL::StaticNode_var;
  skip_stub: Boolean = false): FlagNodeBase;
//#UC START# *45F9074B034B_45F52C0602BF_var*
//#UC END# *45F9074B034B_45F52C0602BF_var*
begin
//#UC START# *45F9074B034B_45F52C0602BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9074B034B_45F52C0602BF_impl*
end;//FlagNodeBase.PrevVisible

function FlagNodeBase.PrevVisibleStop(out shift_counter: Integer;
  out for_constructed: TGCL::StaticNode_var;
  skip_stub: Boolean = false): FlagNodeBase;
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