unit VGSceneWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VGSceneWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , VGSceneAndWinControlPack
 , VGComboBoxPack
 , vg_controls
 , Classes
 , vgObject
 , vg_objects
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *905837D55EDDci*
 //#UC END# *905837D55EDDci*
 //#UC START# *905837D55EDDcit*
 //#UC END# *905837D55EDDcit*
 TVGSceneWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *905837D55EDDpubl*
 //#UC END# *905837D55EDDpubl*
 end;//TVGSceneWordsPackResNameGetter

 TvgVisualObjectFriend = {abstract} class(TvgVisualObject)
  {* Друг для TvgVisualObject }
 end;//TvgVisualObjectFriend

 TkwVgControlVisible = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:Visible >>> l_Boolean
[code]  }
  private
   function vg_control_Visible(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Boolean;
    {* Реализация слова скрипта vg:control:Visible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlVisible

 TkwVgControlHeight = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Height >>> l_Integer
[code]  }
  private
   function vg_control_Height(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Height }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlHeight

 TkwVgControlWidth = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Width >>> l_Integer
[code]  }
  private
   function vg_control_Width(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Width }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlWidth

 TkwVgControlLeft = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Left >>> l_Integer
[code]  }
  private
   function vg_control_Left(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Left }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlLeft

 TkwVgControlTop = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Top >>> l_Integer
[code]  }
  private
   function vg_control_Top(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:Top }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlTop

 TkwVgControlEnabled = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:Enabled >>> l_Boolean
