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
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TtfwArchiHyperlinkScriptCallerResNameGetter
 
end.
