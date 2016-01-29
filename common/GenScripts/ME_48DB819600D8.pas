unit evControlGroup;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , evReqList
 , evDescriptionReqList
 , nevTools
 , l3Interfaces
 , evdTypes
 , nevBase
;

type
 TevControlGroup = class(TevCustomControlTool, IevCustomEditorControl, IevQueryGroup)
  {* ������ ���������� (���� ����������) }
  function Make(const aValue: InevPara;
   const aQueryAdapter: IevQueryCard): IevQueryGroup;
  procedure Create(const aValue: InevPara;
   const aQueryAdapter: IevQueryCard);
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
  function ControlName: Tl3WString;
   {* ��� �������� (��� - k2_tiName). }
  function ControlType: TevControlType;
   {* ��� ��������. }
  function Visible: Boolean;
   {* ��������� ��������. }
  function Upper: Boolean;
   {* ��������� ��� Flat-������. }
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
  function Req: IevReq;
   {* ������ ����������, ������������� ������. }
  function ReqCount: Integer;
   {* ���������� ���������� � ������. }
  function DescriptionReq: IevDescriptionReq;
   {* ������ ����������, ������������� ������. }
  function DescriptionReqCount: Integer;
   {* ���������� ���������� � ������. }
  function GroupName: Il3CString;
   {* ���������� ��� ������ (k2_tiShortName). }
  function Expanded: Boolean;
   {* ���������� True, ���� ������ ����������, �.�. ����� ��� ���������. }
  function QueryCard: IevQueryCard;
 end;//TevControlGroup
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Types
 , l3Base
 , k2OpMisc
 , l3String
 , evReq
 , evDescriptionReq
 , nevFacade
 , ReqRow_Const
;

end.
