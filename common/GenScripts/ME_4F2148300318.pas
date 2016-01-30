unit kwComponentFromStackWord;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwComponentFromStackWord.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwObjectFromStackWord
 , Classes
 , tfwScriptingInterfaces
;

type
 _SystemWord_Parent_ = TkwObjectFromStackWord;
 {$Include SystemWord.imp.pas}
 TkwComponentFromStackWord = {abstract} class(_SystemWord_)
  protected
   procedure DoComponent(aComponent: TComponent;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoObject(anObject: TObject;
    const aCtx: TtfwContext); override;
 end;//TkwComponentFromStackWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include SystemWord.imp.pas}

procedure TkwComponentFromStackWord.DoObject(anObject: TObject;
 const aCtx: TtfwContext);
//#UC START# *4F212BD5010E_4F2148300318_var*
//#UC END# *4F212BD5010E_4F2148300318_var*
begin
//#UC START# *4F212BD5010E_4F2148300318_impl*
 DoComponent(anObject As TComponent, aCtx);
//#UC END# *4F212BD5010E_4F2148300318_impl*
end;//TkwComponentFromStackWord.DoObject

initialization
 TkwComponentFromStackWord.RegisterClass;
 {* ����������� TkwComponentFromStackWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
