unit csCourtsListHelper;

interface

uses
 l3IntfUses
 , CourtDescription_Const
 , l3Variant
 , evdTasksHelpers
;

type
 CourtsListHelper = interface
  procedure Add(anItem: Tl3Tag);
 end;//CourtsListHelper
 
 TCourtsListHelper = class(TevdTagHelper, CourtsListHelper)
  function Make(aValue: Tl3Tag): CourtsListHelper;
  function Count: Integer;
  procedure Add(anItem: Tl3Tag);
  function Courts: Tl3Tag;
 end;//TCourtsListHelper
 
implementation

uses
 l3ImplUses
;

end.
