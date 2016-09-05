unit VCMApllicationSettingsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VCMApllicationSettingsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "VCMApllicationSettingsPack" MUID: (552BAE9B027D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , vcmToolbarMenuRes
 , TypInfo
 , vcmMenuManager
 , vcmSettings
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *552BAE9B027Dimpl_uses*
 //#UC END# *552BAE9B027Dimpl_uses*
;

type
 TkwVcmToolbarSetGlyphSize = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:SetGlyphSize }
  private
   procedure vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
    aValue: TvcmGlyphSize);
    {* Реализация слова скрипта vcm:Toolbar:SetGlyphSize }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphSize

 TkwVcmToolbarGetGlyphSize = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:GetGlyphSize }
  private
   function vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
    {* Реализация слова скрипта vcm:Toolbar:GetGlyphSize }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphSize

 TkwVcmToolbarGetGlyphColorDepth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:GetGlyphColorDepth }
  private
   function vcm_Toolbar_GetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
    {* Реализация слова скрипта vcm:Toolbar:GetGlyphColorDepth }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphColorDepth

 TkwVcmToolbarSetGlyphColorDepth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:SetGlyphColorDepth }
  private
   procedure vcm_Toolbar_SetGlyphColorDepth(const aCtx: TtfwContext;
    aValue: TvcmGlyphColordepth);
    {* Реализация слова скрипта vcm:Toolbar:SetGlyphColorDepth }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphColorDepth

 TkwVcmToolbarButtonSetVisible = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:ToolbarButton:SetVisible }
  private
   procedure vcm_ToolbarButton_SetVisible(const aCtx: TtfwContext;
    const aUtName: AnsiString;
    const aTbName: AnsiString;
    const anEntityName: AnsiString;
    const anOpName: AnsiString;
    aVisible: Boolean);
    {* Реализация слова скрипта vcm:ToolbarButton:SetVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarButtonSetVisible

procedure TkwVcmToolbarSetGlyphSize.vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
 aValue: TvcmGlyphSize);
 {* Реализация слова скрипта vcm:Toolbar:SetGlyphSize }
//#UC START# *552BAF1E0177_552BAF1E0177_Word_var*
//#UC END# *552BAF1E0177_552BAF1E0177_Word_var*
begin
//#UC START# *552BAF1E0177_552BAF1E0177_Word_impl*
 TvcmToolbarGlyphService.Instance.SetGlyphSize(aValue);
//#UC END# *552BAF1E0177_552BAF1E0177_Word_impl*
end;//TkwVcmToolbarSetGlyphSize.vcm_Toolbar_SetGlyphSize

class function TkwVcmToolbarSetGlyphSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:SetGlyphSize';
end;//TkwVcmToolbarSetGlyphSize.GetWordNameForRegister

function TkwVcmToolbarSetGlyphSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmToolbarSetGlyphSize.GetResultTypeInfo

function TkwVcmToolbarSetGlyphSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmToolbarSetGlyphSize.GetAllParamsCount

function TkwVcmToolbarSetGlyphSize.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmGlyphSize)]);
end;//TkwVcmToolbarSetGlyphSize.ParamsTypes

procedure TkwVcmToolbarSetGlyphSize.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TvcmGlyphSize;
begin
 try
  l_aValue := TvcmGlyphSize(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TvcmGlyphSize : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_Toolbar_SetGlyphSize(aCtx, l_aValue);
end;//TkwVcmToolbarSetGlyphSize.DoDoIt

function TkwVcmToolbarGetGlyphSize.vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
 {* Реализация слова скрипта vcm:Toolbar:GetGlyphSize }
//#UC START# *552BBC51039D_552BBC51039D_Word_var*
//#UC END# *552BBC51039D_552BBC51039D_Word_var*
begin
//#UC START# *552BBC51039D_552BBC51039D_Word_impl*
 Result := TvcmToolbarGlyphService.Instance.GetGlyphSize;
//#UC END# *552BBC51039D_552BBC51039D_Word_impl*
end;//TkwVcmToolbarGetGlyphSize.vcm_Toolbar_GetGlyphSize

class function TkwVcmToolbarGetGlyphSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:GetGlyphSize';
end;//TkwVcmToolbarGetGlyphSize.GetWordNameForRegister

function TkwVcmToolbarGetGlyphSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvcmGlyphSize);
end;//TkwVcmToolbarGetGlyphSize.GetResultTypeInfo

function TkwVcmToolbarGetGlyphSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmToolbarGetGlyphSize.GetAllParamsCount

function TkwVcmToolbarGetGlyphSize.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmToolbarGetGlyphSize.ParamsTypes

procedure TkwVcmToolbarGetGlyphSize.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(Ord(vcm_Toolbar_GetGlyphSize(aCtx)));
end;//TkwVcmToolbarGetGlyphSize.DoDoIt

function TkwVcmToolbarGetGlyphColorDepth.vcm_Toolbar_GetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
 {* Реализация слова скрипта vcm:Toolbar:GetGlyphColorDepth }
//#UC START# *552BC39B031D_552BC39B031D_Word_var*
//#UC END# *552BC39B031D_552BC39B031D_Word_var*
begin
//#UC START# *552BC39B031D_552BC39B031D_Word_impl*
 Result := TvcmToolbarGlyphService.Instance.GetGlyphColordepth;
//#UC END# *552BC39B031D_552BC39B031D_Word_impl*
end;//TkwVcmToolbarGetGlyphColorDepth.vcm_Toolbar_GetGlyphColorDepth

class function TkwVcmToolbarGetGlyphColorDepth.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:GetGlyphColorDepth';
end;//TkwVcmToolbarGetGlyphColorDepth.GetWordNameForRegister

