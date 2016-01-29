unit afwToolOwner.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3LongintList
;

type
 _afwToolOwner_ = class(Il3ToolOwner)
  procedure Cleanup;
  procedure AddTool(const aTool: Il3Tool);
   {* Добавить инструмент. }
  procedure RemoveTool(const aTool: Il3Tool);
   {* Удалить инструмент. }
 end;//_afwToolOwner_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
