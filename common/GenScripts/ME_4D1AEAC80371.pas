unit TestNameList;

interface

uses
 l3IntfUses
 , l3StringList
 , l3Base
;

type
 TLoadOperation = (
  lo_Clear
  , lo_AND
  , lo_OR
  , lo_NOT
 );//TLoadOperation
 
 TTestNameList = class(Tl3StringList)
  {* Список тестов для  запуска. }
  function Exists: Boolean;
  procedure LoadFromFileEX(const aFileName: AnsiString;
   aOperation: TLoadOperation);
  procedure ClearList;
 end;//TTestNameList
 
implementation

uses
 l3ImplUses
 , TestNameString
;

end.
