unit vtComboBoxWordsPack;

interface

uses
 l3IntfUses
 , StdCtrls
 , vtComboTree
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwAxiomaticsResNameGetters
 , vtComboBoxQS
 , l3TreeInterfaces
 , l3Filer
 , l3Types
 , l3Interfaces
 , SysUtils
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TvtComboBoxWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TvtComboBoxWordsPackResNameGetter
 
 TCustomComboBoxFriend = class(TCustomComboBox)
  {* Друг для TCustomComboBox }
 end;//TCustomComboBoxFriend
 
 TkwPopComboBoxDropDown = class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:DropDown
*Пример:*
[code]
 aValue aComboBox pop:ComboBox:DropDown
[code]  }
  procedure DropDown(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   aValue: Boolean);
   {* Реализация слова скрипта pop:ComboBox:DropDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxDropDown
 
 TkwPopComboBoxGetItemIndex = class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:GetItemIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboBox pop:ComboBox:GetItemIndex >>> l_Integer
[code]  }
  function GetItemIndex(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox): Integer;
   {* Реализация слова скрипта pop:ComboBox:GetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxGetItemIndex
 
 TkwPopComboBoxIndexOf = class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:IndexOf
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aString aComboBox pop:ComboBox:IndexOf >>> l_Integer
[code]  }
  function IndexOf(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   const aString: AnsiString): Integer;
   {* Реализация слова скрипта pop:ComboBox:IndexOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxIndexOf
 
 TkwPopComboBoxSelectItem = class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:SelectItem
*Пример:*
[code]
 aString aComboBox pop:ComboBox:SelectItem
[code]  }
  procedure SelectItem(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   const aString: AnsiString);
   {* Реализация слова скрипта pop:ComboBox:SelectItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxSelectItem
 
 TkwPopComboBoxSetItemIndex = class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:SetItemIndex
*Пример:*
[code]
 anIndex aComboBox pop:ComboBox:SetItemIndex
[code]  }
  procedure SetItemIndex(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   anIndex: Integer);
   {* Реализация слова скрипта pop:ComboBox:SetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxSetItemIndex
 
 TkwPopComboBoxSaveItems = class(TtfwClassLike)
  {* Слово скрипта pop:ComboBox:SaveItems
[panel]*Формат:* имя_файла  контрол pop:ComboBox:SaveItems 
*Описание:* Сохраняет все пункты выпадающего списка (задается параметром контрол) в файл (задается параметром имя_файла)  и сравнивает с эталоном.
*Пример:*
[code]
'MyList.cmbx' 'StyleComboBox' byname:control:push pop:ComboBox:SaveItems
[code] 
*Результат:* Сохраняет содержимое комбобокса 'StyleComboBox' в  файл  'MyList.cmbx' и сравнивает с эталоном.[panel]
*Пример:*
[code]
 aFileName aComboBox pop:ComboBox:SaveItems
[code]  }
  procedure SaveItems(const aCtx: TtfwContext;
   aComboBox: TCustomComboBox;
   const aFileName: AnsiString);
   {* Реализация слова скрипта pop:ComboBox:SaveItems }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboBoxSaveItems
 
 TkwPopComboTreeDropDown = class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:DropDown
*Пример:*
[code]
 aValue aComboTree pop:ComboTree:DropDown
[code]  }
  procedure DropDown(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   aValue: Boolean);
   {* Реализация слова скрипта pop:ComboTree:DropDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeDropDown
 
 TkwPopComboTreeGetItemIndex = class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:GetItemIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComboTree pop:ComboTree:GetItemIndex >>> l_Integer
[code]  }
  function GetItemIndex(const aCtx: TtfwContext;
   aComboTree: TvtComboTree): Integer;
   {* Реализация слова скрипта pop:ComboTree:GetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeGetItemIndex
 
 TkwPopComboTreeIndexOf = class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:IndexOf
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aString aComboTree pop:ComboTree:IndexOf >>> l_Integer
[code]  }
  function IndexOf(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   const aString: AnsiString): Integer;
   {* Реализация слова скрипта pop:ComboTree:IndexOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeIndexOf
 
 TkwPopComboTreeSelectItem = class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:SelectItem
*Пример:*
[code]
 aString aComboTree pop:ComboTree:SelectItem
[code]  }
  procedure SelectItem(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   const aString: AnsiString);
   {* Реализация слова скрипта pop:ComboTree:SelectItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeSelectItem
 
 TkwPopComboTreeSetItemIndex = class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:SetItemIndex
*Пример:*
[code]
 anIndex aComboTree pop:ComboTree:SetItemIndex
[code]  }
  procedure SetItemIndex(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   anIndex: Integer);
   {* Реализация слова скрипта pop:ComboTree:SetItemIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeSetItemIndex
 
 TkwPopComboTreeSaveItems = class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:SaveItems
[panel]*Формат:* имя_файла  контрол pop:ComboBox:SaveItems 
*Описание:* Сохраняет все пункты выпадающего списка (задается параметром контрол) в файл (задается параметром имя_файла)  и сравнивает с эталоном.
*Пример:*
[code]
'MyList.cmbx' 'StyleComboBox' byname:control:push pop:ComboBox:SaveItems
[code] 
*Результат:* Сохраняет содержимое комбобокса 'StyleComboBox' в  файл  'MyList.cmbx' и сравнивает с эталоном.[panel]
*Пример:*
[code]
 aFileName aComboTree pop:ComboTree:SaveItems
[code]  }
  procedure SaveItems(const aCtx: TtfwContext;
   aComboTree: TvtComboTree;
   const aFileName: AnsiString);
   {* Реализация слова скрипта pop:ComboTree:SaveItems }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeSaveItems
 
end.
