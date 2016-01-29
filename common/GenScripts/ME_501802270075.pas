unit vcmFormDataSourceWithData.imp;

interface

uses
 l3IntfUses
;

type
 // _InitDataType_
 
 _vcmFormDataSourceWithData_ = class(Ml3Unknown)
  procedure Create(const aDataSource: _UseCaseControllerType_;
   const aData: _InitDataType_);
   {* Конструктор }
  function Make(const aDataSource: _UseCaseControllerType_;
   const aData: _InitDataType_): _FormDataSourceType_;
  procedure DoInit;
  procedure GotData;
   {* - данные изменились. }
 end;//_vcmFormDataSourceWithData_
 
implementation

uses
 l3ImplUses
;

end.
