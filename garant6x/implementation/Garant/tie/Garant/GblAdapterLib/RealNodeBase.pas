unit RealNodeBase;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\RealNodeBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "RealNodeBase" MUID: (45F7D8410157)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DefaultNodeBase
 , IOUnit
 , reeBase
 //#UC START# *45F7D8410157intf_uses*
 //#UC END# *45F7D8410157intf_uses*
;

type
 NodeChangeTransaction = class
  private
   transaction_data: ;
   nested_count: Cardinal;
   node: RealNodeBase;
  public
   constructor Make(var node: RealNodeBase); reintroduce; virtual; stdcall;
   procedure Open; virtual; stdcall;
   procedure Close; virtual; stdcall;
   procedure SetName(name: PAnsiChar); virtual; stdcall;
   procedure SetValue; virtual; stdcall;
   procedure SetEntity(const entity); virtual; stdcall;
   procedure TransactionData; virtual; stdcall;
 end;//NodeChangeTransaction

 NodeChangeTransactionHolder = class
  private
   transaction: NodeChangeTransaction;
  public
   constructor Make(var node: RealNodeBase); reintroduce; virtual; stdcall;
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
   procedure GetName; virtual; stdcall;
   procedure SetName(const aValue); virtual; stdcall;
   constructor Make; reintroduce; overload; virtual; stdcall;
   function ApplyChangeDelta(var delta): ByteBool; override;
  public
   procedure FillValue(var value); virtual; stdcall;
   procedure FillEntity(const entity); virtual; stdcall;
   procedure Init(var owner_tree: TreeBase); virtual; stdcall;
   procedure Reset(owner_tree: TreeBase); virtual; stdcall;
   procedure InitInserted(var owner: TreeBase;
    const data); virtual; stdcall;
   procedure DrawNode(level: unsigned integer;
    index: unsigned integer); virtual; stdcall;
   function IsEqual(const e): ByteBool; virtual; stdcall;
   function GetCurrentTransaction: NodeChangeTransaction; virtual; stdcall;
   procedure DeleteCurrentTransaction; virtual; stdcall;
   procedure CommitAndRemoveTransaction; virtual; stdcall;
   procedure PasteNode(const ptype;
    var node: DefaultNodeBase); virtual; stdcall;
   procedure PasteNodes(const ptype;
    const holder); virtual; stdcall;
   procedure ApplyTransaction; virtual; stdcall;
   procedure ChangeNodeValue(const value); virtual; stdcall;
   procedure ChangeNodeEntity(const entity); virtual; stdcall;
   constructor Make(var owner_tree: TreeBase;
    const snode); reintroduce; overload; virtual; stdcall;
   procedure GetServerPointer; override;
   function NodeName: PAnsiChar; override;
  protected
   property Name: 
    read GetName
    write SetName;
 //#UC START# *45F7D8410157publ*
 //#UC END# *45F7D8410157publ*
 end;//RealNodeBase

implementation

uses
 l3ImplUses
 , DelegateNodeBase
 //#UC START# *45F7D8410157impl_uses*
 //#UC END# *45F7D8410157impl_uses*
;

type
 DelegateNodeBaseFriend = {abstract} class(DelegateNodeBase)
  {* Друг к классу DelegateNodeBase }
 end;//DelegateNodeBaseFriend

constructor NodeChangeTransaction.Make(var node: RealNodeBase);
//#UC START# *45FF97C502FD_45FF97A70109_var*
//#UC END# *45FF97C502FD_45FF97A70109_var*
begin
//#UC START# *45FF97C502FD_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97C502FD_45FF97A70109_impl*
end;//NodeChangeTransaction.Make

procedure NodeChangeTransaction.Open;
//#UC START# *45FF97E20251_45FF97A70109_var*
//#UC END# *45FF97E20251_45FF97A70109_var*
begin
//#UC START# *45FF97E20251_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97E20251_45FF97A70109_impl*
end;//NodeChangeTransaction.Open

procedure NodeChangeTransaction.Close;
//#UC START# *45FF97EA030D_45FF97A70109_var*
//#UC END# *45FF97EA030D_45FF97A70109_var*
begin
//#UC START# *45FF97EA030D_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97EA030D_45FF97A70109_impl*
end;//NodeChangeTransaction.Close

procedure NodeChangeTransaction.SetName(name: PAnsiChar);
//#UC START# *45FF97F2031C_45FF97A70109_var*
//#UC END# *45FF97F2031C_45FF97A70109_var*
begin
//#UC START# *45FF97F2031C_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF97F2031C_45FF97A70109_impl*
end;//NodeChangeTransaction.SetName

