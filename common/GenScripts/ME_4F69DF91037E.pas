unit ControlsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ControlsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Controls
 , Graphics
 , l3Interfaces
 , Types
 , Menus
 , Forms
 , Windows
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwRegisterableWord
 , tfwPropertyLike
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , kwBynameControlPush
 , Messages
 , l3PopupMenuHelper
 , l3FormsService
 , l3ControlFontService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TControlFriend = {abstract} class(TControl)
  {* Друг для TControl }
 end;//TControlFriend

 TkwPopControlClientToScreen = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:ClientToScreen
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ClientToScreen >>> l_TPoint
[code]  }
  private
   function ClientToScreen(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TPoint;
    {* Реализация слова скрипта pop:Control:ClientToScreen }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlClientToScreen

 TkwPopControlScreenToClient = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:ScreenToClient
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ScreenToClient >>> l_TPoint
[code]  }
  private
   function ScreenToClient(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TPoint;
    {* Реализация слова скрипта pop:Control:ScreenToClient }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlScreenToClient

 TkwPopControlInvalidate = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Invalidate
*Пример:*
[code]
 aControl pop:Control:Invalidate
[code]  }
  private
   procedure Invalidate(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Invalidate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlInvalidate

 TkwPopControlRepaint = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Repaint
*Пример:*
[code]
 aControl pop:Control:Repaint
[code]  }
  private
   procedure Repaint(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Repaint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlRepaint

 TkwPopControlClick = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Click
*Пример:*
[code]
 aControl pop:Control:Click
[code]  }
  private
   procedure Click(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Click }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlClick

 TkwPopControlShow = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Show
*Пример:*
[code]
 aControl pop:Control:Show
[code]  }
  private
   procedure Show(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Show }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlShow

 TkwPopControlHide = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Hide
*Пример:*
[code]
 aControl pop:Control:Hide
[code]  }
  private
   procedure Hide(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Hide }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHide

 TkwPopControlUndock = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Undock
*Пример:*
[code]
 aControl pop:Control:Undock
[code]  }
  private
   procedure Undock(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Undock }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlUndock

 TkwPopControlGetPopupMenu = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetPopupMenu
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aPoint aControl pop:Control:GetPopupMenu >>> l_TMenuItem
[code]  }
  private
   function GetPopupMenu(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TMenuItem;
    {* Реализация слова скрипта pop:Control:GetPopupMenu }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetPopupMenu

 TkwPopControlGetTopParentForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetTopParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetTopParentForm >>> l_TCustomForm
[code]  }
  private
   function GetTopParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetTopParentForm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetTopParentForm

 TkwPopControlGetMainForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetMainForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetMainForm >>> l_TCustomForm
[code]  }
  private
   function GetMainForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetMainForm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetMainForm

 TkwPopControlGetParentForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetParentForm >>> l_TCustomForm
[code]  }
  private
   function GetParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetParentForm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetParentForm

 TkwPopControlGetAnotherParentForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetAnotherParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetAnotherParentForm >>> l_TCustomForm
[code]  }
  private
   function GetAnotherParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetAnotherParentForm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetAnotherParentForm

 TkwControlByHandle = {final} class(TtfwRegisterableWord)
  {* Слово скрипта Control:ByHandle
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aHandle Control:ByHandle >>> l_TControl
[code]  }
  private
   function ByHandle(const aCtx: TtfwContext;
    aHandle: THandle): TControl;
    {* Реализация слова скрипта Control:ByHandle }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwControlByHandle

 TkwControlFocusedControlPush = {final} class(TtfwRegisterableWord)
  {* Слово скрипта focused:control:push
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 focused:control:push >>> l_TControl
[code]  }
  private
   function focused_control_push(const aCtx: TtfwContext): TControl;
    {* Реализация слова скрипта focused:control:push }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwControlFocusedControlPush

 TkwPopControlColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Color
*Тип результата:* TColor
*Пример:*
[code]
TColor VAR l_TColor
 aControl pop:Control:Color >>> l_TColor
[code]  }
  private
   function Color(const aCtx: TtfwContext;
    aControl: TControl): TColor;
    {* Реализация слова скрипта pop:Control:Color }
  protected
   class procedure DoSetValue(aControl: TControl;
    aValue: TColor);
    {* Метод установки значения свойства Color }
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlColor

 TkwPopControlEnabled = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Enabled >>> l_Boolean
