unit nevFormatInfoArray;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevFormatInfoList
 , nevFormatInfo
;

type
 TnevFormatInfoArray = class(Tl3CProtoObject)
  {* "Разреженный" массив с информацией о форматировании параграфов, см. [$122672470] }
  procedure ClearReferencesToParentFormatInfo;
  procedure ChildAdded(anIndex: Integer);
  procedure ChildDeleted(anIndex: Integer);
 end;//TnevFormatInfoArray
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
