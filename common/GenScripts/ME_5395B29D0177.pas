unit CsReplyProcedures;

interface

uses
 l3IntfUses
 , CsReplyProceduresWithRegistering
;

type
 TCsReplyProcedures = class(TCsReplyProceduresWithRegistering)
  {* ����� ��� ����������� "�������� ��������" ������� ��� �������� �� �������. ���������. ������������ ��� "������ ��-���������". �.�. ����� ������ � ��� � ���������� ���� }
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TCsReplyProcedures
 
implementation

uses
 l3ImplUses
;

end.
