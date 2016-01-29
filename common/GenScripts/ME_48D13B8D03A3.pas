unit evControl;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , nevTools
 , nevBase
 , l3Interfaces
 , evdTypes
;

type
 TevControl = class(TevCustomControlTool, IevCustomEditorControl, IevEditorControl)
  {* ������� ����� ��� ���� ��������� }
  function GetIsMultiline: Boolean;
  function Make(const aValue: InevPara): IevEditorControl;
  procedure SetChecked(aValue: Boolean);
  function DoKeyCommand(const aView: InevControlView;
   aCmd: Word;
   const aTextPara: InevPara): Boolean;
  function DoLMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean): Boolean;
  function DoLMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean;
   const aMap: InevMap): Boolean;
  procedure DoUpperChange;
  procedure SetText(const Value: Il3CString);
  function GetChecked: Boolean;
  procedure DoTextChange(const aView: InevView;
   const aPara: InevPara;
   const anOp: InevOp);
  procedure DoInsertRow(const aView: InevView);
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
  function Field: IevEditorControlField;
   {* ����, �������� ����������� �������. }
  function Req: IevReq;
   {* ��������, �������� ����������� �������. }
  function Enabled: Boolean;
   {* ����������� ��������. }
  function MaxLength: Integer;
  function Caption: Il3CString;
 end;//TevControl
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3Types
 , evParaTools
 , SysUtils
 , l3InterfacedString
 , l3String
 , ReqRow_Const
 , l3CEmptyStringPrim
 , l3CEmptyString
;

end.
