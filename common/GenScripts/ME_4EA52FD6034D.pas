unit evEvdWriter;

interface

uses
 l3IntfUses
 , evdCustomNativeWriter
;

type
 TevCustomEvdStorageWriter = class(TevdCustomNativeWriter)
 end;//TevCustomEvdStorageWriter
 
 TevEvdStorageWriter = class(TevCustomEvdStorageWriter)
  {* �������� ����� � ������� evd � ����������������� ��������� (IStorage). (� published ����������) }
 end;//TevEvdStorageWriter
 
 TevPartContainer = class
 end;//TevPartContainer
 
implementation

uses
 l3ImplUses
;

end.
