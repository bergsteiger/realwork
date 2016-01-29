unit kwPopEditorGetParaByID;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// �����: ����� �.�.
// ������: "kwPopEditorGetParaByID.pas"
// �����: 03.11.2011 15:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_GetParaByID
//
// �������� �� ��������� �������� �� ��� ID.
// 
// ������:
// {code}
// 12 editor:GetParaByID
// IF
// Para:Text .
// ELSE
// '�������� �� ������' .
// ENDIF
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
 TkwPopEditorGetParaByID = {scriptword} class(TkwEditorFromStackWord)
  {* �������� �� ��������� �������� �� ��� ID.

������:
[code]
 12 editor:GetParaByID
 IF
  Para:Text .
 ELSE
 '�������� �� ������' .
 ENDIF
[code] }
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorGetParaByID
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  nevTools
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwPopEditorGetParaByID

procedure TkwPopEditorGetParaByID.DoWithEditor(const aCtx: TtfwContext;
  anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4EB27F0E00CF_var*
var
 l_O : InevObject;
 l_P : InevPara;
//#UC END# *4F4CB81200CA_4EB27F0E00CF_var*
begin
//#UC START# *4F4CB81200CA_4EB27F0E00CF_impl*
 if anEditor.TextSource.DocumentContainer.FindObjByID(aCtx.rEngine.PopInt, l_O) then
 begin
  if not l_O.AsObject.QT(InevPara, l_P) then
   RunnerError('', aCtx);
  aCtx.rEngine.PushIntf(l_P, TypeInfo(InevPara));
  aCtx.rEngine.PushBool(true);
 end//anEditor.TextSource.DocumentContainer.FindObjByID(anID, l_O)
 else
  aCtx.rEngine.PushBool(false);
//#UC END# *4F4CB81200CA_4EB27F0E00CF_impl*
end;//TkwPopEditorGetParaByID.DoWithEditor

class function TkwPopEditorGetParaByID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:GetParaByID';
end;//TkwPopEditorGetParaByID.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_GetParaByID
 TkwPopEditorGetParaByID.RegisterInEngine;
{$IfEnd} //not NoScripts

end.