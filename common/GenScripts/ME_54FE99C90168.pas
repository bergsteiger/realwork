unit ncsDataAccessServices;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TncsDataAccessServices = class(Tl3ProtoObject)
  procedure InitClient;
   {* ����������� � ������������ ������� ��� TdaDataProviderSuperFactory
������ ���� ������ �� ��������� � ������� TdaDataProviderSuperFactory }
  procedure InitServer;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TncsDataAccessServices
 
implementation

uses
 l3ImplUses
 , SysUtils
 , htDataProviderFactory
 , daDataProviderSuperFactory
 , ncsClientParamsStorage
 , daScheme
 , pgDataProviderFactory
 , ncsServerParamsStorage
;

end.
