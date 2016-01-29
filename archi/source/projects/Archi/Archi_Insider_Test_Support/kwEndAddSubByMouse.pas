unit kwEndAddSubByMouse;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwEndAddSubByMouse.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwEndAddSubByMouse
//
// ��������� ����������� ������ �� ��� � ������� ���� (Drag&Drop):
// ����_���������:�����������_������_�����
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
  kwControlWord,
  Controls,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwEndAddSubByMouse = {scriptword} class(TkwControlWord)
  {* ��������� ����������� ������ �� ��� � ������� ���� (Drag&Drop):
����_���������:�����������_������_����� }
 protected
 // realized methods
   procedure DoControl(aControl: TControl;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEndAddSubByMouse
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Messages,
  DragData,
  arArchiTestAdapter2,
  Windows,
  Forms
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwEndAddSubByMouse

procedure TkwEndAddSubByMouse.DoControl(aControl: TControl;
  const aCtx: TtfwContext);
//#UC START# *4DB98B990054_4F0C009200D7_var*
//#UC END# *4DB98B990054_4F0C009200D7_var*
begin
//#UC START# *4DB98B990054_4F0C009200D7_impl*
 AcEndDragAndDrop(aControl);
//#UC END# *4DB98B990054_4F0C009200D7_impl*
end;//TkwEndAddSubByMouse.DoControl

class function TkwEndAddSubByMouse.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '����_���������:�����������_������_�����';
end;//TkwEndAddSubByMouse.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwEndAddSubByMouse
 TkwEndAddSubByMouse.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.