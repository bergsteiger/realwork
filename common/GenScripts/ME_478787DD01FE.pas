unit afwStatus;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , afwInterfaces
 , IafwStatusElementPtrList
;

type
 TafwStatus = class(Tl3CProtoObject, IafwStatus)
  {* Реализация строки статуса. }
  procedure Create(const aMainForm: IafwMainForm);
  function Make(const aMainForm: IafwMainForm): IafwStatus;
   {* Создает экземпляр класса, в виде интерфейса IafwStatus. }
  procedure AddElement(const anElement: IafwStatusElement);
  procedure RemoveElement(const anElement: IafwStatusElement);
  procedure Update;
  procedure GetStatus(out theStatus: TafwStatusInfo);
 end;//TafwStatus
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
;

end.
