unit ExcludedTestsFolders;
 {* ����� ������ ����������� �� ������� }

// ������: "w:\common\components\rtl\Garant\DUnitTuning\ExcludedTestsFolders.pas"
// ���������: "SimpleClass"
// ������� ������: "TExcludedTestsFolders" MUID: (4C9386230151)

{$Include w:\common\components\rtl\Garant\DUnitTuning\tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3StringList
;

type
 TExcludedTestsFolders = class(Tl3StringList)
  {* ����� ������ ����������� �� ������� }
  public
   class function Exists: Boolean;
   class function Instance: TExcludedTestsFolders;
    {* ����� ��������� ���������� ���������� TExcludedTestsFolders }
 end;//TExcludedTestsFolders
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4C9386230151impl_uses*
 //#UC END# *4C9386230151impl_uses*
;

var g_TExcludedTestsFolders: TExcludedTestsFolders = nil;
 {* ��������� ���������� TExcludedTestsFolders }

procedure TExcludedTestsFoldersFree;
 {* ����� ������������ ���������� ���������� TExcludedTestsFolders }
begin
 l3Free(g_TExcludedTestsFolders);
end;//TExcludedTestsFoldersFree

class function TExcludedTestsFolders.Exists: Boolean;
begin
 Result := g_TExcludedTestsFolders <> nil;
end;//TExcludedTestsFolders.Exists

class function TExcludedTestsFolders.Instance: TExcludedTestsFolders;
 {* ����� ��������� ���������� ���������� TExcludedTestsFolders }
begin
 if (g_TExcludedTestsFolders = nil) then
 begin
  l3System.AddExitProc(TExcludedTestsFoldersFree);
  g_TExcludedTestsFolders := Create;
 end;
 Result := g_TExcludedTestsFolders;
end;//TExcludedTestsFolders.Instance
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
