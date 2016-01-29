unit evDropCalendarControl;

interface

uses
 l3IntfUses
 , evDropControl
 , evQueryCardInt
 , evQueryCardDropControlsInt
 , l3Interfaces
 , nevTools
 , nevBase
;

type
 TevDropCalendarControl = class(TevDropControl, IevEditorCalendarField, IevDropCalendar)
  procedure CheckText(const Value: Il3CString);
   {* ������ _TextChange, �� ��� ������������ ������ }
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
  procedure ApplyDate(Value: TDateTime);
   {* ������� ��������� ���� � ���������. }
  procedure ChooseDate(Sender: TObject);
  procedure CancelDate(Sender: TObject);
  function aDate: TDateTime;
   {* ���� �� ��������. }
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* ���������� ���������� ������ �� ��������� ����������� }
 end;//TevDropCalendarControl
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Date
 , l3Base
 , SysUtils
 , DateUtils
 , evControlParaTools
;

end.
