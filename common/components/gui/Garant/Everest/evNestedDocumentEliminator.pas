unit evNestedDocumentEliminator;
{ ������ ���������� ��������� ��������� ���� �� ������ ���������� ����� }

{ $Id: evNestedDocumentEliminator.pas,v 1.4 2013/10/21 15:42:58 lulin Exp $ }

// $Log: evNestedDocumentEliminator.pas,v $
// Revision 1.4  2013/10/21 15:42:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.3  2013/10/21 10:30:41  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.2  2010/11/30 08:17:05  lulin
// - ���������.
//
// Revision 1.1  2009/04/24 12:31:30  narry
// - ������ TevRTFDocumentEliminator
//
// Revision 1.2  2009/03/04 13:32:46  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.1  2007/12/04 13:04:55  lulin
// - ���������� ��� �������� � ����������� ��������.
//
// Revision 1.3  2007/09/28 10:44:11  narry
// - ��������� ���������
//
// Revision 1.2  2007/09/12 13:05:35  narry
// - "���������" ��������� ��������
//
// Revision 1.1  2007/08/21 13:56:20  narry
// - �������������� ���������� ���������� � ����
//

interface

uses
 k2TagFilter,
 l3Types;

type
  TevNestedDocumentEliminator = class(Tk2TagFilter)
    private
    protected
    // internal methods
      function  NeedTranslateChildToNext: Boolean;
        override;
        {-}
  end;//TevNestedDocumentEliminator

implementation

uses
  Document_Const
  ;


function TevNestedDocumentEliminator.NeedTranslateChildToNext: Boolean;
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  Result:= (TopType[1] = nil)
 else
  Result:= True;
end;


end.
