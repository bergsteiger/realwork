{$IfNDef nsEditionsDecorationRules_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/nsEditionsDecorationRules.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Aspects::nsEditionsDecorationRules
//
// ������� ���������� ��������� ��� �� � ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsEditionsDecorationRules_imp}
 _nsEditionsDecorationRules_ = {mixin} class(_nsEditionsDecorationRules_Parent_)
  {* ������� ���������� ��������� ��� �� � ��� }
 protected
 // overridden protected methods
   function GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
     aType: TnevDecorType): Boolean; override;
     {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
 end;//_nsEditionsDecorationRules_

{$Else nsEditionsDecorationRules_imp}

// start class _nsEditionsDecorationRules_

function _nsEditionsDecorationRules_.GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
  aType: TnevDecorType): Boolean;
//#UC START# *4F33E3A20056_4F33E7CF0393_var*
//#UC END# *4F33E3A20056_4F33E7CF0393_var*
begin
//#UC START# *4F33E3A20056_4F33E7CF0393_impl*
 if (aType = nev_dtFooter) AND
    (aFI <> nil) AND
    (aFI.Obj.AsObject.IntA[k2_tiStyle] = ev_saFooterForChangesInfo) then
  // - �� ���������� ������ �� �������
  // http://mdp.garant.ru/pages/viewpage.action?pageId=321988011  
  Result := false  
 else
  Result := inherited GetAllowsThisDecor(aFI, aType);
//#UC END# *4F33E3A20056_4F33E7CF0393_impl*
end;//_nsEditionsDecorationRules_.GetAllowsThisDecor

{$EndIf nsEditionsDecorationRules_imp}
