unit eeSubDescriptorsExport;

interface

uses
 l3IntfUses
 , evSubPanel
 , eeInterfaces
 , l3CacheableBase
;

type
 TeeSubDescriptors = class(TevSubDescriptors, IeeSubViewDescriptors)
  function Subs: IeeSubViewDescriptor;
  function Markers: IeeSubViewDescriptor;
  function Bookmarks: IeeSubViewDescriptor;
 end;//TeeSubDescriptors
 
implementation

uses
 l3ImplUses
 , evdTypes
;

type
 TeeSubDescriptor = class(Tl3CacheableBase, IeeSubViewDescriptor)
  procedure Create(aDescriptors: TeeSubDescriptors;
   aLayerID: Integer);
  procedure Make(aDescriptors: TeeSubDescriptors;
   aLayerID: Integer);
  function Visible: Boolean;
 end;//TeeSubDescriptor
 
end.
