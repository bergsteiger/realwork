unit EmptyFormTest;

interface

uses
 l3IntfUses
 , BaseTest
 , FromWithPanel_Form
;

type
 TEmptyFormTest = class(TBaseTest)
  procedure DoIt;
  procedure CheckControl;
 end;//TEmptyFormTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 , Forms
 , l3Base
;

end.
