unit VCMApllicationSettingsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$VCM"
// ������: "VCMApllicationSettingsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VCM::VCMFormsProcessing::VCMApllicationSettingsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmMenuManager,
  vcmToolbarMenuRes,
  tfwScriptingInterfaces,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwVcmToolbarSetGlyphSize = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:SetGlyphSize
*������:*
[code]
 aValue vcm:Toolbar:SetGlyphSize
[code]  }
 private
 // private methods
   procedure VcmToolbarSetGlyphSize(const aCtx: TtfwContext;
    aValue: TvcmGlyphSize);
     {* ���������� ����� ������� vcm:Toolbar:SetGlyphSize }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphSize

// start class TkwVcmToolbarSetGlyphSize

procedure TkwVcmToolbarSetGlyphSize.VcmToolbarSetGlyphSize(const aCtx: TtfwContext;
  aValue: TvcmGlyphSize);
//#UC START# *3E6A2A4DD8C9_4463E51B5CE8_var*
//#UC END# *3E6A2A4DD8C9_4463E51B5CE8_var*
begin
//#UC START# *3E6A2A4DD8C9_4463E51B5CE8_impl*
 TvcmToolbarGlyphService.Instance.SetGlyphSize(aValue);
//#UC END# *3E6A2A4DD8C9_4463E51B5CE8_impl*
end;//TkwVcmToolbarSetGlyphSize.VcmToolbarSetGlyphSize

procedure TkwVcmToolbarSetGlyphSize.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : TvcmGlyphSize;
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
 VcmToolbarSetGlyphSize(aCtx, l_aValue);
end;//TkwVcmToolbarSetGlyphSize.DoDoIt

class function TkwVcmToolbarSetGlyphSize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Toolbar:SetGlyphSize';
end;//TkwVcmToolbarSetGlyphSize.GetWordNameForRegister

function TkwVcmToolbarSetGlyphSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmToolbarSetGlyphSize.GetResultTypeInfo

function TkwVcmToolbarSetGlyphSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVcmToolbarSetGlyphSize.GetAllParamsCount

function TkwVcmToolbarSetGlyphSize.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmGlyphSize)]);
end;//TkwVcmToolbarSetGlyphSize.ParamsTypes

type
 TkwVcmToolbarGetGlyphSize = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:GetGlyphSize
*��� ����������:* TvcmGlyphSize
*������:*
[code]
TvcmGlyphSize VAR l_TvcmGlyphSize
 vcm:Toolbar:GetGlyphSize >>> l_TvcmGlyphSize
[code]  }
 private
 // private methods
   function VcmToolbarGetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
     {* ���������� ����� ������� vcm:Toolbar:GetGlyphSize }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphSize

// start class TkwVcmToolbarGetGlyphSize

function TkwVcmToolbarGetGlyphSize.VcmToolbarGetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
//#UC START# *0D29944D7496_CB878D8D1F92_var*
//#UC END# *0D29944D7496_CB878D8D1F92_var*
begin
//#UC START# *0D29944D7496_CB878D8D1F92_impl*
 Result := TvcmToolbarGlyphService.Instance.GetGlyphSize;
//#UC END# *0D29944D7496_CB878D8D1F92_impl*
end;//TkwVcmToolbarGetGlyphSize.VcmToolbarGetGlyphSize

procedure TkwVcmToolbarGetGlyphSize.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt(Ord(VcmToolbarGetGlyphSize(aCtx)));
end;//TkwVcmToolbarGetGlyphSize.DoDoIt

class function TkwVcmToolbarGetGlyphSize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Toolbar:GetGlyphSize';
end;//TkwVcmToolbarGetGlyphSize.GetWordNameForRegister

function TkwVcmToolbarGetGlyphSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvcmGlyphSize);
end;//TkwVcmToolbarGetGlyphSize.GetResultTypeInfo

function TkwVcmToolbarGetGlyphSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmToolbarGetGlyphSize.GetAllParamsCount

function TkwVcmToolbarGetGlyphSize.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmToolbarGetGlyphSize.ParamsTypes

type
 TkwVcmToolbarGetGlyphColorDepth = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:GetGlyphColorDepth
*��� ����������:* TvcmGlyphColordepth
*������:*
[code]
TvcmGlyphColordepth VAR l_TvcmGlyphColordepth
 vcm:Toolbar:GetGlyphColorDepth >>> l_TvcmGlyphColordepth
