unit BannerUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/BannerUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  ExternalObjectUnit
  ;

type
 IBanner = interface(IUnknown)
  {* ������ }
   ['{B869F2FF-7971-44F1-BAA5-F664C978EF7F}']
   procedure OpenLink(out aRet {: IUnknown}); stdcall; // can raise CanNotFindData
     {* ������� ������ ������� (���������� ��� IDocument ��� ExternalLink) }
   procedure GetPicture(out aRet {: IExternalObject}); stdcall;
     {* �������� }
 end;//IBanner

implementation

end.