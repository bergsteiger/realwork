unit evDefaultContext;

{ ���������� "�������"       } 
{ �����: ����� �.�. �        }
{ ������: evDefaultContext - }
{ �����: 25.10.2000 16:46    }
{ $Id: evDefaultContext.pas,v 1.3 2008/04/02 10:55:47 lulin Exp $ }

// $Log: evDefaultContext.pas,v $
// Revision 1.3  2008/04/02 10:55:47  lulin
// - ������ nevPrintableDocumentContainer �������� �� ������.
//
// Revision 1.2  2000/12/15 15:10:34  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  evOptimizedContext
  ;

type
  TevDefaultContext = class(TevOptimizedContext);  

implementation

end.

