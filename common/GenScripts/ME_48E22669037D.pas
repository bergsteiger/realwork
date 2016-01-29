unit evQueryCardEditor;

interface

uses
 l3IntfUses
 , evEditor
 , evQueryCardInt
 , l3Interfaces
 , afwCustomCaretType
 , nevTools
 , Messages
 , Controls
 , nevBase
 , l3Core
 , evEditorWithOperations
 , evCustomEditorWindow
 , Classes
 , vcmExternalInterfaces
 , Types
;

type
 TTabState = (
  tsNone
  , tsTab
  , tsShiftTab
 );//TTabState
 
 TevQueryCardEditor = class(TevEditor, IevQueryCardEditor, Il3GetMessageListener)
  procedure WMKeyDown(var Msg: TWMKeyDown);
  procedure WMKillFocus(var Msg: TWMKillFocus);
  procedure WMChar(var Msg: TWMChar);
  procedure WMSetFocus(var Msg: TWMSetFocus);
  procedure CMCancelMode(var Msg: TCMCancelMode);
  function GetQueryDocumentContainer: InevQueryDocumentContainer;
  procedure DoEditorChangeState(CanSetFocus: Boolean);
  function SetCusrot2BoundaryPara(aStart: Boolean): Boolean;
   {* ���������� ������� �� ����� ������� ��� ����� ������ ��������� }
  procedure SendMsgChangePara(const aPara: InevPara);
   {* ������� ��������� � ����� ��������� }
  function GotoNextControl(var aUseFieldOnly: Boolean): Boolean;
   {* ������� � ���������� �������� }
  function GotoPrevControl(var aUseFieldOnly: Boolean): Boolean;
   {* ������� � ����������� �������� }
  function GetControl: IevCustomEditorControl;
  function GetLine: Integer;
  procedure WMLButtonDown(var Msg: TWMLButtonDown);
  procedure WMRButtonDown(var Msg: TWMRButtonDown);
  procedure SetCursorToPara(const aPara: InevPara;
   bAtEnd: Boolean;
   aNeedClear: Boolean);
   {* ���������� ������ � ������� ��������� }
  procedure NotifyEmptySpace;
   {* ����������� � ��������� � ������ ����� � ��������� }
  function GetCurrPara: Tl3Variant;
  procedure ClearCardCache;
  function DroppingData: Boolean;
  procedure SignalDisableUnselectAfterDrop;
  procedure GetMessageListenerNotify(Code: Integer;
   aWParam: WPARAM;
   Msg: PMsg;
   var theResult: Tl3HookProcResult);
 end;//TevQueryCardEditor
 
implementation

uses
 l3ImplUses
 , evQueryCardEditorHotSpot
 , k2Tags
 , evdTypes
 , evOp
 , SysUtils
 , evMsgCode
 , l3Base
 , evQueryCardSelection
 , evTextParaTools
 , evControlParaConst
 , evParaTools
 , nevNavigation
 , Windows
 , evTypes
 , ControlPara_Const
 , nevGUIInterfaces
 , ParaList_Const
 , Forms
 , l3ListenersManager
 , TtfwClassRef_Proxy
 , QueryCardProcessingPack
;

end.
