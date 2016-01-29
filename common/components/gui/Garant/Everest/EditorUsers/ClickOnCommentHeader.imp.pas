{$IfNDef ClickOnCommentHeader_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest$EditorUsers"
// ������: "w:/common/components/gui/Garant/Everest/EditorUsers/ClickOnCommentHeader.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest$EditorUsers::MixIns::ClickOnCommentHeader
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ClickOnCommentHeader_imp}
{$If not defined(NoScripts)}
 _MouseClickOnPoint_Parent_ = _ClickOnCommentHeader_Parent_;
 {$Include ..\EditorUsers\MouseClickOnPoint.imp.pas}
 _ClickOnCommentHeader_ = {mixin} class(_MouseClickOnPoint_)
 private
 // private methods
   function CheckCollapsed(aText: TevCustomEditorWindow): Boolean; virtual; abstract;
 protected
 // overridden protected methods
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* ���������� �����, �� ������� ����� ������������������. }
 end;//_ClickOnCommentHeader_
{$Else}

 _MouseClickOnPoint_Parent_ = _ClickOnCommentHeader_Parent_;
 {$Include ..\EditorUsers\MouseClickOnPoint.imp.pas}
 _ClickOnCommentHeader_ = _MouseClickOnPoint_;

{$IfEnd} //not NoScripts

{$Else ClickOnCommentHeader_imp}

{$If not defined(NoScripts)}

{$Include ..\EditorUsers\MouseClickOnPoint.imp.pas}

// start class _ClickOnCommentHeader_

function _ClickOnCommentHeader_.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4DE7451703C8_var*
//#UC END# *4C3C927B027E_4DE7451703C8_var*
begin
//#UC START# *4C3C927B027E_4DE7451703C8_impl*
 Result.X := aMap.Bounds.Left + 100;
 Result.Y := aMap.Bounds.Top + 30;
//#UC END# *4C3C927B027E_4DE7451703C8_impl*
end;//_ClickOnCommentHeader_.GetPoint

{$IfEnd} //not NoScripts

{$EndIf ClickOnCommentHeader_imp}
