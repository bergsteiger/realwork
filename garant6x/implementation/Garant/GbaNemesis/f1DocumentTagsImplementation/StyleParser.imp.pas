{$IfNDef StyleParser_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/StyleParser.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::StyleParser
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define StyleParser_imp}
 _StyleParser_ = {mixin} class(_StyleParser_Parent_)
 protected
 // protected methods
   procedure DoDoParseStyle(const aStyle: IStream);
 end;//_StyleParser_

{$Else StyleParser_imp}

// start class _StyleParser_

procedure _StyleParser_.DoDoParseStyle(const aStyle: IStream);
//#UC START# *4CEFBA5302E6_4CEFBA3C0323_var*
//#UC END# *4CEFBA5302E6_4CEFBA3C0323_var*
begin
//#UC START# *4CEFBA5302E6_4CEFBA3C0323_impl*
 if (aStyle <> nil) then
 begin
  Include(_Instance_R_(Self).f_State, ns_nsInParse);
  try
   TnsStyleParser.Parse(aStyle, Self);
  finally
   Exclude(_Instance_R_(Self).f_State, ns_nsInParse);
  end;//try..finally
 end;//aStyle <> nil
//#UC END# *4CEFBA5302E6_4CEFBA3C0323_impl*
end;//_StyleParser_.DoDoParseStyle

{$EndIf StyleParser_imp}
