unit kwPopEditorBlockResize;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorBlockResize.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_BlockResize
//
// *������:
// aDelta aTop anEditor  pop:editor:BlockResize
// * aDelta - �������� �����
// * aTop - true ����� ������� ������� �������
// * anEditor - ��������, � ������� ���������� ����.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwBlockResize,
  nevTools,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwPopEditorBlockResize = {scriptword} class(TkwBlockResize)
  {* *������:
aDelta aTop anEditor  pop:editor:BlockResize
* aDelta - �������� �����
* aTop - true ����� ������� ������� �������
* anEditor - ��������, � ������� ���������� ����. }
 protected
 // realized methods
   procedure CorrectBlockPoint(const aCtx: TtfwContext;
     var aMap: InevMap;
     var aCursor: InevBasePoint); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorBlockResize
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  evOp,
  CommentPara_Const,
  TextPara_Const
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwPopEditorBlockResize

procedure TkwPopEditorBlockResize.CorrectBlockPoint(const aCtx: TtfwContext;
  var aMap: InevMap;
  var aCursor: InevBasePoint);
//#UC START# *514BFC55039E_4F38F6E001CB_var*
//#UC END# *514BFC55039E_4F38F6E001CB_var*
begin
//#UC START# *514BFC55039E_4F38F6E001CB_impl*
 
//#UC END# *514BFC55039E_4F38F6E001CB_impl*
end;//TkwPopEditorBlockResize.CorrectBlockPoint

class function TkwPopEditorBlockResize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:BlockResize';
end;//TkwPopEditorBlockResize.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_BlockResize
 TkwPopEditorBlockResize.RegisterInEngine;
{$IfEnd} //not NoScripts

end.