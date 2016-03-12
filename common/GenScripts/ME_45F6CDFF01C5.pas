unit FlagNodeStub;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FlagNodeStub.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , FlagNodeBase
 , DynamicTreeDefinesUnit
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
   procedure remove_me_and_siblings(var count: Cardinal); virtual;
  public
   constructor make; reintroduce; virtual;
   procedure set_all_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function internal_set_all_flag(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
    {* возвращает количество взведённых (изменённых?) флагов. }
   procedure set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean); override;
   function internal_set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
    value: Boolean;
    children_only: Boolean): size; override;
   function set_flag(flag: TFlagMask;
    value: Boolean;
    with_notify: Boolean): Boolean; override;
   function next_visible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function plane_next(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function plane_next_back(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function prev_visible(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function prev_visible_stop(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var;
    skip_stub: Boolean = False): FlagNodeBase; override;
   function next_one_level(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; override;
   function prev_one_level(out shift_counter: Integer;
    out for_constructed: TGCL::StaticNode_var): FlagNodeBase; override;
 //#UC START# *45F6CDFF01C5publ*
 //#UC END# *45F6CDFF01C5publ*
 end;//FlagNodeStub

implementation

uses
 l3ImplUses
 , reeBase
;

constructor FlagNodeStub.make;
//#UC START# *45FEA1AE0232_45F6CDFF01C5_var*
//#UC END# *45FEA1AE0232_45F6CDFF01C5_var*
begin
//#UC START# *45FEA1AE0232_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FEA1AE0232_45F6CDFF01C5_impl*
end;//FlagNodeStub.make

procedure FlagNodeStub.remove_me_and_siblings(var count: Cardinal);
//#UC START# *45FEA0EB005D_45F6CDFF01C5_var*
//#UC END# *45FEA0EB005D_45F6CDFF01C5_var*
begin
//#UC START# *45FEA0EB005D_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FEA0EB005D_45F6CDFF01C5_impl*
end;//FlagNodeStub.remove_me_and_siblings

procedure FlagNodeStub.set_all_flag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *45F80922032C_45F6CDFF01C5_var*
//#UC END# *45F80922032C_45F6CDFF01C5_var*
begin
//#UC START# *45F80922032C_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F80922032C_45F6CDFF01C5_impl*
end;//FlagNodeStub.set_all_flag

function FlagNodeStub.internal_set_all_flag(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
 {* возвращает количество взведённых (изменённых?) флагов. }
//#UC START# *45F810730290_45F6CDFF01C5_var*
//#UC END# *45F810730290_45F6CDFF01C5_var*
begin
//#UC START# *45F810730290_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F810730290_45F6CDFF01C5_impl*
end;//FlagNodeStub.internal_set_all_flag

procedure FlagNodeStub.set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean);
//#UC START# *51EFC6D0015B_45F6CDFF01C5_var*
//#UC END# *51EFC6D0015B_45F6CDFF01C5_var*
begin
//#UC START# *51EFC6D0015B_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC6D0015B_45F6CDFF01C5_impl*
end;//FlagNodeStub.set_all_flag_except_first_children_of_root_children

function FlagNodeStub.internal_set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
 value: Boolean;
 children_only: Boolean): size;
//#UC START# *51EFC7130001_45F6CDFF01C5_var*
//#UC END# *51EFC7130001_45F6CDFF01C5_var*
begin
//#UC START# *51EFC7130001_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EFC7130001_45F6CDFF01C5_impl*
end;//FlagNodeStub.internal_set_all_flag_except_first_children_of_root_children

function FlagNodeStub.set_flag(flag: TFlagMask;
 value: Boolean;
 with_notify: Boolean): Boolean;
//#UC START# *45F8123602DE_45F6CDFF01C5_var*
//#UC END# *45F8123602DE_45F6CDFF01C5_var*
begin
//#UC START# *45F8123602DE_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8123602DE_45F6CDFF01C5_impl*
end;//FlagNodeStub.set_flag

function FlagNodeStub.next_visible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F0B02BF_45F6CDFF01C5_var*
//#UC END# *45F81F0B02BF_45F6CDFF01C5_var*
begin
//#UC START# *45F81F0B02BF_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F0B02BF_45F6CDFF01C5_impl*
end;//FlagNodeStub.next_visible

function FlagNodeStub.plane_next(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F81F6B01C5_45F6CDFF01C5_var*
//#UC END# *45F81F6B01C5_45F6CDFF01C5_var*
begin
//#UC START# *45F81F6B01C5_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F81F6B01C5_45F6CDFF01C5_impl*
end;//FlagNodeStub.plane_next

function FlagNodeStub.plane_next_back(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9071F035B_45F6CDFF01C5_var*
//#UC END# *45F9071F035B_45F6CDFF01C5_var*
begin
//#UC START# *45F9071F035B_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9071F035B_45F6CDFF01C5_impl*
end;//FlagNodeStub.plane_next_back

function FlagNodeStub.prev_visible(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9074B034B_45F6CDFF01C5_var*
//#UC END# *45F9074B034B_45F6CDFF01C5_var*
begin
//#UC START# *45F9074B034B_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9074B034B_45F6CDFF01C5_impl*
end;//FlagNodeStub.prev_visible

function FlagNodeStub.prev_visible_stop(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var;
 skip_stub: Boolean = False): FlagNodeBase;
//#UC START# *45F9077A003E_45F6CDFF01C5_var*
//#UC END# *45F9077A003E_45F6CDFF01C5_var*
begin
//#UC START# *45F9077A003E_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F9077A003E_45F6CDFF01C5_impl*
end;//FlagNodeStub.prev_visible_stop

function FlagNodeStub.next_one_level(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F90792004E_45F6CDFF01C5_var*
//#UC END# *45F90792004E_45F6CDFF01C5_var*
begin
//#UC START# *45F90792004E_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F90792004E_45F6CDFF01C5_impl*
end;//FlagNodeStub.next_one_level

function FlagNodeStub.prev_one_level(out shift_counter: Integer;
 out for_constructed: TGCL::StaticNode_var): FlagNodeBase;
//#UC START# *45F907B000EA_45F6CDFF01C5_var*
//#UC END# *45F907B000EA_45F6CDFF01C5_var*
begin
//#UC START# *45F907B000EA_45F6CDFF01C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F907B000EA_45F6CDFF01C5_impl*
end;//FlagNodeStub.prev_one_level

//#UC START# *45F6CDFF01C5impl*
//#UC END# *45F6CDFF01C5impl*

end.
