unit Masks;

interface

uses
 l3IntfUses
 , SysUtils
;

type
 EMaskException = class(Exception)
 end;//EMaskException
 
 TMask = class
  {* TMask allows the comparison of strings containing wildcards to a file mask. }
 end;//TMask
 
implementation

uses
 l3ImplUses
;

end.
