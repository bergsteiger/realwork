unit evParaEliminator;
{* ������, ������������ ��� ���������, ����� ��������� (� �������������� ��� �����). }

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evParaEliminator - }
{ �����: 26.11.2004 16:39 }
{ $Id: evParaEliminator.pas,v 1.4 2013/10/21 15:42:58 lulin Exp $ }

// $Log: evParaEliminator.pas,v $
// Revision 1.4  2013/10/21 15:42:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.3  2013/10/21 10:30:41  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.2  2009/03/17 09:43:48  lulin
// - bug fix: �� ����������.
//
// Revision 1.1  2004/11/26 13:45:30  lulin
// - new unit: evParaEliminator.
//

{$I evDefine.inc }

interface

uses
  k2TagFilter
  ;

type
  TevParaEliminator = class(Tk2TagFilter)
   {* ������, ������������ ��� ���������, ����� ��������� (� �������������� ��� �����). }
    protected
    // internal methods
      function  NeedTranslateChildToNext: Boolean;
        override;
        {-}
  end;//TevParaEliminator

implementation

uses
  k2Tags,

  Document_Const
  ;

// start class TevParaEliminator

function TevParaEliminator.NeedTranslateChildToNext: Boolean;
  //override;
  {-}
begin
 with CurrentType do
  Result := IsKindOf(k2_typDocument);
end;

end.