procedure NodeChangeTransaction.SetValue;
//#UC START# *45FF9837030D_45FF97A70109_var*
//#UC END# *45FF9837030D_45FF97A70109_var*
begin
//#UC START# *45FF9837030D_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF9837030D_45FF97A70109_impl*
end;//NodeChangeTransaction.SetValue

procedure NodeChangeTransaction.SetEntity(const entity);
//#UC START# *45FF990800AB_45FF97A70109_var*
//#UC END# *45FF990800AB_45FF97A70109_var*
begin
//#UC START# *45FF990800AB_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF990800AB_45FF97A70109_impl*
end;//NodeChangeTransaction.SetEntity

procedure NodeChangeTransaction.TransactionData;
//#UC START# *45FF991B038A_45FF97A70109_var*
//#UC END# *45FF991B038A_45FF97A70109_var*
begin
//#UC START# *45FF991B038A_45FF97A70109_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF991B038A_45FF97A70109_impl*
end;//NodeChangeTransaction.TransactionData

constructor NodeChangeTransactionHolder.Make(var node: RealNodeBase);
//#UC START# *45FF99D90203_45FF99BC0399_var*
//#UC END# *45FF99D90203_45FF99BC0399_var*
begin
//#UC START# *45FF99D90203_45FF99BC0399_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF99D90203_45FF99BC0399_impl*
end;//NodeChangeTransactionHolder.Make

procedure RealNodeBase.GetName;
//#UC START# *45FFE327036B_45F7D8410157get_var*
//#UC END# *45FFE327036B_45F7D8410157get_var*
begin
//#UC START# *45FFE327036B_45F7D8410157get_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE327036B_45F7D8410157get_impl*
end;//RealNodeBase.GetName

procedure RealNodeBase.SetName(const aValue);
//#UC START# *45FFE327036B_45F7D8410157set_var*
//#UC END# *45FFE327036B_45F7D8410157set_var*
begin
//#UC START# *45FFE327036B_45F7D8410157set_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE327036B_45F7D8410157set_impl*
end;//RealNodeBase.SetName

procedure RealNodeBase.FillValue(var value);
//#UC START# *45FFDF2B03B9_45F7D8410157_var*
//#UC END# *45FFDF2B03B9_45F7D8410157_var*
begin
//#UC START# *45FFDF2B03B9_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDF2B03B9_45F7D8410157_impl*
end;//RealNodeBase.FillValue

procedure RealNodeBase.FillEntity(const entity);
//#UC START# *45FFDF540213_45F7D8410157_var*
//#UC END# *45FFDF540213_45F7D8410157_var*
begin
//#UC START# *45FFDF540213_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDF540213_45F7D8410157_impl*
end;//RealNodeBase.FillEntity

procedure RealNodeBase.Init(var owner_tree: TreeBase);
//#UC START# *45FFDF6E005D_45F7D8410157_var*
//#UC END# *45FFDF6E005D_45F7D8410157_var*
begin
//#UC START# *45FFDF6E005D_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDF6E005D_45F7D8410157_impl*
end;//RealNodeBase.Init

procedure RealNodeBase.Reset(owner_tree: TreeBase);
//#UC START# *45FFDFAF0232_45F7D8410157_var*
//#UC END# *45FFDFAF0232_45F7D8410157_var*
begin
//#UC START# *45FFDFAF0232_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDFAF0232_45F7D8410157_impl*
end;//RealNodeBase.Reset

procedure RealNodeBase.InitInserted(var owner: TreeBase;
 const data);
//#UC START# *45FFDFBA003E_45F7D8410157_var*
//#UC END# *45FFDFBA003E_45F7D8410157_var*
begin
//#UC START# *45FFDFBA003E_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDFBA003E_45F7D8410157_impl*
end;//RealNodeBase.InitInserted

procedure RealNodeBase.DrawNode(level: unsigned integer;
 index: unsigned integer);
//#UC START# *45FFE07E034B_45F7D8410157_var*
//#UC END# *45FFE07E034B_45F7D8410157_var*
begin
//#UC START# *45FFE07E034B_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE07E034B_45F7D8410157_impl*
end;//RealNodeBase.DrawNode

function RealNodeBase.IsEqual(const e): ByteBool;
//#UC START# *45FFE0D503D8_45F7D8410157_var*
//#UC END# *45FFE0D503D8_45F7D8410157_var*
begin
//#UC START# *45FFE0D503D8_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE0D503D8_45F7D8410157_impl*
end;//RealNodeBase.IsEqual

