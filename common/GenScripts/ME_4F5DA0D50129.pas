unit kwPopEditorEditFormula;
 {* *������:* ���������_��_��������  pop:editor:EditFormula
*��������:* ��������� ���� �������������� ������� � �������� �� "��". 
*������:*
[code]
focused:control:push pop:editor:EditFormula
[code]
*���������:*
 �������� ������ �������������� ������� � ����� ������ �� ������� ������ "��"
*����������:* �� �������� ��������� �������. ������ ��� �������� ��������� � �������, ���� ��� � ��� ������������ ����� � ������ �������������� ����� ������ ���������. }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorEditFormula.pas"
// ���������: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorEditFormula = {final} class(TkwEditorFromStackWord)
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
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorEditFormula
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevTools
 , l3Units
 , Types
 , Messages
 , Windows
;

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
begin
 Result := 'pop:editor:EditFormula';
end;//TkwPopEditorEditFormula.GetWordNameForRegister

initialization
 TkwPopEditorEditFormula.RegisterInEngine;
 {* ����������� pop_editor_EditFormula }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
