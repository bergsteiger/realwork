unit vcmProfilerInterfaces;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , SysUtils
;

type
 IvcmProfiler = interface(IvcmBase)
  {* ��������� }
  procedure Init(const aDisplayName: AnsiString;
   aFinishCount: Integer);
   {* �������������� ��������� }
  procedure Start;
   {* ������ ����� }
  procedure Finish;
   {* ��������� ����� }
 end;//IvcmProfiler
 
 IvcmProfilersCollection = interface(IvcmBase)
  {* ���������� }
  procedure StartProfile(const aDisplayName: AnsiString;
   anId: Integer;
   aFinishCount: Integer);
   {* aFinishCount - ������������� ���������� ������� Finish ����� �������
                         ���������, ��� �������� ��������� � ��� ��������
                         HasFinished ����������� � True }
  procedure FinishProfile(anId: Integer);
   {* ��������� ������ ����������. EvcmProfilerWasNotStarted }
  function FindById(anId: Integer): IvcmProfiler;
   {* ��� ����� ������������� ����������, ��� ����� ������ ���
          ������������� }
 end;//IvcmProfilersCollection
 
 EvcmProfilerWasNotStarted = class(Exception)
  {* ��������� �� ��� ������� }
 end;//EvcmProfilerWasNotStarted
 
implementation

uses
 l3ImplUses
;

end.
