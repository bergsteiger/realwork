unit CsReplyProcedures;
 {* ����� ��� ����������� "�������� ��������" ������� ��� �������� �� �������. ���������. ������������ ��� "������ ��-���������". �.�. ����� ������ � ��� � ���������� ���� }

// ������: "w:\common\components\rtl\Garant\cs\CsReplyProcedures.pas"
// ���������: "SimpleClass"
// ������� ������: "TCsReplyProcedures" MUID: (5395B29D0177)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsReplyProceduresWithRegistering
;

type
 TCsReplyProcedures = class(TCsReplyProceduresWithRegistering)
  {* ����� ��� ����������� "�������� ��������" ������� ��� �������� �� �������. ���������. ������������ ��� "������ ��-���������". �.�. ����� ������ � ��� � ���������� ���� }
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TCsReplyProcedures;
    {* ����� ��������� ���������� ���������� TCsReplyProcedures }
 end;//TCsReplyProcedures
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TCsReplyProcedures: TCsReplyProcedures = nil;
 {* ��������� ���������� TCsReplyProcedures }

procedure TCsReplyProceduresFree;
 {* ����� ������������ ���������� ���������� TCsReplyProcedures }
begin
 l3Free(g_TCsReplyProcedures);
end;//TCsReplyProceduresFree

class function TCsReplyProcedures.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TCsReplyProcedures <> nil;
end;//TCsReplyProcedures.Exists

class function TCsReplyProcedures.Instance: TCsReplyProcedures;
 {* ����� ��������� ���������� ���������� TCsReplyProcedures }
begin
 if (g_TCsReplyProcedures = nil) then
 begin
  l3System.AddExitProc(TCsReplyProceduresFree);
  g_TCsReplyProcedures := Create;
 end;
 Result := g_TCsReplyProcedures;
end;//TCsReplyProcedures.Instance
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