function RealNodeBase.GetCurrentTransaction: NodeChangeTransaction;
//#UC START# *45FFE0FD030D_45F7D8410157_var*
//#UC END# *45FFE0FD030D_45F7D8410157_var*
begin
//#UC START# *45FFE0FD030D_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE0FD030D_45F7D8410157_impl*
end;//RealNodeBase.GetCurrentTransaction

procedure RealNodeBase.DeleteCurrentTransaction;
//#UC START# *45FFE11C0261_45F7D8410157_var*
//#UC END# *45FFE11C0261_45F7D8410157_var*
begin
//#UC START# *45FFE11C0261_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE11C0261_45F7D8410157_impl*
end;//RealNodeBase.DeleteCurrentTransaction

procedure RealNodeBase.CommitAndRemoveTransaction;
//#UC START# *45FFE12C031C_45F7D8410157_var*
//#UC END# *45FFE12C031C_45F7D8410157_var*
begin
//#UC START# *45FFE12C031C_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE12C031C_45F7D8410157_impl*
end;//RealNodeBase.CommitAndRemoveTransaction

procedure RealNodeBase.PasteNode(const ptype;
 var node: DefaultNodeBase);
//#UC START# *45FFE20201C5_45F7D8410157_var*
//#UC END# *45FFE20201C5_45F7D8410157_var*
begin
//#UC START# *45FFE20201C5_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE20201C5_45F7D8410157_impl*
end;//RealNodeBase.PasteNode

procedure RealNodeBase.PasteNodes(const ptype;
 const holder);
//#UC START# *45FFE26E001F_45F7D8410157_var*
//#UC END# *45FFE26E001F_45F7D8410157_var*
begin
//#UC START# *45FFE26E001F_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE26E001F_45F7D8410157_impl*
end;//RealNodeBase.PasteNodes

procedure RealNodeBase.ApplyTransaction;
//#UC START# *45FFE2AF035B_45F7D8410157_var*
//#UC END# *45FFE2AF035B_45F7D8410157_var*
begin
//#UC START# *45FFE2AF035B_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE2AF035B_45F7D8410157_impl*
end;//RealNodeBase.ApplyTransaction

procedure RealNodeBase.ChangeNodeValue(const value);
//#UC START# *45FFE2BC03A9_45F7D8410157_var*
//#UC END# *45FFE2BC03A9_45F7D8410157_var*
begin
//#UC START# *45FFE2BC03A9_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE2BC03A9_45F7D8410157_impl*
end;//RealNodeBase.ChangeNodeValue

procedure RealNodeBase.ChangeNodeEntity(const entity);
//#UC START# *45FFE2FB038A_45F7D8410157_var*
//#UC END# *45FFE2FB038A_45F7D8410157_var*
begin
//#UC START# *45FFE2FB038A_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE2FB038A_45F7D8410157_impl*
end;//RealNodeBase.ChangeNodeEntity

constructor RealNodeBase.Make;
//#UC START# *45FFF0060399_45F7D8410157_var*
//#UC END# *45FFF0060399_45F7D8410157_var*
begin
//#UC START# *45FFF0060399_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFF0060399_45F7D8410157_impl*
end;//RealNodeBase.Make

constructor RealNodeBase.Make(var owner_tree: TreeBase;
 const snode);
//#UC START# *45FFF06B0157_45F7D8410157_var*
//#UC END# *45FFF06B0157_45F7D8410157_var*
begin
//#UC START# *45FFF06B0157_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFF06B0157_45F7D8410157_impl*
end;//RealNodeBase.Make

procedure RealNodeBase.GetServerPointer;
//#UC START# *45F94B820290_45F7D8410157_var*
//#UC END# *45F94B820290_45F7D8410157_var*
begin
//#UC START# *45F94B820290_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94B820290_45F7D8410157_impl*
end;//RealNodeBase.GetServerPointer

function RealNodeBase.NodeName: PAnsiChar;
//#UC START# *45F94D570138_45F7D8410157_var*
//#UC END# *45F94D570138_45F7D8410157_var*
begin
//#UC START# *45F94D570138_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F94D570138_45F7D8410157_impl*
end;//RealNodeBase.NodeName

function RealNodeBase.ApplyChangeDelta(var delta): ByteBool;
//#UC START# *45F95B9A0000_45F7D8410157_var*
//#UC END# *45F95B9A0000_45F7D8410157_var*
begin
//#UC START# *45F95B9A0000_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F95B9A0000_45F7D8410157_impl*
end;//RealNodeBase.ApplyChangeDelta

//#UC START# *45F7D8410157impl*
//#UC END# *45F7D8410157impl*

end.
