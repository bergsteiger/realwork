unit evEvdReader;

interface

uses
 l3IntfUses
 , evEvdRd
;

type
 TevCustomEvdStorageReader = class(TevCustomEvdReader)
  {* �������� ����� � ������� evd �� ������������������ ��������� (IStorage) }
 end;//TevCustomEvdStorageReader
 
 TevEvdStorageReader = class(TevCustomEvdStorageReader)
  {* �������� ����� � ������� evd (� published ����������). }
 end;//TevEvdStorageReader
 
implementation

uses
 l3ImplUses
;

end.
