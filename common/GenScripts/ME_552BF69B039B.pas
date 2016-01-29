unit l3AutolinkService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Variant
;

 (*
 Ml3AutolinkService = interface
  {* �������� ������� Tl3AutolinkService }
  function GetAutolinkFilter: Ik2TagGenerator;
  procedure CleanAutolinkFilter;
 end;//Ml3AutolinkService
 *)
 
type
 Il3AutolinkService = interface
  {* ��������� ������� Tl3AutolinkService }
  function GetAutolinkFilter: Ik2TagGenerator;
  procedure CleanAutolinkFilter;
 end;//Il3AutolinkService
 
 Tl3AutolinkService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetAutolinkFilter: Ik2TagGenerator;
  procedure CleanAutolinkFilter;
 end;//Tl3AutolinkService
 
implementation

uses
 l3ImplUses
 , AutolinkFilterWordsPack
;

end.
