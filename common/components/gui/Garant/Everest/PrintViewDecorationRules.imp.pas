{$IfNDef PrintViewDecorationRules_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/PrintViewDecorationRules.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Aspects::PrintViewDecorationRules
//
// ������� ������ ��������� �� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define PrintViewDecorationRules_imp}
 _nsEditionsDecorationRules_Parent_ = _PrintViewDecorationRules_Parent_;
 {$Include ..\Everest\nsEditionsDecorationRules.imp.pas}
 _PrintViewDecorationRules_ = {mixin} class(_nsEditionsDecorationRules_)
  {* ������� ������ ��������� �� ������ }
 protected
 // overridden protected methods
   function GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
     aType: TnevDecorType): Boolean; override;
     {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
 end;//_PrintViewDecorationRules_

{$Else PrintViewDecorationRules_imp}

{$Include ..\Everest\nsEditionsDecorationRules.imp.pas}

// start class _PrintViewDecorationRules_

function _PrintViewDecorationRules_.GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
  aType: TnevDecorType): Boolean;
//#UC START# *4F33E3A20056_4F4B4B10001B_var*
//#UC END# *4F33E3A20056_4F4B4B10001B_var*
begin
//#UC START# *4F33E3A20056_4F4B4B10001B_impl*
 if (aType = nev_dtHeader) AND
    (aFI <> nil) AND
    (aFI.Obj.AsObject.IntA[k2_tiStyle] = ev_saHeaderForChangesInfo) then
  // - �� ���������� ������ �� �������
  // http://mdp.garant.ru/pages/viewpage.action?pageId=321988011
  // (!)(!)(+)(!)(!) http://mdp.garant.ru/pages/viewpage.action?pageId=321986755  
  Result := false  
 else
  Result := inherited GetAllowsThisDecor(aFI, aType);
//#UC END# *4F33E3A20056_4F4B4B10001B_impl*
end;//_PrintViewDecorationRules_.GetAllowsThisDecor

{$EndIf PrintViewDecorationRules_imp}
