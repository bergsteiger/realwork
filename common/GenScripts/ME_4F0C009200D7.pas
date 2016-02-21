unit kwEndAddSubByMouse;
 {* ��������� ����������� ������ �� ��� � ������� ���� (Drag&Drop):
����_���������:�����������_������_����� }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEndAddSubByMouse.pas"
// ���������: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , kwControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
;

type
 TkwEndAddSubByMouse = class(TkwControlWord)
  {* ��������� ����������� ������ �� ��� � ������� ���� (Drag&Drop):
����_���������:�����������_������_����� }
  protected
   {$If NOT Defined(NoVCL)}
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEndAddSubByMouse
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Messages
 , DragData
 , arArchiTestAdapter2
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$If NOT Defined(NoVCL)}
procedure TkwEndAddSubByMouse.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4DB98B990054_4F0C009200D7_var*
//#UC END# *4DB98B990054_4F0C009200D7_var*
begin
//#UC START# *4DB98B990054_4F0C009200D7_impl*
 AcEndDragAndDrop(aControl);
//#UC END# *4DB98B990054_4F0C009200D7_impl*
end;//TkwEndAddSubByMouse.DoControl
{$IfEnd} // NOT Defined(NoVCL)

class function TkwEndAddSubByMouse.GetWordNameForRegister: AnsiString;
begin
 Result := '����_���������:�����������_������_�����';
end;//TkwEndAddSubByMouse.GetWordNameForRegister

initialization
 TkwEndAddSubByMouse.RegisterInEngine;
 {* ����������� TkwEndAddSubByMouse }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
