unit afwPreviewPageSpy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwPreviewPage
;

type
 IafwPagesLogger = interface
  procedure LogPage(aPage: TafwPreviewPage;
   aCounter: Boolean);
  procedure IncCounterPageNumer;
 end;//IafwPagesLogger
 
 TafwPreviewPageSpy = class(Tl3ProtoObject)
  {* Следилка за TafwPreviewPage, для [RequestLink:235873282] }
  function Exists: Boolean;
  procedure SetLogger(const aLogger: IafwPagesLogger);
  procedure RemoveLogger(const aLogger: IafwPagesLogger);
  procedure LogPage(aPage: TafwPreviewPage;
   aCounter: Boolean);
  procedure IncCounterNumber;
 end;//TafwPreviewPageSpy
 
implementation

uses
 l3ImplUses
;

end.
