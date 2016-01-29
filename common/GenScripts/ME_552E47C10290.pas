unit ListerWordsPack;

interface

uses
 l3IntfUses
 , vtLister
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TvtCustomListerFriend = class(TvtCustomLister)
  {* Друг для TvtCustomLister }
 end;//TvtCustomListerFriend
 
 TkwPopListerSelectWithShift = class(TtfwClassLike)
  {* Слово скрипта pop:Lister:SelectWithShift
[panel]*Формат:* 
[code]
aFinishID aLister pop:Lister:SelectWithShift
[code] 
*Описание:* Выделяет несколько элементов от текущего до aFinishID у контролов TvtCustomListner и их потомков (TvtOutliner и т.п.). Полный аналог выделения с пощью Shift мышью.[panel]
*Пример:*
[code]
 aFinish aLister pop:Lister:SelectWithShift
[code]  }
  procedure SelectWithShift(const aCtx: TtfwContext;
   aLister: TvtCustomLister;
   aFinish: Integer);
   {* Реализация слова скрипта pop:Lister:SelectWithShift }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerSelectWithShift
 
 TkwPopListerGetSelected = class(TtfwClassLike)
  {* Слово скрипта pop:Lister:GetSelected
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aLister pop:Lister:GetSelected >>> l_Boolean
[code]  }
  function GetSelected(const aCtx: TtfwContext;
   aLister: TvtCustomLister;
   anIndex: Integer): Boolean;
   {* Реализация слова скрипта pop:Lister:GetSelected }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerGetSelected
 
 TkwPopListerFooterCaption = class(TtfwClassLike)
  {* Слово скрипта pop:Lister:FooterCaption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aLister pop:Lister:FooterCaption >>> l_String
[code]  }
  function FooterCaption(const aCtx: TtfwContext;
   aLister: TvtCustomLister): AnsiString;
   {* Реализация слова скрипта pop:Lister:FooterCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerFooterCaption
 
 TkwPopListerCurrent = class(TtfwPropertyLike)
  {* Слово скрипта pop:Lister:Current
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aLister pop:Lister:Current >>> l_Integer
[code]  }
  function Current(const aCtx: TtfwContext;
   aLister: TvtCustomLister): Integer;
   {* Реализация слова скрипта pop:Lister:Current }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerCurrent
 
end.