[code]  }
  private
   function Enabled(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
    {* Реализация слова скрипта pop:Control:Enabled }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlEnabled

 TkwPopControlVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Visible >>> l_Boolean
[code]  }
  private
   function Visible(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
    {* Реализация слова скрипта pop:Control:Visible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlVisible

 TkwPopControlName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Name >>> l_String
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
    {* Реализация слова скрипта pop:Control:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlName

 TkwPopControlHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Hint
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Hint >>> l_String
[code]  }
  private
   function Hint(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
    {* Реализация слова скрипта pop:Control:Hint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHint

 TkwPopControlShowHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:ShowHint
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:ShowHint >>> l_Boolean
[code]  }
  private
   function ShowHint(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
    {* Реализация слова скрипта pop:Control:ShowHint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlShowHint

 TkwPopControlCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Caption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Caption >>> l_String
[code]  }
  private
   function Caption(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
    {* Реализация слова скрипта pop:Control:Caption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlCaption

 TkwPopControlTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Top >>> l_Integer
[code]  }
  private
   function Top(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Top }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlTop

 TkwPopControlLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Left >>> l_Integer
[code]  }
  private
   function Left(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Left }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlLeft

 TkwPopControlHeight = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Height >>> l_Integer
[code]  }
  private
   function Height(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Height }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHeight

 TkwPopControlWidth = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Width >>> l_Integer
[code]  }
  private
   function Width(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Width }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlWidth

 TkwPopControlParent = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Parent
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aControl pop:Control:Parent >>> l_TControl
[code]  }
  private
   function Parent(const aCtx: TtfwContext;
    aControl: TControl): TControl;
    {* Реализация слова скрипта pop:Control:Parent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlParent

 TkwPopControlFont = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Font
*Тип результата:* Il3FontInfo
*Пример:*
[code]
INTERFACE VAR l_Il3FontInfo
 aControl pop:Control:Font >>> l_Il3FontInfo
[code]  }
  private
   function Font(const aCtx: TtfwContext;
    aControl: TControl): Il3FontInfo;
    {* Реализация слова скрипта pop:Control:Font }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlFont

function TkwPopControlClientToScreen.ClientToScreen(const aCtx: TtfwContext;
 aControl: TControl;
 const aPoint: TPoint): TPoint;
 {* Реализация слова скрипта pop:Control:ClientToScreen }
//#UC START# *AD33435ADFB6_D7ECBE257199_var*
//#UC END# *AD33435ADFB6_D7ECBE257199_var*
begin
//#UC START# *AD33435ADFB6_D7ECBE257199_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD33435ADFB6_D7ECBE257199_impl*
end;//TkwPopControlClientToScreen.ClientToScreen

procedure TkwPopControlClientToScreen.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushPoint(ClientToScreen(aCtx, l_aControl, l_aPoint));
end;//TkwPopControlClientToScreen.DoDoIt

class function TkwPopControlClientToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:ClientToScreen';
end;//TkwPopControlClientToScreen.GetWordNameForRegister

function TkwPopControlClientToScreen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwPopControlClientToScreen.GetResultTypeInfo

function TkwPopControlClientToScreen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlClientToScreen.GetAllParamsCount

function TkwPopControlClientToScreen.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlClientToScreen.ParamsTypes

function TkwPopControlScreenToClient.ScreenToClient(const aCtx: TtfwContext;
 aControl: TControl;
 const aPoint: TPoint): TPoint;
 {* Реализация слова скрипта pop:Control:ScreenToClient }
//#UC START# *BD2CDDD5F1AA_856C40E22773_var*
//#UC END# *BD2CDDD5F1AA_856C40E22773_var*
begin
//#UC START# *BD2CDDD5F1AA_856C40E22773_impl*
 !!! Needs to be implemented !!!
//#UC END# *BD2CDDD5F1AA_856C40E22773_impl*
end;//TkwPopControlScreenToClient.ScreenToClient

procedure TkwPopControlScreenToClient.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushPoint(ScreenToClient(aCtx, l_aControl, l_aPoint));
end;//TkwPopControlScreenToClient.DoDoIt

class function TkwPopControlScreenToClient.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:ScreenToClient';
end;//TkwPopControlScreenToClient.GetWordNameForRegister

function TkwPopControlScreenToClient.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwPopControlScreenToClient.GetResultTypeInfo

function TkwPopControlScreenToClient.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlScreenToClient.GetAllParamsCount

function TkwPopControlScreenToClient.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlScreenToClient.ParamsTypes

procedure TkwPopControlInvalidate.Invalidate(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Invalidate }
//#UC START# *AEDBA2810D44_084D24347CB6_var*
//#UC END# *AEDBA2810D44_084D24347CB6_var*
begin
//#UC START# *AEDBA2810D44_084D24347CB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *AEDBA2810D44_084D24347CB6_impl*
end;//TkwPopControlInvalidate.Invalidate

procedure TkwPopControlInvalidate.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Invalidate(aCtx, l_aControl);
end;//TkwPopControlInvalidate.DoDoIt

class function TkwPopControlInvalidate.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Invalidate';
end;//TkwPopControlInvalidate.GetWordNameForRegister

function TkwPopControlInvalidate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlInvalidate.GetResultTypeInfo

function TkwPopControlInvalidate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlInvalidate.GetAllParamsCount

function TkwPopControlInvalidate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlInvalidate.ParamsTypes

procedure TkwPopControlRepaint.Repaint(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Repaint }
//#UC START# *8B1BE2A99EEC_7D2AE156F001_var*
//#UC END# *8B1BE2A99EEC_7D2AE156F001_var*
begin
//#UC START# *8B1BE2A99EEC_7D2AE156F001_impl*
 !!! Needs to be implemented !!!
//#UC END# *8B1BE2A99EEC_7D2AE156F001_impl*
end;//TkwPopControlRepaint.Repaint

procedure TkwPopControlRepaint.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Repaint(aCtx, l_aControl);
end;//TkwPopControlRepaint.DoDoIt

class function TkwPopControlRepaint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Repaint';
end;//TkwPopControlRepaint.GetWordNameForRegister

function TkwPopControlRepaint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlRepaint.GetResultTypeInfo

function TkwPopControlRepaint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlRepaint.GetAllParamsCount

function TkwPopControlRepaint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlRepaint.ParamsTypes

procedure TkwPopControlClick.Click(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Click }
//#UC START# *61CF2F0B3020_F8C716BBBC31_var*
//#UC END# *61CF2F0B3020_F8C716BBBC31_var*
begin
//#UC START# *61CF2F0B3020_F8C716BBBC31_impl*
 TControlFriend(aControl).Click;
//#UC END# *61CF2F0B3020_F8C716BBBC31_impl*
end;//TkwPopControlClick.Click

procedure TkwPopControlClick.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Click(aCtx, l_aControl);
end;//TkwPopControlClick.DoDoIt

class function TkwPopControlClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Click';
end;//TkwPopControlClick.GetWordNameForRegister

function TkwPopControlClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlClick.GetResultTypeInfo

function TkwPopControlClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlClick.GetAllParamsCount

function TkwPopControlClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlClick.ParamsTypes

procedure TkwPopControlShow.Show(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Show }
//#UC START# *A66BD712D618_0D58233E83D8_var*
//#UC END# *A66BD712D618_0D58233E83D8_var*
begin
//#UC START# *A66BD712D618_0D58233E83D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *A66BD712D618_0D58233E83D8_impl*
end;//TkwPopControlShow.Show

procedure TkwPopControlShow.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Show(aCtx, l_aControl);
end;//TkwPopControlShow.DoDoIt

class function TkwPopControlShow.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Show';
end;//TkwPopControlShow.GetWordNameForRegister

function TkwPopControlShow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlShow.GetResultTypeInfo

function TkwPopControlShow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlShow.GetAllParamsCount

function TkwPopControlShow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlShow.ParamsTypes

procedure TkwPopControlHide.Hide(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Hide }
//#UC START# *AA0E2FC1D31A_9D867B7EC0B0_var*
//#UC END# *AA0E2FC1D31A_9D867B7EC0B0_var*
begin
//#UC START# *AA0E2FC1D31A_9D867B7EC0B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *AA0E2FC1D31A_9D867B7EC0B0_impl*
end;//TkwPopControlHide.Hide

procedure TkwPopControlHide.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Hide(aCtx, l_aControl);
end;//TkwPopControlHide.DoDoIt

class function TkwPopControlHide.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Hide';
end;//TkwPopControlHide.GetWordNameForRegister

function TkwPopControlHide.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlHide.GetResultTypeInfo

function TkwPopControlHide.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHide.GetAllParamsCount

function TkwPopControlHide.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHide.ParamsTypes

procedure TkwPopControlUndock.Undock(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Undock }
//#UC START# *E44BD472B7AB_6BAE007A323D_var*
//#UC END# *E44BD472B7AB_6BAE007A323D_var*
begin
//#UC START# *E44BD472B7AB_6BAE007A323D_impl*
 aControl.ManualDock(nil, nil, alNone);
//#UC END# *E44BD472B7AB_6BAE007A323D_impl*
end;//TkwPopControlUndock.Undock

procedure TkwPopControlUndock.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Undock(aCtx, l_aControl);
end;//TkwPopControlUndock.DoDoIt

class function TkwPopControlUndock.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Undock';
end;//TkwPopControlUndock.GetWordNameForRegister

function TkwPopControlUndock.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlUndock.GetResultTypeInfo

function TkwPopControlUndock.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlUndock.GetAllParamsCount

function TkwPopControlUndock.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlUndock.ParamsTypes

function TkwPopControlGetPopupMenu.GetPopupMenu(const aCtx: TtfwContext;
 aControl: TControl;
 const aPoint: TPoint): TMenuItem;
 {* Реализация слова скрипта pop:Control:GetPopupMenu }
//#UC START# *03EB93F2B4F5_42A7FAEADBD6_var*
//#UC END# *03EB93F2B4F5_42A7FAEADBD6_var*
begin
//#UC START# *03EB93F2B4F5_42A7FAEADBD6_impl*
 Result := Tl3PopupMenuHelper.Instance.GetPopupMenu(aControl, aPoint);
//#UC END# *03EB93F2B4F5_42A7FAEADBD6_impl*
end;//TkwPopControlGetPopupMenu.GetPopupMenu

procedure TkwPopControlGetPopupMenu.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetPopupMenu(aCtx, l_aControl, l_aPoint));
end;//TkwPopControlGetPopupMenu.DoDoIt

class function TkwPopControlGetPopupMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetPopupMenu';
end;//TkwPopControlGetPopupMenu.GetWordNameForRegister

function TkwPopControlGetPopupMenu.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopControlGetPopupMenu.GetResultTypeInfo

function TkwPopControlGetPopupMenu.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlGetPopupMenu.GetAllParamsCount

function TkwPopControlGetPopupMenu.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlGetPopupMenu.ParamsTypes

function TkwPopControlGetTopParentForm.GetTopParentForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetTopParentForm }
//#UC START# *D1A25E7B9BDA_801293AEE662_var*
//#UC END# *D1A25E7B9BDA_801293AEE662_var*
begin
//#UC START# *D1A25E7B9BDA_801293AEE662_impl*
 Result := Tl3FormsService.Instance.GetTopParentForm(aControl);
//#UC END# *D1A25E7B9BDA_801293AEE662_impl*
end;//TkwPopControlGetTopParentForm.GetTopParentForm

procedure TkwPopControlGetTopParentForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetTopParentForm(aCtx, l_aControl));
end;//TkwPopControlGetTopParentForm.DoDoIt

class function TkwPopControlGetTopParentForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetTopParentForm';
end;//TkwPopControlGetTopParentForm.GetWordNameForRegister

function TkwPopControlGetTopParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetTopParentForm.GetResultTypeInfo

function TkwPopControlGetTopParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetTopParentForm.GetAllParamsCount

function TkwPopControlGetTopParentForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetTopParentForm.ParamsTypes

function TkwPopControlGetMainForm.GetMainForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetMainForm }
//#UC START# *2075E5D1B087_19DF01986BE7_var*
//#UC END# *2075E5D1B087_19DF01986BE7_var*
begin
//#UC START# *2075E5D1B087_19DF01986BE7_impl*
 Result := Tl3FormsService.Instance.GetMainForm(aControl);
//#UC END# *2075E5D1B087_19DF01986BE7_impl*
end;//TkwPopControlGetMainForm.GetMainForm

procedure TkwPopControlGetMainForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetMainForm(aCtx, l_aControl));
end;//TkwPopControlGetMainForm.DoDoIt

class function TkwPopControlGetMainForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetMainForm';
end;//TkwPopControlGetMainForm.GetWordNameForRegister

function TkwPopControlGetMainForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetMainForm.GetResultTypeInfo

function TkwPopControlGetMainForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetMainForm.GetAllParamsCount

function TkwPopControlGetMainForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetMainForm.ParamsTypes

function TkwPopControlGetParentForm.GetParentForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetParentForm }
//#UC START# *290504A82C40_BC5B460C7FEA_var*
//#UC END# *290504A82C40_BC5B460C7FEA_var*
begin
//#UC START# *290504A82C40_BC5B460C7FEA_impl*
 Result := Tl3FormsService.Instance.GetParentForm(aControl);
//#UC END# *290504A82C40_BC5B460C7FEA_impl*
end;//TkwPopControlGetParentForm.GetParentForm

procedure TkwPopControlGetParentForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetParentForm(aCtx, l_aControl));
end;//TkwPopControlGetParentForm.DoDoIt

class function TkwPopControlGetParentForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetParentForm';
end;//TkwPopControlGetParentForm.GetWordNameForRegister

function TkwPopControlGetParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetParentForm.GetResultTypeInfo

function TkwPopControlGetParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetParentForm.GetAllParamsCount

function TkwPopControlGetParentForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetParentForm.ParamsTypes

function TkwPopControlGetAnotherParentForm.GetAnotherParentForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetAnotherParentForm }
//#UC START# *68CF70189B15_8A00B7773D0C_var*
//#UC END# *68CF70189B15_8A00B7773D0C_var*
begin
//#UC START# *68CF70189B15_8A00B7773D0C_impl*
 Result := Tl3FormsService.Instance.GetAnotherParentForm(aControl);
//#UC END# *68CF70189B15_8A00B7773D0C_impl*
end;//TkwPopControlGetAnotherParentForm.GetAnotherParentForm

procedure TkwPopControlGetAnotherParentForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetAnotherParentForm(aCtx, l_aControl));
end;//TkwPopControlGetAnotherParentForm.DoDoIt

class function TkwPopControlGetAnotherParentForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetAnotherParentForm';
end;//TkwPopControlGetAnotherParentForm.GetWordNameForRegister

function TkwPopControlGetAnotherParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetAnotherParentForm.GetResultTypeInfo

function TkwPopControlGetAnotherParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetAnotherParentForm.GetAllParamsCount

function TkwPopControlGetAnotherParentForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetAnotherParentForm.ParamsTypes

function TkwControlByHandle.ByHandle(const aCtx: TtfwContext;
 aHandle: THandle): TControl;
 {* Реализация слова скрипта Control:ByHandle }
//#UC START# *C84440B65B87_0241DA0F487D_var*
//#UC END# *C84440B65B87_0241DA0F487D_var*
begin
//#UC START# *C84440B65B87_0241DA0F487D_impl*
 Result := FindControl(aHandle);
 RunnerAssert(Assigned(Result), 'Не найден контрол.', aCtx);
