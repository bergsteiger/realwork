unit tfwOtherWordRunner.imp;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwAnonimousWord
;

type
 _tfwOtherWordRunner_ = class
  procedure RunOther(const aCtx: TtfwContext);
  function GetWordToRun: TtfwAnonimousWord;
 end;//_tfwOtherWordRunner_
 
implementation

uses
 l3ImplUses
;

end.
