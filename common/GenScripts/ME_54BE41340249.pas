unit eeSubList;

interface

uses
 l3IntfUses
 , eeTagEditorTool
 , eeInterfaces
 , l3Interfaces
;

type
 TeeSubList = class(TeeTagEditorTool, IeeSubList)
  function Count: Integer;
  function Subs: IeeSub;
  function SubsByID: IeeSub;
  function Add(anID: Integer;
   const aName: Il3CString): IeeSub;
 end;//TeeSubList
 
implementation

uses
 l3ImplUses
;

end.
