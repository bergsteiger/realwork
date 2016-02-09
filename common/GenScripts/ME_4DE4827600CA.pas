unit ArchiInsiderTest;
 {* ������� "��������" �� ����������� ������������� ����. }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiInsiderTest.pas"
// ���������: "SimpleClass"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomInsiderScripter
;

type
 TArchiInsiderTest = class(TCustomInsiderScripter)
  {* ������� "��������" �� ����������� ������������� ����. }
  protected
   procedure Run; override;
   procedure Prepare; override;
    {* ���������� � ������ DoIt }
 end;//TArchiInsiderTest
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptEngine
;

procedure TArchiInsiderTest.Run;
//#UC START# *4DC3D2E00153_4DE4827600CA_var*
//#UC END# *4DC3D2E00153_4DE4827600CA_var*
begin
//#UC START# *4DC3D2E00153_4DE4827600CA_impl*
 OwnScriptFromFile;    
//#UC END# *4DC3D2E00153_4DE4827600CA_impl*
end;//TArchiInsiderTest.Run

procedure TArchiInsiderTest.Prepare;
 {* ���������� � ������ DoIt }
//#UC START# *4DC3DE630030_4DE4827600CA_var*
//#UC END# *4DC3DE630030_4DE4827600CA_var*
begin
//#UC START# *4DC3DE630030_4DE4827600CA_impl*
//#UC END# *4DC3DE630030_4DE4827600CA_impl*
end;//TArchiInsiderTest.Prepare
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
