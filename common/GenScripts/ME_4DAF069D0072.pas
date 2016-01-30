unit kwAttributeSearch;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwAttributeSearch.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _F1Test_Parent_ = TtfwRegisterableWord;
 {$Include F1Test.imp.pas}
 TkwAttributeSearch = class(_F1Test_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwAttributeSearch
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , nsConst
 , bsTypesNew
;

{$Include F1Test.imp.pas}

procedure TkwAttributeSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DAF069D0072_var*
//#UC END# *4DAEEDE10285_4DAF069D0072_var*
begin
//#UC START# *4DAEEDE10285_4DAF069D0072_impl*
 TdmStdRes.OpenQuery(lg_qtAttribute, nil, nil);
//#UC END# *4DAEEDE10285_4DAF069D0072_impl*
end;//TkwAttributeSearch.DoDoIt

class function TkwAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'ППР_Prim';
end;//TkwAttributeSearch.GetWordNameForRegister

initialization
 TkwAttributeSearch.RegisterInEngine;
 {* Регистрация AttributeSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
