unit VGComboBoxPack;

interface

uses
 l3IntfUses
 , vg_listbox
 , tfwAxiomaticsResNameGetter
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
 TVGComboBoxPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TVGComboBoxPackResNameGetter
 
 TkwVgComboBoxGetText = class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetText
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aComboBox vg:ComboBox:GetText >>> l_String
[code]  }
  function vg_ComboBox_GetText(const aCtx: TtfwContext;
   aComboBox: TvgComboBox): AnsiString;
   {* Реализация слова скрипта vg:ComboBox:GetText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgComboBoxGetText
 
 TkwVgComboBoxItemHeight = class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:ItemHeight
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:ItemHeight >>> l_Integer
[code]  }
  function vg_ComboBox_ItemHeight(const aCtx: TtfwContext;
   aComboBox: TvgComboBox): Integer;
   {* Реализация слова скрипта vg:ComboBox:ItemHeight }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgComboBoxItemHeight
 
 TkwVgComboBoxItemIndex = class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:ItemIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:ItemIndex >>> l_Integer
[code]  }
  function vg_ComboBox_ItemIndex(const aCtx: TtfwContext;
   aComboBox: TvgComboBox): Integer;
   {* Реализация слова скрипта vg:ComboBox:ItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgComboBoxItemIndex
 
 TkwVgComboBoxGetItem = class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetItem
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 anIndex aComboBox vg:ComboBox:GetItem >>> l_String
[code]  }
  function vg_ComboBox_GetItem(const aCtx: TtfwContext;
   aComboBox: TvgComboBox;
   anIndex: Integer): AnsiString;
   {* Реализация слова скрипта vg:ComboBox:GetItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgComboBoxGetItem
 
 TkwVgComboBoxGetHighLightItemIndex = class(TtfwClassLike)
  {* Слово скрипта vg:ComboBox:GetHighLightItemIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:GetHighLightItemIndex >>> l_Integer
[code]  }
  function vg_ComboBox_GetHighLightItemIndex(const aCtx: TtfwContext;
   aComboBox: TvgComboBox): Integer;
   {* Реализация слова скрипта vg:ComboBox:GetHighLightItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVgComboBoxGetHighLightItemIndex
 
end.
