unit nsDocumentContextHistory;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsDocumentContextHistory.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsDocumentContextHistoryPrim
 , ContextHistoryInterfaces
;

type
 TnsDocumentContextHistory = class(TnsDocumentContextHistoryPrim)
  public
   class function Make: InsContextSearchHistory; reintroduce;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsDocumentContextHistory;
    {* ����� ��������� ���������� ���������� TnsDocumentContextHistory }
 end;//TnsDocumentContextHistory
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsDocumentContextHistory: TnsDocumentContextHistory = nil;
 {* ��������� ���������� TnsDocumentContextHistory }

procedure TnsDocumentContextHistoryFree;
 {* ����� ������������ ���������� ���������� TnsDocumentContextHistory }
begin
 l3Free(g_TnsDocumentContextHistory);
end;//TnsDocumentContextHistoryFree

class function TnsDocumentContextHistory.Make: InsContextSearchHistory;
var
 l_Inst : TnsDocumentContextHistory;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentContextHistory.Make

class function TnsDocumentContextHistory.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsDocumentContextHistory <> nil;
end;//TnsDocumentContextHistory.Exists

class function TnsDocumentContextHistory.Instance: TnsDocumentContextHistory;
 {* ����� ��������� ���������� ���������� TnsDocumentContextHistory }
begin
 if (g_TnsDocumentContextHistory = nil) then
 begin
  l3System.AddExitProc(TnsDocumentContextHistoryFree);
  g_TnsDocumentContextHistory := Create;
 end;
 Result := g_TnsDocumentContextHistory;
end;//TnsDocumentContextHistory.Instance
{$IfEnd} // NOT Defined(Admin)

end.
