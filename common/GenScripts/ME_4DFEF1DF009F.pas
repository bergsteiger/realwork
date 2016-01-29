unit evContentsNodeFilter;

interface

uses
 l3IntfUses
 , l3Base
 , evInternalInterfaces
 , l3Variant
 , k2SimpleTagList
 , nevTools
 , nevBase
;

type
 TevContentsNodeFilter = class(Tl3Base, InevContentsNodeFilter)
  {* фильтр оглваления документа }
  function NeedColor(const aNode: InevNode): Boolean;
  function GetDocContentLevel: Integer;
  procedure Create(aDocument: Tl3Variant);
  function Make(aDocument: Tl3Variant): InevContentsNodeFilter;
  procedure ColorNode(const aNode: InevNode);
  function FilteredNodeFlag: Integer;
  procedure CheckTagList;
  procedure AddFilterTag(aTag: Tl3Variant);
  procedure ChangeDocument(aDocument: Tl3Variant);
  function NeedCreate(aTag: Tl3Variant): Boolean;
 end;//TevContentsNodeFilter
 
implementation

uses
 l3ImplUses
 , evdTypes
 , l3TreeInterfaces
 , SysUtils
 , l3Bits
 , l3Types
 , l3MinMax
 , k2Tags
 , evContentsUtils
;

end.
