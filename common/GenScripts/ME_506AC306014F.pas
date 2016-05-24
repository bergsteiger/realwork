unit VGSceneWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VGSceneWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "VGSceneWordsPack" MUID: (506AC306014F)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vgVisualObject
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwAxiomaticsResNameGetter
 , VGSceneAndWinControlPack
 , VGComboBoxPack
 , vg_controls
 , Classes
 , vgObject
 , vg_objects
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TvgVisualObjectFriend = {abstract} class(TvgVisualObject)
  {* Друг к классу TvgVisualObject }
 end;//TvgVisualObjectFriend

 TkwVgControlVisible = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Visible }
  private
   function vg_control_Visible(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Boolean;
    {* Реализация слова скрипта vg:control:Visible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlVisible

 TkwVgControlHeight = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Height }
  private
   function vg_control_Height(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Height }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlHeight

 TkwVgControlWidth = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Width }
  private
   function vg_control_Width(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Width }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlWidth

 TkwVgControlLeft = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Left }
  private
   function vg_control_Left(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Left }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlLeft

 TkwVgControlTop = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Top }
  private
   function vg_control_Top(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Top }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlTop

 TkwVgControlEnabled = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Enabled }
  private
   function vg_control_Enabled(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Boolean;
    {* Реализация слова скрипта vg:control:Enabled }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlEnabled

 TkwVgControlName = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Name }
  private
   function vg_control_Name(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): AnsiString;
    {* Реализация слова скрипта vg:control:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlName

 TkwVgControlClick = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Click }
  private
   procedure vg_control_Click(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject);
    {* Реализация слова скрипта vg:control:Click }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlClick

 TkwVgControlCountSiblingLikeMe = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:CountSiblingLikeMe }
  private
   function vg_control_CountSiblingLikeMe(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:CountSiblingLikeMe }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlCountSiblingLikeMe

 TkwVgControlGetIsChecked = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:GetIsChecked }
  private
   function vg_control_GetIsChecked(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Boolean;
    {* Реализация слова скрипта vg:control:GetIsChecked }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlGetIsChecked

 TkwVgControlSetIsChecked = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:SetIsChecked }
  private
   procedure vg_control_SetIsChecked(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject;
    aValue: Boolean);
    {* Реализация слова скрипта vg:control:SetIsChecked }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlSetIsChecked

 TkwVgControlLeftInScene = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:LeftInScene }
  private
   function vg_control_LeftInScene(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:LeftInScene }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlLeftInScene

 TkwVgControlTopInScene = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:TopInScene }
  private
   function vg_control_TopInScene(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:TopInScene }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlTopInScene

 TkwVgControlScene = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Scene }
  private
   function vg_control_Scene(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): TControl;
    {* Реализация слова скрипта vg:control:Scene }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlScene

 TkwVgControlText = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Text }
  private
   function vg_control_Text(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): AnsiString;
    {* Реализация слова скрипта vg:control:Text }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlText

 TVGSceneWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TVGSceneWordsPackResNameGetter

