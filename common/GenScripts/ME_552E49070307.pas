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
  {* ����� ������� pop:PageControl:FindPageByCaption
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aCaption aPageControl pop:PageControl:FindPageByCaption >>> l_Integer
[code]  }
  function FindPageByCaption(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl;
   const aCaption: Il3CString): Integer;
   {* ���������� ����� ������� pop:PageControl:FindPageByCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlFindPageByCaption
 
 TkwPopPageControlPageCaptionByIndex = class(TtfwClassLike)
  {* ����� ������� pop:PageControl:PageCaptionByIndex
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 anIndex aPageControl pop:PageControl:PageCaptionByIndex >>> l_String
[code]  }
  function PageCaptionByIndex(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl;
   anIndex: Integer): AnsiString;
   {* ���������� ����� ������� pop:PageControl:PageCaptionByIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlPageCaptionByIndex
 
 TkwPopPageControlPageByIndex = class(TtfwClassLike)
  {* ����� ������� pop:PageControl:PageByIndex
*��� ����������:* TElTabSheet
*������:*
[code]
OBJECT VAR l_TElTabSheet
 anIndex aPageControl pop:PageControl:PageByIndex >>> l_TElTabSheet
[code]  }
  function PageByIndex(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl;
   anIndex: Integer): TElTabSheet;
   {* ���������� ����� ������� pop:PageControl:PageByIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlPageByIndex
 
 TkwPopPageControlGetAllPageCaptions = class(TtfwClassLike)
  {* ����� ������� pop:PageControl:GetAllPageCaptions
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aPageControl pop:PageControl:GetAllPageCaptions >>> l_String
[code]  }
  function GetAllPageCaptions(const aCtx: TtfwContext;
   aPageControl: TElCustomPageControl): AnsiString;
   {* ���������� ����� ������� pop:PageControl:GetAllPageCaptions }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopPageControlGetAllPageCaptions
 
end.
