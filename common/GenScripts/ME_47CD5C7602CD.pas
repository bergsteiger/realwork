unit evQueryCardInt;
 {* ���������� ��� ��. }

// ������: "w:\common\components\gui\Garant\Everest\qf\evQueryCardInt.pas"
// ���������: "Interfaces"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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

 IevCustomParaTool = interface(InevBase)
  ['{F96CF4AB-61BA-4F63-9E57-93BF7BCA563C}']
  function Get_Para: InevPara;
  property Para: InevPara
   read Get_Para;
   {* ��������, �������������� �������. }
 end;//IevCustomParaTool

 IevDescriptionReq = interface(IevCustomParaTool)
  ['{39E4DC89-8746-4B32-8E8C-FD5EF32307A9}']
  function pm_GetReqName: Il3CString;
  function pm_GetCollapsed: Boolean;
  procedure pm_SetCollapsed(aValue: Boolean);
  property ReqName: Il3CString
   read pm_GetReqName;
  property Collapsed: Boolean
   read pm_GetCollapsed
   write pm_SetCollapsed;
 end;//IevDescriptionReq

 IevControlIterator = interface;

 IevCustomEditorControl = interface(IevCustomParaTool)
  {* ������� �������� ��� ���� ��������� (������ � ���������� ������). ��� ������������� ������ ���������. }
  ['{8D573C85-19D6-4023-AAA9-40E656222B46}']
  function Get_ControlName: Tl3WString;
  procedure Set_ControlName(const aValue: Tl3WString);
  function Get_ControlType: TevControlType;
  function Get_Visible: Boolean;
  procedure Set_Visible(aValue: Boolean);
  function Get_Upper: Boolean;
  procedure Set_Upper(aValue: Boolean);
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
  property ControlName: Tl3WString
   read Get_ControlName
   write Set_ControlName;
   {* ��� �������� (��� - k2_tiName). }
  property ControlType: TevControlType
   read Get_ControlType;
   {* ��� ��������. }
  property Visible: Boolean
   read Get_Visible
   write Set_Visible;
   {* ��������� ��������. }
  property Upper: Boolean
   read Get_Upper
   write Set_Upper;
   {* ��������� ��� Flat-������. }
 end;//IevCustomEditorControl

 IevControlIterator = interface(InevBase)
  ['{6328C97E-55E5-41E6-A89C-7ACE388C46F2}']
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

 IevAdapterModel = interface(InevBase)
  ['{8486860A-0D26-4E6E-A10B-300423475B2E}']
  {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
  function Get_HistoryList: Il3StringsEx;
  {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
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
  {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
  property HistoryList: Il3StringsEx
   read Get_HistoryList;
   {* ������� �����. }
  {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 end;//IevAdapterModel

 IevEditorControlField = interface;

 IevEditorControl = interface(IevCustomEditorControl)
  {* �� ���������� InevInputListener }
  ['{E653F6A0-014F-4D03-AFF9-62933425793A}']
  function Get_Enabled: Boolean;
  procedure Set_Enabled(aValue: Boolean);
  function Get_MaxLength: Integer;
  function Get_Caption: Il3CString;
  function Get_Field: IevEditorControlField;
  procedure Set_Field(const aValue: IevEditorControlField);
  function Get_Req: IevReq;
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
  procedure SetFocus(aChangePara: Boolean = False);
   {* �������� ����� �������� (�������� � ������� �������� �����. }
  property Enabled: Boolean
   read Get_Enabled
   write Set_Enabled;
   {* ����������� ��������. }
  property MaxLength: Integer
   read Get_MaxLength;
  property Caption: Il3CString
   read Get_Caption;
  property Field: IevEditorControlField
   read Get_Field
   write Set_Field;
   {* ����, �������� ����������� �������. }
  property Req: IevReq
   read Get_Req;
   {* ��������, �������� ����������� �������. }
 end;//IevEditorControl

 IevModelListener = interface(InevBase)
  ['{0F3D9F13-3BA0-42EC-99A7-6D3FDA705548}']
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
  ['{C2A60427-E1AA-472A-AC70-0516173258C0}']
  function Get_Text: Il3CString;
  procedure Set_Text(const aValue: Il3CString);
  function Get_ErrorColor: Boolean;
  procedure Set_ErrorColor(aValue: Boolean);
  function Get_Valid: Boolean;
  procedure Set_Valid(aValue: Boolean);
  function Get_ChildList: IevEditorControlList;
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
   aIsStart: Boolean = True);
   {* ��� ���������� � ����� ������. ������������ ��� ����� ���. }
  function IsFieldEmpty: Boolean;
   {* ��������� �������� �� ���� ������ (��� �������� �������� �� ���������). }
  function FindButton(aButtonType: TevButtonType): IevEditorControlButton;
   {* ���������� ������ ��� ����. }
  procedure ClearText;
   {* ������� ���� ���������. }
  function SelectAllOnFocus: Boolean;
   {* ���� �� �������� ���� ��� �������������. }
  property Text: Il3CString
   read Get_Text
   write Set_Text;
   {* ����� ���� ���������. }
  property ErrorColor: Boolean
   read Get_ErrorColor
   write Set_ErrorColor;
   {* ���������� �� ���� ���������� ������. }
  property Valid: Boolean
   read Get_Valid
   write Set_Valid;
   {* ��������� �� ������������. }
  property ChildList: IevEditorControlList
   read Get_ChildList;
 end;//IevEditorControlField

 IevEditorFieldWithTree = interface(IevEditorControlField)
  ['{3984A532-F741-4C46-A304-0034BC2FE756}']
  function Get_Value: InevSimpleNode;
  function Get_IsAsterisk: Boolean;
  function Get_DefaultNode: InevSimpleNode;
  function Get_Asterisk: AnsiChar;
  procedure Set_Asterisk(aValue: AnsiChar);
  function Get_IsList: Boolean;
  function Get_SourceTree: InevSimpleTree;
  function Get_ComboStyle: TevComboStyle;
  procedure Set_ComboStyle(aValue: TevComboStyle);
  function Get_LogicalState: Integer;
  procedure Set_LogicalState(aValue: Integer);
  function Get_Down: Boolean;
  procedure Set_Down(aValue: Boolean);
  function Get_IsLogicalStateButtonEnabled: Boolean;
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
  property Value: InevSimpleNode
   read Get_Value;
   {* ��������� ���� � ������. }
  property IsAsterisk: Boolean
   read Get_IsAsterisk;
   {* ������������ �� � ������ ������ '*'. }
  property DefaultNode: InevSimpleNode
   read Get_DefaultNode;
   {* ���� � ��������� �� ���������. }
  property Asterisk: AnsiChar
   read Get_Asterisk
   write Set_Asterisk;
   {* ������ ���������. }
  property IsList: Boolean
   read Get_IsList;
   {* ���� ���������� � True, �� ������������ ������, � �� ������. }
  property SourceTree: InevSimpleTree
   read Get_SourceTree;
   {* ������ � �������.
� ���� - Get_Tree. }
  property ComboStyle: TevComboStyle
   read Get_ComboStyle
   write Set_ComboStyle;
   {* ����� ��������� ����������� ������. }
  property LogicalState: Integer
   read Get_LogicalState
   write Set_LogicalState;
   {* ������������ ���������� �������� ��� ����. }
  property Down: Boolean
   read Get_Down
   write Set_Down;
   {* ������ �� ������ � ���������.
� ���� - Get_Checked/Set_Checked. }
  property IsLogicalStateButtonEnabled: Boolean
   read Get_IsLogicalStateButtonEnabled;
 end;//IevEditorFieldWithTree

 IevQueryGroup = interface;

 IevQueryCard = interface;

 IevReq = interface(IevCustomParaTool)
  ['{520F1943-DE74-4D3E-9AFB-26989C571B12}']
  function Get_ReqName: Il3CString;
  function Get_ReqCaption: Il3CString;
  function Get_ModelListener: IevModelListener;
  function Get_Fields(Index: Integer): IevEditorControlField;
  function Get_Group: IevQueryGroup;
  function Get_QueryCard: IevQueryCard;
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
   NeedSetFocus: Boolean = False): IevEditorControlField;
   {* ���������� ���������. }
  function GetItemImage(Index: Integer;
   var aImages: InevImageList): Integer;
   {* ����� ��� ��������� �������� ��� ����������� ������. }
  procedure DeleteField(const aView: InevView;
   const aControl: IevEditorControlField = nil;
   NeedFocus: Boolean = False);
   {* �������� ���������. }
  procedure InsertToModel(const aView: InevView;
   const aControl: IevEditorControl;
   aChild: Tl3Variant;
   NeedFocus: Boolean = False;
   anAdd: Boolean = False);
   {* ���������� ��������� ������ � ������. }
  procedure DeleteFromModel(const aView: InevView;
   const aControl: IevEditorControl;
   NeedFocus: Boolean = False);
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
   aAtEnd: Boolean = False);
   {* ���������� �����. }
  function FirstField: IevEditorControlField;
   {* ���������� ������ ������� � ������. }
  function LastField: IevEditorControlField;
   {* ���������� ��������� ������� � ������. }
  property ReqName: Il3CString
   read Get_ReqName;
   {* ��� ���������. }
  property ReqCaption: Il3CString
   read Get_ReqCaption;
   {* �������� ��������� (������� � �����). � ���� - Get_TagCaption. }
  property ModelListener: IevModelListener
   read Get_ModelListener;
   {* ������ � ������-����. }
  property Fields[Index: Integer]: IevEditorControlField
   read Get_Fields;
   {* C����� ���������, ������������� ���������. }
  property Group: IevQueryGroup
   read Get_Group;
   {* ���������� ������, � ������� ����������� ��������. }
  property QueryCard: IevQueryCard
   read Get_QueryCard;
 end;//IevReq

 IevQueryGroup = interface(IevCustomEditorControl)
  ['{ABDD1ABC-B02D-4FB5-B6B4-1D186DDFB6E6}']
  function Get_ReqCount: Integer;
  function Get_DescriptionReqCount: Integer;
  function Get_GroupName: Il3CString;
  function Get_Expanded: Boolean;
  procedure Set_Expanded(aValue: Boolean);
  function Get_Req(Index: Integer): IevReq;
  function Get_DescriptionReq(Index: Integer): IevDescriptionReq;
  function Get_QueryCard: IevQueryCard;
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
  property ReqCount: Integer
   read Get_ReqCount;
   {* ���������� ���������� � ������. }
  property DescriptionReqCount: Integer
   read Get_DescriptionReqCount;
   {* ���������� ���������� � ������. }
  property GroupName: Il3CString
   read Get_GroupName;
   {* ���������� ��� ������ (k2_tiShortName). }
  property Expanded: Boolean
   read Get_Expanded
   write Set_Expanded;
   {* ���������� True, ���� ������ ����������, �.�. ����� ��� ���������. }
  property Req[Index: Integer]: IevReq
   read Get_Req;
   {* ������ ����������, ������������� ������. }
  property DescriptionReq[Index: Integer]: IevDescriptionReq
   read Get_DescriptionReq;
   {* ������ ����������, ������������� ������. }
  property QueryCard: IevQueryCard
   read Get_QueryCard;
 end;//IevQueryGroup

 IevQueryCard = interface(InevBase)
  ['{50D656F4-8A1C-464A-85D7-CCB4415849B6}']
  function Get_GroupCount: Integer;
  function Get_InsertRowMode: Boolean;
  procedure Set_InsertRowMode(aValue: Boolean);
  function pm_GetCardType: TevQueryType;
  function Get_QueryGroup(anIndex: Integer): IevQueryGroup;
  function pm_GetEditor: InevControl;
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
  property GroupCount: Integer
   read Get_GroupCount;
   {* ���������� ����� � ��������. }
  property InsertRowMode: Boolean
   read Get_InsertRowMode
   write Set_InsertRowMode;
   {* ����� ���������� �����. }
  property CardType: TevQueryType
   read pm_GetCardType;
   {* �������� ��� ����������� ��������. }
  property QueryGroup[anIndex: Integer]: IevQueryGroup
   read Get_QueryGroup;
   {* ������ �����, �������� � ��.
� ���� Get_Group. }
  property Editor: InevControl
   read pm_GetEditor;
   {* ������ �� ��������. }
 end;//IevQueryCard

 IevDatesReq = interface(InevBase)
  ['{B2384BD5-8B98-4A3C-89E8-D1AFB090BBC8}']
  function Get_StartDate: TDateTime;
  procedure Set_StartDate(aValue: TDateTime);
  function Get_EndDate: TDateTime;
  procedure Set_EndDate(aValue: TDateTime);
  property StartDate: TDateTime
   read Get_StartDate
   write Set_StartDate;
   {* ��������� ���� ���������. }
  property EndDate: TDateTime
   read Get_EndDate
   write Set_EndDate;
   {* �������� ���� ���������. }
 end;//IevDatesReq

 IevPhoneReq = interface(InevBase)
  ['{B58BF42E-F74B-4F4E-82DC-61A690BC20A1}']
  function Get_Code: Il3CString;
  procedure Set_Code(const aValue: Il3CString);
  function Get_Number: Il3CString;
  procedure Set_Number(const aValue: Il3CString);
  property Code: Il3CString
   read Get_Code
   write Set_Code;
  property Number: Il3CString
   read Get_Number
   write Set_Number;
 end;//IevPhoneReq

 IevEditorControlButton = interface(IevEditorControl)
  {* ��������� ������. }
  ['{38B36936-ECA7-48CC-92F3-7183292CE360}']
  function GetButtonType: TevButtonType;
 end;//IevEditorControlButton

 //_ItemType_ = IevEditorControl;
 IevEditorControlList = interface(InevBase)
  ['{C5160916-203D-4BF8-AC66-0820F74478C3}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: IevEditorControl;
  function pm_GetLast: IevEditorControl;
  function pm_GetItems(anIndex: Integer): IevEditorControl;
  function pm_GetCount: Integer;
  procedure AssignList(const aList: IevEditorControlList);
  property Empty: Boolean
   read pm_GetEmpty;
  property First: IevEditorControl
   read pm_GetFirst;
   {* ������ �������. }
  property Last: IevEditorControl
   read pm_GetLast;
   {* ��������� �������. }
  property Items[anIndex: Integer]: IevEditorControl
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* ����� ���������. }
 end;//IevEditorControlList

 IevComboReq = interface(InevBase)
  ['{40A89677-FACE-4DF8-83EE-4DE875DD7922}']
  function Get_DefStateIndex: Integer;
  procedure Set_DefStateIndex(aValue: Integer);
  function Get_HistoryList: Il3StringsEx;
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
  property DefStateIndex: Integer
   read Get_DefStateIndex
   write Set_DefStateIndex;
   {* ��������� ���������� ����� �� ���������. }
  property HistoryList: Il3StringsEx
   read Get_HistoryList;
   {* ������ ������� �����. }
 end;//IevComboReq

 IevEditorStateButton = interface(IevEditorControlButton)
  {* ��������� ������ � ���������� ����������. }
  ['{2DDC445D-9825-4749-925A-86FE9131AA78}']
  function Get_StateCount: Integer;
  function Get_CurrentIndex: Integer;
  procedure Set_CurrentIndex(aValue: Integer);
  function Get_ImageIndex: Integer;
  function GetStateIndex: Integer;
   {* ���������� ���������� ��������� ������ �� 0 �� �������������. }
  property StateCount: Integer
   read Get_StateCount;
   {* ���������� ���������. }
  property CurrentIndex: Integer
   read Get_CurrentIndex
   write Set_CurrentIndex;
   {* ������� �������� ��� �����������. }
  property ImageIndex: Integer
   read Get_ImageIndex;
   {* ��������� ����� ��������. }
 end;//IevEditorStateButton

 IevEditorCalendarField = interface(IevEditorControlField)
  ['{BE859AF1-0BCC-449E-A7F5-17E627BF40A2}']
  function Get_aDate: TDateTime;
  procedure Set_aDate(aValue: TDateTime);
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
  property aDate: TDateTime
   read Get_aDate
   write Set_aDate;
   {* ���� �� ��������.
� ���� - Get_Date/Set_Date. }
 end;//IevEditorCalendarField

 IevEditorPhoneField = interface(IevEditorControlField)
  ['{1770F128-709C-486F-828C-483459F37509}']
  function IsStart: Boolean;
   {* ������� ������ ��������� ���� ���������. }
  function GetOtherField: IevEditorPhoneField;
   {* ������ �������. }
 end;//IevEditorPhoneField

 IevControlFriend = interface(IevCommonControl)
  ['{41C31E9B-8789-491D-8E39-2DD94AE71855}']
  function GetControl: IevEditorControl;
   {* �������� ������� �� ������. }
 end;//IevControlFriend

 IevEditorControlLabel = interface(IevEditorControl)
  {* ��������� Label (� ��� ����� � �����������). }
  ['{7557EE92-FA6A-43FB-8615-F5CFF35A0CAD}']
  function Get_Caption: Il3CString;
  procedure Set_Caption(const aValue: Il3CString);
  procedure RestoreCaption;
   {* ��������������� �������� �����. }
  property Caption: Il3CString
   read Get_Caption
   write Set_Caption;
   {* ����� �����.
� ���� - Get_Text/Set_Text. }
 end;//IevEditorControlLabel

 IevQueryCardEditor = interface(InevBase)
  ['{A119A4B9-2DEB-4649-B89A-1957F9EDB06D}']
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

 IqaReqPrim = interface(InevBase)
  ['{5A2A14D2-4E7B-4D71-A1C1-473F9AC99CA2}']
  function Get_Modified: Boolean;
  procedure Set_Modified(aValue: Boolean);
  property Modified: Boolean
   read Get_Modified
   write Set_Modified;
   {* ������� ��������������� ������������� �� ������� ���������� ���������� }
 end;//IqaReqPrim

 IevReqIterator_DoReq_Action = function(const anItem: IevReq): Boolean;
  {* ��� �������������� ������� ��� IevReqIterator.DoReq }

 IevReqIterator = interface(InevBase)
  ['{EF763092-54E8-4271-8146-192454C64DFC}']
  function DoReq(anAction: IevReqIterator_DoReq_Action): Integer;
  function DoReqF(anAction: IevReqIterator_DoReq_Action): Integer;
 end;//IevReqIterator

function L2IevReqIteratorDoReqAction(anAction: pointer): IevReqIterator_DoReq_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� IevReqIterator.DoReq }

implementation

uses
 l3ImplUses
 , l3Base
;

function L2IevReqIteratorDoReqAction(anAction: pointer): IevReqIterator_DoReq_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� IevReqIterator.DoReq }
asm
 jmp l3LocalStub
end;//L2IevReqIteratorDoReqAction

end.
