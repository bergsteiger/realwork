{$IfNDef StyleParser_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\StyleParser.imp.pas"
// Стереотип: "Impurity"

{$Define StyleParser_imp}

 _StyleParser_ = class(_StyleParser_Parent_)
  protected
   procedure DoDoParseStyle(const aStyle: IStream);
 end;//_StyleParser_

{$Else StyleParser_imp}

{$IfNDef StyleParser_imp_impl}

{$Define StyleParser_imp_impl}

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

{$EndIf StyleParser_imp_impl}

{$EndIf StyleParser_imp}

