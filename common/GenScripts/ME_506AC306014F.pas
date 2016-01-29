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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TVGSceneWordsPackResNameGetter
 
 TvgVisualObjectFriend = class(TvgVisualObject)
  {* ���� ��� TvgVisualObject }
 end;//TvgVisualObjectFriend
 
 TkwVgControlVisible = class(TtfwClassLike)
  {* ����� ������� vg:control:Visible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:Visible >>> l_Boolean
[code]  }
  function vg_control_Visible(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Boolean;
   {* ���������� ����� ������� vg:control:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlVisible
 
 TkwVgControlHeight = class(TtfwClassLike)
  {* ����� ������� vg:control:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Height >>> l_Integer
[code]  }
  function vg_control_Height(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* ���������� ����� ������� vg:control:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlHeight
 
 TkwVgControlWidth = class(TtfwClassLike)
  {* ����� ������� vg:control:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Width >>> l_Integer
[code]  }
  function vg_control_Width(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* ���������� ����� ������� vg:control:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlWidth
 
 TkwVgControlLeft = class(TtfwClassLike)
  {* ����� ������� vg:control:Left
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Left >>> l_Integer
[code]  }
  function vg_control_Left(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* ���������� ����� ������� vg:control:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlLeft
 
 TkwVgControlTop = class(TtfwClassLike)
  {* ����� ������� vg:control:Top
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:Top >>> l_Integer
[code]  }
  function vg_control_Top(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* ���������� ����� ������� vg:control:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlTop
 
 TkwVgControlEnabled = class(TtfwClassLike)
  {* ����� ������� vg:control:Enabled
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:Enabled >>> l_Boolean
[code]  }
  function vg_control_Enabled(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Boolean;
   {* ���������� ����� ������� vg:control:Enabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlEnabled
 
 TkwVgControlName = class(TtfwClassLike)
  {* ����� ������� vg:control:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aVisualObject vg:control:Name >>> l_String
[code]  }
  function vg_control_Name(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): AnsiString;
   {* ���������� ����� ������� vg:control:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlName
 
 TkwVgControlClick = class(TtfwClassLike)
  {* ����� ������� vg:control:Click
*������:*
[code]
 aVisualObject vg:control:Click
[code]  }
  procedure vg_control_Click(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject);
   {* ���������� ����� ������� vg:control:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlClick
 
 TkwVgControlCountSiblingLikeMe = class(TtfwClassLike)
  {* ����� ������� vg:control:CountSiblingLikeMe
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:CountSiblingLikeMe >>> l_Integer
[code]  }
  function vg_control_CountSiblingLikeMe(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* ���������� ����� ������� vg:control:CountSiblingLikeMe }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlCountSiblingLikeMe
 
 TkwVgControlGetIsChecked = class(TtfwClassLike)
  {* ����� ������� vg:control:GetIsChecked
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aVisualObject vg:control:GetIsChecked >>> l_Boolean
[code]  }
  function vg_control_GetIsChecked(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Boolean;
   {* ���������� ����� ������� vg:control:GetIsChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlGetIsChecked
 
 TkwVgControlSetIsChecked = class(TtfwClassLike)
  {* ����� ������� vg:control:SetIsChecked
*������:*
[code]
 aValue aVisualObject vg:control:SetIsChecked
[code]  }
  procedure vg_control_SetIsChecked(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject;
   aValue: Boolean);
   {* ���������� ����� ������� vg:control:SetIsChecked }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlSetIsChecked
 
 TkwVgControlLeftInScene = class(TtfwClassLike)
  {* ����� ������� vg:control:LeftInScene
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:LeftInScene >>> l_Integer
[code]  }
  function vg_control_LeftInScene(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* ���������� ����� ������� vg:control:LeftInScene }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlLeftInScene
 
 TkwVgControlTopInScene = class(TtfwClassLike)
  {* ����� ������� vg:control:TopInScene
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aVisualObject vg:control:TopInScene >>> l_Integer
[code]  }
  function vg_control_TopInScene(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): Integer;
   {* ���������� ����� ������� vg:control:TopInScene }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlTopInScene
 
 TkwVgControlScene = class(TtfwClassLike)
  {* ����� ������� vg:control:Scene
*��� ����������:* TControl
*������:*
[code]
OBJECT VAR l_TControl
 aVisualObject vg:control:Scene >>> l_TControl
[code]  }
  function vg_control_Scene(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): TControl;
   {* ���������� ����� ������� vg:control:Scene }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlScene
 
 TkwVgControlText = class(TtfwClassLike)
  {* ����� ������� vg:control:Text
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aVisualObject vg:control:Text >>> l_String
[code]  }
  function vg_control_Text(const aCtx: TtfwContext;
   aVisualObject: TvgVisualObject): AnsiString;
   {* ���������� ����� ������� vg:control:Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgControlText
 
end.
