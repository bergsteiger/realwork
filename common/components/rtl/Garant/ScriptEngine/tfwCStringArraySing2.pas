unit tfwCStringArraySing2;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing2.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwCStringArraySing2" MUID: (4F4D42D9035C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , tfwCStringArray
;

type
 TtfwCStringArraySing2 = class(TtfwCStringArray)
  public
   class function Instance: TtfwCStringArraySing2;
    {* ����� ��������� ���������� ���������� TtfwCStringArraySing2 }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwCStringArraySing2

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4F4D42D9035Cimpl_uses*
 //#UC END# *4F4D42D9035Cimpl_uses*
;

var g_TtfwCStringArraySing2: TtfwCStringArraySing2 = nil;
 {* ��������� ���������� TtfwCStringArraySing2 }

procedure TtfwCStringArraySing2Free;
 {* ����� ������������ ���������� ���������� TtfwCStringArraySing2 }
begin
 l3Free(g_TtfwCStringArraySing2);
end;//TtfwCStringArraySing2Free

class function TtfwCStringArraySing2.Instance: TtfwCStringArraySing2;
 {* ����� ��������� ���������� ���������� TtfwCStringArraySing2 }
begin
 if (g_TtfwCStringArraySing2 = nil) then
 begin
  l3System.AddExitProc(TtfwCStringArraySing2Free);
  g_TtfwCStringArraySing2 := Create;
 end;
 Result := g_TtfwCStringArraySing2;
end;//TtfwCStringArraySing2.Instance

class function TtfwCStringArraySing2.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwCStringArraySing2 <> nil;
end;//TtfwCStringArraySing2.Exists

end.
