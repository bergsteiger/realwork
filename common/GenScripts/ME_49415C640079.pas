unit vcmFormSetDataSourceWithoutData.imp;

interface

uses
 l3IntfUses
 , vcmInterfaces
;

type
 _vcmFormSetDataSourceWithoutData_ = class(_vcmFormSetDataSource_)
  {* ������ ������ ������. ��� "������ ������" }
  function MakeData: _SetDataType_;
   {* ������ ������. }
 end;//_vcmFormSetDataSourceWithoutData_
 
implementation

uses
 l3ImplUses
 , vcmLocalInterfaces
 , l3Base
 , SysUtils
;

end.
