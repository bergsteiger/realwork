unit kwCompiledWordWorker;
 {* ������� ����� ��� ����������� ���������������� ����. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorker.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSourcePointWord
 , tfwScriptingInterfaces
;

type
 RkwCompiledWordWorker = class of TkwCompiledWordWorker;

 TkwCompiledWordWorker = {abstract} class(TkwSourcePointWord)
  {* ������� ����� ��� ����������� ���������������� ����. }
  private
   f_WordToWork: TtfwWord;
    {* ���� ��� �������� WordToWork }
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(aWordToPush: TtfwWord;
    aWordToRun: TtfwWord;
    const aCtx: TtfwContext); reintroduce; virtual;
  public
   property WordToWork: TtfwWord
    read f_WordToWork;
 end;//TkwCompiledWordWorker
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

constructor TkwCompiledWordWorker.Create(aWordToPush: TtfwWord;
 aWordToRun: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *4DCBB0CD028D_4DCBD50101CB_var*
//#UC END# *4DCBB0CD028D_4DCBD50101CB_var*
begin
//#UC START# *4DCBB0CD028D_4DCBD50101CB_impl*
 inherited Create(aCtx);
 aWordToPush.SetRefTo(f_WordToWork);
//#UC END# *4DCBB0CD028D_4DCBD50101CB_impl*
end;//TkwCompiledWordWorker.Create

procedure TkwCompiledWordWorker.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4DCBD50101CB_var*
//#UC END# *479731C50290_4DCBD50101CB_var*
begin
//#UC START# *479731C50290_4DCBD50101CB_impl*
 FreeAndNil(f_WordToWork);
 inherited;
//#UC END# *479731C50290_4DCBD50101CB_impl*
end;//TkwCompiledWordWorker.Cleanup

initialization
 TkwCompiledWordWorker.RegisterClass;
 {* ����������� TkwCompiledWordWorker }
{$IfEnd} // NOT Defined(NoScripts)

end.
