unit VCMApllicationSettingsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VCMApllicationSettingsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmToolbarMenuRes
 , vcmMenuManager
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwVcmToolbarSetGlyphSize = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:SetGlyphSize
*Пример:*
[code]
 aValue vcm:Toolbar:SetGlyphSize
[code]  }
  private
   procedure vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
    aValue: TvcmGlyphSize);
    {* Реализация слова скрипта vcm:Toolbar:SetGlyphSize }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphSize

 TkwVcmToolbarGetGlyphSize = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:GetGlyphSize
*Тип результата:* TvcmGlyphSize
*Пример:*
[code]
TvcmGlyphSize VAR l_TvcmGlyphSize
 vcm:Toolbar:GetGlyphSize >>> l_TvcmGlyphSize
[code]  }
  private
   function vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
    {* Реализация слова скрипта vcm:Toolbar:GetGlyphSize }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphSize

 TkwVcmToolbarGetGlyphColorDepth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:GetGlyphColorDepth
*Тип результата:* TvcmGlyphColordepth
*Пример:*
[code]
TvcmGlyphColordepth VAR l_TvcmGlyphColordepth
 vcm:Toolbar:GetGlyphColorDepth >>> l_TvcmGlyphColordepth
[code]  }
  private
   function vcm_Toolbar_GetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
    {* Реализация слова скрипта vcm:Toolbar:GetGlyphColorDepth }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphColorDepth

 TkwVcmToolbarSetGlyphColorDepth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:SetGlyphColorDepth
*Пример:*
[code]
 aValue vcm:Toolbar:SetGlyphColorDepth
[code]  }
  private
   procedure vcm_Toolbar_SetGlyphColorDepth(const aCtx: TtfwContext;
    aValue: TvcmGlyphColordepth);
    {* Реализация слова скрипта vcm:Toolbar:SetGlyphColorDepth }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphColorDepth

procedure TkwVcmToolbarSetGlyphSize.vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
 aValue: TvcmGlyphSize);
 {* Реализация слова скрипта vcm:Toolbar:SetGlyphSize }
//#UC START# *3E6A2A4DD8C9_4463E51B5CE8_var*
//#UC END# *3E6A2A4DD8C9_4463E51B5CE8_var*
begin
//#UC START# *3E6A2A4DD8C9_4463E51B5CE8_impl*
 TvcmToolbarGlyphService.Instance.SetGlyphSize(aValue);
//#UC END# *3E6A2A4DD8C9_4463E51B5CE8_impl*
end;//TkwVcmToolbarSetGlyphSize.vcm_Toolbar_SetGlyphSize

procedure TkwVcmToolbarSetGlyphSize.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4463E51B5CE8_var*
//#UC END# *4DAEEDE10285_4463E51B5CE8_var*
begin
//#UC START# *4DAEEDE10285_4463E51B5CE8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4463E51B5CE8_impl*
end;//TkwVcmToolbarSetGlyphSize.DoDoIt

class function TkwVcmToolbarSetGlyphSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:SetGlyphSize';
end;//TkwVcmToolbarSetGlyphSize.GetWordNameForRegister

function TkwVcmToolbarSetGlyphSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4463E51B5CE8_var*
//#UC END# *551544E2001A_4463E51B5CE8_var*
begin
//#UC START# *551544E2001A_4463E51B5CE8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4463E51B5CE8_impl*
end;//TkwVcmToolbarSetGlyphSize.GetResultTypeInfo

function TkwVcmToolbarSetGlyphSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmToolbarSetGlyphSize.GetAllParamsCount

function TkwVcmToolbarSetGlyphSize.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4463E51B5CE8_var*
//#UC END# *5617F4D00243_4463E51B5CE8_var*
begin
//#UC START# *5617F4D00243_4463E51B5CE8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4463E51B5CE8_impl*
end;//TkwVcmToolbarSetGlyphSize.ParamsTypes

function TkwVcmToolbarGetGlyphSize.vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
 {* Реализация слова скрипта vcm:Toolbar:GetGlyphSize }
//#UC START# *0D29944D7496_CB878D8D1F92_var*
//#UC END# *0D29944D7496_CB878D8D1F92_var*
begin
//#UC START# *0D29944D7496_CB878D8D1F92_impl*
 Result := TvcmToolbarGlyphService.Instance.GetGlyphSize;
//#UC END# *0D29944D7496_CB878D8D1F92_impl*
end;//TkwVcmToolbarGetGlyphSize.vcm_Toolbar_GetGlyphSize

procedure TkwVcmToolbarGetGlyphSize.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB878D8D1F92_var*
//#UC END# *4DAEEDE10285_CB878D8D1F92_var*
begin
//#UC START# *4DAEEDE10285_CB878D8D1F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB878D8D1F92_impl*
end;//TkwVcmToolbarGetGlyphSize.DoDoIt

class function TkwVcmToolbarGetGlyphSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:GetGlyphSize';
end;//TkwVcmToolbarGetGlyphSize.GetWordNameForRegister

function TkwVcmToolbarGetGlyphSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CB878D8D1F92_var*
//#UC END# *551544E2001A_CB878D8D1F92_var*
begin
//#UC START# *551544E2001A_CB878D8D1F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CB878D8D1F92_impl*
end;//TkwVcmToolbarGetGlyphSize.GetResultTypeInfo

function TkwVcmToolbarGetGlyphSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmToolbarGetGlyphSize.GetAllParamsCount

function TkwVcmToolbarGetGlyphSize.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CB878D8D1F92_var*
//#UC END# *5617F4D00243_CB878D8D1F92_var*
begin
//#UC START# *5617F4D00243_CB878D8D1F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CB878D8D1F92_impl*
end;//TkwVcmToolbarGetGlyphSize.ParamsTypes

function TkwVcmToolbarGetGlyphColorDepth.vcm_Toolbar_GetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
 {* Реализация слова скрипта vcm:Toolbar:GetGlyphColorDepth }
//#UC START# *5358A0B19EFE_8FA6E0CDB066_var*
//#UC END# *5358A0B19EFE_8FA6E0CDB066_var*
begin
//#UC START# *5358A0B19EFE_8FA6E0CDB066_impl*
 Result := TvcmToolbarGlyphService.Instance.GetGlyphColordepth;
//#UC END# *5358A0B19EFE_8FA6E0CDB066_impl*
end;//TkwVcmToolbarGetGlyphColorDepth.vcm_Toolbar_GetGlyphColorDepth

procedure TkwVcmToolbarGetGlyphColorDepth.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8FA6E0CDB066_var*
//#UC END# *4DAEEDE10285_8FA6E0CDB066_var*
begin
//#UC START# *4DAEEDE10285_8FA6E0CDB066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8FA6E0CDB066_impl*
end;//TkwVcmToolbarGetGlyphColorDepth.DoDoIt

class function TkwVcmToolbarGetGlyphColorDepth.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:GetGlyphColorDepth';
end;//TkwVcmToolbarGetGlyphColorDepth.GetWordNameForRegister

function TkwVcmToolbarGetGlyphColorDepth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8FA6E0CDB066_var*
//#UC END# *551544E2001A_8FA6E0CDB066_var*
begin
//#UC START# *551544E2001A_8FA6E0CDB066_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8FA6E0CDB066_impl*
end;//TkwVcmToolbarGetGlyphColorDepth.GetResultTypeInfo

function TkwVcmToolbarGetGlyphColorDepth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmToolbarGetGlyphColorDepth.GetAllParamsCount

function TkwVcmToolbarGetGlyphColorDepth.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8FA6E0CDB066_var*
//#UC END# *5617F4D00243_8FA6E0CDB066_var*
begin
//#UC START# *5617F4D00243_8FA6E0CDB066_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8FA6E0CDB066_impl*
end;//TkwVcmToolbarGetGlyphColorDepth.ParamsTypes

procedure TkwVcmToolbarSetGlyphColorDepth.vcm_Toolbar_SetGlyphColorDepth(const aCtx: TtfwContext;
 aValue: TvcmGlyphColordepth);
 {* Реализация слова скрипта vcm:Toolbar:SetGlyphColorDepth }
//#UC START# *47BBC580F855_2E579942A814_var*
//#UC END# *47BBC580F855_2E579942A814_var*
begin
//#UC START# *47BBC580F855_2E579942A814_impl*
 TvcmToolbarGlyphService.Instance.SetGlyphColorDepth(aValue);
//#UC END# *47BBC580F855_2E579942A814_impl*
end;//TkwVcmToolbarSetGlyphColorDepth.vcm_Toolbar_SetGlyphColorDepth

procedure TkwVcmToolbarSetGlyphColorDepth.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2E579942A814_var*
//#UC END# *4DAEEDE10285_2E579942A814_var*
begin
//#UC START# *4DAEEDE10285_2E579942A814_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2E579942A814_impl*
end;//TkwVcmToolbarSetGlyphColorDepth.DoDoIt

class function TkwVcmToolbarSetGlyphColorDepth.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:SetGlyphColorDepth';
end;//TkwVcmToolbarSetGlyphColorDepth.GetWordNameForRegister

function TkwVcmToolbarSetGlyphColorDepth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2E579942A814_var*
//#UC END# *551544E2001A_2E579942A814_var*
begin
//#UC START# *551544E2001A_2E579942A814_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2E579942A814_impl*
end;//TkwVcmToolbarSetGlyphColorDepth.GetResultTypeInfo

function TkwVcmToolbarSetGlyphColorDepth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmToolbarSetGlyphColorDepth.GetAllParamsCount

function TkwVcmToolbarSetGlyphColorDepth.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2E579942A814_var*
//#UC END# *5617F4D00243_2E579942A814_var*
begin
//#UC START# *5617F4D00243_2E579942A814_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2E579942A814_impl*
end;//TkwVcmToolbarSetGlyphColorDepth.ParamsTypes

initialization
 TkwVcmToolbarSetGlyphSize.RegisterInEngine;
 {* Регистрация vcm_Toolbar_SetGlyphSize }
 TkwVcmToolbarGetGlyphSize.RegisterInEngine;
 {* Регистрация vcm_Toolbar_GetGlyphSize }
 TkwVcmToolbarGetGlyphColorDepth.RegisterInEngine;
 {* Регистрация vcm_Toolbar_GetGlyphColorDepth }
 TkwVcmToolbarSetGlyphColorDepth.RegisterInEngine;
 {* Регистрация vcm_Toolbar_SetGlyphColorDepth }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphSize));
 {* Регистрация типа TvcmGlyphSize }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphColordepth));
 {* Регистрация типа TvcmGlyphColordepth }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
