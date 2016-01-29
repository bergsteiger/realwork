{$IfNDef SelectOperation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest$EditorUsers"
// ������: "w:/common/components/gui/Garant/Everest/EditorUsers/SelectOperation.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest$EditorUsers::MixIns::SelectOperation
//
// ��������� ��������� ���������, ��������� � �.�.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define SelectOperation_imp}
{$If not defined(NoScripts)}
 _SelectOperation_ = {mixin} class(_SelectOperation_Parent_)
  {* ��������� ��������� ���������, ��������� � �.�. }
 public
 // public methods
   procedure SelectPara(aText: TevCustomEditorWindow);
     {* �������� �������� ������� }
   procedure SelectDocument(aText: TevCustomEditorWindow);
     {* �������� �������� ������� }
 end;//_SelectOperation_
{$Else}

 _SelectOperation_ = _SelectOperation_Parent_;

{$IfEnd} //not NoScripts

{$Else SelectOperation_imp}

{$If not defined(NoScripts)}

// start class _SelectOperation_

procedure _SelectOperation_.SelectPara(aText: TevCustomEditorWindow);
//#UC START# *4D41388401C4_4D4137E30326_var*
//#UC END# *4D41388401C4_4D4137E30326_var*
begin
//#UC START# *4D41388401C4_4D4137E30326_impl*
 aText.Select(ev_stPara);
//#UC END# *4D41388401C4_4D4137E30326_impl*
end;//_SelectOperation_.SelectPara

procedure _SelectOperation_.SelectDocument(aText: TevCustomEditorWindow);
//#UC START# *4D4138A60088_4D4137E30326_var*
//#UC END# *4D4138A60088_4D4137E30326_var*
begin
//#UC START# *4D4138A60088_4D4137E30326_impl*
 aText.Select(ev_stDocument);
//#UC END# *4D4138A60088_4D4137E30326_impl*
end;//_SelectOperation_.SelectDocument

{$IfEnd} //not NoScripts

{$EndIf SelectOperation_imp}
