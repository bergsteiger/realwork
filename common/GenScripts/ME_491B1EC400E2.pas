unit vcmFormDataSource;

interface

uses
 l3IntfUses
 , vcmControllers
;

type
 TvcmFormDataSource = class(_vcmFormDataSource_)
  {* "Бизнес объект формы". Для поддержки старого нетипизированного подхода }
 end;//TvcmFormDataSource
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

end.