function TkwVgControlVisible.vg_control_Visible(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Boolean;
 {* Реализация слова скрипта vg:control:Visible }
//#UC START# *551D4CAA00E9_551D4CAA00E9_4D49562A01B7_Word_var*
//#UC END# *551D4CAA00E9_551D4CAA00E9_4D49562A01B7_Word_var*
begin
//#UC START# *551D4CAA00E9_551D4CAA00E9_4D49562A01B7_Word_impl*
 Result := aVisualObject.CheckParentVisible
//#UC END# *551D4CAA00E9_551D4CAA00E9_4D49562A01B7_Word_impl*
end;//TkwVgControlVisible.vg_control_Visible

class function TkwVgControlVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Visible';
end;//TkwVgControlVisible.GetWordNameForRegister

function TkwVgControlVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwVgControlVisible.GetResultTypeInfo

function TkwVgControlVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlVisible.GetAllParamsCount

function TkwVgControlVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlVisible.ParamsTypes

procedure TkwVgControlVisible.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(vg_control_Visible(aCtx, l_aVisualObject));
end;//TkwVgControlVisible.DoDoIt

function TkwVgControlHeight.vg_control_Height(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Height }
//#UC START# *551D4CCD0130_551D4CCD0130_4D49562A01B7_Word_var*
//#UC END# *551D4CCD0130_551D4CCD0130_4D49562A01B7_Word_var*
begin
//#UC START# *551D4CCD0130_551D4CCD0130_4D49562A01B7_Word_impl*
 Result := Round(aVisualObject.Height);
//#UC END# *551D4CCD0130_551D4CCD0130_4D49562A01B7_Word_impl*
end;//TkwVgControlHeight.vg_control_Height

class function TkwVgControlHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Height';
end;//TkwVgControlHeight.GetWordNameForRegister

function TkwVgControlHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgControlHeight.GetResultTypeInfo

function TkwVgControlHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlHeight.GetAllParamsCount

function TkwVgControlHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlHeight.ParamsTypes

procedure TkwVgControlHeight.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_control_Height(aCtx, l_aVisualObject));
end;//TkwVgControlHeight.DoDoIt

function TkwVgControlWidth.vg_control_Width(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Width }
//#UC START# *551D4CF10224_551D4CF10224_4D49562A01B7_Word_var*
//#UC END# *551D4CF10224_551D4CF10224_4D49562A01B7_Word_var*
begin
//#UC START# *551D4CF10224_551D4CF10224_4D49562A01B7_Word_impl*
 Result := Round(aVisualObject.Width)
//#UC END# *551D4CF10224_551D4CF10224_4D49562A01B7_Word_impl*
end;//TkwVgControlWidth.vg_control_Width

class function TkwVgControlWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Width';
end;//TkwVgControlWidth.GetWordNameForRegister

function TkwVgControlWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgControlWidth.GetResultTypeInfo

function TkwVgControlWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlWidth.GetAllParamsCount

function TkwVgControlWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlWidth.ParamsTypes

procedure TkwVgControlWidth.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_control_Width(aCtx, l_aVisualObject));
end;//TkwVgControlWidth.DoDoIt

function TkwVgControlLeft.vg_control_Left(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Left }
//#UC START# *551D4CFE03AD_551D4CFE03AD_4D49562A01B7_Word_var*
//#UC END# *551D4CFE03AD_551D4CFE03AD_4D49562A01B7_Word_var*
begin
//#UC START# *551D4CFE03AD_551D4CFE03AD_4D49562A01B7_Word_impl*
 Result := Round(aVisualObject.Position.X)
//#UC END# *551D4CFE03AD_551D4CFE03AD_4D49562A01B7_Word_impl*
end;//TkwVgControlLeft.vg_control_Left

class function TkwVgControlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Left';
end;//TkwVgControlLeft.GetWordNameForRegister

function TkwVgControlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgControlLeft.GetResultTypeInfo

function TkwVgControlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlLeft.GetAllParamsCount

function TkwVgControlLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlLeft.ParamsTypes

procedure TkwVgControlLeft.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_control_Left(aCtx, l_aVisualObject));
end;//TkwVgControlLeft.DoDoIt

function TkwVgControlTop.vg_control_Top(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Top }
//#UC START# *551D4D1002FD_551D4D1002FD_4D49562A01B7_Word_var*
//#UC END# *551D4D1002FD_551D4D1002FD_4D49562A01B7_Word_var*
begin
//#UC START# *551D4D1002FD_551D4D1002FD_4D49562A01B7_Word_impl*
 Result := Round(aVisualObject.Position.Y)
//#UC END# *551D4D1002FD_551D4D1002FD_4D49562A01B7_Word_impl*
end;//TkwVgControlTop.vg_control_Top

class function TkwVgControlTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Top';
end;//TkwVgControlTop.GetWordNameForRegister

function TkwVgControlTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgControlTop.GetResultTypeInfo

function TkwVgControlTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlTop.GetAllParamsCount

function TkwVgControlTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlTop.ParamsTypes

procedure TkwVgControlTop.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_control_Top(aCtx, l_aVisualObject));
end;//TkwVgControlTop.DoDoIt

function TkwVgControlEnabled.vg_control_Enabled(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Boolean;
 {* Реализация слова скрипта vg:control:Enabled }
//#UC START# *551D4D2101E1_551D4D2101E1_4D49562A01B7_Word_var*
//#UC END# *551D4D2101E1_551D4D2101E1_4D49562A01B7_Word_var*
begin
//#UC START# *551D4D2101E1_551D4D2101E1_4D49562A01B7_Word_impl*
 Result := aVisualObject.Enabled
//#UC END# *551D4D2101E1_551D4D2101E1_4D49562A01B7_Word_impl*
end;//TkwVgControlEnabled.vg_control_Enabled

class function TkwVgControlEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Enabled';
end;//TkwVgControlEnabled.GetWordNameForRegister

function TkwVgControlEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwVgControlEnabled.GetResultTypeInfo

function TkwVgControlEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlEnabled.GetAllParamsCount

function TkwVgControlEnabled.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlEnabled.ParamsTypes

procedure TkwVgControlEnabled.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(vg_control_Enabled(aCtx, l_aVisualObject));
end;//TkwVgControlEnabled.DoDoIt

function TkwVgControlName.vg_control_Name(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): AnsiString;
 {* Реализация слова скрипта vg:control:Name }
//#UC START# *551D4D30029E_551D4D30029E_4D49562A01B7_Word_var*
//#UC END# *551D4D30029E_551D4D30029E_4D49562A01B7_Word_var*
begin
//#UC START# *551D4D30029E_551D4D30029E_4D49562A01B7_Word_impl*
 Result := aVisualObject.Name
//#UC END# *551D4D30029E_551D4D30029E_4D49562A01B7_Word_impl*
end;//TkwVgControlName.vg_control_Name

class function TkwVgControlName.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Name';
end;//TkwVgControlName.GetWordNameForRegister

function TkwVgControlName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwVgControlName.GetResultTypeInfo

function TkwVgControlName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlName.GetAllParamsCount

function TkwVgControlName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlName.ParamsTypes

procedure TkwVgControlName.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(vg_control_Name(aCtx, l_aVisualObject));
end;//TkwVgControlName.DoDoIt

procedure TkwVgControlClick.vg_control_Click(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject);
 {* Реализация слова скрипта vg:control:Click }
//#UC START# *551D4D56027F_551D4D56027F_4D49562A01B7_Word_var*
//#UC END# *551D4D56027F_551D4D56027F_4D49562A01B7_Word_var*
begin
//#UC START# *551D4D56027F_551D4D56027F_4D49562A01B7_Word_impl*
 with TvgVisualObjectFriend(aVisualObject) do
 begin
  MouseDown(mbLeft, [], 0, 0);
  MouseUp(mbLeft, [], 0, 0);
 end;//with TvgVisualObjectFriend(aVisualObject)
//#UC END# *551D4D56027F_551D4D56027F_4D49562A01B7_Word_impl*
end;//TkwVgControlClick.vg_control_Click

class function TkwVgControlClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Click';
end;//TkwVgControlClick.GetWordNameForRegister

function TkwVgControlClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVgControlClick.GetResultTypeInfo

function TkwVgControlClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlClick.GetAllParamsCount

function TkwVgControlClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlClick.ParamsTypes

procedure TkwVgControlClick.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vg_control_Click(aCtx, l_aVisualObject);
end;//TkwVgControlClick.DoDoIt

function TkwVgControlCountSiblingLikeMe.vg_control_CountSiblingLikeMe(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:CountSiblingLikeMe }
//#UC START# *551D4D910121_551D4D910121_4D49562A01B7_Word_var*
var
 l_Count : Integer;
 l_Index : Integer;
 l_Ow    : TComponent;
 l_C     : TComponent;
//#UC END# *551D4D910121_551D4D910121_4D49562A01B7_Word_var*
begin
//#UC START# *551D4D910121_551D4D910121_4D49562A01B7_Word_impl*
 l_Count := 0;
 l_Ow := aVisualObject.Owner;
 for l_Index := 0 to Pred(l_Ow.ComponentCount) do
 begin
  l_C := l_Ow.Components[l_Index];
  if l_C.InheritsFrom(aVisualObject.ClassType) then
   Inc(l_Count);
 end;//for l_Index
 Result := l_Count;
//#UC END# *551D4D910121_551D4D910121_4D49562A01B7_Word_impl*
end;//TkwVgControlCountSiblingLikeMe.vg_control_CountSiblingLikeMe

class function TkwVgControlCountSiblingLikeMe.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:CountSiblingLikeMe';
end;//TkwVgControlCountSiblingLikeMe.GetWordNameForRegister

function TkwVgControlCountSiblingLikeMe.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgControlCountSiblingLikeMe.GetResultTypeInfo

function TkwVgControlCountSiblingLikeMe.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlCountSiblingLikeMe.GetAllParamsCount

function TkwVgControlCountSiblingLikeMe.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlCountSiblingLikeMe.ParamsTypes

procedure TkwVgControlCountSiblingLikeMe.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_control_CountSiblingLikeMe(aCtx, l_aVisualObject));
end;//TkwVgControlCountSiblingLikeMe.DoDoIt

