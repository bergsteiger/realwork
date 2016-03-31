unit evOperationDispatcherEx;

// ������: "w:\common\components\gui\Garant\Everest\evOperationDispatcherEx.pas"
// ���������: "SimpleClass"
// ������� ������: "TevOperationDispatcherEx" MUID: (4DD4F7060070)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evDisp
;

type
 TevOperationDispatcherEx = class(TevOperationDispatcher)
  public
   class function Instance: TevOperationDispatcherEx;
    {* ����� ��������� ���������� ���������� TevOperationDispatcherEx }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TevOperationDispatcherEx

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TevOperationDispatcherEx: TevOperationDispatcherEx = nil;
 {* ��������� ���������� TevOperationDispatcherEx }

procedure TevOperationDispatcherExFree;
 {* ����� ������������ ���������� ���������� TevOperationDispatcherEx }
begin
 l3Free(g_TevOperationDispatcherEx);
end;//TevOperationDispatcherExFree

class function TevOperationDispatcherEx.Instance: TevOperationDispatcherEx;
 {* ����� ��������� ���������� ���������� TevOperationDispatcherEx }
begin
 if (g_TevOperationDispatcherEx = nil) then
 begin
  l3System.AddExitProc(TevOperationDispatcherExFree);
  g_TevOperationDispatcherEx := Create;
 end;
 Result := g_TevOperationDispatcherEx;
end;//TevOperationDispatcherEx.Instance

class function TevOperationDispatcherEx.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TevOperationDispatcherEx <> nil;
end;//TevOperationDispatcherEx.Exists

end.
