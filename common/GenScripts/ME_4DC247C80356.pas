unit AutoTest;

interface

uses
 l3IntfUses
 , CustomInsiderScripter
;

type
 TAutoTest = class(TCustomInsiderScripter)
  procedure Run;
  procedure Prepare;
   {* ���������� � ������ DoIt }
 end;//TAutoTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
;

end.
