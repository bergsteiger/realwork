unit l3FontManagerEx;

// ������: "w:\common\components\rtl\Garant\L3\l3FontManagerEx.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3FontManager
;

type
 Tl3FontManagerEx = class(Tl3FontManager)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: Tl3FontManagerEx;
    {* ����� ��������� ���������� ���������� Tl3FontManagerEx }
 end;//Tl3FontManagerEx

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3FontManagerEx: Tl3FontManagerEx = nil;
 {* ��������� ���������� Tl3FontManagerEx }

procedure Tl3FontManagerExFree;
 {* ����� ������������ ���������� ���������� Tl3FontManagerEx }
begin
 l3Free(g_Tl3FontManagerEx);
end;//Tl3FontManagerExFree

class function Tl3FontManagerEx.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3FontManagerEx <> nil;
end;//Tl3FontManagerEx.Exists

class function Tl3FontManagerEx.Instance: Tl3FontManagerEx;
 {* ����� ��������� ���������� ���������� Tl3FontManagerEx }
begin
 if (g_Tl3FontManagerEx = nil) then
 begin
  l3System.AddExitProc(Tl3FontManagerExFree);
  g_Tl3FontManagerEx := Create;
 end;
 Result := g_Tl3FontManagerEx;
end;//Tl3FontManagerEx.Instance

end.
