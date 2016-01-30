unit RealNodeBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\RealNodeBase.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , DefaultNodeBase
 , IOUnit
 , reeBase
;

type
 NodeChangeTransaction = class
  private
   transaction_data: ;
   nested_count: Cardinal;
   node: RealNodeBase;
  public
   constructor make(var node: RealNodeBase); reintroduce; virtual;
   procedure open; virtual;
   procedure close; virtual;
   procedure set_name(name: PAnsiChar); virtual;
   procedure set_value; virtual;
   procedure set_entity(entity); virtual;
   procedure transaction_data; virtual;
 end;//NodeChangeTransaction

 NodeChangeTransactionHolder = class
  private
   transaction: NodeChangeTransaction;
  public
   constructor make(var node: RealNodeBase); reintroduce; virtual;
 end;//NodeChangeTransactionHolder

 //#UC START# *45F7D8410157ci*
 //#UC END# *45F7D8410157ci*
 //#UC START# *45F7D8410157cit*
 //#UC END# *45F7D8410157cit*
 RealNodeBase = {abstract} class(DefaultNodeBase)
  private
   server_point: ;
   current_transaction: NodeChangeTransaction;
  protected
   function pm_Getname: IString; virtual;
   procedure pm_Setname(const aValue: IString); virtual;
   constructor make; reintroduce; overload; virtual;
   function apply_change_delta(var delta): Boolean; override;
  public
   procedure fill_value(var value); virtual;
   procedure fill_entity(entity); virtual;
   procedure init(var owner_tree: TreeBase); virtual;
   procedure reset(owner_tree: TreeBase); virtual;
   procedure init_inserted(var owner: TreeBase;
    data); virtual;
   procedure draw_node(level: unsigned integer;
    index: unsigned integer); virtual;
   function is_equal(e): Boolean; virtual;
   function get_current_transaction: NodeChangeTransaction; virtual;
   procedure delete_current_transaction; virtual;
   procedure commit_and_remove_transaction; virtual;
   procedure paste_node(ptype;
    var node: DefaultNodeBase); virtual;
   procedure paste_nodes(ptype;
    holder); virtual;
   procedure apply_transaction; virtual;
   procedure change_node_value(value); virtual;
   procedure change_node_entity(entity); virtual;
   constructor make(var owner_tree: TreeBase;
    snode); reintroduce; overload; virtual;
   procedure get_server_pointer; override;
   function node_name: PAnsiChar; override;
  protected
   property name: IString
    read pm_Getname
    write pm_Setname;
 //#UC START# *45F7D8410157publ*
 //#UC END# *45F7D8410157publ*
 end;//RealNodeBase

implementation

uses
 l3ImplUses
;

constructor NodeChangeTransaction.make(var node: RealNodeBase);
//#UC START# *45FF97C502FD_45FF97A70109_var*
//#UC END# *45FF97C502FD_45FF97A70109_var*
begin
//#UC START# *45FF97C502FD_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97C502FD_45FF97A70109_impl*
end;//NodeChangeTransaction.make

procedure NodeChangeTransaction.open;
//#UC START# *45FF97E20251_45FF97A70109_var*
//#UC END# *45FF97E20251_45FF97A70109_var*
begin
//#UC START# *45FF97E20251_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97E20251_45FF97A70109_impl*
end;//NodeChangeTransaction.open

procedure NodeChangeTransaction.close;
//#UC START# *45FF97EA030D_45FF97A70109_var*
//#UC END# *45FF97EA030D_45FF97A70109_var*
begin
//#UC START# *45FF97EA030D_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97EA030D_45FF97A70109_impl*
end;//NodeChangeTransaction.close

procedure NodeChangeTransaction.set_name(name: PAnsiChar);
//#UC START# *45FF97F2031C_45FF97A70109_var*
//#UC END# *45FF97F2031C_45FF97A70109_var*
begin
//#UC START# *45FF97F2031C_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97F2031C_45FF97A70109_impl*
end;//NodeChangeTransaction.set_name

procedure NodeChangeTransaction.set_value;
//#UC START# *45FF9837030D_45FF97A70109_var*
//#UC END# *45FF9837030D_45FF97A70109_var*
begin
//#UC START# *45FF9837030D_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF9837030D_45FF97A70109_impl*
end;//NodeChangeTransaction.set_value

