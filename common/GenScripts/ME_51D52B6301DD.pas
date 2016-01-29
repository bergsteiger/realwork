unit AppConfigBaseTest;

interface

uses
 l3IntfUses
 , EmptyFormTest
 , AppConfigTestMixin.imp
 , Types
;

type
 TAppConfigBaseTest = class(TEmptyFormTest)
  {* Тесты на работу конфигурации }
 end;//TAppConfigBaseTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , Messages
 , vtCheckBox
 , TestFrameWork
;

end.
