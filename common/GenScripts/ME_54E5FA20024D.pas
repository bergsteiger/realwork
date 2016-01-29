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
  {* ����� ������� pop:HideField:IsExpanded
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aHideField pop:HideField:IsExpanded >>> l_Boolean
[code]  }
  function IsExpanded(const aCtx: TtfwContext;
   aHideField: TvtCustomHideField): Boolean;
   {* ���������� ����� ������� pop:HideField:IsExpanded }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopHideFieldIsExpanded
 
 TkwPopHideFieldSetExpanded = class(TtfwClassLike)
  {* ����� ������� pop:HideField:SetExpanded
*������:*
[code]
 aValue aHideField pop:HideField:SetExpanded
[code]  }
  procedure SetExpanded(const aCtx: TtfwContext;
   aHideField: TvtCustomHideField;
   aValue: Boolean);
   {* ���������� ����� ������� pop:HideField:SetExpanded }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopHideFieldSetExpanded
 
 TkwPopHideFieldGetCaption = class(TtfwClassLike)
  {* ����� ������� pop:HideField:GetCaption
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aHideField pop:HideField:GetCaption >>> l_String
[code]  }
  function GetCaption(const aCtx: TtfwContext;
   aHideField: TvtCustomHideField): AnsiString;
   {* ���������� ����� ������� pop:HideField:GetCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopHideFieldGetCaption
 
end.
