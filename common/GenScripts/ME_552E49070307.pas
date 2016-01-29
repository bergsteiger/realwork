unit PageControlWordsPack;

interface

uses
 l3IntfUses
 , ElPgCtl
 , l3Interfaces
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3String
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopPageControlFindPageByCaption = class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:FindPageByCaption
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aCaption aPageControl pop:PageControl:FindPageByCaption >>> l_Integer
[code]  }
  function FindPageByCaption(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl;
   const aCaption: Il3CString): Integer;
   {* Реализация слова скрипта pop:PageControl:FindPageByCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlFindPageByCaption
 
 TkwPopPageControlPageCaptionByIndex = class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:PageCaptionByIndex
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 anIndex aPageControl pop:PageControl:PageCaptionByIndex >>> l_String
[code]  }
  function PageCaptionByIndex(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl;
   anIndex: Integer): AnsiString;
   {* Реализация слова скрипта pop:PageControl:PageCaptionByIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlPageCaptionByIndex
 
 TkwPopPageControlPageByIndex = class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:PageByIndex
*Тип результата:* TElTabSheet
*Пример:*
[code]
OBJECT VAR l_TElTabSheet
 anIndex aPageControl pop:PageControl:PageByIndex >>> l_TElTabSheet
[code]  }
  function PageByIndex(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl;
   anIndex: Integer): TElTabSheet;
   {* Реализация слова скрипта pop:PageControl:PageByIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlPageByIndex
 
 TkwPopPageControlGetAllPageCaptions = class(TtfwClassLike)
  {* Слово скрипта pop:PageControl:GetAllPageCaptions
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aPageControl pop:PageControl:GetAllPageCaptions >>> l_String
[code]  }
  function GetAllPageCaptions(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl): AnsiString;
   {* Реализация слова скрипта pop:PageControl:GetAllPageCaptions }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlGetAllPageCaptions
 
end.
