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
   {* �������� ����������. }
  procedure RemoveTool(const aTool: Il3Tool);
   {* ������� ����������. }
 end;//_afwToolOwner_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
