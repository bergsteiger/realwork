unit nsInpharmContextHistory;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsInpharmContextHistory.pas"
// ���������: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 end;//TnsInpharmContextHistory
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsInpharmContextHistory: Pointer = nil;
 {* ��������� ���������� TnsInpharmContextHistory }

procedure TnsInpharmContextHistoryFree;
 {* ����� ������������ ���������� ���������� TnsInpharmContextHistory }
begin
 IUnknown(g_TnsInpharmContextHistory) := nil;
end;//TnsInpharmContextHistoryFree

class function TnsInpharmContextHistory.Make: InsContextSearchHistory;
begin
 if (g_TnsInpharmContextHistory = nil) then
 begin
  l3System.AddExitProc(TnsInpharmContextHistoryFree);
  InsContextSearchHistory(g_TnsInpharmContextHistory) := inherited Make;
 end;
 Result := InsContextSearchHistory(g_TnsInpharmContextHistory);
end;//TnsInpharmContextHistory.Make

class function TnsInpharmContextHistory.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsInpharmContextHistory <> nil;
end;//TnsInpharmContextHistory.Exists
{$IfEnd} // NOT Defined(Admin)

end.
