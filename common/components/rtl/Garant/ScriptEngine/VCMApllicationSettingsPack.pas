unit VCMApllicationSettingsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\VCMApllicationSettingsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "VCMApllicationSettingsPack" MUID: (552BAE9B027D)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwVcmToolbarSetGlyphSize = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:SetGlyphSize }
  private
   procedure vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
    aValue: TvcmGlyphSize);
    {* ���������� ����� ������� vcm:Toolbar:SetGlyphSize }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphSize

 TkwVcmToolbarGetGlyphSize = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:GetGlyphSize }
  private
   function vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
    {* ���������� ����� ������� vcm:Toolbar:GetGlyphSize }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphSize

 TkwVcmToolbarGetGlyphColorDepth = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:GetGlyphColorDepth }
  private
   function vcm_Toolbar_GetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
    {* ���������� ����� ������� vcm:Toolbar:GetGlyphColorDepth }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphColorDepth

 TkwVcmToolbarSetGlyphColorDepth = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:SetGlyphColorDepth }
  private
   procedure vcm_Toolbar_SetGlyphColorDepth(const aCtx: TtfwContext;
    aValue: TvcmGlyphColordepth);
    {* ���������� ����� ������� vcm:Toolbar:SetGlyphColorDepth }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphColorDepth

procedure TkwVcmToolbarSetGlyphSize.vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
 aValue: TvcmGlyphSize);
 {* ���������� ����� ������� vcm:Toolbar:SetGlyphSize }
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
   RunnerError('������ ��� ��������� ��������� aValue: TvcmGlyphSize : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_Toolbar_SetGlyphSize(aCtx, l_aValue);
end;//TkwVcmToolbarSetGlyphSize.DoDoIt

function TkwVcmToolbarGetGlyphSize.vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
 {* ���������� ����� ������� vcm:Toolbar:GetGlyphSize }
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
 {* ���������� ����� ������� vcm:Toolbar:GetGlyphColorDepth }
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
 {* ���������� ����� ������� vcm:Toolbar:SetGlyphColorDepth }
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
   RunnerError('������ ��� ��������� ��������� aValue: TvcmGlyphColordepth : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_Toolbar_SetGlyphColorDepth(aCtx, l_aValue);
end;//TkwVcmToolbarSetGlyphColorDepth.DoDoIt

initialization
 TkwVcmToolbarSetGlyphSize.RegisterInEngine;
 {* ����������� vcm_Toolbar_SetGlyphSize }
 TkwVcmToolbarGetGlyphSize.RegisterInEngine;
 {* ����������� vcm_Toolbar_GetGlyphSize }
 TkwVcmToolbarGetGlyphColorDepth.RegisterInEngine;
 {* ����������� vcm_Toolbar_GetGlyphColorDepth }
 TkwVcmToolbarSetGlyphColorDepth.RegisterInEngine;
 {* ����������� vcm_Toolbar_SetGlyphColorDepth }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphSize));
 {* ����������� ���� TvcmGlyphSize }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphColordepth));
 {* ����������� ���� TvcmGlyphColordepth }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
