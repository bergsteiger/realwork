unit EditableBox;

interface

uses
 l3IntfUses
 , DropDownTree
 , Classes
 , ctTypes
 , l3TreeInterfaces
 , l3VCLStrings
 , Messages
 , l3Interfaces
 , vcmExternalInterfaces
 , StdCtrls
;

type
 TEditableState = (
  esNone
  , esSemiCompleted
  , esCompleted
  , esWrong
 );//TEditableState
 
 TEditableBox = class(TDropDownTree)
  {* логика фильтрации }
  procedure SaveState;
  procedure RestoreState;
  procedure TriggerClearEvent;
  procedure InternalSetText(const aStr: Il3CString;
   aBorder: Integer);
  function vcmSetRoot(const aRoot: IvcmNodes): Boolean;
  procedure vcmSetCurrent(const aCurrent: Il3SimpleNode);
  procedure SetRoot(const aRoot: Il3SimpleNode);
  function IsSimpleTree: Boolean;
  procedure ChangeUnsimpleTree;
  function MakeNodesFromItems: Boolean;
  procedure Clear;
  procedure DropDownCompletion;
  function GetFullPath(const aNode: Il3SimpleNode): Il3CString;
  procedure CMEnabledChanged(var Msg: TMessage);
  function AutoWidthStored: Boolean;
   {* "‘ункци€ определ€юща€, что свойство AutoWidth сохран€етс€" }
 end;//TEditableBox
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Forms
 , vtOutliner
 , l3SimpleTree
 , l3InternalInterfaces
 , l3ScreenIC
 , l3Base
 , l3String
 , l3Tree_TLB
 , l3ControlsTypes
 , l3Nodes
 , l3MinMax
 , l3Units
 , l3InterfacesMisc
 , TtfwClassRef_Proxy
;

end.
