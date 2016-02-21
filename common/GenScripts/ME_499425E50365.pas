unit vcmProfilerInterfaces;
 {* ��������������. [$136264930] }

// ������: "w:\common\components\gui\Garant\VCM\vcmProfilerInterfaces.pas"
// ���������: "Interfaces"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , SysUtils
;

type
 IvcmProfiler = interface(IvcmBase)
  {* ��������� }
  ['{9414E6E8-AC1E-4B2C-8F9C-EB76E9BB846B}']
  function pm_GetId: Integer;
  function pm_GetHasFinished: Boolean;
  function pm_GetExecuteTime: Integer;
  function pm_GetExecuteCount: Integer;
  function pm_GetAverageExecuteTime: Integer;
  function pm_GetDisplayName: AnsiString;
  procedure Init(const aDisplayName: AnsiString;
   aFinishCount: Integer);
   {* �������������� ��������� }
  procedure Start;
   {* ������ ����� }
  procedure Finish;
   {* ��������� ����� }
  property Id: Integer
   read pm_GetId;
   {* ������������� ���������� }
  property HasFinished: Boolean
   read pm_GetHasFinished;
   {* ���������� �������� �� ��������� ������ }
  property ExecuteTime: Integer
   read pm_GetExecuteTime;
   {* ����� �������� ���������� (� ��������������) }
  property ExecuteCount: Integer
   read pm_GetExecuteCount;
   {* ���������� �������� ����������. ��������� ���������� ����������
           ������� ������ }
  property AverageExecuteTime: Integer
   read pm_GetAverageExecuteTime;
   {* ������� ����� �������� ���������� }
  property DisplayName: AnsiString
   read pm_GetDisplayName;
   {* ������������ �������� }
 end;//IvcmProfiler

 IvcmProfilersCollection = interface(IvcmBase)
  {* ���������� }
  ['{0EE0F248-3908-4E76-B215-164D52D394DD}']
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
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
