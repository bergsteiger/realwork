unit tfwCStringArraySing;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

uses
 l3IntfUses
 , tfwCStringArray
;

type
 TtfwCStringArraySing = class(TtfwCStringArray)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TtfwCStringArraySing;
    {* ����� ��������� ���������� ���������� TtfwCStringArraySing }
 end;//TtfwCStringArraySing

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwCStringArraySing: TtfwCStringArraySing = nil;
 {* ��������� ���������� TtfwCStringArraySing }

procedure TtfwCStringArraySingFree;
 {* ����� ������������ ���������� ���������� TtfwCStringArraySing }
begin
 l3Free(g_TtfwCStringArraySing);
end;//TtfwCStringArraySingFree

class function TtfwCStringArraySing.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwCStringArraySing <> nil;
end;//TtfwCStringArraySing.Exists

class function TtfwCStringArraySing.Instance: TtfwCStringArraySing;
 {* ����� ��������� ���������� ���������� TtfwCStringArraySing }
begin
 if (g_TtfwCStringArraySing = nil) then
 begin
  l3System.AddExitProc(TtfwCStringArraySingFree);
  g_TtfwCStringArraySing := Create;
 end;
 Result := g_TtfwCStringArraySing;
end;//TtfwCStringArraySing.Instance

end.
