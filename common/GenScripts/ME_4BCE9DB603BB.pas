unit K204114253;

interface

uses
 l3IntfUses
 , VCMBaseTest
 , elCustomEdit_Form
 , elCustomEdit
;

type
 TK204114253 = class(TVCMBaseTest)
  {* [$204114253] }
  procedure DoIt;
 end;//TK204114253
 
implementation

uses
 l3ImplUses
 , evdSchema
 , TestFrameWork
 , vcmBase
 , SysUtils
 , Forms
 , l3Base
;

type
 TelCustomEditHack = class(TelCustomEdit)
 end;//TelCustomEditHack
 
end.
