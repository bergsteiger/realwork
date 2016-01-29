unit m3StorageService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Mm3StorageService = interface
  {* �������� ������� Tm3StorageService }
  function UseSplitted: Boolean;
  function SetUseSplitted(aValue: Boolean): Boolean;
 end;//Mm3StorageService
 *)
 
type
 Im3StorageService = interface
  {* ��������� ������� Tm3StorageService }
  function UseSplitted: Boolean;
  function SetUseSplitted(aValue: Boolean): Boolean;
 end;//Im3StorageService
 
 Tm3StorageService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function UseSplitted: Boolean;
  function SetUseSplitted(aValue: Boolean): Boolean;
 end;//Tm3StorageService
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
