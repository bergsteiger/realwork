unit CsReplyProcedures;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/CsReplyProcedures.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ServerSide::TCsReplyProcedures
//
// ����� ��� ����������� "�������� ��������" ������� ��� �������� �� �������. ���������.
// ������������ ��� "������ ��-���������". �.�. ����� ������ � ��� � ���������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  CsReplyProceduresWithRegistering
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TCsReplyProcedures = class(TCsReplyProceduresWithRegistering)
  {* ����� ��� ����������� "�������� ��������" ������� ��� �������� �� �������. ���������. ������������ ��� "������ ��-���������". �.�. ����� ������ � ��� � ���������� ���� }
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TCsReplyProcedures;
    {- ���������� ��������� ����������. }
 end;//TCsReplyProcedures
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  l3Base {a}
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}


// start class TCsReplyProcedures

var g_TCsReplyProcedures : TCsReplyProcedures = nil;

procedure TCsReplyProceduresFree;
begin
 l3Free(g_TCsReplyProcedures);
end;

class function TCsReplyProcedures.Instance: TCsReplyProcedures;
begin
 if (g_TCsReplyProcedures = nil) then
 begin
  l3System.AddExitProc(TCsReplyProceduresFree);
  g_TCsReplyProcedures := Create;
 end;
 Result := g_TCsReplyProcedures;
end;


class function TCsReplyProcedures.Exists: Boolean;
 {-}
begin
 Result := g_TCsReplyProcedures <> nil;
end;//TCsReplyProcedures.Exists

{$IfEnd} //AppServerSide AND not Nemesis

end.