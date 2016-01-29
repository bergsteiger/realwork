{$IfNDef nevDocumentContainerDecorationRules_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/nevDocumentContainerDecorationRules.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Aspects::nevDocumentContainerDecorationRules
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevDocumentContainerDecorationRules_imp}
 _nevDocumentContainerDecorationRules_ = {mixin} class(_nevDocumentContainerDecorationRules_Parent_)
 public
 // realized methods
   function AllowsThisDecor(aFI: TnevFormatInfoPrim;
     aType: TnevDecorType): Boolean;
     {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
 protected
 // protected methods
   function GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
     aType: TnevDecorType): Boolean; virtual;
     {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
 end;//_nevDocumentContainerDecorationRules_

{$Else nevDocumentContainerDecorationRules_imp}

// start class _nevDocumentContainerDecorationRules_

function _nevDocumentContainerDecorationRules_.GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
  aType: TnevDecorType): Boolean;
//#UC START# *4F33E3A20056_4F33E5FD009E_var*
//#UC END# *4F33E3A20056_4F33E5FD009E_var*
begin
//#UC START# *4F33E3A20056_4F33E5FD009E_impl*
 Result := true;
//#UC END# *4F33E3A20056_4F33E5FD009E_impl*
end;//_nevDocumentContainerDecorationRules_.GetAllowsThisDecor

function _nevDocumentContainerDecorationRules_.AllowsThisDecor(aFI: TnevFormatInfoPrim;
  aType: TnevDecorType): Boolean;
//#UC START# *4F33E2A30116_4F33E5FD009E_var*
//#UC END# *4F33E2A30116_4F33E5FD009E_var*
begin
//#UC START# *4F33E2A30116_4F33E5FD009E_impl*
 Result := {_Instance_R_}(Self).GetAllowsThisDecor(aFI, aType);
//#UC END# *4F33E2A30116_4F33E5FD009E_impl*
end;//_nevDocumentContainerDecorationRules_.AllowsThisDecor

{$EndIf nevDocumentContainerDecorationRules_imp}