//#UC END# *C84440B65B87_0241DA0F487D_impl*
end;//TkwControlByHandle.ByHandle

procedure TkwControlByHandle.DoDoIt(const aCtx: TtfwContext);
var l_aHandle: THandle;
begin
 try
  l_aHandle := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHandle: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ByHandle(aCtx, l_aHandle));
end;//TkwControlByHandle.DoDoIt

class function TkwControlByHandle.GetWordNameForRegister: AnsiString;
begin
 Result := 'Control:ByHandle';
end;//TkwControlByHandle.GetWordNameForRegister

function TkwControlByHandle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwControlByHandle.GetResultTypeInfo

function TkwControlByHandle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwControlByHandle.GetAllParamsCount

function TkwControlByHandle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), TypeInfo(THandle)]);
end;//TkwControlByHandle.ParamsTypes

function TkwControlFocusedControlPush.focused_control_push(const aCtx: TtfwContext): TControl;
 {* Реализация слова скрипта focused:control:push }
//#UC START# *190B20AA18AF_DDB6E934DC7B_var*
var
 l_C : TControl;
//#UC END# *190B20AA18AF_DDB6E934DC7B_var*
begin
//#UC START# *190B20AA18AF_DDB6E934DC7B_impl*
 l_C := FindControl(GetFocus);
 if (l_C = nil) then
 // - наверное мы под отладчиком или из под нас выдернули фокус
 begin
  RunnerAssert(Screen.ActiveForm <> nil, 'Нет активной формы', aCtx);
  l_C := Screen.ActiveForm.ActiveControl;
 end;//l_C = nil
 RunnerAssert(l_C <> nil, 'Не нашли контрол в фокусе', aCtx);
 Result := l_C;
//#UC END# *190B20AA18AF_DDB6E934DC7B_impl*
end;//TkwControlFocusedControlPush.focused_control_push

procedure TkwControlFocusedControlPush.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(focused_control_push(aCtx));
end;//TkwControlFocusedControlPush.DoDoIt

class function TkwControlFocusedControlPush.GetWordNameForRegister: AnsiString;
begin
 Result := 'focused:control:push';
end;//TkwControlFocusedControlPush.GetWordNameForRegister

function TkwControlFocusedControlPush.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwControlFocusedControlPush.GetResultTypeInfo

function TkwControlFocusedControlPush.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwControlFocusedControlPush.GetAllParamsCount

function TkwControlFocusedControlPush.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwControlFocusedControlPush.ParamsTypes

function TkwPopControlColor.Color(const aCtx: TtfwContext;
 aControl: TControl): TColor;
 {* Реализация слова скрипта pop:Control:Color }
//#UC START# *AACBF5E37A06_EBE4B9074377_var*
//#UC END# *AACBF5E37A06_EBE4B9074377_var*
begin
//#UC START# *AACBF5E37A06_EBE4B9074377_impl*
 Result := TControlFriend(aControl).Color;
//#UC END# *AACBF5E37A06_EBE4B9074377_impl*
end;//TkwPopControlColor.Color

class procedure TkwPopControlColor.DoSetValue(aControl: TControl;
 aValue: TColor);
 {* Метод установки значения свойства Color }
//#UC START# *8D28522E42BF_EBE4B9074377_var*
//#UC END# *8D28522E42BF_EBE4B9074377_var*
begin
//#UC START# *8D28522E42BF_EBE4B9074377_impl*
 TControlFriend(aControl).Color := aValue;
//#UC END# *8D28522E42BF_EBE4B9074377_impl*
end;//TkwPopControlColor.DoSetValue

procedure TkwPopControlColor.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(Color(aCtx, l_aControl)));
end;//TkwPopControlColor.DoDoIt

class function TkwPopControlColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Color';
end;//TkwPopControlColor.GetWordNameForRegister

procedure TkwPopControlColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
try
 l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
except
 on E: Exception do
 begin
  RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
  Exit;
 end;//on E: Exception
end;//try..except
DoSetValue(Control, aValue);
end;//TkwPopControlColor.SetValuePrim

function TkwPopControlColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TColor);
end;//TkwPopControlColor.GetResultTypeInfo

function TkwPopControlColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlColor.GetAllParamsCount

function TkwPopControlColor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlColor.ParamsTypes

function TkwPopControlEnabled.Enabled(const aCtx: TtfwContext;
 aControl: TControl): Boolean;
 {* Реализация слова скрипта pop:Control:Enabled }
//#UC START# *881B1521CB8E_ACE5425C329D_var*
//#UC END# *881B1521CB8E_ACE5425C329D_var*
begin
//#UC START# *881B1521CB8E_ACE5425C329D_impl*
 !!! Needs to be implemented !!!
//#UC END# *881B1521CB8E_ACE5425C329D_impl*
end;//TkwPopControlEnabled.Enabled

procedure TkwPopControlEnabled.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Enabled(aCtx, l_aControl));
end;//TkwPopControlEnabled.DoDoIt

class function TkwPopControlEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Enabled';
end;//TkwPopControlEnabled.GetWordNameForRegister

procedure TkwPopControlEnabled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwPopControlEnabled.SetValuePrim

function TkwPopControlEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlEnabled.GetResultTypeInfo

function TkwPopControlEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlEnabled.GetAllParamsCount

function TkwPopControlEnabled.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlEnabled.ParamsTypes

function TkwPopControlVisible.Visible(const aCtx: TtfwContext;
 aControl: TControl): Boolean;
 {* Реализация слова скрипта pop:Control:Visible }
//#UC START# *72FC754CCB47_5C3AF1C3D79A_var*
//#UC END# *72FC754CCB47_5C3AF1C3D79A_var*
begin
//#UC START# *72FC754CCB47_5C3AF1C3D79A_impl*
 !!! Needs to be implemented !!!
//#UC END# *72FC754CCB47_5C3AF1C3D79A_impl*
end;//TkwPopControlVisible.Visible

procedure TkwPopControlVisible.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Visible(aCtx, l_aControl));
end;//TkwPopControlVisible.DoDoIt

class function TkwPopControlVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Visible';
end;//TkwPopControlVisible.GetWordNameForRegister

procedure TkwPopControlVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwPopControlVisible.SetValuePrim

function TkwPopControlVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlVisible.GetResultTypeInfo

function TkwPopControlVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlVisible.GetAllParamsCount

function TkwPopControlVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlVisible.ParamsTypes

function TkwPopControlName.Name(const aCtx: TtfwContext;
 aControl: TControl): AnsiString;
 {* Реализация слова скрипта pop:Control:Name }
//#UC START# *FD1C57C9B52D_F53819E00314_var*
//#UC END# *FD1C57C9B52D_F53819E00314_var*
begin
//#UC START# *FD1C57C9B52D_F53819E00314_impl*
 !!! Needs to be implemented !!!
//#UC END# *FD1C57C9B52D_F53819E00314_impl*
end;//TkwPopControlName.Name

procedure TkwPopControlName.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aControl));
end;//TkwPopControlName.DoDoIt

class function TkwPopControlName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Name';
end;//TkwPopControlName.GetWordNameForRegister

procedure TkwPopControlName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopControlName.SetValuePrim

function TkwPopControlName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopControlName.GetResultTypeInfo

function TkwPopControlName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlName.GetAllParamsCount

function TkwPopControlName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlName.ParamsTypes

function TkwPopControlHint.Hint(const aCtx: TtfwContext;
 aControl: TControl): AnsiString;
 {* Реализация слова скрипта pop:Control:Hint }
//#UC START# *BFC5BB99D590_7EEF2F285EA8_var*
//#UC END# *BFC5BB99D590_7EEF2F285EA8_var*
begin
//#UC START# *BFC5BB99D590_7EEF2F285EA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *BFC5BB99D590_7EEF2F285EA8_impl*
end;//TkwPopControlHint.Hint

procedure TkwPopControlHint.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Hint(aCtx, l_aControl));
end;//TkwPopControlHint.DoDoIt

class function TkwPopControlHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Hint';
end;//TkwPopControlHint.GetWordNameForRegister

procedure TkwPopControlHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Hint', aCtx);
end;//TkwPopControlHint.SetValuePrim

function TkwPopControlHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopControlHint.GetResultTypeInfo

function TkwPopControlHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHint.GetAllParamsCount

function TkwPopControlHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHint.ParamsTypes

function TkwPopControlShowHint.ShowHint(const aCtx: TtfwContext;
 aControl: TControl): Boolean;
 {* Реализация слова скрипта pop:Control:ShowHint }
//#UC START# *0D147356E888_B165FF488B6E_var*
//#UC END# *0D147356E888_B165FF488B6E_var*
begin
//#UC START# *0D147356E888_B165FF488B6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D147356E888_B165FF488B6E_impl*
end;//TkwPopControlShowHint.ShowHint

procedure TkwPopControlShowHint.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(ShowHint(aCtx, l_aControl));
end;//TkwPopControlShowHint.DoDoIt

class function TkwPopControlShowHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:ShowHint';
end;//TkwPopControlShowHint.GetWordNameForRegister

procedure TkwPopControlShowHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShowHint', aCtx);
end;//TkwPopControlShowHint.SetValuePrim

function TkwPopControlShowHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlShowHint.GetResultTypeInfo

function TkwPopControlShowHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlShowHint.GetAllParamsCount

function TkwPopControlShowHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlShowHint.ParamsTypes

function TkwPopControlCaption.Caption(const aCtx: TtfwContext;
 aControl: TControl): AnsiString;
 {* Реализация слова скрипта pop:Control:Caption }
//#UC START# *DAFCD40E37A8_6ED40CDED494_var*
//#UC END# *DAFCD40E37A8_6ED40CDED494_var*
begin
//#UC START# *DAFCD40E37A8_6ED40CDED494_impl*
 Result := TControlFriend(aControl).Caption;
//#UC END# *DAFCD40E37A8_6ED40CDED494_impl*
end;//TkwPopControlCaption.Caption

procedure TkwPopControlCaption.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Caption(aCtx, l_aControl));
end;//TkwPopControlCaption.DoDoIt

