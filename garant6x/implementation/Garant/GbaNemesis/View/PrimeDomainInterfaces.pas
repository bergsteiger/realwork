unit PrimeDomainInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$Strange"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimeDomainInterfaces.pas"
// �����: 21.10.2009 21:07
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::View$Strange::PrimeDomainInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PrimeUnit
  ;

type
 InsPrimeNode = interface(IUnknown)
  {* ���� ������ ��������� ���� }
   ['{E5BF71FF-A857-40FD-A325-7B8F18DEEA50}']
   function pm_GetData: IPrime;
   property Data: IPrime
     read pm_GetData;
 end;//InsPrimeNode
{$IfEnd} //not Admin

implementation

end.