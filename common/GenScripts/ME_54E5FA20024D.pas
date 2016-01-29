unit vtHideFieldWords;

interface

uses
 l3IntfUses
 , vtHideField
 , tfwClassLike
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
 TkwPopHideFieldIsExpanded = class(TtfwClassLike)
  {* Слово скрипта pop:HideField:IsExpanded
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aHideField pop:HideField:IsExpanded >>> l_Boolean
[code]  }
  function IsExpanded(const aCtx: TtfwContext;
   aHideField: TvtCustomHideField): Boolean;
   {* Реализация слова скрипта pop:HideField:IsExpanded }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopHideFieldIsExpanded
 
 TkwPopHideFieldSetExpanded = class(TtfwClassLike)
  {* Слово скрипта pop:HideField:SetExpanded
*Пример:*
[code]
 aValue aHideField pop:HideField:SetExpanded
[code]  }
  procedure SetExpanded(const aCtx: TtfwContext;
   aHideField: TvtCustomHideField;
   aValue: Boolean);
   {* Реализация слова скрипта pop:HideField:SetExpanded }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopHideFieldSetExpanded
 
 TkwPopHideFieldGetCaption = class(TtfwClassLike)
  {* Слово скрипта pop:HideField:GetCaption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aHideField pop:HideField:GetCaption >>> l_String
[code]  }
  function GetCaption(const aCtx: TtfwContext;
   aHideField: TvtCustomHideField): AnsiString;
   {* Реализация слова скрипта pop:HideField:GetCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopHideFieldGetCaption
 
end.
