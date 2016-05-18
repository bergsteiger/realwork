unit l3DialogServiceImpl;

// ������: "w:\common\components\rtl\Garant\L3\l3DialogServiceImpl.pas"
// ���������: "ServiceImplementation"
// ������� ������: "Tl3DialogServiceImpl" MUID: (573B090C02C5)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3DialogService
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 Tl3DialogServiceImpl = {final} class(Tl3ProtoObject, Il3DialogService)
  public
   function CallExecute(aDialog: TCommonDialog): Boolean;
   class function Instance: Tl3DialogServiceImpl;
    {* ����� ��������� ���������� ���������� Tl3DialogServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tl3DialogServiceImpl

implementation

uses
 l3ImplUses
 , l3BatchService
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
;

var g_Tl3DialogServiceImpl: Tl3DialogServiceImpl = nil;
 {* ��������� ���������� Tl3DialogServiceImpl }

procedure Tl3DialogServiceImplFree;
 {* ����� ������������ ���������� ���������� Tl3DialogServiceImpl }
begin
 l3Free(g_Tl3DialogServiceImpl);
end;//Tl3DialogServiceImplFree

function Tl3DialogServiceImpl.CallExecute(aDialog: TCommonDialog): Boolean;
//#UC START# *52B375B038DC_573B090C02C5_var*
//#UC END# *52B375B038DC_573B090C02C5_var*
begin
//#UC START# *52B375B038DC_573B090C02C5_impl*
{$ifdef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
  if (aDialog is TSaveDialog) then // ���� ����� Open �� �����
  begin
   Result := True;
   TSaveDialog(aDialog).FileName := ChangeFileExt(Application.ExeName, '.autosave');
   Exit;
  end;
{$endif}
 Result := aDialog.Execute;
//#UC END# *52B375B038DC_573B090C02C5_impl*
end;//Tl3DialogServiceImpl.CallExecute

class function Tl3DialogServiceImpl.Instance: Tl3DialogServiceImpl;
 {* ����� ��������� ���������� ���������� Tl3DialogServiceImpl }
begin
 if (g_Tl3DialogServiceImpl = nil) then
 begin
  l3System.AddExitProc(Tl3DialogServiceImplFree);
  g_Tl3DialogServiceImpl := Create;
 end;
 Result := g_Tl3DialogServiceImpl;
end;//Tl3DialogServiceImpl.Instance

class function Tl3DialogServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3DialogServiceImpl <> nil;
end;//Tl3DialogServiceImpl.Exists

initialization
 Tl3DialogService.Instance.Alien := Tl3DialogServiceImpl.Instance;
 {* ����������� Tl3DialogServiceImpl }

end.
