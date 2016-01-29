unit evStandardStylesList;

interface

uses
 l3IntfUses
 , evStandardStylesListPrim
 , evResultFontInterfaces
 , l3Types
;

type
 TevStandardStylesList = class(_l3Searcher_)
  function StyleByID(anID: Integer;
   aJust: Boolean;
   aVis: Boolean;
   aFixed: Boolean): IevResultFont;
  procedure AddStyleByID(anID: Integer;
   aJust: Boolean;
   aVis: Boolean;
   aFixed: Boolean;
   const aStyle: IevResultFont);
 end;//TevStandardStylesList
 
implementation

uses
 l3ImplUses
 , l3Base
 , evResultFontHolder
;

end.
