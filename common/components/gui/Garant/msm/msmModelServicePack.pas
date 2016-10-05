unit msmModelServicePack;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelServicePack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "msmModelServicePack" MUID: (57EE6C5602EB)

{$Include w:\common\components\msm.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , l3Interfaces
 , tfwScriptingInterfaces
 , TypInfo
 , msmModelService
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *57EE6C5602EBimpl_uses*
 //#UC END# *57EE6C5602EBimpl_uses*
;

type
 TkwMsmModelRoot = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта msm:ModelRoot }
  private
   function msm_ModelRoot(const aCtx: TtfwContext): Il3CString;
    {* Реализация слова скрипта msm:ModelRoot }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsmModelRoot

function TkwMsmModelRoot.msm_ModelRoot(const aCtx: TtfwContext): Il3CString;
 {* Реализация слова скрипта msm:ModelRoot }
//#UC START# *57EE6C7A01B3_57EE6C7A01B3_Word_var*
//#UC END# *57EE6C7A01B3_57EE6C7A01B3_Word_var*
begin
//#UC START# *57EE6C7A01B3_57EE6C7A01B3_Word_impl*
 Result := TtfwCStringFactory.C(TmsmModelService.Instance.ModelRoot);
//#UC END# *57EE6C7A01B3_57EE6C7A01B3_Word_impl*
end;//TkwMsmModelRoot.msm_ModelRoot

class function TkwMsmModelRoot.GetWordNameForRegister: AnsiString;
begin
 Result := 'msm:ModelRoot';
end;//TkwMsmModelRoot.GetWordNameForRegister

function TkwMsmModelRoot.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwMsmModelRoot.GetResultTypeInfo

function TkwMsmModelRoot.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwMsmModelRoot.GetAllParamsCount

function TkwMsmModelRoot.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMsmModelRoot.ParamsTypes

procedure TkwMsmModelRoot.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(msm_ModelRoot(aCtx));
end;//TkwMsmModelRoot.DoDoIt

initialization
 TkwMsmModelRoot.RegisterInEngine;
 {* Регистрация msm_ModelRoot }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
