unit tfwArchiHyperlinkScriptCaller;

interface

uses
 l3IntfUses
 , tfwHyperlinkScriptCaller
 , tfwAxiomaticsResNameGetter
;

type
 TtfwArchiHyperlinkScriptCaller = class(TtfwHyperlinkScriptCaller)
 end;//TtfwArchiHyperlinkScriptCaller
 
implementation

uses
 l3ImplUses
;

type
 TtfwArchiHyperlinkScriptCallerResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TtfwArchiHyperlinkScriptCallerResNameGetter
 
end.
