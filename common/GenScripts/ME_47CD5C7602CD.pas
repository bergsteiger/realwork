unit evQueryCardInt;

interface

uses
 l3IntfUses
 , nevTools
 , l3Interfaces
 , evdTypes
 , nevBase
 , l3PureMixIns
 , l3Variant
 , l3Types
 , k2Interfaces
 , k2Prim
;

type
 InevBase = nevTools.InevBase;
 
 TevButtonType = (
  ev_btNone
  , ev_btLogical
  , ev_btAdd
  , ev_btDelete
 );//TevButtonType
 
 TevComboStyle = (
  ev_cbFilterable
  , ev_cbDropDown
 );//TevComboStyle
 
 IevCustomParaTool = interface
 end;//IevCustomParaTool
 
 IevDescriptionReq = interface(IevCustomParaTool)
 end;//IevDescriptionReq
 
 IevControlIterator = interface;
 
 IevCustomEditorControl = interface(IevCustomParaTool)
  {* ������� �������� ��� ���� ��������� (������ � ���������� ������). ��� ������������� ������ ���������. }
  function IsMultiline: Boolean;
   {* ������� �������� ��������� ����� � ������������ ����������� �� ��� 
          � ������� ������� (� ������ ��� �� ���������). }
  function GetControlIterator: IevControlIterator;
   {* ��������� "����������" �� ���������. }
  procedure InitBoolProperty(aIdent: Integer;
   aValue: Boolean);
   {* ��� ��������� ��������� �������� (�� ������������ �������� ������ ��� 
         ���������� ��������). }
  procedure UpperChange;
   {* ���������� ��������� ��������� ������. }
 end;//IevCustomEditorControl
 
 IevControlIterator = interface
  function GetNextVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* ���������� ��������� ������� ������� ��� nil, ���� ������ ���. }
  function GetPrevVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* ���������� ���������� ������� ������� ��� nil, ���� ������ ���. }
 end;//IevControlIterator
 
 TevQueryType = (
  {* ��� ��. }
  ev_qtAttributeSearch
   {* ��� }
  , ev_qtLegistationReview
   {* ����� ���������������� }
  , ev_qtPostingsOrder
   {* ����� �������� }
  , ev_qtSearchWithLawSupport
   {* ����� � �������� ���������� (������ �������) }
  , ev_qtConsultations
   {* �������� ��������� }
  , ev_qtInpharm
   {* ����� �������������� ��������� }
 );//TevQueryType
 
 IevEditorControl = interface;
 
 IevModelListener = interface;
 
 IevEditorFieldWithTree = interface;
 
 IevReq = interface;
 
 IevAdapterModel = interface
  procedure FocusStartField;
   {* ������������� ����� �� ������ �������. }
  procedure LimitCharsReached(const aControl: IevEditorControl);
  function GetTreeFromAdapter(const aReq: Il3CString): InevSimpleTree;
   {* �������� ������ � ��������. }
  procedure EscPressed(const aField: IevEditorFieldWithTree);
   {* ���������� �������� ������ �� ESC. }
  function ModelListener(const aReq: IevReq): IevModelListener;
  function GetPromptTreeFromAdapter: InevSimpleTree;
  procedure NotifyContextWrong;
 end;//IevAdapterModel
 
 IevEditorControlField = interface;
 
 IevEditorControl = interface(IevCustomEditorControl)
  {* �� ���������� InevInputListener }
  function LMouseBtnUp(const aView: InevControlView;
   const aPara: InevPara;
   const aPt: TnevPoint;
   const aKeys: TevMouseState;
   anInPara: Boolean): Boolean;
   {* ���������� ������� �� ����� ������ ����. }
  function LMouseBtnDown(const aView: InevControlView;
   const aPara: InevPara;
   const aPt: TnevPoint;
   const aKeys: TevMouseState;
   anInPara: Boolean;
   const aMap: InevMap): Boolean;
   {* ���������� ���������� ����� ������ ����. }
  function KeyCommand(const aView: InevControlView;
   aCmd: Word;
   const aPara: InevPara): Boolean;
   {* ���������� ������� �� ���������. }
  procedure RememberState;
   {* ����������� ��������� ��� ������������ ����. }
  procedure TextChange(const aView: InevView;
   const aPara: InevPara;
   const anOp: InevOp);
   {* ������� ��������� ������ � ��������� (������� �����). }
  function GetHint(var aValue: Il3CString): Boolean;
   {* ����� ����� �� �����. ���� ������ ���, �� ������������ False. }
  procedure InsertRow(const aView: InevView);
   {* ������� ���������� ������ � ������� �� 'Enter'. }
  procedure SetFocus(aChangePara: Boolean);
   {* �������� ����� �������� (�������� � ������� �������� �����. }
 end;//IevEditorControl
 
 IevModelListener = interface
  procedure EnterPressed;
   {* ���������� ������� �� "Enter". }
  function GetHint(const aValue: IevEditorControl): Il3CString;
   {* ���������� ���� ��� ����. }
  function GetImage(Index: Integer;
   var aImages: InevImageList): Integer;
   {* ���������� ����� �������� � ������ �������� ��� �����������. }
  function AnalyzeString(const aValue: Il3CString;
   out aRslt: Il3CString): Boolean;
   {* ������ ����������� ������, ���� �����, �� ������� ������ ������� ��� ��������� ������ �� ���������. }
  function CheckValue(const aField: IevEditorControlField): Boolean;
   {* �������� �������� ����. }
  procedure TextChange;
   {* ���������� ��������� ������ � ����. }
  procedure AfterSetText(const aField: IevEditorControlField);
   {* ���������� ���������� ���� ������ �������� - ����������� ����� ������
          �������� � ������. }
  function IsEditEmpty: Boolean;
   {* ��������� ���� �� ������ ��������. }
  procedure HyperLinkClick;
   {* ��������� ������ �� ������. }
 end;//IevModelListener
 
 IevEditorControlButton = interface;
 
 IevEditorControlList = interface;
 
 IevEditorControlField = interface(IevEditorControl)
  {* ��������� ���� ���������. }
  procedure SynchronizeSelectedValueWithText;
  function HasOtherField: Boolean;
  procedure CheckDataText;
   {* ��������� ��������� ����� �� ������������. }
  function AnalyzeString(const aValue: Il3CString;
   aPos: Integer;
   out aRslt: Il3CString): Boolean;
   {* ������ ����������� ������, ���� �����, �� ������� ������ ������� ��� ��������� ������ �� ���������. }
  function IsClear: Boolean;
   {* ������� ���������� ������ ����, ��� ���� ������ (�������� ���������� 
          ��� ���������� ������!). ��� ���������� ��� ��������� ��� ���� ���! }
  procedure InitOtherField(const aValue: IevEditorControl;
   aIsStart: Boolean);
   {* ��� ���������� � ����� ������. ������������ ��� ����� ���. }
  function IsFieldEmpty: Boolean;
   {* ��������� �������� �� ���� ������ (��� �������� �������� �� ���������). }
  function FindButton(aButtonType: TevButtonType): IevEditorControlButton;
   {* ���������� ������ ��� ����. }
  procedure ClearText;
   {* ������� ���� ���������. }
  function SelectAllOnFocus: Boolean;
   {* ���� �� �������� ���� ��� �������������. }
 end;//IevEditorControlField
 
 IevEditorFieldWithTree = interface(IevEditorControlField)
  procedure SetNodeByIndex(aIndex: Integer);
  function GetNodeIndex(const aNode: InevSimpleNode): Integer;
   {* ���������� ����� ����. }
  procedure ShowNode(const aNode: InevSimpleNode);
   {* ���������� ���� � ����. }
  procedure CheckTextVersusValue;
   {* ������� �� ��� ������ ����� ����� Undo ����� � �������� �� ���������
        � ��������� ����� - � ���� ������ ������� ���. }
  function NeedClearOnEscape: Boolean;
  procedure SetMaskText(const aText: Il3CString);
 end;//IevEditorFieldWithTree
 
 IevQueryGroup = interface;
 
 IevQueryCard = interface;
 
 IevReq = interface(IevCustomParaTool)
  procedure KeyAction(aCmd: Word);
   {* "�������" ��������� �������. }
  function AnalyzeString(const aValue: Il3CString;
   out aRslt: Il3CString): Boolean;
  procedure TextChange(const aView: InevView);
   {* ���������� ������� ��������� ������. }
  procedure RememberState(const aControl: IevCustomEditorControl);
   {* ��������� ��������� �������� ��� ������������ ����. }
  function GetNextVisible(const aControl: IevEditorControl;
   OnlyFields: Boolean;
   out anIsLastField: Boolean): IevEditorControl;
   {* ���������� ��������� ������� �������. }
  function GetFirstVisible(OnlyFields: Boolean): IevEditorControl;
   {* ���������� ������ ������� ������� ��� ���������. }
  function GetPrevVisible(const aControl: IevEditorControl;
   OnlyFields: Boolean;
   out anIsFirstField: Boolean): IevEditorControl;
   {* ���������� ��������� ������� �������. }
  function GetLastVisible(OnlyFields: Boolean): IevEditorControl;
   {* ���������� ��������� ������� �������. }
  function GetHint(var aValue: Il3CString;
   const aControl: IevEditorControl): Boolean;
   {* �������� ���� ��� ��������. }
  function IsRequired: Boolean;
   {* ������������ ���� (������ ����������� ��������� ��������). }
  function IsEmpty: Boolean;
   {* ���������, �������� �� �������� ������. }
  function FieldsCount: Integer;
   {* ���������� ��������� (����� ���������) � ���������. }
  procedure ButtonPressed(const aView: InevView;
   const aControl: IevEditorControl;
   aBtnType: TevButtonType);
   {* ��������� ������� �� ������� ������ �� � ����. }
  procedure AfterSetText(const aField: IevEditorControlField);
  function AddField(const aView: InevView;
   NeedSetFocus: Boolean): IevEditorControlField;
   {* ���������� ���������. }
  function GetItemImage(Index: Integer;
   var aImages: InevImageList): Integer;
   {* ����� ��� ��������� �������� ��� ����������� ������. }
  procedure DeleteField(const aView: InevView;
   const aControl: IevEditorControlField;
   NeedFocus: Boolean);
   {* �������� ���������. }
  procedure InsertToModel(const aView: InevView;
   const aControl: IevEditorControl;
   aChild: Tl3Variant;
   NeedFocus: Boolean;
   anAdd: Boolean);
   {* ���������� ��������� ������ � ������. }
  procedure DeleteFromModel(const aView: InevView;
   const aControl: IevEditorControl;
   NeedFocus: Boolean);
   {* �������� ��������� ������ �� ������. }
  procedure InitModel(const aTag: InevPara;
   AddValues: Boolean;
   anIndexField: Integer;
   anIndexCtrl: Integer);
   {* ������������� �������� �����������. }
  function CheckEdit(const aField: IevEditorControlField): Boolean;
   {* �������� �������� ����. }
  procedure UpdateState(const aField: IevEditorControlField;
   const anOp: InevOp);
   {* �������� ��������� ���� � ������, ������ ��������. }
  procedure SetFocus(const aField: IevEditorControlField;
   aAtEnd: Boolean);
   {* ���������� �����. }
  function FirstField: IevEditorControlField;
   {* ���������� ������ ������� � ������. }
  function LastField: IevEditorControlField;
   {* ���������� ��������� ������� � ������. }
 end;//IevReq
 
 IevQueryGroup = interface(IevCustomEditorControl)
  procedure ClickOnDisabledLabel;
  procedure AfterCollapsed;
   {* ���������� ������� ������������ ������. }
  function CanCollapsed: Boolean;
   {* �������� ����� �� ������ ����������. }
  function LMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   const aMap: InevMap): Boolean;
   {* ��������� ������� �� ����� ������ ����. }
  function LMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState): Boolean;
  function FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
   {* ���������� �������� �� �����. }
  procedure InitModel(const aTag: InevPara);
   {* ������������� ������. }
  function LastReq: IevReq;
   {* ��������� ������� � ������. }
  function FirstReq: IevReq;
   {* ������ �������� � ������. }
  function GetNextReq(const aReq: IevReq): IevReq;
   {* ���������� ��������� ��������. }
  function GetPrevReq(const aReq: IevReq): IevReq;
   {* ���������� ���������� ��������. }
 end;//IevQueryGroup
 
 IevQueryCard = interface
  procedure ChangePara(const aCurPara: InevPara);
   {* ������� ����� ������� ���������. }
  procedure SetCurrPara(const aCurPara: InevPara);
  function GetDocumentContainer: InevQueryDocumentContainer;
   {* �������� ��������� ���������. }
  procedure RememberFocusControl(const aValue: IevEditorControl);
   {* ��������� ������� ��� ��������� ������. }
  procedure BeforeDelete;
   {* ���������� ����� ��������� ����. }
  procedure ClearUpper;
   {* ���������� ������� Upper � ����. }
  procedure UpperChange(const aButton: IevCustomEditorControl);
   {* ���������� ����� ��������� Upper � ������ � True. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* ���������� ���� �� ������. }
  procedure CardClear;
   {* ���������� ������� ��. }
  procedure StartLongOperation;
   {* ������ ��� ���������� ����������� � ���������. }
  procedure EndLongOperation;
   {* ������ ��� ���������� ����������� � ���������. }
  procedure ChangeStateAll(anExpand: Boolean);
   {* ���������� ������� �������������/����������� ���� �������. }
  procedure AfterCollapsed(const aGroup: IevQueryGroup);
  procedure LimitCharsReached(const aControl: IevEditorControl);
   {* ���������� ���������� ������������� ����� �������� � ���������. }
  procedure RememberState(const aControl: IevCustomEditorControl);
   {* ��������� ��������� ��� ������������ ����. }
  function GetStateControl: IevCustomEditorControl;
   {* ���������� �������, ������� ��� �������� ��� ������ ������������ ����. }
  function GetFocusedControl(aCurPara: Tl3Variant): IevEditorControl;
   {* ���������� �������, ������� ����� �����. }
  procedure LinkView(const aQueryContainer: InevQueryDocumentContainer);
   {* ������������� ������. }
  procedure LinkListener(const aListener: IevAdapterModel);
   {* ���������� ������ �� ������� ������. }
  function AdapterModel: IevAdapterModel;
  procedure ReleaseListeners;
   {* ��������� ������ �� ������� ������. }
  function FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
   {* ��������� ��������� �� �����. }
  procedure StartSetFocus;
   {* ���������� ������ ��������� ��� �������������� ���� � ��������. }
  function GetControlIterator(const aCurrentControl: IevCustomEditorControl): IevControlIterator;
 end;//IevQueryCard
 
 IevDatesReq = interface
 end;//IevDatesReq
 
 IevPhoneReq = interface
 end;//IevPhoneReq
 
 IevEditorControlButton = interface(IevEditorControl)
  {* ��������� ������. }
  function GetButtonType: TevButtonType;
 end;//IevEditorControlButton
 
 IevEditorControlList = interface
  procedure AssignList(const aList: IevEditorControlList);
 end;//IevEditorControlList
 
 IevComboReq = interface
  procedure ClearLogicValue;
  procedure EscPressed(const aField: IevEditorFieldWithTree);
  function NeedAsterisk: Boolean;
   {* ����� �� ��������� �������� '*' � ������. }
  function GetTreeFromAdapter: InevSimpleTree;
   {* �������� ������ � ��������. }
  function IsMulti: Boolean;
   {* ������� ��������� � ����������� ����������. }
  procedure HyperLinkClick;
   {* ������ �� �����������. }
  function IsContext: Boolean;
   {* ������� ����, ��� �������� �������� ���������. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* �������� ���� ����������� ������ �� ������ ����. }
  function GetPromptTreeFromAdapter: InevSimpleTree;
  procedure NotifyContextWrong;
 end;//IevComboReq
 
 IevEditorStateButton = interface(IevEditorControlButton)
  {* ��������� ������ � ���������� ����������. }
  function GetStateIndex: Integer;
   {* ���������� ���������� ��������� ������ �� 0 �� �������������. }
 end;//IevEditorStateButton
 
 IevEditorCalendarField = interface(IevEditorControlField)
  procedure AnalyzeText;
   {* ���������� ����, ���� ������� ������ ���� � �����. }
  function IsBlank: Boolean;
   {* ���� ������, �.�. ����� �������. }
  procedure ClearField;
   {* ������� ������ ����� ����. ClearText - ������� ��� ���� �����. }
  function IsStart: Boolean;
   {* ������� ������ ��������� ���� ���������. }
  function GetOtherField: IevEditorCalendarField;
   {* ������ �������. }
 end;//IevEditorCalendarField
 
 IevEditorPhoneField = interface(IevEditorControlField)
  function IsStart: Boolean;
   {* ������� ������ ��������� ���� ���������. }
  function GetOtherField: IevEditorPhoneField;
   {* ������ �������. }
 end;//IevEditorPhoneField
 
 IevControlFriend = interface(IevCommonControl)
  function GetControl: IevEditorControl;
   {* �������� ������� �� ������. }
 end;//IevControlFriend
 
 IevEditorControlLabel = interface(IevEditorControl)
  {* ��������� Label (� ��� ����� � �����������). }
  procedure RestoreCaption;
   {* ��������������� �������� �����. }
 end;//IevEditorControlLabel
 
 IevQueryCardEditor = interface
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
 end;//IevQueryCardEditor
 
 IqaReqPrim = interface
 end;//IqaReqPrim
 
 IevReqIterator_DoReq_Action = function(const anItem: IevReq): Boolean;
  {* ��� �������������� ������� ��� IevReqIterator.DoReq }
 
 IevReqIterator = interface
  procedure DoReq;
 end;//IevReqIterator
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
