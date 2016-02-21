unit afwSettingsImplSing;

// ������: "w:\common\components\gui\Garant\AFW\afwSettingsImplSing.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwSettingsImplPersistent
;

type
 TafwSettingsImplSing = class(TafwSettingsImplPersistent)
  protected
   procedure InitFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TafwSettingsImplSing;
    {* ����� ��������� ���������� ���������� TafwSettingsImplSing }
 end;//TafwSettingsImplSing

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TafwSettingsImplSing: TafwSettingsImplSing = nil;
 {* ��������� ���������� TafwSettingsImplSing }

procedure TafwSettingsImplSingFree;
 {* ����� ������������ ���������� ���������� TafwSettingsImplSing }
begin
 l3Free(g_TafwSettingsImplSing);
end;//TafwSettingsImplSingFree

class function TafwSettingsImplSing.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TafwSettingsImplSing <> nil;
end;//TafwSettingsImplSing.Exists

class function TafwSettingsImplSing.Instance: TafwSettingsImplSing;
 {* ����� ��������� ���������� ���������� TafwSettingsImplSing }
begin
 if (g_TafwSettingsImplSing = nil) then
 begin
  l3System.AddExitProc(TafwSettingsImplSingFree);
  g_TafwSettingsImplSing := Create;
 end;
 Result := g_TafwSettingsImplSing;
end;//TafwSettingsImplSing.Instance

procedure TafwSettingsImplSing.InitFields;
//#UC START# *47A042E100E2_4F6C7DC2022A_var*
//#UC END# *47A042E100E2_4F6C7DC2022A_var*
begin
//#UC START# *47A042E100E2_4F6C7DC2022A_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4F6C7DC2022A_impl*
end;//TafwSettingsImplSing.InitFields

end.
