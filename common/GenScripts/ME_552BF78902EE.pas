unit ddAutoLinkServices;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3AutolinkService
 , l3Variant
;

type
 TddAutolinkService = class(Tl3ProtoObject, Il3AutolinkService)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetAutolinkFilter: Ik2TagGenerator;
  procedure CleanAutolinkFilter;
 end;//TddAutolinkService
 
implementation

uses
 l3ImplUses
 , ddAutoLinkFilter
;

end.
