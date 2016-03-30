unit FlagNodeStub;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FlagNodeStub.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "FlagNodeStub" MUID: (45F6CDFF01C5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , FlagNodeBase
 , DynamicTreeDefinesUnit
 //#UC START# *45F6CDFF01C5intf_uses*
 //#UC END# *45F6CDFF01C5intf_uses*
;

type
 //#UC START# *45F6CDFF01C5ci*
 //#UC END# *45F6CDFF01C5ci*
 //#UC START# *45F6CDFF01C5cit*
 //#UC END# *45F6CDFF01C5cit*
 FlagNodeStub = {final} class(FlagNodeBase)
  public
   _StubImpl: FlagNodeStub;
  protected
   procedure RemoveMeAndSiblings(var count: Cardinal); virtual; stdcall;
  public
   constructor Make; reintroduce; virtual; stdcall;
   procedure SetAllFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function InternalSetAllFlag(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
    {* возвращает количество взведённых (изменённых?) флагов. }
   procedure SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function InternalSetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
   function SetFlag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): ByteBool; override;
   function NextVisible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function PlaneNext(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function PlaneNextBack(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function PrevVisible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function PrevVisibleStop(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function NextOneLevel(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; override;
   function PrevOneLevel(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; override;
 //#UC START# *45F6CDFF01C5publ*
 //#UC END# *45F6CDFF01C5publ*
 end;//FlagNodeStub

implementation

uses
 l3ImplUses
 , reeBase
 //#UC START# *45F6CDFF01C5impl_uses*
 //#UC END# *45F6CDFF01C5impl_uses*
;

constructor FlagNodeStub.Make;
//#UC START# *45FEA1AE0232_45F6CDFF01C5_var*
//#UC END# *45FEA1AE0232_45F6CDFF01C5_var*
begin
//#UC START# *45FEA1AE0232_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FEA1AE0232_45F6CDFF01C5_impl*
end;//FlagNodeStub.Make

procedure FlagNodeStub.RemoveMeAndSiblings(var count: Cardinal);
//#UC START# *45FEA0EB005D_45F6CDFF01C5_var*
//#UC END# *45FEA0EB005D_45F6CDFF01C5_var*
begin
//#UC START# *45FEA0EB005D_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FEA0EB005D_45F6CDFF01C5_impl*
end;//FlagNodeStub.RemoveMeAndSiblings

procedure FlagNodeStub.SetAllFlag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *45F80922032C_45F6CDFF01C5_var*
//#UC END# *45F80922032C_45F6CDFF01C5_var*
begin
//#UC START# *45F80922032C_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80922032C_45F6CDFF01C5_impl*
end;//FlagNodeStub.SetAllFlag

function FlagNodeStub.InternalSetAllFlag(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
 {* возвращает количество взведённых (изменённых?) флагов. }
//#UC START# *45F810730290_45F6CDFF01C5_var*
//#UC END# *45F810730290_45F6CDFF01C5_var*
begin
//#UC START# *45F810730290_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F810730290_45F6CDFF01C5_impl*
end;//FlagNodeStub.InternalSetAllFlag

procedure FlagNodeStub.SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *51EFC6D0015B_45F6CDFF01C5_var*
//#UC END# *51EFC6D0015B_45F6CDFF01C5_var*
begin
//#UC START# *51EFC6D0015B_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC6D0015B_45F6CDFF01C5_impl*
end;//FlagNodeStub.SetAllFlagExceptFirstChildrenOfRootChildren

function FlagNodeStub.InternalSetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
//#UC START# *51EFC7130001_45F6CDFF01C5_var*
//#UC END# *51EFC7130001_45F6CDFF01C5_var*
begin
//#UC START# *51EFC7130001_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC7130001_45F6CDFF01C5_impl*
end;//FlagNodeStub.InternalSetAllFlagExceptFirstChildrenOfRootChildren

function FlagNodeStub.SetFlag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean): ByteBool;
//#UC START# *45F8123602DE_45F6CDFF01C5_var*
//#UC END# *45F8123602DE_45F6CDFF01C5_var*
begin
//#UC START# *45F8123602DE_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F6CDFF01C5_impl*
end;//FlagNodeStub.SetFlag

function FlagNodeStub.NextVisible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F0B02BF_45F6CDFF01C5_var*
//#UC END# *45F81F0B02BF_45F6CDFF01C5_var*
begin
//#UC START# *45F81F0B02BF_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F0B02BF_45F6CDFF01C5_impl*
end;//FlagNodeStub.NextVisible

function FlagNodeStub.PlaneNext(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F6B01C5_45F6CDFF01C5_var*
//#UC END# *45F81F6B01C5_45F6CDFF01C5_var*
begin
//#UC START# *45F81F6B01C5_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F6B01C5_45F6CDFF01C5_impl*
end;//FlagNodeStub.PlaneNext

function FlagNodeStub.PlaneNextBack(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9071F035B_45F6CDFF01C5_var*
//#UC END# *45F9071F035B_45F6CDFF01C5_var*
begin
//#UC START# *45F9071F035B_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9071F035B_45F6CDFF01C5_impl*
end;//FlagNodeStub.PlaneNextBack

function FlagNodeStub.PrevVisible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9074B034B_45F6CDFF01C5_var*
//#UC END# *45F9074B034B_45F6CDFF01C5_var*
begin
//#UC START# *45F9074B034B_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9074B034B_45F6CDFF01C5_impl*
end;//FlagNodeStub.PrevVisible

function FlagNodeStub.PrevVisibleStop(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9077A003E_45F6CDFF01C5_var*
//#UC END# *45F9077A003E_45F6CDFF01C5_var*
begin
//#UC START# *45F9077A003E_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9077A003E_45F6CDFF01C5_impl*
end;//FlagNodeStub.PrevVisibleStop

function FlagNodeStub.NextOneLevel(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F90792004E_45F6CDFF01C5_var*
//#UC END# *45F90792004E_45F6CDFF01C5_var*
begin
//#UC START# *45F90792004E_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F90792004E_45F6CDFF01C5_impl*
end;//FlagNodeStub.NextOneLevel

function FlagNodeStub.PrevOneLevel(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F907B000EA_45F6CDFF01C5_var*
//#UC END# *45F907B000EA_45F6CDFF01C5_var*
begin
//#UC START# *45F907B000EA_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F907B000EA_45F6CDFF01C5_impl*
end;//FlagNodeStub.PrevOneLevel

//#UC START# *45F6CDFF01C5impl*
//#UC END# *45F6CDFF01C5impl*

end.
