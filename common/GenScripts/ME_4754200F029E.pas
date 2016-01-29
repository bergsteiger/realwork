unit l3ProgressComponent;

interface

uses
 l3IntfUses
 , l3InterfacedComponent
 , l3Interfaces
;

type
 Tl3ProgressComponent = class(Tl3InterfacedComponent, Il3Progress)
  {* ������� ����� �����������, ������� ��������� ���������. }
  procedure Start(Count: Integer;
   const aMsg: Il3CString); overload;
   {* ������ �������. }
  procedure Start(Count: Large;
   const aMsg: Il3CString); overload;
   {* ������ �������. }
  procedure Finish;
   {* ��������� �������. }
  procedure Progress(Current: Integer); overload;
   {* �������� ������� ���������. }
  procedure Progress(Current: Large); overload;
   {* �������� ������� ���������. }
  procedure ProgressEx(Current: Integer;
   const aMsg: Il3CString);
  procedure ChangeIO(Start: Boolean);
   {* �������� ���� InIO. }
  function InIO: Boolean;
   {* � �������� �����/������? }
  function InUse: Boolean;
 end;//Tl3ProgressComponent
 
implementation

uses
 l3ImplUses
;

end.