procedure NodeChangeTransaction.set_entity(entity);
//#UC START# *45FF990800AB_45FF97A70109_var*
//#UC END# *45FF990800AB_45FF97A70109_var*
begin
//#UC START# *45FF990800AB_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF990800AB_45FF97A70109_impl*
end;//NodeChangeTransaction.set_entity

procedure NodeChangeTransaction.transaction_data;
//#UC START# *45FF991B038A_45FF97A70109_var*
//#UC END# *45FF991B038A_45FF97A70109_var*
begin
//#UC START# *45FF991B038A_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF991B038A_45FF97A70109_impl*
end;//NodeChangeTransaction.transaction_data

constructor NodeChangeTransactionHolder.make(var node: RealNodeBase);
//#UC START# *45FF99D90203_45FF99BC0399_var*
//#UC END# *45FF99D90203_45FF99BC0399_var*
begin
//#UC START# *45FF99D90203_45FF99BC0399_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF99D90203_45FF99BC0399_impl*
end;//NodeChangeTransactionHolder.make

function RealNodeBase.pm_Getname: IString;
//#UC START# *45FFE327036B_45F7D8410157get_var*
//#UC END# *45FFE327036B_45F7D8410157get_var*
begin
//#UC START# *45FFE327036B_45F7D8410157get_impl*
 Result := f_name
//#UC END# *45FFE327036B_45F7D8410157get_impl*
end;//RealNodeBase.pm_Getname

procedure RealNodeBase.pm_Setname(const aValue: IString);
//#UC START# *45FFE327036B_45F7D8410157set_var*
//#UC END# *45FFE327036B_45F7D8410157set_var*
begin
//#UC START# *45FFE327036B_45F7D8410157set_impl*
 f_name := aValue
//#UC END# *45FFE327036B_45F7D8410157set_impl*
end;//RealNodeBase.pm_Setname

procedure RealNodeBase.fill_value(var value);
//#UC START# *45FFDF2B03B9_45F7D8410157_var*
//#UC END# *45FFDF2B03B9_45F7D8410157_var*
begin
//#UC START# *45FFDF2B03B9_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDF2B03B9_45F7D8410157_impl*
end;//RealNodeBase.fill_value

procedure RealNodeBase.fill_entity(entity);
//#UC START# *45FFDF540213_45F7D8410157_var*
//#UC END# *45FFDF540213_45F7D8410157_var*
begin
//#UC START# *45FFDF540213_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDF540213_45F7D8410157_impl*
end;//RealNodeBase.fill_entity

procedure RealNodeBase.init(var owner_tree: TreeBase);
//#UC START# *45FFDF6E005D_45F7D8410157_var*
//#UC END# *45FFDF6E005D_45F7D8410157_var*
begin
//#UC START# *45FFDF6E005D_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDF6E005D_45F7D8410157_impl*
end;//RealNodeBase.init

procedure RealNodeBase.reset(owner_tree: TreeBase);
//#UC START# *45FFDFAF0232_45F7D8410157_var*
//#UC END# *45FFDFAF0232_45F7D8410157_var*
begin
//#UC START# *45FFDFAF0232_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDFAF0232_45F7D8410157_impl*
end;//RealNodeBase.reset

procedure RealNodeBase.init_inserted(var owner: TreeBase;
 data);
//#UC START# *45FFDFBA003E_45F7D8410157_var*
//#UC END# *45FFDFBA003E_45F7D8410157_var*
begin
//#UC START# *45FFDFBA003E_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDFBA003E_45F7D8410157_impl*
end;//RealNodeBase.init_inserted

procedure RealNodeBase.draw_node(level: unsigned integer;
 index: unsigned integer);
//#UC START# *45FFE07E034B_45F7D8410157_var*
//#UC END# *45FFE07E034B_45F7D8410157_var*
begin
//#UC START# *45FFE07E034B_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE07E034B_45F7D8410157_impl*
end;//RealNodeBase.draw_node

function RealNodeBase.is_equal(e): Boolean;
//#UC START# *45FFE0D503D8_45F7D8410157_var*
//#UC END# *45FFE0D503D8_45F7D8410157_var*
begin
//#UC START# *45FFE0D503D8_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE0D503D8_45F7D8410157_impl*
end;//RealNodeBase.is_equal

