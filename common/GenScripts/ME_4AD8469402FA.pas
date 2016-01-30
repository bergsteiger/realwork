unit nsInpharmContextHistory;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsInpharmContextHistory.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsInpharmContextHistoryPrim
 , ContextHistoryInterfaces
;

type
 TnsInpharmContextHistory = class(TnsInpharmContextHistoryPrim)
  public
   class function Make: InsContextSearchHistory; reintroduce;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsInpharmContextHistory;
    {* ����� ��������� ���������� ���������� TnsInpharmContextHistory }
 end;//TnsInpharmContextHistory
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsInpharmContextHistory: TnsInpharmContextHistory = nil;
 {* ��������� ���������� TnsInpharmContextHistory }

procedure TnsInpharmContextHistoryFree;
 {* ����� ������������ ���������� ���������� TnsInpharmContextHistory }
begin
 l3Free(g_TnsInpharmContextHistory);
end;//TnsInpharmContextHistoryFree

class function TnsInpharmContextHistory.Make: InsContextSearchHistory;
var
 l_Inst : TnsInpharmContextHistory;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsInpharmContextHistory.Make

class function TnsInpharmContextHistory.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsInpharmContextHistory <> nil;
end;//TnsInpharmContextHistory.Exists

class function TnsInpharmContextHistory.Instance: TnsInpharmContextHistory;
 {* ����� ��������� ���������� ���������� TnsInpharmContextHistory }
begin
 if (g_TnsInpharmContextHistory = nil) then
 begin
  l3System.AddExitProc(TnsInpharmContextHistoryFree);
  g_TnsInpharmContextHistory := Create;
 end;
 Result := g_TnsInpharmContextHistory;
end;//TnsInpharmContextHistory.Instance
{$IfEnd} // NOT Defined(Admin)

end.
