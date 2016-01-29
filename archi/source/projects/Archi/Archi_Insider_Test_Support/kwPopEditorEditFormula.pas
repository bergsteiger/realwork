unit kwPopEditorEditFormula;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwPopEditorEditFormula.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EditorKeyWords::pop_editor_EditFormula
//
// *������:* ���������_��_��������  pop:editor:EditFormula
// *��������:* ��������� ���� �������������� ������� � �������� �� "��".
// *������:*
// {code}
// focused:control:push pop:editor:EditFormula
// {code}
// *���������:*
// �������� ������ �������������� ������� � ����� ������ �� ������� ������ "��"
// *����������:* �� �������� ��������� �������. ������ ��� �������� ��������� � �������, ���� ��� �
// ��� ������������ ����� � ������ �������������� ����� ������ ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwEditorFromStackWord,
  evCustomEditorWindow,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwPopEditorEditFormula = {final scriptword} class(TkwEditorFromStackWord)
  {* *������:* ���������_��_��������  pop:editor:EditFormula
*��������:* ��������� ���� �������������� ������� � �������� �� "��". 
*������:*
[code]
focused:control:push pop:editor:EditFormula
[code]
*���������:*
 �������� ������ �������������� ������� � ����� ������ �� ������� ������ "��"
*����������:* �� �������� ��������� �������. ������ ��� �������� ��������� � �������, ���� ��� � ��� ������������ ����� � ������ �������������� ����� ������ ���������. }
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorEditFormula
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  nevTools,
  l3Units,
  Types,
  Messages,
  Windows
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwPopEditorEditFormula

procedure TkwPopEditorEditFormula.DoWithEditor(const aCtx: TtfwContext;
  anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4F5DA0D50129_var*
var
 l_Map        : InevMap;
 l_Point      : Tl3Point;
 l_SPoint     : Tl3SPoint;
 l_MousePos   : TSmallPoint;
 l_InnerPoint : InevBasePoint;
//#UC END# *4F4CB81200CA_4F5DA0D50129_var*
begin
//#UC START# *4F4CB81200CA_4F5DA0D50129_impl*
 l_InnerPoint := anEditor.Selection.Cursor.MostInner;
 l_Map := anEditor.View.MapByPoint(l_InnerPoint);
 l_Point := l3Point(l_Map.Bounds.Left + l_Map.FI.Width div 2, l_Map.Bounds.Bottom - 150);
 l_SPoint := anEditor.Canvas.LP2DP(l_Point);
 l_MousePos := PointToSmallPoint(Point(l_SPoint.X, l_SPoint.Y));
 SendMessage(anEditor.Handle, WM_LBUTTONDBLCLK, 0, Longint(l_MousePos));
//#UC END# *4F4CB81200CA_4F5DA0D50129_impl*
end;//TkwPopEditorEditFormula.DoWithEditor

class function TkwPopEditorEditFormula.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:EditFormula';
end;//TkwPopEditorEditFormula.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� pop_editor_EditFormula
 TkwPopEditorEditFormula.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.