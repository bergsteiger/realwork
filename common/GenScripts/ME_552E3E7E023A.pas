unit StatusBarWordsPack;

interface

uses
 l3IntfUses
 , vtStatusBar
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
 TkwPopStatusBarGetPanel = class(TtfwClassLike)
  {* ����� ������� pop:vtStatusBar:GetPanel
[panel]*��������:* �������� � ���� ������ ���������� �� ������.
������:
[code]
anIndex aStatusControl pop:vtStatusBar:GetPanel
[code]
anIndex - ����� ������.
aStatusControl - ������� ������-���.
� ���� ���������� ������ ������ TvtStatusPanel[panel]
*��� ����������:* TvtStatusPanel
*������:*
[code]
OBJECT VAR l_TvtStatusPanel
 anIndex aStatusBar pop:vtStatusBar:GetPanel >>> l_TvtStatusPanel
[code]  }
  function GetPanel(const aCtx: TtfwContext;
   aStatusBar: TvtStatusBar;
   anIndex: Integer): TvtStatusPanel;
   {* ���������� ����� ������� pop:vtStatusBar:GetPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopStatusBarGetPanel
 
end.