function RealNodeBase.get_current_transaction: NodeChangeTransaction;
//#UC START# *45FFE0FD030D_45F7D8410157_var*
//#UC END# *45FFE0FD030D_45F7D8410157_var*
begin
//#UC START# *45FFE0FD030D_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE0FD030D_45F7D8410157_impl*
end;//RealNodeBase.get_current_transaction

procedure RealNodeBase.delete_current_transaction;
//#UC START# *45FFE11C0261_45F7D8410157_var*
//#UC END# *45FFE11C0261_45F7D8410157_var*
begin
//#UC START# *45FFE11C0261_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE11C0261_45F7D8410157_impl*
end;//RealNodeBase.delete_current_transaction

procedure RealNodeBase.commit_and_remove_transaction;
//#UC START# *45FFE12C031C_45F7D8410157_var*
//#UC END# *45FFE12C031C_45F7D8410157_var*
begin
//#UC START# *45FFE12C031C_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE12C031C_45F7D8410157_impl*
end;//RealNodeBase.commit_and_remove_transaction

procedure RealNodeBase.paste_node(ptype;
 var node: DefaultNodeBase);
//#UC START# *45FFE20201C5_45F7D8410157_var*
//#UC END# *45FFE20201C5_45F7D8410157_var*
begin
//#UC START# *45FFE20201C5_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE20201C5_45F7D8410157_impl*
end;//RealNodeBase.paste_node

procedure RealNodeBase.paste_nodes(ptype;
 holder);
//#UC START# *45FFE26E001F_45F7D8410157_var*
//#UC END# *45FFE26E001F_45F7D8410157_var*
begin
//#UC START# *45FFE26E001F_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE26E001F_45F7D8410157_impl*
end;//RealNodeBase.paste_nodes

procedure RealNodeBase.apply_transaction;
//#UC START# *45FFE2AF035B_45F7D8410157_var*
//#UC END# *45FFE2AF035B_45F7D8410157_var*
begin
//#UC START# *45FFE2AF035B_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE2AF035B_45F7D8410157_impl*
end;//RealNodeBase.apply_transaction

procedure RealNodeBase.change_node_value(value);
//#UC START# *45FFE2BC03A9_45F7D8410157_var*
//#UC END# *45FFE2BC03A9_45F7D8410157_var*
begin
//#UC START# *45FFE2BC03A9_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE2BC03A9_45F7D8410157_impl*
end;//RealNodeBase.change_node_value

procedure RealNodeBase.change_node_entity(entity);
//#UC START# *45FFE2FB038A_45F7D8410157_var*
//#UC END# *45FFE2FB038A_45F7D8410157_var*
begin
//#UC START# *45FFE2FB038A_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE2FB038A_45F7D8410157_impl*
end;//RealNodeBase.change_node_entity

constructor RealNodeBase.make;
//#UC START# *45FFF0060399_45F7D8410157_var*
//#UC END# *45FFF0060399_45F7D8410157_var*
begin
//#UC START# *45FFF0060399_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFF0060399_45F7D8410157_impl*
end;//RealNodeBase.make

constructor RealNodeBase.make(var owner_tree: TreeBase;
 snode);
//#UC START# *45FFF06B0157_45F7D8410157_var*
//#UC END# *45FFF06B0157_45F7D8410157_var*
begin
//#UC START# *45FFF06B0157_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFF06B0157_45F7D8410157_impl*
end;//RealNodeBase.make

procedure RealNodeBase.get_server_pointer;
//#UC START# *45F94B820290_45F7D8410157_var*
//#UC END# *45F94B820290_45F7D8410157_var*
begin
//#UC START# *45F94B820290_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B820290_45F7D8410157_impl*
end;//RealNodeBase.get_server_pointer

function RealNodeBase.node_name: PAnsiChar;
//#UC START# *45F94D570138_45F7D8410157_var*
//#UC END# *45F94D570138_45F7D8410157_var*
begin
//#UC START# *45F94D570138_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D570138_45F7D8410157_impl*
end;//RealNodeBase.node_name

function RealNodeBase.apply_change_delta(var delta): Boolean;
//#UC START# *45F95B9A0000_45F7D8410157_var*
//#UC END# *45F95B9A0000_45F7D8410157_var*
begin
//#UC START# *45F95B9A0000_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95B9A0000_45F7D8410157_impl*
end;//RealNodeBase.apply_change_delta

//#UC START# *45F7D8410157impl*
//#UC END# *45F7D8410157impl*

end.
