unit m3DBActions;

{ ���������� "M3"         }
{ �����: ����� �.�. �     }
{ ������: m3DBActions -   }
{ �����: 21.12.2007 11:19 }
{ $Id: m3DBActions.pas,v 1.3 2009/03/23 11:24:02 lulin Exp $ }

// $Log: m3DBActions.pas,v $
// Revision 1.3  2009/03/23 11:24:02  lulin
// - ���������� �������� ����������� ������� ������ ���������.
//
// Revision 1.2  2008/05/08 14:04:19  fireton
// - ������� �������� � ������� �� �����
//
// Revision 1.1  2007/12/21 08:26:10  lulin
// - ������� ��� ���������� ������� �������� � ��������� ������.
//

{$Include m3Define.inc}

interface

uses
  m3DBInterfaces
  ;

function  m3L2DocumentAction(Action: Pointer): Tm3DocumentAction;
  {* - ������ �������� ��� ��������� ���������. }
procedure m3FreeDocumentAction(var Stub: Tm3DocumentAction);
  {* - ����������� �������� ��� ��������� ���������. }
function  m3L2FilerAction(Action: Pointer): Tm3FilerAction;
  {* - ������ �������� ��� ��������� ���������. }
procedure m3FreeFilerAction(var Stub: Tm3FilerAction);
  {* - ����������� �������� ��� ��������� ���������. }
function  m3L2DBStreamAction(Action: Pointer): Tm3DBStreamAction;
  {* - ������ �������� ��� ��������� ���������. }
procedure m3FreeDBStreamAction(var Stub: Tm3DBStreamAction);
  {* - ����������� �������� ��� ��������� ���������. }
function  m3L2DBIndexAction(Action: Pointer): Tm3DBIndexAction;
  {* - ������ �������� ��� ��������� ���������. }
procedure m3FreeDBIndexAction(var Stub: Tm3DBIndexAction);
  {* - ����������� �������� ��� ��������� ���������. }

implementation

uses
  l3Base
  ;

function  m3L2DocumentAction(Action: Pointer): Tm3DocumentAction;
  {* - ������ �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeDocumentAction(var Stub: Tm3DocumentAction);
  {* - ����������� �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  m3L2FilerAction(Action: Pointer): Tm3FilerAction;
  {* - ������ �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeFilerAction(var Stub: Tm3FilerAction);
  {* - ����������� �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  m3L2DBStreamAction(Action: Pointer): Tm3DBStreamAction;
  {* - ������ �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeDBStreamAction(var Stub: Tm3DBStreamAction);
  {* - ����������� �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  m3L2DBIndexAction(Action: Pointer): Tm3DBIndexAction;
  {* - ������ �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeDBIndexAction(var Stub: Tm3DBIndexAction);
  {* - ����������� �������� ��� ��������� ���������. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

end.

