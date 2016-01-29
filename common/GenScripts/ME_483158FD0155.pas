unit FakeBox;

interface

uses
 l3IntfUses
 , Messages
 , Controls
 , EditableBox
 , Classes
 , l3TreeInterfaces
 , l3VCLStrings
 , Graphics
 , l3Interfaces
 , l3InternalInterfaces
;

type
 TFakeBoxPrim = class(TEditableBox)
  procedure ShowNode(const aNode: Il3SimpleNode;
   TriggerSelect: Boolean);
   {* Показать узел с последующим выбором (т.е. дерево после вызова нефильтрованое) для Морозова, он передаёт таким образом ноды из ППР. }
  function FindIndexOf(const aNode: Il3SimpleNode): Integer;
  function FindCurrent(const aText: Il3CString): Il3SimpleNode;
  procedure SetSimpleTree(const aTree: Il3SimpleTree);
  procedure LocalUpdateAction;
  function DrawWithErrorColor: Boolean;
  function DoCreateStrings: Tl3Strings;
  function IsValid: Boolean;
  function IsNeedGotoNode(const aNode: Il3SimpleNode): Boolean;
  function IsLockPaint: Boolean;
  procedure DefilterTree;
  procedure ActionExecuteHandler;
 end;//TFakeBoxPrim
 
 TFakeBox = class(TFakeBoxPrim)
  procedure CNKeyDown(var Message: TWMKeyDown);
  procedure WMChar(var Message: TWMChar);
  procedure WMClear(var Msg: TMessage);
  procedure WMPaint(var Message: TMessage);
  procedure WMNCPaint(var Message: TMessage);
  procedure WMSetText(var Msg: TMessage);
  procedure CMParentFontChanged(var Message: TMessage);
 end;//TFakeBox
 
implementation

uses
 l3ImplUses
 , ctTypes
 , l3Tree_TLB
 , SysUtils
 , afwFacade
 , ctFakeBoxStrings
 , l3Nodes
 , nevBase
 , Windows
 , DropDownTree
 , Forms
 , l3String
 , l3Base
 , TtfwClassRef_Proxy
 , vtComboBoxWordsPack
;

type
 THackWinControl = class(TWinControl)
 end;//THackWinControl
 
end.