function TkwVgControlGetIsChecked.vg_control_GetIsChecked(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Boolean;
 {* Реализация слова скрипта vg:control:GetIsChecked }
//#UC START# *551D4DB90078_551D4DB90078_4D49562A01B7_Word_var*
//#UC END# *551D4DB90078_551D4DB90078_4D49562A01B7_Word_var*
begin
//#UC START# *551D4DB90078_551D4DB90078_4D49562A01B7_Word_impl*
 Result := (aVisualObject As TvgRadioButton).IsChecked;
//#UC END# *551D4DB90078_551D4DB90078_4D49562A01B7_Word_impl*
end;//TkwVgControlGetIsChecked.vg_control_GetIsChecked

class function TkwVgControlGetIsChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:GetIsChecked';
end;//TkwVgControlGetIsChecked.GetWordNameForRegister

function TkwVgControlGetIsChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwVgControlGetIsChecked.GetResultTypeInfo

function TkwVgControlGetIsChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlGetIsChecked.GetAllParamsCount

function TkwVgControlGetIsChecked.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlGetIsChecked.ParamsTypes

procedure TkwVgControlGetIsChecked.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(vg_control_GetIsChecked(aCtx, l_aVisualObject));
end;//TkwVgControlGetIsChecked.DoDoIt

procedure TkwVgControlSetIsChecked.vg_control_SetIsChecked(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject;
 aValue: Boolean);
 {* Реализация слова скрипта vg:control:SetIsChecked }
//#UC START# *551D4DC601EC_551D4DC601EC_4D49562A01B7_Word_var*
//#UC END# *551D4DC601EC_551D4DC601EC_4D49562A01B7_Word_var*
begin
//#UC START# *551D4DC601EC_551D4DC601EC_4D49562A01B7_Word_impl*
 (aVisualObject As TvgRadioButton).IsChecked := aValue;
//#UC END# *551D4DC601EC_551D4DC601EC_4D49562A01B7_Word_impl*
end;//TkwVgControlSetIsChecked.vg_control_SetIsChecked

class function TkwVgControlSetIsChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:SetIsChecked';
end;//TkwVgControlSetIsChecked.GetWordNameForRegister

function TkwVgControlSetIsChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVgControlSetIsChecked.GetResultTypeInfo

function TkwVgControlSetIsChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwVgControlSetIsChecked.GetAllParamsCount

function TkwVgControlSetIsChecked.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject), TypeInfo(Boolean)]);
end;//TkwVgControlSetIsChecked.ParamsTypes

