unit k2NilOp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2NilOp.pas"
// �����: 19.05.2011 14:36
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::K2::Operations::Tk2NilOp
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Op
  ;

type
 Tk2NilOp = class(Tk2Op)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: Tk2NilOp;
    {- ���������� ��������� ����������. }
 end;//Tk2NilOp

implementation

uses
  l3Base {a}
  ;


// start class Tk2NilOp

var g_Tk2NilOp : Tk2NilOp = nil;

procedure Tk2NilOpFree;
begin
 l3Free(g_Tk2NilOp);
end;

class function Tk2NilOp.Instance: Tk2NilOp;
begin
 if (g_Tk2NilOp = nil) then
 begin
  l3System.AddExitProc(Tk2NilOpFree);
  g_Tk2NilOp := Create;
 end;
 Result := g_Tk2NilOp;
end;


class function Tk2NilOp.Exists: Boolean;
 {-}
begin
 Result := g_Tk2NilOp <> nil;
end;//Tk2NilOp.Exists

end.