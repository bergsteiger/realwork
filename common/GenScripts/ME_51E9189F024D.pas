unit ddCustomDestination;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddRTFProperties
 , rtfListTable
 , ddTypes
;

type
 TddCustomDestination = class(Tl3ProtoObject)
  function GetStyle(aStyleID: Integer): TddStyleEntry;
  function GetList(aListID: Integer;
   out aWasRestart: Boolean): TrtfList;
  function GetClearBorderType: TddClearBoder;
  procedure BeforeCloseParagraph(const aDocAtom: TObject;
   var aNewStyle: Integer);
  function GetMinPictureWidth: Integer;
  function GetMinPictureHeight: Integer;
  function NextTextPara(const anCurrent: TObject): TObject;
 end;//TddCustomDestination
 
implementation

uses
 l3ImplUses
;

end.
