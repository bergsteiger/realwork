unit ArchiAutoTest;
 {* ��������� ������������ � ����. }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiAutoTest.pas"
// ���������: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ArchiInsiderTest
;

type
 TArchiAutoTest = class(TArchiInsiderTest)
  {* ��������� ������������ � ����. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; override;
   class function IsScript: Boolean; override;
    {* ��� ��� ������������ - ��-�� ������ �������� � ���� ������������� � TTestSuite. }
  public
   constructor Create(const aMethodName: AnsiString;
    const aFolder: AnsiString); override;
 end;//TArchiAutoTest
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , StrUtils
;

function TArchiAutoTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
//#UC START# *4C937013031D_4DE482A503AB_var*
//#UC END# *4C937013031D_4DE482A503AB_var*
begin
//#UC START# *4C937013031D_4DE482A503AB_impl*
 Result := 'Scripts';
//#UC END# *4C937013031D_4DE482A503AB_impl*
end;//TArchiAutoTest.GetFolder

function TArchiAutoTest.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
//#UC START# *4DB03121022B_4DE482A503AB_var*
//#UC END# *4DB03121022B_4DE482A503AB_var*
begin
//#UC START# *4DB03121022B_4DE482A503AB_impl*
 if ANSIStartsText('@\', aFileName) then
  Result := FileFromCurrent('Common\' + Copy(aFileName, 3, Length(aFileName) - 2))
 else
  if (ExtractFilePath(aFileName) <> '') then
   Result := aFileName
  else
   Result := FileFromCurrent('Auto') + '\'+ aFileName;
//#UC END# *4DB03121022B_4DE482A503AB_impl*
end;//TArchiAutoTest.ResolveScriptFilePath

class function TArchiAutoTest.IsScript: Boolean;
 {* ��� ��� ������������ - ��-�� ������ �������� � ���� ������������� � TTestSuite. }
//#UC START# *4DC395670274_4DE482A503AB_var*
//#UC END# *4DC395670274_4DE482A503AB_var*
begin
//#UC START# *4DC395670274_4DE482A503AB_impl*
 Result := True;
//#UC END# *4DC395670274_4DE482A503AB_impl*
end;//TArchiAutoTest.IsScript

constructor TArchiAutoTest.Create(const aMethodName: AnsiString;
 const aFolder: AnsiString);
//#UC START# *4DC399CA00BC_4DE482A503AB_var*
//#UC END# *4DC399CA00BC_4DE482A503AB_var*
begin
//#UC START# *4DC399CA00BC_4DE482A503AB_impl*
 inherited Create(aMethodName, aFolder);
 FMethod := Self.DoIt;
//#UC END# *4DC399CA00BC_4DE482A503AB_impl*
end;//TArchiAutoTest.Create
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