class function TkwPopControlCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Caption';
end;//TkwPopControlCaption.GetWordNameForRegister

procedure TkwPopControlCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwPopControlCaption.SetValuePrim

function TkwPopControlCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopControlCaption.GetResultTypeInfo

function TkwPopControlCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlCaption.GetAllParamsCount

function TkwPopControlCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlCaption.ParamsTypes

function TkwPopControlTop.Top(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Top }
//#UC START# *CACB8661C141_531AEAE3EB2E_var*
//#UC END# *CACB8661C141_531AEAE3EB2E_var*
begin
//#UC START# *CACB8661C141_531AEAE3EB2E_impl*
 !!! Needs to be implemented !!!
//#UC END# *CACB8661C141_531AEAE3EB2E_impl*
end;//TkwPopControlTop.Top

procedure TkwPopControlTop.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Top(aCtx, l_aControl));
end;//TkwPopControlTop.DoDoIt

class function TkwPopControlTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Top';
end;//TkwPopControlTop.GetWordNameForRegister

procedure TkwPopControlTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
try
 l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
except
 on E: Exception do
 begin
  RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
  Exit;
 end;//on E: Exception
end;//try..except
DoSetValue(Control, aValue);
end;//TkwPopControlTop.SetValuePrim

function TkwPopControlTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlTop.GetResultTypeInfo

function TkwPopControlTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlTop.GetAllParamsCount

function TkwPopControlTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlTop.ParamsTypes

function TkwPopControlLeft.Left(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Left }
//#UC START# *5FE004AA30D7_43ADF087E3E7_var*
//#UC END# *5FE004AA30D7_43ADF087E3E7_var*
begin
//#UC START# *5FE004AA30D7_43ADF087E3E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5FE004AA30D7_43ADF087E3E7_impl*
end;//TkwPopControlLeft.Left

procedure TkwPopControlLeft.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Left(aCtx, l_aControl));
end;//TkwPopControlLeft.DoDoIt

class function TkwPopControlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Left';
end;//TkwPopControlLeft.GetWordNameForRegister

procedure TkwPopControlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
try
 l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
except
 on E: Exception do
 begin
  RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
  Exit;
 end;//on E: Exception
end;//try..except
DoSetValue(Control, aValue);
end;//TkwPopControlLeft.SetValuePrim

function TkwPopControlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlLeft.GetResultTypeInfo

function TkwPopControlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlLeft.GetAllParamsCount

function TkwPopControlLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlLeft.ParamsTypes

function TkwPopControlHeight.Height(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Height }
//#UC START# *DE0DB4F0B791_AA5F37A792A3_var*
//#UC END# *DE0DB4F0B791_AA5F37A792A3_var*
begin
//#UC START# *DE0DB4F0B791_AA5F37A792A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *DE0DB4F0B791_AA5F37A792A3_impl*
end;//TkwPopControlHeight.Height

procedure TkwPopControlHeight.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Height(aCtx, l_aControl));
end;//TkwPopControlHeight.DoDoIt

class function TkwPopControlHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Height';
end;//TkwPopControlHeight.GetWordNameForRegister

procedure TkwPopControlHeight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
try
 l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
except
 on E: Exception do
 begin
  RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
  Exit;
 end;//on E: Exception
end;//try..except
DoSetValue(Control, aValue);
end;//TkwPopControlHeight.SetValuePrim

function TkwPopControlHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlHeight.GetResultTypeInfo

function TkwPopControlHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHeight.GetAllParamsCount

function TkwPopControlHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHeight.ParamsTypes

function TkwPopControlWidth.Width(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Width }
//#UC START# *AE64B1A70E4C_50D37A00C710_var*
//#UC END# *AE64B1A70E4C_50D37A00C710_var*
begin
//#UC START# *AE64B1A70E4C_50D37A00C710_impl*
 !!! Needs to be implemented !!!
//#UC END# *AE64B1A70E4C_50D37A00C710_impl*
end;//TkwPopControlWidth.Width

procedure TkwPopControlWidth.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Width(aCtx, l_aControl));
end;//TkwPopControlWidth.DoDoIt

class function TkwPopControlWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Width';
end;//TkwPopControlWidth.GetWordNameForRegister

procedure TkwPopControlWidth.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
try
 l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
except
 on E: Exception do
 begin
  RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
  Exit;
 end;//on E: Exception
end;//try..except
DoSetValue(Control, aValue);
end;//TkwPopControlWidth.SetValuePrim

function TkwPopControlWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlWidth.GetResultTypeInfo

function TkwPopControlWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlWidth.GetAllParamsCount

function TkwPopControlWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlWidth.ParamsTypes

function TkwPopControlParent.Parent(const aCtx: TtfwContext;
 aControl: TControl): TControl;
 {* Реализация слова скрипта pop:Control:Parent }
//#UC START# *E3DE424443EE_B324E2362907_var*
//#UC END# *E3DE424443EE_B324E2362907_var*
begin
//#UC START# *E3DE424443EE_B324E2362907_impl*
 !!! Needs to be implemented !!!