[code]  }
 private
 // private methods
   function VcmToolbarGetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
     {* ���������� ����� ������� vcm:Toolbar:GetGlyphColorDepth }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarGetGlyphColorDepth

// start class TkwVcmToolbarGetGlyphColorDepth

function TkwVcmToolbarGetGlyphColorDepth.VcmToolbarGetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
//#UC START# *5358A0B19EFE_8FA6E0CDB066_var*
//#UC END# *5358A0B19EFE_8FA6E0CDB066_var*
begin
//#UC START# *5358A0B19EFE_8FA6E0CDB066_impl*
 Result := TvcmToolbarGlyphService.Instance.GetGlyphColordepth;
//#UC END# *5358A0B19EFE_8FA6E0CDB066_impl*
end;//TkwVcmToolbarGetGlyphColorDepth.VcmToolbarGetGlyphColorDepth

procedure TkwVcmToolbarGetGlyphColorDepth.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt(Ord(VcmToolbarGetGlyphColorDepth(aCtx)));
end;//TkwVcmToolbarGetGlyphColorDepth.DoDoIt

class function TkwVcmToolbarGetGlyphColorDepth.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Toolbar:GetGlyphColorDepth';
end;//TkwVcmToolbarGetGlyphColorDepth.GetWordNameForRegister

function TkwVcmToolbarGetGlyphColorDepth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvcmGlyphColordepth);
end;//TkwVcmToolbarGetGlyphColorDepth.GetResultTypeInfo

function TkwVcmToolbarGetGlyphColorDepth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmToolbarGetGlyphColorDepth.GetAllParamsCount

function TkwVcmToolbarGetGlyphColorDepth.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmToolbarGetGlyphColorDepth.ParamsTypes

type
 TkwVcmToolbarSetGlyphColorDepth = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:SetGlyphColorDepth
*������:*
[code]
 aValue vcm:Toolbar:SetGlyphColorDepth
[code]  }
 private
 // private methods
   procedure VcmToolbarSetGlyphColorDepth(const aCtx: TtfwContext;
    aValue: TvcmGlyphColordepth);
     {* ���������� ����� ������� vcm:Toolbar:SetGlyphColorDepth }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmToolbarSetGlyphColorDepth

// start class TkwVcmToolbarSetGlyphColorDepth

procedure TkwVcmToolbarSetGlyphColorDepth.VcmToolbarSetGlyphColorDepth(const aCtx: TtfwContext;
  aValue: TvcmGlyphColordepth);
//#UC START# *47BBC580F855_2E579942A814_var*
//#UC END# *47BBC580F855_2E579942A814_var*
begin
//#UC START# *47BBC580F855_2E579942A814_impl*
 TvcmToolbarGlyphService.Instance.SetGlyphColorDepth(aValue);
//#UC END# *47BBC580F855_2E579942A814_impl*
end;//TkwVcmToolbarSetGlyphColorDepth.VcmToolbarSetGlyphColorDepth

procedure TkwVcmToolbarSetGlyphColorDepth.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : TvcmGlyphColordepth;
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
 VcmToolbarSetGlyphColorDepth(aCtx, l_aValue);
end;//TkwVcmToolbarSetGlyphColorDepth.DoDoIt

class function TkwVcmToolbarSetGlyphColorDepth.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Toolbar:SetGlyphColorDepth';
end;//TkwVcmToolbarSetGlyphColorDepth.GetWordNameForRegister

function TkwVcmToolbarSetGlyphColorDepth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmToolbarSetGlyphColorDepth.GetResultTypeInfo

function TkwVcmToolbarSetGlyphColorDepth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVcmToolbarSetGlyphColorDepth.GetAllParamsCount

function TkwVcmToolbarSetGlyphColorDepth.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmGlyphColordepth)]);
end;//TkwVcmToolbarSetGlyphColorDepth.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_Toolbar_SetGlyphSize
 TkwVcmToolbarSetGlyphSize.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_Toolbar_GetGlyphSize
 TkwVcmToolbarGetGlyphSize.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_Toolbar_GetGlyphColorDepth
 TkwVcmToolbarGetGlyphColorDepth.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� vcm_Toolbar_SetGlyphColorDepth
 TkwVcmToolbarSetGlyphColorDepth.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvcmGlyphSize
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphSize));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvcmGlyphColordepth
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmGlyphColordepth));
{$IfEnd} //not NoScripts AND not NoVCM

end.