[code]  }
  private
   function vg_control_Enabled(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Boolean;
    {* Реализация слова скрипта vg:control:Enabled }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlEnabled

 TkwVgControlName = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aVisualObject vg:control:Name >>> l_String
[code]  }
  private
   function vg_control_Name(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): AnsiString;
    {* Реализация слова скрипта vg:control:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlName

 TkwVgControlClick = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Click
*Пример:*
[code]
 aVisualObject vg:control:Click
[code]  }
  private
   procedure vg_control_Click(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject);
    {* Реализация слова скрипта vg:control:Click }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlClick

 TkwVgControlCountSiblingLikeMe = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:CountSiblingLikeMe
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:CountSiblingLikeMe >>> l_Integer
[code]  }
  private
   function vg_control_CountSiblingLikeMe(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:CountSiblingLikeMe }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlCountSiblingLikeMe

 TkwVgControlGetIsChecked = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:GetIsChecked
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:GetIsChecked >>> l_Boolean
[code]  }
  private
   function vg_control_GetIsChecked(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Boolean;
    {* Реализация слова скрипта vg:control:GetIsChecked }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlGetIsChecked

 TkwVgControlSetIsChecked = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:SetIsChecked
*Пример:*
[code]
 aValue aVisualObject vg:control:SetIsChecked
[code]  }
  private
   procedure vg_control_SetIsChecked(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject;
    aValue: Boolean);
    {* Реализация слова скрипта vg:control:SetIsChecked }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlSetIsChecked

 TkwVgControlLeftInScene = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:LeftInScene
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:LeftInScene >>> l_Integer
[code]  }
  private
   function vg_control_LeftInScene(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:LeftInScene }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlLeftInScene

 TkwVgControlTopInScene = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:TopInScene
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:TopInScene >>> l_Integer
[code]  }
  private
   function vg_control_TopInScene(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): Integer;
    {* Реализация слова скрипта vg:control:TopInScene }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlTopInScene

 TkwVgControlScene = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Scene
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aVisualObject vg:control:Scene >>> l_TControl
[code]  }
  private
   function vg_control_Scene(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): TControl;
    {* Реализация слова скрипта vg:control:Scene }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlScene

 TkwVgControlText = {final} class(TtfwClassLike)
  {* Слово скрипта vg:control:Text
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aVisualObject vg:control:Text >>> l_String
[code]  }
  private
   function vg_control_Text(const aCtx: TtfwContext;
    aVisualObject: TvgVisualObject): AnsiString;
    {* Реализация слова скрипта vg:control:Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgControlText

class function TVGSceneWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'VGSceneWordsPack';
end;//TVGSceneWordsPackResNameGetter.ResName

 {$R VGSceneWordsPack.res}

function TkwVgControlVisible.vg_control_Visible(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Boolean;
 {* Реализация слова скрипта vg:control:Visible }
//#UC START# *99CDF025D5A5_89C786B088C6_var*
//#UC END# *99CDF025D5A5_89C786B088C6_var*
begin
//#UC START# *99CDF025D5A5_89C786B088C6_impl*
 Result := aVisualObject.CheckParentVisible
//#UC END# *99CDF025D5A5_89C786B088C6_impl*
end;//TkwVgControlVisible.vg_control_Visible

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

function TkwVgControlHeight.vg_control_Height(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Height }
//#UC START# *20F09B87AF2A_05A703B5907E_var*
//#UC END# *20F09B87AF2A_05A703B5907E_var*
begin
//#UC START# *20F09B87AF2A_05A703B5907E_impl*
 Result := Round(aVisualObject.Height);
//#UC END# *20F09B87AF2A_05A703B5907E_impl*
end;//TkwVgControlHeight.vg_control_Height

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

function TkwVgControlWidth.vg_control_Width(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Width }
//#UC START# *68ABF3A0E921_6D438B9C5A14_var*
//#UC END# *68ABF3A0E921_6D438B9C5A14_var*
begin
//#UC START# *68ABF3A0E921_6D438B9C5A14_impl*
 Result := Round(aVisualObject.Width)
//#UC END# *68ABF3A0E921_6D438B9C5A14_impl*
end;//TkwVgControlWidth.vg_control_Width

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

function TkwVgControlLeft.vg_control_Left(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Left }
//#UC START# *015BF6CE41DE_0ED393F18084_var*
//#UC END# *015BF6CE41DE_0ED393F18084_var*
begin
//#UC START# *015BF6CE41DE_0ED393F18084_impl*
 Result := Round(aVisualObject.Position.X)
//#UC END# *015BF6CE41DE_0ED393F18084_impl*
end;//TkwVgControlLeft.vg_control_Left

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

function TkwVgControlTop.vg_control_Top(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:Top }
//#UC START# *15CFF0C454F0_E4BF70016043_var*
//#UC END# *15CFF0C454F0_E4BF70016043_var*
begin
//#UC START# *15CFF0C454F0_E4BF70016043_impl*
 Result := Round(aVisualObject.Position.Y)
//#UC END# *15CFF0C454F0_E4BF70016043_impl*
end;//TkwVgControlTop.vg_control_Top

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

function TkwVgControlEnabled.vg_control_Enabled(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Boolean;
 {* Реализация слова скрипта vg:control:Enabled }
//#UC START# *7861C2BB2686_20CB200689C7_var*
//#UC END# *7861C2BB2686_20CB200689C7_var*
begin
//#UC START# *7861C2BB2686_20CB200689C7_impl*
 Result := aVisualObject.Enabled
//#UC END# *7861C2BB2686_20CB200689C7_impl*
end;//TkwVgControlEnabled.vg_control_Enabled

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

function TkwVgControlName.vg_control_Name(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): AnsiString;
 {* Реализация слова скрипта vg:control:Name }
//#UC START# *FEEF38963F97_F80A519316B5_var*
//#UC END# *FEEF38963F97_F80A519316B5_var*
begin
//#UC START# *FEEF38963F97_F80A519316B5_impl*
 Result := aVisualObject.Name
//#UC END# *FEEF38963F97_F80A519316B5_impl*
end;//TkwVgControlName.vg_control_Name

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

procedure TkwVgControlClick.vg_control_Click(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject);
 {* Реализация слова скрипта vg:control:Click }
//#UC START# *FCBA5E83A1C1_E94B273F03D9_var*
//#UC END# *FCBA5E83A1C1_E94B273F03D9_var*
begin
//#UC START# *FCBA5E83A1C1_E94B273F03D9_impl*
 with TvgVisualObjectFriend(aVisualObject) do
 begin
  MouseDown(mbLeft, [], 0, 0);
  MouseUp(mbLeft, [], 0, 0);
 end;//with TvgVisualObjectFriend(aVisualObject)
//#UC END# *FCBA5E83A1C1_E94B273F03D9_impl*
end;//TkwVgControlClick.vg_control_Click

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

function TkwVgControlCountSiblingLikeMe.vg_control_CountSiblingLikeMe(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:CountSiblingLikeMe }
//#UC START# *4724A104EB0C_8969D4FAAB14_var*
var
 l_Count : Integer;
 l_Index : Integer;
 l_Ow    : TComponent;
 l_C     : TComponent;
//#UC END# *4724A104EB0C_8969D4FAAB14_var*
begin
//#UC START# *4724A104EB0C_8969D4FAAB14_impl*
 l_Count := 0;
 l_Ow := aVisualObject.Owner;
 for l_Index := 0 to Pred(l_Ow.ComponentCount) do
 begin
  l_C := l_Ow.Components[l_Index];
  if l_C.InheritsFrom(aVisualObject.ClassType) then
   Inc(l_Count);
 end;//for l_Index
 Result := l_Count;
//#UC END# *4724A104EB0C_8969D4FAAB14_impl*
end;//TkwVgControlCountSiblingLikeMe.vg_control_CountSiblingLikeMe

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

function TkwVgControlGetIsChecked.vg_control_GetIsChecked(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Boolean;
 {* Реализация слова скрипта vg:control:GetIsChecked }
//#UC START# *351A7FD6B4C4_D3F9471133D7_var*
//#UC END# *351A7FD6B4C4_D3F9471133D7_var*
begin
//#UC START# *351A7FD6B4C4_D3F9471133D7_impl*
 Result := (aVisualObject As TvgRadioButton).IsChecked;
//#UC END# *351A7FD6B4C4_D3F9471133D7_impl*
end;//TkwVgControlGetIsChecked.vg_control_GetIsChecked

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

procedure TkwVgControlSetIsChecked.vg_control_SetIsChecked(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject;
 aValue: Boolean);
 {* Реализация слова скрипта vg:control:SetIsChecked }
//#UC START# *E83EB4C5B17F_5389853B1E01_var*
//#UC END# *E83EB4C5B17F_5389853B1E01_var*
begin
//#UC START# *E83EB4C5B17F_5389853B1E01_impl*
 (aVisualObject As TvgRadioButton).IsChecked := aValue;
//#UC END# *E83EB4C5B17F_5389853B1E01_impl*
end;//TkwVgControlSetIsChecked.vg_control_SetIsChecked

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

function TkwVgControlLeftInScene.vg_control_LeftInScene(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:LeftInScene }
//#UC START# *74951CD8B8BB_0B0F33EAEBDF_var*
var
 l_Left: Single;
 l_Obj: TvgObject;
//#UC END# *74951CD8B8BB_0B0F33EAEBDF_var*
begin
//#UC START# *74951CD8B8BB_0B0F33EAEBDF_impl*
 l_Left := aVisualObject.Position.X;
 l_Obj := aVisualObject;
 while Assigned(l_Obj.Parent) {and (anObject.Parent <> anObject.Scene)} do
 begin
  l_Obj := l_Obj.Parent;
  if l_Obj is TvgVisualObject then
   l_Left := TvgVisualObject(l_Obj).Position.X + l_Left;
 end;
 Result := Round(l_Left);
//#UC END# *74951CD8B8BB_0B0F33EAEBDF_impl*
end;//TkwVgControlLeftInScene.vg_control_LeftInScene

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

function TkwVgControlTopInScene.vg_control_TopInScene(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): Integer;
 {* Реализация слова скрипта vg:control:TopInScene }
//#UC START# *9772F92476AF_FFE6E88470A5_var*
var
 l_Top: Single;
 l_Obj: TvgObject;
//#UC END# *9772F92476AF_FFE6E88470A5_var*
begin
//#UC START# *9772F92476AF_FFE6E88470A5_impl*
 l_Top := aVisualObject.Position.Y;
 l_Obj := aVisualObject;
 while Assigned(l_Obj.Parent) {and (anObject.Parent <> anObject.Scene)} do
 begin
  l_Obj := l_Obj.Parent;
  if l_Obj is TvgVisualObject then
   l_Top := TvgVisualObject(l_Obj).Position.Y + l_Top;
 end;
 Result := Round(l_Top);
//#UC END# *9772F92476AF_FFE6E88470A5_impl*
end;//TkwVgControlTopInScene.vg_control_TopInScene

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

function TkwVgControlScene.vg_control_Scene(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): TControl;
 {* Реализация слова скрипта vg:control:Scene }
//#UC START# *05812BD7CDDB_E3230FB2D73B_var*
//#UC END# *05812BD7CDDB_E3230FB2D73B_var*
begin
//#UC START# *05812BD7CDDB_E3230FB2D73B_impl*
 Result := aVisualObject.Scene.GetSceneControl;
//#UC END# *05812BD7CDDB_E3230FB2D73B_impl*
end;//TkwVgControlScene.vg_control_Scene

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

function TkwVgControlText.vg_control_Text(const aCtx: TtfwContext;
 aVisualObject: TvgVisualObject): AnsiString;
 {* Реализация слова скрипта vg:control:Text }
//#UC START# *E164CC8FC765_BD648FBA9D21_var*
//#UC END# *E164CC8FC765_BD648FBA9D21_var*
begin
//#UC START# *E164CC8FC765_BD648FBA9D21_impl*
 if (aVisualObject is TvgTextControl) then
  Result := TvgTextControl(aVisualObject).Text
 else
 if (aVisualObject is TvgText) then
  Result := TvgText(aVisualObject).Text
 else
  Result := '';
//#UC END# *E164CC8FC765_BD648FBA9D21_impl*
end;//TkwVgControlText.vg_control_Text

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

initialization
 TVGSceneWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgVisualObject));
 {* Регистрация типа TvgVisualObject }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
 {* Регистрация типа TControl }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

end.
