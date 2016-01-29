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
  {* ���� ��� TvtCustomLister }
 end;//TvtCustomListerFriend
 
 TkwPopListerSelectWithShift = class(TtfwClassLike)
  {* ����� ������� pop:Lister:SelectWithShift
[panel]*������:* 
[code]
aFinishID aLister pop:Lister:SelectWithShift
[code] 
*��������:* �������� ��������� ��������� �� �������� �� aFinishID � ��������� TvtCustomListner � �� �������� (TvtOutliner � �.�.). ������ ������ ��������� � ����� Shift �����.[panel]
*������:*
[code]
 aFinish aLister pop:Lister:SelectWithShift
[code]  }
  procedure SelectWithShift(const aCtx: TtfwContext;
   aLister: TvtCustomLister;
   aFinish: Integer);
   {* ���������� ����� ������� pop:Lister:SelectWithShift }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerSelectWithShift
 
 TkwPopListerGetSelected = class(TtfwClassLike)
  {* ����� ������� pop:Lister:GetSelected
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aLister pop:Lister:GetSelected >>> l_Boolean
[code]  }
  function GetSelected(const aCtx: TtfwContext;
   aLister: TvtCustomLister;
   anIndex: Integer): Boolean;
   {* ���������� ����� ������� pop:Lister:GetSelected }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerGetSelected
 
 TkwPopListerFooterCaption = class(TtfwClassLike)
  {* ����� ������� pop:Lister:FooterCaption
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aLister pop:Lister:FooterCaption >>> l_String
[code]  }
  function FooterCaption(const aCtx: TtfwContext;
   aLister: TvtCustomLister): AnsiString;
   {* ���������� ����� ������� pop:Lister:FooterCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerFooterCaption
 
 TkwPopListerCurrent = class(TtfwPropertyLike)
  {* ����� ������� pop:Lister:Current
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aLister pop:Lister:Current >>> l_Integer
[code]  }
  function Current(const aCtx: TtfwContext;
   aLister: TvtCustomLister): Integer;
   {* ���������� ����� ������� pop:Lister:Current }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopListerCurrent
 
end.
