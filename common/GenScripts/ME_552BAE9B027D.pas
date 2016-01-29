unit VCMApllicationSettingsPack;

interface

uses
 l3IntfUses
 , vcmToolbarMenuRes
 , vcmMenuManager
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwVcmToolbarSetGlyphSize = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:SetGlyphSize
*������:*
[code]
 aValue vcm:Toolbar:SetGlyphSize
[code]  }
  procedure vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
   aValue: TvcmGlyphSize);
   {* ���������� ����� ������� vcm:Toolbar:SetGlyphSize }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarSetGlyphSize
 
 TkwVcmToolbarGetGlyphSize = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:GetGlyphSize
*��� ����������:* TvcmGlyphSize
*������:*
[code]
TvcmGlyphSize VAR l_TvcmGlyphSize
 vcm:Toolbar:GetGlyphSize >>> l_TvcmGlyphSize
[code]  }
  function vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
   {* ���������� ����� ������� vcm:Toolbar:GetGlyphSize }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarGetGlyphSize
 
 TkwVcmToolbarGetGlyphColorDepth = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:GetGlyphColorDepth
*��� ����������:* TvcmGlyphColordepth
*������:*
[code]
TvcmGlyphColordepth VAR l_TvcmGlyphColordepth
 vcm:Toolbar:GetGlyphColorDepth >>> l_TvcmGlyphColordepth
[code]  }
  function vcm_Toolbar_GetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
   {* ���������� ����� ������� vcm:Toolbar:GetGlyphColorDepth }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarGetGlyphColorDepth
 
 TkwVcmToolbarSetGlyphColorDepth = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:Toolbar:SetGlyphColorDepth
*������:*
[code]
 aValue vcm:Toolbar:SetGlyphColorDepth
[code]  }
  procedure vcm_Toolbar_SetGlyphColorDepth(const aCtx: TtfwContext;
   aValue: TvcmGlyphColordepth);
   {* ���������� ����� ������� vcm:Toolbar:SetGlyphColorDepth }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarSetGlyphColorDepth
 
end.