//#UC END# *E3DE424443EE_B324E2362907_impl*
end;//TkwPopControlParent.Parent

procedure TkwPopControlParent.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Parent(aCtx, l_aControl));
end;//TkwPopControlParent.DoDoIt

class function TkwPopControlParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Parent';
end;//TkwPopControlParent.GetWordNameForRegister

procedure TkwPopControlParent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Parent', aCtx);
end;//TkwPopControlParent.SetValuePrim

function TkwPopControlParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwPopControlParent.GetResultTypeInfo

function TkwPopControlParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlParent.GetAllParamsCount

function TkwPopControlParent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlParent.ParamsTypes

function TkwPopControlFont.Font(const aCtx: TtfwContext;
 aControl: TControl): Il3FontInfo;
 {* Реализация слова скрипта pop:Control:Font }
//#UC START# *BCE0497B09C6_520187343F71_var*
//#UC END# *BCE0497B09C6_520187343F71_var*
begin
//#UC START# *BCE0497B09C6_520187343F71_impl*
 Result := Tl3ControlFontService.Instance.GetFont(aControl);
//#UC END# *BCE0497B09C6_520187343F71_impl*
end;//TkwPopControlFont.Font

procedure TkwPopControlFont.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Font(aCtx, l_aControl),Il3FontInfo);
end;//TkwPopControlFont.DoDoIt

class function TkwPopControlFont.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Font';
end;//TkwPopControlFont.GetWordNameForRegister

procedure TkwPopControlFont.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Font', aCtx);
end;//TkwPopControlFont.SetValuePrim

function TkwPopControlFont.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Il3FontInfo);
end;//TkwPopControlFont.GetResultTypeInfo

function TkwPopControlFont.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlFont.GetAllParamsCount

function TkwPopControlFont.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlFont.ParamsTypes

initialization
 TkwPopControlClientToScreen.RegisterInEngine;
 {* Регистрация pop_Control_ClientToScreen }
 TkwPopControlScreenToClient.RegisterInEngine;
 {* Регистрация pop_Control_ScreenToClient }
 TkwPopControlInvalidate.RegisterInEngine;
 {* Регистрация pop_Control_Invalidate }
 TkwPopControlRepaint.RegisterInEngine;
 {* Регистрация pop_Control_Repaint }
 TkwPopControlClick.RegisterInEngine;
 {* Регистрация pop_Control_Click }
 TkwPopControlShow.RegisterInEngine;
 {* Регистрация pop_Control_Show }
 TkwPopControlHide.RegisterInEngine;
 {* Регистрация pop_Control_Hide }
 TkwPopControlUndock.RegisterInEngine;
 {* Регистрация pop_Control_Undock }
 TkwPopControlGetPopupMenu.RegisterInEngine;
 {* Регистрация pop_Control_GetPopupMenu }
 TkwPopControlGetTopParentForm.RegisterInEngine;
 {* Регистрация pop_Control_GetTopParentForm }
 TkwPopControlGetMainForm.RegisterInEngine;
 {* Регистрация pop_Control_GetMainForm }
 TkwPopControlGetParentForm.RegisterInEngine;
 {* Регистрация pop_Control_GetParentForm }
 TkwPopControlGetAnotherParentForm.RegisterInEngine;
 {* Регистрация pop_Control_GetAnotherParentForm }
 TkwControlByHandle.RegisterInEngine;
 {* Регистрация Control_ByHandle }
 TkwControlFocusedControlPush.RegisterInEngine;
 {* Регистрация Control_focused_control_push }
 TkwPopControlColor.RegisterInEngine;
 {* Регистрация pop_Control_Color }
 TkwPopControlEnabled.RegisterInEngine;
 {* Регистрация pop_Control_Enabled }
 TkwPopControlVisible.RegisterInEngine;
 {* Регистрация pop_Control_Visible }
 TkwPopControlName.RegisterInEngine;
 {* Регистрация pop_Control_Name }
 TkwPopControlHint.RegisterInEngine;
 {* Регистрация pop_Control_Hint }
 TkwPopControlShowHint.RegisterInEngine;
 {* Регистрация pop_Control_ShowHint }
 TkwPopControlCaption.RegisterInEngine;
 {* Регистрация pop_Control_Caption }
 TkwPopControlTop.RegisterInEngine;
 {* Регистрация pop_Control_Top }
 TkwPopControlLeft.RegisterInEngine;
 {* Регистрация pop_Control_Left }
 TkwPopControlHeight.RegisterInEngine;
 {* Регистрация pop_Control_Height }
 TkwPopControlWidth.RegisterInEngine;
 {* Регистрация pop_Control_Width }
 TkwPopControlParent.RegisterInEngine;
 {* Регистрация pop_Control_Parent }
 TkwPopControlFont.RegisterInEngine;
 {* Регистрация pop_Control_Font }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
 {* Регистрация типа TControl }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TPoint }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
 {* Регистрация типа TCustomForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(THandle));
 {* Регистрация типа THandle }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TColor));
 {* Регистрация типа TColor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3FontInfo));
 {* Регистрация типа Il3FontInfo }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
