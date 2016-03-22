unit seModalWorkerList;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerList.pas"
// ���������: "SimpleClass"
// ������� ������: "TseModalWorkerList" MUID: (4FC756830111)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , seModalWorkerListPrim
;

type
 TseModalWorkerList = class(TseModalWorkerListPrim)
  public
   class function Instance: TseModalWorkerList;
    {* ����� ��������� ���������� ���������� TseModalWorkerList }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TseModalWorkerList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TseModalWorkerList: TseModalWorkerList = nil;
 {* ��������� ���������� TseModalWorkerList }

procedure TseModalWorkerListFree;
 {* ����� ������������ ���������� ���������� TseModalWorkerList }
begin
 l3Free(g_TseModalWorkerList);
end;//TseModalWorkerListFree

class function TseModalWorkerList.Instance: TseModalWorkerList;
 {* ����� ��������� ���������� ���������� TseModalWorkerList }
begin
 if (g_TseModalWorkerList = nil) then
 begin
  l3System.AddExitProc(TseModalWorkerListFree);
  g_TseModalWorkerList := Create;
 end;
 Result := g_TseModalWorkerList;
end;//TseModalWorkerList.Instance

class function TseModalWorkerList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TseModalWorkerList <> nil;
end;//TseModalWorkerList.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
