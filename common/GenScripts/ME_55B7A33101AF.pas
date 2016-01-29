unit tfwAxiomaticsResNameGetter;

interface

uses
 l3IntfUses
;

type
 RtfwAxiomaticsResNameGetter = class of TtfwAxiomaticsResNameGetter;
 
 TtfwAxiomaticsResNameGetter = class
  function ResName: AnsiString;
  procedure Register;
 end;//TtfwAxiomaticsResNameGetter
 
implementation

uses
 l3ImplUses
 , tfwAxiomaticsResNameGetters
;

end.