procedure TkwVgControlSetIsChecked.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
var l_aValue: Boolean;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vg_control_SetIsChecked(aCtx, l_aVisualObject, l_aValue);
end;//TkwVgControlSetIsChecked.DoDoIt

function TkwVgControlLeftInScene.vg_control_LeftInScene(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:LeftInScene }
//#UC START# *551D4DEF0359_551D4DEF0359_4D49562A01B7_Word_var*
var
 l_Left: Single;
 l_Obj: TvgObject;
//#UC END# *551D4DEF0359_551D4DEF0359_4D49562A01B7_Word_var*
begin
//#UC START# *551D4DEF0359_551D4DEF0359_4D49562A01B7_Word_impl*
 l_Left := aVisualObject.Position.X;
 l_Obj := aVisualObject;
 while Assigned(l_Obj.Parent) {and (anObject.Parent <> anObject.Scene)} do
 begin
  l_Obj := l_Obj.Parent;
  if l_Obj is TvgVisualObject then
   l_Left := TvgVisualObject(l_Obj).Position.X + l_Left;
 end;
 Result := Round(l_Left);
//#UC END# *551D4DEF0359_551D4DEF0359_4D49562A01B7_Word_impl*
end;//TkwVgControlLeftInScene.vg_control_LeftInScene

class function TkwVgControlLeftInScene.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:LeftInScene';
end;//TkwVgControlLeftInScene.GetWordNameForRegister

function TkwVgControlLeftInScene.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgControlLeftInScene.GetResultTypeInfo

function TkwVgControlLeftInScene.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlLeftInScene.GetAllParamsCount

function TkwVgControlLeftInScene.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlLeftInScene.ParamsTypes

procedure TkwVgControlLeftInScene.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_control_LeftInScene(aCtx, l_aVisualObject));
end;//TkwVgControlLeftInScene.DoDoIt

function TkwVgControlTopInScene.vg_control_TopInScene(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:TopInScene }
//#UC START# *551D4E00011A_551D4E00011A_4D49562A01B7_Word_var*
var
 l_Top: Single;
 l_Obj: TvgObject;
//#UC END# *551D4E00011A_551D4E00011A_4D49562A01B7_Word_var*
begin
//#UC START# *551D4E00011A_551D4E00011A_4D49562A01B7_Word_impl*
 l_Top := aVisualObject.Position.Y;
 l_Obj := aVisualObject;
 while Assigned(l_Obj.Parent) {and (anObject.Parent <> anObject.Scene)} do
 begin
  l_Obj := l_Obj.Parent;
  if l_Obj is TvgVisualObject then
   l_Top := TvgVisualObject(l_Obj).Position.Y + l_Top;
 end;
 Result := Round(l_Top);
//#UC END# *551D4E00011A_551D4E00011A_4D49562A01B7_Word_impl*
end;//TkwVgControlTopInScene.vg_control_TopInScene

class function TkwVgControlTopInScene.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:TopInScene';
end;//TkwVgControlTopInScene.GetWordNameForRegister

function TkwVgControlTopInScene.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVgControlTopInScene.GetResultTypeInfo

function TkwVgControlTopInScene.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlTopInScene.GetAllParamsCount

function TkwVgControlTopInScene.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlTopInScene.ParamsTypes

procedure TkwVgControlTopInScene.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vg_control_TopInScene(aCtx, l_aVisualObject));
end;//TkwVgControlTopInScene.DoDoIt

function TkwVgControlScene.vg_control_Scene(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): TControl;
 {* Реализация слова скрипта vg:control:Scene }
//#UC START# *551D4E320027_551D4E320027_4D49562A01B7_Word_var*
//#UC END# *551D4E320027_551D4E320027_4D49562A01B7_Word_var*
begin
//#UC START# *551D4E320027_551D4E320027_4D49562A01B7_Word_impl*
 Result := aVisualObject.Scene.GetSceneControl;
//#UC END# *551D4E320027_551D4E320027_4D49562A01B7_Word_impl*
end;//TkwVgControlScene.vg_control_Scene

