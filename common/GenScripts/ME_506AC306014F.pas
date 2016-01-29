unit VGSceneWordsPack;

interface

uses
 l3IntfUses
 , vgVisualObject
 , Controls
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
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
 TVGSceneWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TVGSceneWordsPackResNameGetter
 
 TvgVisualObjectFriend = class(TvgVisualObject)
  {* Друг для TvgVisualObject }
 end;//TvgVisualObjectFriend
 
 TkwVgControlVisible = class(TtfwClassLike)
  {* Слово скрипта vg:control:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:Visible >>> l_Boolean
[code]  }
  function vg_control_Visible(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Boolean;
   {* Реализация слова скрипта vg:control:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlVisible
 
 TkwVgControlHeight = class(TtfwClassLike)
  {* Слово скрипта vg:control:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Height >>> l_Integer
[code]  }
  function vg_control_Height(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* Реализация слова скрипта vg:control:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlHeight
 
 TkwVgControlWidth = class(TtfwClassLike)
  {* Слово скрипта vg:control:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Width >>> l_Integer
[code]  }
  function vg_control_Width(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* Реализация слова скрипта vg:control:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlWidth
 
 TkwVgControlLeft = class(TtfwClassLike)
  {* Слово скрипта vg:control:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Left >>> l_Integer
[code]  }
  function vg_control_Left(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* Реализация слова скрипта vg:control:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlLeft
 
 TkwVgControlTop = class(TtfwClassLike)
  {* Слово скрипта vg:control:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Top >>> l_Integer
[code]  }
  function vg_control_Top(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* Реализация слова скрипта vg:control:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlTop
 
 TkwVgControlEnabled = class(TtfwClassLike)
  {* Слово скрипта vg:control:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:Enabled >>> l_Boolean
[code]  }
  function vg_control_Enabled(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Boolean;
   {* Реализация слова скрипта vg:control:Enabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlEnabled
 
 TkwVgControlName = class(TtfwClassLike)
  {* Слово скрипта vg:control:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aVisualObject vg:control:Name >>> l_String
[code]  }
  function vg_control_Name(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): AnsiString;
   {* Реализация слова скрипта vg:control:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlName
 
 TkwVgControlClick = class(TtfwClassLike)
  {* Слово скрипта vg:control:Click
*Пример:*
[code]
 aVisualObject vg:control:Click
[code]  }
  procedure vg_control_Click(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject);
   {* Реализация слова скрипта vg:control:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlClick
 
 TkwVgControlCountSiblingLikeMe = class(TtfwClassLike)
  {* Слово скрипта vg:control:CountSiblingLikeMe
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:CountSiblingLikeMe >>> l_Integer
[code]  }
  function vg_control_CountSiblingLikeMe(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* Реализация слова скрипта vg:control:CountSiblingLikeMe }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlCountSiblingLikeMe
 
 TkwVgControlGetIsChecked = class(TtfwClassLike)
  {* Слово скрипта vg:control:GetIsChecked
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:GetIsChecked >>> l_Boolean
[code]  }
  function vg_control_GetIsChecked(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Boolean;
   {* Реализация слова скрипта vg:control:GetIsChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlGetIsChecked
 
 TkwVgControlSetIsChecked = class(TtfwClassLike)
  {* Слово скрипта vg:control:SetIsChecked
*Пример:*
[code]
 aValue aVisualObject vg:control:SetIsChecked
[code]  }
  procedure vg_control_SetIsChecked(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject;
   aValue: Boolean);
   {* Реализация слова скрипта vg:control:SetIsChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlSetIsChecked
 
 TkwVgControlLeftInScene = class(TtfwClassLike)
  {* Слово скрипта vg:control:LeftInScene
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:LeftInScene >>> l_Integer
[code]  }
  function vg_control_LeftInScene(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* Реализация слова скрипта vg:control:LeftInScene }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlLeftInScene
 
 TkwVgControlTopInScene = class(TtfwClassLike)
  {* Слово скрипта vg:control:TopInScene
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:TopInScene >>> l_Integer
[code]  }
  function vg_control_TopInScene(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* Реализация слова скрипта vg:control:TopInScene }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlTopInScene
 
 TkwVgControlScene = class(TtfwClassLike)
  {* Слово скрипта vg:control:Scene
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aVisualObject vg:control:Scene >>> l_TControl
[code]  }
  function vg_control_Scene(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): TControl;
   {* Реализация слова скрипта vg:control:Scene }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlScene
 
 TkwVgControlText = class(TtfwClassLike)
  {* Слово скрипта vg:control:Text
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aVisualObject vg:control:Text >>> l_String
[code]  }
  function vg_control_Text(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): AnsiString;
   {* Реализация слова скрипта vg:control:Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlText
 
end.
