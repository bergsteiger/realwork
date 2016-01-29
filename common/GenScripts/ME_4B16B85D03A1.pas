unit vcmData.imp;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
;

type
 // _IvcmRealData_
 
 _vcmData_ = class(Tl3ProtoObject, IvcmData)
  procedure Create(const aData: _IvcmRealData_); overload;
  procedure MakeFrom(const aData: _IvcmRealData_);
  procedure AssignData(const aData: _IvcmRealData_);
  procedure Create; overload;
  function Clone: IvcmData;
   {* сделать копию }
 end;//_vcmData_
 
implementation

uses
 l3ImplUses
;

end.
