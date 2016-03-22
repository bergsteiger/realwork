unit kwCompiledWordContainer;
 {* ��������� ��� ����������������� ����. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordContainer.pas"
// ���������: "SimpleClass"
// ������� ������: "TkwCompiledWordContainer" MUID: (4DB6E4630256)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSourcePointWord
 , tfwScriptingInterfaces
;

type
 TkwCompiledWordContainer = {abstract} class(TkwSourcePointWord)
  {* ��������� ��� ����������������� ����. }
  private
   f_WordToWork: TtfwWord;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(aCompiled: TtfwWord;
    const aCtx: TtfwContext); reintroduce;
  public
   property WordToWork: TtfwWord
    read f_WordToWork;
 end;//TkwCompiledWordContainer
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

constructor TkwCompiledWordContainer.Create(aCompiled: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *4DB6E4AB01B1_4DB6E4630256_var*
//#UC END# *4DB6E4AB01B1_4DB6E4630256_var*
begin
//#UC START# *4DB6E4AB01B1_4DB6E4630256_impl*
 inherited Create(aCtx);
 aCompiled.SetRefTo(f_WordToWork);
//#UC END# *4DB6E4AB01B1_4DB6E4630256_impl*
end;//TkwCompiledWordContainer.Create

procedure TkwCompiledWordContainer.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4DB6E4630256_var*
//#UC END# *479731C50290_4DB6E4630256_var*
begin
//#UC START# *479731C50290_4DB6E4630256_impl*
 FreeAndNil(f_WordToWork);
 inherited;
//#UC END# *479731C50290_4DB6E4630256_impl*
end;//TkwCompiledWordContainer.Cleanup

initialization
 TkwCompiledWordContainer.RegisterClass;
 {* ����������� TkwCompiledWordContainer }
{$IfEnd} // NOT Defined(NoScripts)

end.
