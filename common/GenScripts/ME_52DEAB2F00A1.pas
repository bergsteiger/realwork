unit kwEvdBin2EvdTxt;

interface

uses
 l3IntfUses
 , tfwSysUtilsWord
 , tfwScriptingInterfaces
;

type
 TkwEvdBin2EvdTxt = class(TtfwSysUtilsWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEvdBin2EvdTxt
 
implementation

uses
 l3ImplUses
 , l3Filer
 , l3Interfaces
 , l3Memory
 , evEvdRd
 , evdNativeWriter
;

end.
