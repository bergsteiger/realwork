unit nevFormatPool;

interface

uses
 l3IntfUses
 , nevFormatPoolBase
 , nevTools
 , nevBase
 , nevRootFormatInfoListPrim
 , l3Types
;

type
 TnevRootFormatInfoKey = record
 end;//TnevRootFormatInfoKey
 
 TnevRootFormatInfoList = class(_l3Searcher_)
 end;//TnevRootFormatInfoList
 
 TnevFormatPool = class(_nevChildSpy_, InevFormatPool)
  procedure AfterSectionBreakAdded;
  procedure Clear;
  function FormatInfoForView(const aView: InevView): TnevFormatInfoPrim;
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  procedure ChildAdded(const aList: InevParaList;
   const aChild: InevPara);
  procedure ChildDeleted(const aList: InevParaList;
   const aChild: InevPara);
  procedure ClearFormatInfoForView(const aView: InevView);
 end;//TnevFormatPool
 
implementation

uses
 l3ImplUses
 , nevRootFormatInfo
 , SysUtils
 , nevPrintingRootFormatInfo
;

end.
