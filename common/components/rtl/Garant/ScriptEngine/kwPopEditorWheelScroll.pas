unit kwPopEditorWheelScroll;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorWheelScroll.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_WheelScroll
//
// *������:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
// *��������:* ������������ �������� � ������� ���������. aVeritcal - ���� true, �� �����������
// �����������. aUp - ������������ �����, ���� true
// *������:*
// {code}
// false true focused:control:push anEditorControl pop:editor:WheelScroll
// {code}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwEditorFromStackWord,
  evCustomEditorWindow,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwPopEditorWheelScroll = {final scriptword} class(TkwEditorFromStackWord)
  {* *������:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
*��������:* ������������ �������� � ������� ���������. aVeritcal - ���� true, �� ����������� �����������. aUp - ������������ �����, ���� true
*������:*
[code] 
false true focused:control:push anEditorControl pop:editor:WheelScroll
[code] }
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorWheelScroll
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwPopEditorWheelScroll

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
 {-}
begin
 Result := 'pop:editor:WheelScroll';
end;//TkwPopEditorWheelScroll.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_WheelScroll
 TkwPopEditorWheelScroll.RegisterInEngine;
{$IfEnd} //not NoScripts

end.