unit kwInnerIncludedInChildren;

interface

uses
 l3IntfUses
 , kwInnerIncluded
 , tfwScriptingInterfaces
;

type
 TkwInnerIncludedInChildren = class(TkwInnerIncluded)
  procedure Create(const aFileName: AnsiString;
   aWordToIncludeTo: TtfwWord);
 end;//TkwInnerIncludedInChildren
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
