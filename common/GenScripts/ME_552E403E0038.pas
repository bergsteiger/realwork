unit StatusPanelWordsPack;

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
 TkwPopStatusPanelGetText = class(TtfwClassLike)
  {* ����� ������� pop:vtStatusPanel:GetText
[panel]*��������:* ���������� ����� ������
*������:* 
[code]
aPanel pop:vtStatusPanel:GetText
[code]
aPanel - ������ ������ TvtStatusPanel, ������� ����� �������� � ������� pop:vtStatusPanel:GetText[panel]
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aStatusPanel pop:vtStatusPanel:GetText >>> l_String
[code]  }
  function GetText(const aCtx: TtfwContext;
   aStatusPanel: TvtStatusPanel): AnsiString;
   {* ���������� ����� ������� pop:vtStatusPanel:GetText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopStatusPanelGetText
 
end.
