unit l3Prg;

interface

uses
 l3IntfUses
 , l3_Base
 , l3Interfaces
;

type
 Tl3ProgressIndicator = class(Tl3_Base, Il3Progress)
  {* ��������� ���������. }
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
 end;//Tl3ProgressIndicator
 
implementation

uses
 l3ImplUses
;

end.
