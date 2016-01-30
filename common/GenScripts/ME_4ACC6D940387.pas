unit BannerUnit;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BannerUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , ExternalObjectUnit
 , BaseTypesUnit
;

type
 IBanner = interface
  {* ������ }
  ['{B869F2FF-7971-44F1-BAA5-F664C978EF7F}']
  function open_link: IUnknown; { can raise CanNotFindData }
   {* ������� ������ ������� (���������� ��� IDocument ��� ExternalLink) }
  function get_picture: IExternalObject;
   {* �������� }
 end;//IBanner

class function make: BadFactoryType; { can raise CanNotFindData }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType; { can raise CanNotFindData }
var
 l_Inst : IBanner;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
