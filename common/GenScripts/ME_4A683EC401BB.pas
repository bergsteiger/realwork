unit bsChatDispatcher;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\bsChatDispatcher.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsChatDispatcherPrim
 , ChatInterfaces
;

type
 TbsChatDispatcher = class(TbsChatDispatcherPrim)
  public
   class function Make: IbsChatDispatcher; reintroduce;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TbsChatDispatcher;
    {* ����� ��������� ���������� ���������� TbsChatDispatcher }
 end;//TbsChatDispatcher
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TbsChatDispatcher: TbsChatDispatcher = nil;
 {* ��������� ���������� TbsChatDispatcher }

procedure TbsChatDispatcherFree;
 {* ����� ������������ ���������� ���������� TbsChatDispatcher }
begin
 l3Free(g_TbsChatDispatcher);
end;//TbsChatDispatcherFree

class function TbsChatDispatcher.Make: IbsChatDispatcher;
var
 l_Inst : TbsChatDispatcher;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsChatDispatcher.Make

class function TbsChatDispatcher.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TbsChatDispatcher <> nil;
end;//TbsChatDispatcher.Exists

class function TbsChatDispatcher.Instance: TbsChatDispatcher;
 {* ����� ��������� ���������� ���������� TbsChatDispatcher }
begin
 if (g_TbsChatDispatcher = nil) then
 begin
  l3System.AddExitProc(TbsChatDispatcherFree);
  g_TbsChatDispatcher := Create;
 end;
 Result := g_TbsChatDispatcher;
end;//TbsChatDispatcher.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
