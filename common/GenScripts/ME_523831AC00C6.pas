unit LostNodeAppConfigTest;

interface

uses
 l3IntfUses
 , EmptyFormTest
 , AppConfigTestMixin.imp
 , Types
;

type
 TLostNodeAppConfigTest = class(TEmptyFormTest)
 end;//TLostNodeAppConfigTest
 
implementation

uses
 l3ImplUses
 , ddAppConfigLists
 , ddAppConfigDates
 , ddAppConfigConst
 , ddAppConfigStrings
 , ddAppConfigDataAdapters
 , TestFrameWork
;

end.
