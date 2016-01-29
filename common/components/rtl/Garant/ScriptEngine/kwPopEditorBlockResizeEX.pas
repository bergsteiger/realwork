unit kwPopEditorBlockResizeEX;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorBlockResizeEX.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_BlockResizeEX
//
// *������:
// aDelta aTop aLevel anEditor  pop:editor:BlockResizeEX
// * aDelta - �������� �����
// * aTop - true ����� ������� ������� �������
// * aLevel - ������� ����������� �����.
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
 TkwPopEditorBlockResizeEX = {final scriptword} class(TkwBlockResize)
  {* *������:
aDelta aTop aLevel anEditor  pop:editor:BlockResizeEX
* aDelta - �������� �����
* aTop - true ����� ������� ������� �������
* aLevel - ������� ����������� �����.
* anEditor - ��������, � ������� ���������� ����. }
 protected
 // realized methods
   procedure CorrectBlockPoint(const aCtx: TtfwContext;
     var aMap: InevMap;
     var aCursor: InevBasePoint); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorBlockResizeEX
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

// start class TkwPopEditorBlockResizeEX

procedure TkwPopEditorBlockResizeEX.CorrectBlockPoint(const aCtx: TtfwContext;
  var aMap: InevMap;
  var aCursor: InevBasePoint);
//#UC START# *514BFC55039E_514BFA8902C0_var*
var
 i      : Integer;
 l_Count: Integer;
//#UC END# *514BFC55039E_514BFA8902C0_var*
begin
//#UC START# *514BFC55039E_514BFA8902C0_impl*
 if aCtx.rEngine.IsTopInt then
 begin
  l_Count := aCtx.rEngine.PopInt;
  for i := 0 to l_Count do
  begin
   aMap := aMap.Outer as InevMap;
   aCursor := aCursor.ParentPoint;
  end; // for i := 0 to l_Count do
 end // if aCtx.rEngine.IsTopInt then
 else
  Assert(False, '�� ����� ������� �����!');
//#UC END# *514BFC55039E_514BFA8902C0_impl*
end;//TkwPopEditorBlockResizeEX.CorrectBlockPoint

class function TkwPopEditorBlockResizeEX.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:BlockResizeEX';
end;//TkwPopEditorBlockResizeEX.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_BlockResizeEX
 TkwPopEditorBlockResizeEX.RegisterInEngine;
{$IfEnd} //not NoScripts

end.