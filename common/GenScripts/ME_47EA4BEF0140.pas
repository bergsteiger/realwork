unit afwApplicationDataUpdate.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwApplicationDataUpdate_ = class(IafwApplicationDataListener, Ml3Unknown)
  {* Примесь, реализующая IafwApplicationDataListener. }
  procedure FinishDataUpdate;
  procedure UpdateFinished;
   {* Информирует слушателя об окончании обновления данных }
 end;//_afwApplicationDataUpdate_
 
implementation

uses
 l3ImplUses
 , afwFacade
;

end.
