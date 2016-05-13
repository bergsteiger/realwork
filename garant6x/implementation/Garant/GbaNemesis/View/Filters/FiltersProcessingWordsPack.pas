unit FiltersProcessingWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\FiltersProcessingWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "FiltersProcessingWordsPack" MUID: (571E1AF302D6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571E1AF302D6intf_uses*
 //#UC END# *571E1AF302D6intf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , FiltersUnit
 , DataAdapter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *571E1AF302D6impl_uses*
 //#UC END# *571E1AF302D6impl_uses*
;

type
 TkwFiltersList = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwFiltersList

 TkwPermanentFilterExists = {abstract} class(TtfwRegisterableWord)
  protected
   function GetFilters: IFiltersFromQuery; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwPermanentFilterExists

 TkwIsLegalPermanentFilterExists = {final} class(TkwPermanentFilterExists)
  protected
   function GetFilters: IFiltersFromQuery; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsLegalPermanentFilterExists

 TkwIsPharmPermanentFilterExists = {final} class(TkwPermanentFilterExists)
  protected
   function GetFilters: IFiltersFromQuery; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsPharmPermanentFilterExists

class function TkwFiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := 'filters:Open';
end;//TkwFiltersList.GetWordNameForRegister

procedure TkwFiltersList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBA9CE301B4_var*
//#UC END# *4DAEEDE10285_4DBA9CE301B4_var*
begin
//#UC START# *4DAEEDE10285_4DBA9CE301B4_impl*
 aCtx.rCaller.Check(vcmDispatcher.EntityOperation(TdmStdRes.opcode_Filters_FiltersListOpen, vcmParams));
//#UC END# *4DAEEDE10285_4DBA9CE301B4_impl*
end;//TkwFiltersList.DoDoIt

procedure TkwPermanentFilterExists.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B2B1460348_var*
//#UC END# *4DAEEDE10285_53B2B1460348_var*
begin
//#UC START# *4DAEEDE10285_53B2B1460348_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_53B2B1460348_impl*
end;//TkwPermanentFilterExists.DoDoIt

function TkwIsLegalPermanentFilterExists.GetFilters: IFiltersFromQuery;
//#UC START# *53B2B2C800D6_53B2B2950270_var*
//#UC END# *53B2B2C800D6_53B2B2950270_var*
begin
//#UC START# *53B2B2C800D6_53B2B2950270_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B2B2C800D6_53B2B2950270_impl*
end;//TkwIsLegalPermanentFilterExists.GetFilters

class function TkwIsLegalPermanentFilterExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsLegalPermanentFilterExists';
end;//TkwIsLegalPermanentFilterExists.GetWordNameForRegister

function TkwIsPharmPermanentFilterExists.GetFilters: IFiltersFromQuery;
//#UC START# *53B2B2C800D6_53B2B2730077_var*
//#UC END# *53B2B2C800D6_53B2B2730077_var*
begin
//#UC START# *53B2B2C800D6_53B2B2730077_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B2B2C800D6_53B2B2730077_impl*
end;//TkwIsPharmPermanentFilterExists.GetFilters

class function TkwIsPharmPermanentFilterExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsPharmPermanentFilterExists';
end;//TkwIsPharmPermanentFilterExists.GetWordNameForRegister

initialization
 TkwFiltersList.RegisterInEngine;
 {* Регистрация TkwFiltersList }
 TkwPermanentFilterExists.RegisterClass;
 {* Регистрация PermanentFilterExists }
 TkwIsLegalPermanentFilterExists.RegisterInEngine;
 {* Регистрация IsLegalPermanentFilterExists }
 TkwIsPharmPermanentFilterExists.RegisterInEngine;
 {* Регистрация IsPharmPermanentFilterExists }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
