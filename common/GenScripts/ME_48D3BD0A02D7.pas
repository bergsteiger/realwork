unit evReq;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , evEditorControlFieldList
 , evEditorControlList
 , l3Base
 , l3Variant
 , nevTools
 , evdTypes
 , l3Interfaces
 , nevBase
 , evControl
;

type
 RevControlClass = class of TevControl;
 
 TevReq = class(TevCustomControlTool, IevReq, IevComboReq, IevDatesReq, IevPhoneReq)
  {* ����� ��������� (�������� ������ � �������) }
  function Make(const aValue: InevPara): IevReq;
  function AddValue(const aView: InevView;
   const aControl: IevEditorControl;
   const aPara: InevPara;
   ToModel: Boolean;
   anAdd: Boolean): Boolean;
   {* ���������� ������ ���� � ��������. aControl - ������ (���� ��� �����
         ������ ����� ����), ToModel: ������ ��������� � ������ aPara }
  function DeleteValue(const aView: InevView;
   const aControl: IevEditorControl;
   ToModel: Boolean): Integer;
   {* �������� ���� �� ���������. ���������� ������ ���� ��������� ������ ���������� }
  function GetControlClass(aControlType: TevControlType): RevControlClass;
  function CanVisibleLogicBtn: Boolean;
  function LogicBtnEnabled: Boolean;
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
  function ModelListener: IevModelListener;
   {* ������ � ������-����. }
  function Fields: IevEditorControlField;
   {* C����� ���������, ������������� ���������. }
  function ReqName: Il3CString;
   {* ��� ���������. }
  function ReqCaption: Il3CString;
   {* �������� ��������� (������� � �����). � ���� - Get_TagCaption. }
  procedure SetFocus(const aField: IevEditorControlField;
   aAtEnd: Boolean);
   {* ���������� �����. }
  function FirstField: IevEditorControlField;
   {* ���������� ������ ������� � ������. }
  function LastField: IevEditorControlField;
   {* ���������� ��������� ������� � ������. }
  function Group: IevQueryGroup;
   {* ���������� ������, � ������� ����������� ��������. }
  function QueryCard: IevQueryCard;
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
  function DefStateIndex: Integer;
   {* ��������� ���������� ����� �� ���������. }
  function IsContext: Boolean;
   {* ������� ����, ��� �������� �������� ���������. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* �������� ���� ����������� ������ �� ������ ����. }
  function HistoryList: Il3StringsEx;
   {* ������ ������� �����. }
  function StartDate: TDateTime;
   {* ��������� ���� ���������. }
  function EndDate: TDateTime;
   {* �������� ���� ���������. }
  function Code: Il3CString;
  function Number: Il3CString;
  function GetPromptTreeFromAdapter: InevSimpleTree;
  procedure NotifyContextWrong;
 end;//TevReq
 
implementation

uses
 l3ImplUses
 , OvcConst
 , evControlParaConst
 , l3String
 , k2Tags
 , evButtonControl
 , evDropCalendarControl
 , evDropCombo
 , evLabel
 , evSimpleEdit
 , evMemoEdit
 , evEmailEdit
 , evPhoneEdit
 , SysUtils
 , nevFacade
 , evControlParaTools
 , evParaTools
 , l3InterfacesMisc
 , l3Date
 , l3Bits
 , Table_Const
 , ReqRow_Const
 , ControlPara_Const
 , ControlsBlock_Const
 , evReqRowImplementation
;

end.
