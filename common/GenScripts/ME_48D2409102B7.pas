unit evEditControl;

interface

uses
 l3IntfUses
 , evControl
 , evQueryCardInt
 , evEditorControlList
 , l3Interfaces
 , nevTools
 , nevBase
;

type
 TevEditControl = class(TevControl, IevEditorControlField)
  {* ������� ����� ���� ��������� }
  procedure DoSynchronizeSelectedValueWithText;
  function GetHasOtherField: Boolean;
  procedure AfterSetText(const Value: Il3CString);
  function GetSelectAllOnFocus: Boolean;
  function GetIsClear: Boolean;
  procedure DoInitOtherField(const aValue: IevEditorControl;
   aIsStart: Boolean);
  procedure DoClearText;
  procedure DoCheckDataText;
  function DoAnalyzeString(const aValue: Il3CString;
   aPos: Integer;
   out aRslt: Il3CString): Boolean;
  function GetIsFieldEmpty: Boolean;
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
  function Text: Il3CString;
   {* ����� ���� ���������. }
  function ErrorColor: Boolean;
   {* ���������� �� ���� ���������� ������. }
  function Valid: Boolean;
   {* ��������� �� ������������. }
  function ChildList: IevEditorControlList;
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
  procedure SynchronizeSelectedValueWithText;
  function HasOtherField: Boolean;
 end;//TevEditControl
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , k2Tags
 , l3Chars
 , SysUtils
;

end.