function TkwVcmToolbarGetGlyphColorDepth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvcmGlyphColordepth);
end;//TkwVcmToolbarGetGlyphColorDepth.GetResultTypeInfo

function TkwVcmToolbarGetGlyphColorDepth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmToolbarGetGlyphColorDepth.GetAllParamsCount

function TkwVcmToolbarGetGlyphColorDepth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmToolbarGetGlyphColorDepth.ParamsTypes

procedure TkwVcmToolbarGetGlyphColorDepth.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(Ord(vcm_Toolbar_GetGlyphColorDepth(aCtx)));
end;//TkwVcmToolbarGetGlyphColorDepth.DoDoIt

procedure TkwVcmToolbarSetGlyphColorDepth.vcm_Toolbar_SetGlyphColorDepth(const aCtx: TtfwContext;
 aValue: TvcmGlyphColordepth);
 {* Реализация слова скрипта vcm:Toolbar:SetGlyphColorDepth }
//#UC START# *552BC3BA003E_552BC3BA003E_Word_var*
//#UC END# *552BC3BA003E_552BC3BA003E_Word_var*
begin
//#UC START# *552BC3BA003E_552BC3BA003E_Word_impl*
 TvcmToolbarGlyphService.Instance.SetGlyphColorDepth(aValue);
//#UC END# *552BC3BA003E_552BC3BA003E_Word_impl*
end;//TkwVcmToolbarSetGlyphColorDepth.vcm_Toolbar_SetGlyphColorDepth

class function TkwVcmToolbarSetGlyphColorDepth.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Toolbar:SetGlyphColorDepth';
end;//TkwVcmToolbarSetGlyphColorDepth.GetWordNameForRegister

function TkwVcmToolbarSetGlyphColorDepth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmToolbarSetGlyphColorDepth.GetResultTypeInfo

function TkwVcmToolbarSetGlyphColorDepth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmToolbarSetGlyphColorDepth.GetAllParamsCount

function TkwVcmToolbarSetGlyphColorDepth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmGlyphColordepth)]);
end;//TkwVcmToolbarSetGlyphColorDepth.ParamsTypes

procedure TkwVcmToolbarSetGlyphColorDepth.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TvcmGlyphColordepth;
begin
 try
  l_aValue := TvcmGlyphColordepth(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TvcmGlyphColordepth : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_Toolbar_SetGlyphColorDepth(aCtx, l_aValue);
end;//TkwVcmToolbarSetGlyphColorDepth.DoDoIt

procedure TkwVcmToolbarButtonSetVisible.vcm_ToolbarButton_SetVisible(const aCtx: TtfwContext;
 const aUtName: AnsiString;
 const aTbName: AnsiString;
 const anEntityName: AnsiString;
 const anOpName: AnsiString;
 aVisible: Boolean);
 {* Реализация слова скрипта vcm:ToolbarButton:SetVisible }
//#UC START# *57BACA480334_57BACA480334_Word_var*
//#UC END# *57BACA480334_57BACA480334_Word_var*
begin
//#UC START# *57BACA480334_57BACA480334_Word_impl*
 vcmSaveToolbarAction(aUtName, aTbName, anEntityName, anOpName, aVisible);
//#UC END# *57BACA480334_57BACA480334_Word_impl*
end;//TkwVcmToolbarButtonSetVisible.vcm_ToolbarButton_SetVisible

class function TkwVcmToolbarButtonSetVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:ToolbarButton:SetVisible';
end;//TkwVcmToolbarButtonSetVisible.GetWordNameForRegister

function TkwVcmToolbarButtonSetVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmToolbarButtonSetVisible.GetResultTypeInfo

function TkwVcmToolbarButtonSetVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 5;
end;//TkwVcmToolbarButtonSetVisible.GetAllParamsCount

function TkwVcmToolbarButtonSetVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString, @tfw_tiString, TypeInfo(Boolean)]);
end;//TkwVcmToolbarButtonSetVisible.ParamsTypes

procedure TkwVcmToolbarButtonSetVisible.DoDoIt(const aCtx: TtfwContext);
var l_aUtName: AnsiString;
var l_aTbName: AnsiString;
var l_anEntityName: AnsiString;
var l_anOpName: AnsiString;
var l_aVisible: Boolean;
begin
 try
  l_aUtName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aUtName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTbName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTbName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anEntityName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anEntityName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOpName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOpName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aVisible := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisible: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_ToolbarButton_SetVisible(aCtx, l_aUtName, l_aTbName, l_anEntityName, l_anOpName, l_aVisible);
end;//TkwVcmToolbarButtonSetVisible.DoDoIt

initialization
 TkwVcmToolbarSetGlyphSize.RegisterInEngine;
 {* Регистрация vcm_Toolbar_SetGlyphSize }
 TkwVcmToolbarGetGlyphSize.RegisterInEngine;
 {* Регистрация vcm_Toolbar_GetGlyphSize }
 TkwVcmToolbarGetGlyphColorDepth.RegisterInEngine;
 {* Регистрация vcm_Toolbar_GetGlyphColorDepth }
 TkwVcmToolbarSetGlyphColorDepth.RegisterInEngine;
 {* Регистрация vcm_Toolbar_SetGlyphColorDepth }
 TkwVcmToolbarButtonSetVisible.RegisterInEngine;
 {* Регистрация vcm_ToolbarButton_SetVisible }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphSize));
 {* Регистрация типа TvcmGlyphSize }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphColordepth));
 {* Регистрация типа TvcmGlyphColordepth }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
