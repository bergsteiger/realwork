unit DataAdapterRes;

interface
uses
 l3StringIDEx;

const
  // ������������ ������ ��� ��������� � ������ ������� ������ �� ������� ��������� �����
  // http://mdp.garant.ru/pages/viewpage.action?pageId=508825964
  str_warInvalidMargins : Tl3StringIDEx = (rS : -1; rLocalized : false;
   rKey : 'warInvalidMargins'; rValue : '������� ������ ������� �� ������� ��������� �����. '+
   '�������������� ��������� ������� ������ � ������������ � ��������� ������� ������.');

implementation

initialization
 str_warInvalidMargins.Init;

end.
