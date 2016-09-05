unit kwPopEditorWheelScroll;
 {* *������:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
*��������:* ������������ �������� � ������� ���������. aVeritcal - ���� true, �� ����������� �����������. aUp - ������������ �����, ���� true
*������:*
[code] 
false true focused:control:push anEditorControl pop:editor:WheelScroll
[code] }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorWheelScroll.pas"
// ���������: "ScriptKeyword"
// ������� ������: "pop_editor_WheelScroll" MUID: (4F4F5A730085)
// ��� ����: "TkwPopEditorWheelScroll"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorWheelScroll = {final} class(TkwEditorFromStackWord)
  {* *������:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
*��������:* ������������ �������� � ������� ���������. aVeritcal - ���� true, �� ����������� �����������. aUp - ������������ �����, ���� true
*������:*
[code] 
false true focused:control:push anEditorControl pop:editor:WheelScroll
[code] }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorWheelScroll
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
 //#UC START# *4F4F5A730085impl_uses*
 //#UC END# *4F4F5A730085impl_uses*
;

procedure TkwPopEditorWheelScroll.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4F4F5A730085_var*
var
 l_Up       : Boolean;
 l_Vertical : Boolean;
//#UC END# *4F4CB81200CA_4F4F5A730085_var*
begin
//#UC START# *4F4CB81200CA_4F4F5A730085_impl*
 if aCtx.rEngine.IsTopBool then
  l_Vertical := aCtx.rEngine.PopBool
 else
  Assert(False, '�� ������ ���������� ���������!');
 if aCtx.rEngine.IsTopBool then
  l_Up := aCtx.rEngine.PopBool
 else
  Assert(False, '�� ������ ����������� ���������!');
 with anEditor.View.Scroller[l_Vertical] do
  if l_Up then
   WheelUp
  else
   WheelDown;
//#UC END# *4F4CB81200CA_4F4F5A730085_impl*
end;//TkwPopEditorWheelScroll.DoWithEditor

class function TkwPopEditorWheelScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:WheelScroll';
end;//TkwPopEditorWheelScroll.GetWordNameForRegister

initialization
 TkwPopEditorWheelScroll.RegisterInEngine;
 {* ����������� pop_editor_WheelScroll }
{$IfEnd} // NOT Defined(NoScripts)

end.
