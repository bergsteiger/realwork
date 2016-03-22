unit RealNodeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/RealNodeBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  reeBase,
  DefaultNodeBase
  ;

type
 NodeChangeTransaction = class
 private
 // private fields
   transaction_data : ;
   nested_count : Cardinal;
   node : RealNodeBase;
 public
 // public methods
   constructor Make(var node: RealNodeBase); virtual;
   procedure Open; virtual;
   procedure Close; virtual;
   procedure SetName(name: PAnsiChar); virtual;
   procedure SetValue; virtual;
   procedure SetEntity(entity); virtual;
   procedure TransactionData; overload;  virtual;
 end;//NodeChangeTransaction

 NodeChangeTransactionHolder = class
 private
 // private fields
   transaction : NodeChangeTransaction;
 public
 // public methods
   constructor Make(var node: RealNodeBase); virtual;
 end;//NodeChangeTransactionHolder

//#UC START# *45F7D8410157ci*
//#UC END# *45F7D8410157ci*
//#UC START# *45F7D8410157cit*
//#UC END# *45F7D8410157cit*
 RealNodeBase = {abstract} class(DefaultNodeBase)
 private
 // private fields
   server_point : ;
   current_transaction : NodeChangeTransaction;
 protected
 // property methods
   function pm_GetName: IString; virtual;
   procedure pm_SetName(const aValue: IString); virtual;
 protected
 // realized methods
   procedure GetServerPointer; override;
   function NodeName: PAnsiChar; override;
   function ApplyChangeDelta(var delta): Boolean; override;
 protected
 // protected methods
   constructor Make; overload;  virtual;
 public
 // public methods
   procedure FillValue(var value); virtual;
   procedure FillEntity(entity); virtual;
   procedure Init(var owner_tree: TreeBase); virtual;
   procedure Reset(owner_tree: TreeBase); virtual;
   procedure InitInserted(var owner: TreeBase;
    data); virtual;
   procedure DrawNode(level: unsigned integer;
    index: unsigned integer); virtual;
   function IsEqual(e): Boolean; virtual;
   function GetCurrentTransaction: NodeChangeTransaction; virtual;
   procedure DeleteCurrentTransaction; virtual;
   procedure CommitAndRemoveTransaction; virtual;
   procedure PasteNode(ptype;
    var node: DefaultNodeBase); virtual;
   procedure PasteNodes(ptype;
    holder); virtual;
   procedure ApplyTransaction; virtual;
   procedure ChangeNodeValue(value); virtual;
   procedure ChangeNodeEntity(entity); virtual;
   constructor Make(var owner_tree: TreeBase;
    snode); overload;  virtual;
 protected
 // protected properties
   property name: IString
     read pm_GetName
     write pm_SetName;
//#UC START# *45F7D8410157publ*
//#UC END# *45F7D8410157publ*
 end;//RealNodeBase

implementation

// start class NodeChangeTransaction

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

procedure NodeChangeTransaction.SetEntity(entity);
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
// start class NodeChangeTransactionHolder

constructor NodeChangeTransactionHolder.Make(var node: RealNodeBase);
//#UC START# *45FF99D90203_45FF99BC0399_var*
//#UC END# *45FF99D90203_45FF99BC0399_var*
begin
//#UC START# *45FF99D90203_45FF99BC0399_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FF99D90203_45FF99BC0399_impl*
end;//NodeChangeTransactionHolder.Make

function RealNodeBase.pm_GetName: IString;
//#UC START# *45FFE327036B_45F7D8410157get_var*
//#UC END# *45FFE327036B_45F7D8410157get_var*
begin
//#UC START# *45FFE327036B_45F7D8410157get_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE327036B_45F7D8410157get_impl*
end;//RealNodeBase.pm_GetName

procedure RealNodeBase.pm_SetName(const aValue: IString);
//#UC START# *45FFE327036B_45F7D8410157set_var*
//#UC END# *45FFE327036B_45F7D8410157set_var*
begin
//#UC START# *45FFE327036B_45F7D8410157set_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE327036B_45F7D8410157set_impl*
end;//RealNodeBase.pm_SetName

procedure RealNodeBase.FillValue(var value);
//#UC START# *45FFDF2B03B9_45F7D8410157_var*
//#UC END# *45FFDF2B03B9_45F7D8410157_var*
begin
//#UC START# *45FFDF2B03B9_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDF2B03B9_45F7D8410157_impl*
end;//RealNodeBase.FillValue

procedure RealNodeBase.FillEntity(entity);
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
  data);
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

function RealNodeBase.IsEqual(e): Boolean;
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

procedure RealNodeBase.PasteNode(ptype;
  var node: DefaultNodeBase);
//#UC START# *45FFE20201C5_45F7D8410157_var*
//#UC END# *45FFE20201C5_45F7D8410157_var*
begin
//#UC START# *45FFE20201C5_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE20201C5_45F7D8410157_impl*
end;//RealNodeBase.PasteNode

procedure RealNodeBase.PasteNodes(ptype;
  holder);
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

procedure RealNodeBase.ChangeNodeValue(value);
//#UC START# *45FFE2BC03A9_45F7D8410157_var*
//#UC END# *45FFE2BC03A9_45F7D8410157_var*
begin
//#UC START# *45FFE2BC03A9_45F7D8410157_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFE2BC03A9_45F7D8410157_impl*
end;//RealNodeBase.ChangeNodeValue

procedure RealNodeBase.ChangeNodeEntity(entity);
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
  snode);
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

function RealNodeBase.ApplyChangeDelta(var delta): Boolean;
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