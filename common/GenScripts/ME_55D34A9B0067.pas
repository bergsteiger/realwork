unit tfwF1HyperlinkScriptCaller;

interface

uses
 l3IntfUses
 , tfwHyperlinkScriptCaller
 , tfwAxiomaticsResNameGetter
;

type
 TtfwF1HyperlinkScriptCaller = class(TtfwHyperlinkScriptCaller)
 end;//TtfwF1HyperlinkScriptCaller
 
implementation

uses
 l3ImplUses
;

type
 TtfwF1HyperlinkScriptCallerResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TtfwF1HyperlinkScriptCallerResNameGetter
 
end.
