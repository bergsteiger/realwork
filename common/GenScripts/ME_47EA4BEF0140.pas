unit afwApplicationDataUpdate.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwApplicationDataUpdate_ = class(IafwApplicationDataListener, Ml3Unknown)
  {* �������, ����������� IafwApplicationDataListener. }
  procedure FinishDataUpdate;
  procedure UpdateFinished;
   {* ����������� ��������� �� ��������� ���������� ������ }
 end;//_afwApplicationDataUpdate_
 
implementation

uses
 l3ImplUses
 , afwFacade
;

end.