class function TkwVgControlScene.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Scene';
end;//TkwVgControlScene.GetWordNameForRegister

function TkwVgControlScene.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwVgControlScene.GetResultTypeInfo

function TkwVgControlScene.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlScene.GetAllParamsCount

function TkwVgControlScene.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlScene.ParamsTypes

procedure TkwVgControlScene.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vg_control_Scene(aCtx, l_aVisualObject));
end;//TkwVgControlScene.DoDoIt

function TkwVgControlText.vg_control_Text(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): AnsiString;
 {* Реализация слова скрипта vg:control:Text }
//#UC START# *551D538A00B4_551D538A00B4_4D49562A01B7_Word_var*
//#UC END# *551D538A00B4_551D538A00B4_4D49562A01B7_Word_var*
begin
//#UC START# *551D538A00B4_551D538A00B4_4D49562A01B7_Word_impl*
 if (aVisualObject is TvgTextControl) then
  Result := TvgTextControl(aVisualObject).Text
 else
 if (aVisualObject is TvgText) then
  Result := TvgText(aVisualObject).Text
 else
  Result := '';
//#UC END# *551D538A00B4_551D538A00B4_4D49562A01B7_Word_impl*
end;//TkwVgControlText.vg_control_Text

class function TkwVgControlText.GetWordNameForRegister: AnsiString;
begin
 Result := 'vg:control:Text';
end;//TkwVgControlText.GetWordNameForRegister

function TkwVgControlText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwVgControlText.GetResultTypeInfo

function TkwVgControlText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVgControlText.GetAllParamsCount

function TkwVgControlText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgVisualObject)]);
end;//TkwVgControlText.ParamsTypes

procedure TkwVgControlText.DoDoIt(const aCtx: TtfwContext);
var l_aVisualObject: TvgVisualObject;
begin
 try
  l_aVisualObject := TvgVisualObject(aCtx.rEngine.PopObjAs(TvgVisualObject));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVisualObject: TvgVisualObject : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(vg_control_Text(aCtx, l_aVisualObject));
end;//TkwVgControlText.DoDoIt

class function TVGSceneWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'VGSceneWordsPack';
end;//TVGSceneWordsPackResNameGetter.ResName

{$R VGSceneWordsPack.res}

initialization
 TkwVgControlVisible.RegisterInEngine;
 {* Регистрация vg_control_Visible }
 TkwVgControlHeight.RegisterInEngine;
 {* Регистрация vg_control_Height }
 TkwVgControlWidth.RegisterInEngine;
 {* Регистрация vg_control_Width }
 TkwVgControlLeft.RegisterInEngine;
 {* Регистрация vg_control_Left }
 TkwVgControlTop.RegisterInEngine;
 {* Регистрация vg_control_Top }
 TkwVgControlEnabled.RegisterInEngine;
 {* Регистрация vg_control_Enabled }
 TkwVgControlName.RegisterInEngine;
 {* Регистрация vg_control_Name }
 TkwVgControlClick.RegisterInEngine;
 {* Регистрация vg_control_Click }
 TkwVgControlCountSiblingLikeMe.RegisterInEngine;
 {* Регистрация vg_control_CountSiblingLikeMe }
 TkwVgControlGetIsChecked.RegisterInEngine;
 {* Регистрация vg_control_GetIsChecked }
 TkwVgControlSetIsChecked.RegisterInEngine;
 {* Регистрация vg_control_SetIsChecked }
 TkwVgControlLeftInScene.RegisterInEngine;
 {* Регистрация vg_control_LeftInScene }
 TkwVgControlTopInScene.RegisterInEngine;
 {* Регистрация vg_control_TopInScene }
 TkwVgControlScene.RegisterInEngine;
 {* Регистрация vg_control_Scene }
 TkwVgControlText.RegisterInEngine;
 {* Регистрация vg_control_Text }
 TVGSceneWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgVisualObject));
 {* Регистрация типа TvgVisualObject }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
 {* Регистрация типа TControl }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

end.
