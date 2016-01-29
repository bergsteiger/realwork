unit evControlContainer;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , nevTools
 , evQueryCardInt
 , evQueryGroupList
 , nevBase
 , l3Variant
 , Messages
 , l3Interfaces
 , l3CProtoObject
;

type
 TevControlContainer = class(TevCustomControlTool, InevControlListener, IevQueryCard)
  function Make: IevQueryCard;
  procedure DoHideDroppedControl(CanSetFocus: Boolean);
  function DoMouseWheel(aDown: Boolean): Boolean;
  procedure Create;
  function GetFirstVisible(const aGroup: IevQueryGroup;
   anOnlyFields: Boolean;
   anExpanedeOnly: Boolean): IevCustomEditorControl;
  function GetLastVisible(const aGroup: IevQueryGroup;
   anOnlyFields: Boolean;
   anExpanedeOnly: Boolean): IevCustomEditorControl;
  function GetFirstControl(const aReq: IevReq;
   anOnlyFields: Boolean): IevCustomEditorControl;
  function GetLastControl(const aReq: IevReq;
   anOnlyFields: Boolean): IevCustomEditorControl;
  function GetNextReq(const aReq: IevReq;
   anExpandedOnly: Boolean;
   out aFirstReq: Boolean): IevReq;
   {* ���������� ��������� �������� ��� nil, ���� ������ ���. }
  function GetPrevReq(const aReq: IevReq;
   anExpandedOnly: Boolean;
   out aLastReq: Boolean): IevReq;
   {* ���������� ���������� ��������. }
  function DoGetNode(anIndex: Integer): InevSimpleNode;
  procedure DoDeleteOnUndo(aTag: Tl3Tag);
  procedure DoChangePara(const aCurPara: InevPara);
  function DoKeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Tag): Boolean;
   {* ������� ��������� � ������� ������. }
  function CanInsertPara: Boolean;
   {* ��������� �� ��������� ��������. }
  procedure InsertOnUndo(aPrev: Tl3Variant;
   aChild: Tl3Variant;
   anAdd: Boolean);
   {* ������� �� ������� ��� �������. }
  procedure DeleteOnUndo(aTag: Tl3Variant);
   {* ������� �������� ��� �������. }
  procedure HideDroppedControl(CanSetFocus: Boolean);
   {* ���������� ��������� ������� ��������� ��������� (����� ��� ����������� ��������). }
  function MouseWheel(aDown: Boolean): Boolean;
   {* ������� ��������� ����. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Variant): Boolean;
   {* ������� ��������� � ������� ������. }
  procedure ChangePara(const aCurPara: InevPara);
   {* ������� ����� ������� ���������. }
  procedure BeforeRMouseClick;
   {* �������, ���������� ����� ���������� ����. }
  procedure ClearUpper;
  function NeedKey(aPara: Tl3Variant;
   var aKeyCode: Word): Boolean;
   {* �������/���� ������������� ������. }
  procedure CursorCreate;
   {* �������� ������ ����� ��������. }
  procedure UpdateState;
  function IsLastField(aPara: Tl3Variant): Boolean;
   {* ��������� �������� �� �������� ��������� ��� �������� ������. }
  function IsFirstField(aPara: Tl3Variant): Boolean;
   {* ��������� �������� �� �������� ������ ��� �������� ������. }
  procedure StartPaste;
   {* ������ ��� �������� �������. }
  procedure FinishPaste;
   {* ������ ��� �������� �������. }
  function IsPasting: Boolean;
   {* ������ ������ ��� �������� �������. }
  function GetFirstPara(OnlyFields: Boolean): InevPara;
   {* �������� ������ ��������, � ������� ����� �������� �����. }
  function GetLastPara(OnlyFields: Boolean): InevPara;
   {* �������� ��������� ��������, � ������� ����� �������� �����. }
  procedure SetCurrPara(const aCurPara: InevPara);
  function GetDocumentContainer: InevQueryDocumentContainer;
   {* �������� ��������� ���������. }
  procedure RememberFocusControl(const aValue: IevEditorControl);
   {* ��������� ������� ��� ��������� ������. }
  procedure BeforeDelete;
   {* ���������� ����� ��������� ����. }
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
  function QueryGroup: IevQueryGroup;
   {* ������ �����, �������� � ��.
� ���� Get_Group. }
  function GroupCount: Integer;
   {* ���������� ����� � ��������. }
  function Editor: InevControl;
   {* ������ �� ��������. }
  function InsertRowMode: Boolean;
   {* ����� ���������� �����. }
  function CardType: TevQueryType;
   {* �������� ��� ����������� ��������. }
  function GetControlIterator(const aCurrentControl: IevCustomEditorControl): IevControlIterator;
 end;//TevControlContainer
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evControlParaTools
 , evControlParaConst
 , SysUtils
 , evdTypes
 , l3Base
 , Windows
 , evQueryCardConst
 , nevFacade
 , ControlPara_Const
 , ControlsBlock_Const
 , evControlGroup
;

type
 TevControlIterator = class(Tl3CProtoObject, IevControlIterator)
  procedure Make(const aControl: IevCustomEditorControl;
   aQueryCard: TevControlContainer);
  procedure Create(const aControl: IevCustomEditorControl;
   aQueryCard: TevControlContainer);
  function GetNextVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* ���������� ��������� ������� ������� ��� nil, ���� ������ ���. }
  function GetPrevVisible(OnlyFields: Boolean): IevCustomEditorControl;
   {* ���������� ���������� ������� ������� ��� nil, ���� ������ ���. }
 end;//TevControlIterator
 
end.
