unit msmDeletedElements;

// ������: "w:\common\components\gui\Garant\msm\msmDeletedElements.pas"
// ���������: "SimpleClass"
// ������� ������: "TmsmDeletedElements" MUID: (57F7BBC60360)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmChangedElementsPrim
;

type
 TmsmDeletedElements = class(TmsmChangedElementsPrim)
  public
   class function Instance: TmsmDeletedElements;
    {* ����� ��������� ���������� ���������� TmsmDeletedElements }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TmsmDeletedElements

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , msmChangedElementsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 //#UC START# *57F7BBC60360impl_uses*
 //#UC END# *57F7BBC60360impl_uses*
;

var g_TmsmDeletedElements: TmsmDeletedElements = nil;
 {* ��������� ���������� TmsmDeletedElements }

procedure TmsmDeletedElementsFree;
 {* ����� ������������ ���������� ���������� TmsmDeletedElements }
begin
 l3Free(g_TmsmDeletedElements);
end;//TmsmDeletedElementsFree

class function TmsmDeletedElements.Instance: TmsmDeletedElements;
 {* ����� ��������� ���������� ���������� TmsmDeletedElements }
begin
 if (g_TmsmDeletedElements = nil) then
 begin
  l3System.AddExitProc(TmsmDeletedElementsFree);
  g_TmsmDeletedElements := Create;
 end;
 Result := g_TmsmDeletedElements;
end;//TmsmDeletedElements.Instance

class function TmsmDeletedElements.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TmsmDeletedElements <> nil;
end;//TmsmDeletedElements.Exists

end.
