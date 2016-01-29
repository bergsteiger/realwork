unit vtOutlinerWithQuickSearch;

interface

uses
 l3IntfUses
 , vtOutliner
 , Types
 , Classes
;

type
 TvtOutlinerWithQuickSearch = class(TvtCustomOutliner)
  procedure QuickSearchHandler(Sender: TObject;
   const aString: AnsiString);
  procedure QuickSearchHintTimerEvent(Sender: TObject);
 end;//TvtOutlinerWithQuickSearch
 
implementation

uses
 l3ImplUses
 , Controls
 , Windows
 , Forms
 , TtfwClassRef_Proxy
;

end.
