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
  {* Слово скрипта vcm:Toolbar:SetGlyphSize
*Пример:*
[code]
 aValue vcm:Toolbar:SetGlyphSize
[code]  }
  procedure vcm_Toolbar_SetGlyphSize(const aCtx: TtfwContext;
   aValue: TvcmGlyphSize);
   {* Реализация слова скрипта vcm:Toolbar:SetGlyphSize }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarSetGlyphSize
 
 TkwVcmToolbarGetGlyphSize = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:GetGlyphSize
*Тип результата:* TvcmGlyphSize
*Пример:*
[code]
TvcmGlyphSize VAR l_TvcmGlyphSize
 vcm:Toolbar:GetGlyphSize >>> l_TvcmGlyphSize
[code]  }
  function vcm_Toolbar_GetGlyphSize(const aCtx: TtfwContext): TvcmGlyphSize;
   {* Реализация слова скрипта vcm:Toolbar:GetGlyphSize }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarGetGlyphSize
 
 TkwVcmToolbarGetGlyphColorDepth = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:GetGlyphColorDepth
*Тип результата:* TvcmGlyphColordepth
*Пример:*
[code]
TvcmGlyphColordepth VAR l_TvcmGlyphColordepth
 vcm:Toolbar:GetGlyphColorDepth >>> l_TvcmGlyphColordepth
[code]  }
  function vcm_Toolbar_GetGlyphColorDepth(const aCtx: TtfwContext): TvcmGlyphColordepth;
   {* Реализация слова скрипта vcm:Toolbar:GetGlyphColorDepth }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarGetGlyphColorDepth
 
 TkwVcmToolbarSetGlyphColorDepth = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:Toolbar:SetGlyphColorDepth
*Пример:*
[code]
 aValue vcm:Toolbar:SetGlyphColorDepth
[code]  }
  procedure vcm_Toolbar_SetGlyphColorDepth(const aCtx: TtfwContext;
   aValue: TvcmGlyphColordepth);
   {* Реализация слова скрипта vcm:Toolbar:SetGlyphColorDepth }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmToolbarSetGlyphColorDepth
 
end.
