unit seModalWorkerList;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerList.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , seModalWorkerListPrim
;

type
 TseModalWorkerList = class(TseModalWorkerListPrim)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TseModalWorkerList;
    {* ����� ��������� ���������� ���������� TseModalWorkerList }
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

class function TseModalWorkerList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TseModalWorkerList <> nil;
end;//TseModalWorkerList.Exists

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
{$IfEnd} // NOT Defined(NoScripts)

end.
