unit PharmFirmListUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/PharmFirmListUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// ������ ����
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
  DocumentUnit
  ;

type
 IPharmFirmListEntry = interface(IEntityBase)
  {* ������� ��� ���������-����� �� ������ }
   ['{7408C436-42FD-4AD7-879D-5C2625EFAE18}']
   procedure GetDocument(out aRet {: IDocument}); stdcall;
 end;//IPharmFirmListEntry

implementation

end.