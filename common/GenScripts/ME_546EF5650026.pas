unit ncsFileDescHelper;

interface

uses
 l3IntfUses
 , FileDesc_Const
 , l3Variant
 , evdTasksHelpers
;

type
 FileDescHelper = interface
  procedure Add(anItem: Tl3Tag);
 end;//FileDescHelper
 
 TFileDescHelper = class(TevdTagHelper, FileDescHelper)
  function Make(aValue: Tl3Tag): FileDescHelper;
  function Count: Integer;
  function Files: Tl3Tag;
  procedure Add(anItem: Tl3Tag);
 end;//TFileDescHelper
 
implementation

uses
 l3ImplUses
;

end.
