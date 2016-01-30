unit evOperationDispatcherEx;

// ������: "w:\common\components\gui\Garant\Everest\evOperationDispatcherEx.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evDisp
;

type
 TevOperationDispatcherEx = class(TevOperationDispatcher)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TevOperationDispatcherEx;
    {* ����� ��������� ���������� ���������� TevOperationDispatcherEx }
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

class function TevOperationDispatcherEx.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TevOperationDispatcherEx <> nil;
end;//TevOperationDispatcherEx.Exists

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

end.
