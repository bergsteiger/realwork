unit evReqCellHotSpot;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evReqCellHotSpot - }
{ �����: 25.06.2005 17:36 }
{ $Id: evReqCellHotSpot.pas,v 1.2 2007/12/04 12:47:04 lulin Exp $ }

// $Log: evReqCellHotSpot.pas,v $
// Revision 1.2  2007/12/04 12:47:04  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.1  2005/08/25 14:12:51  lulin
// - new behavior: ��� �� �� ������� Hint'� � ������ ��� ����� � ����� ������� � ����������.
//

{$Include evDefine.inc }

interface

uses
  evTableCellHotSpot
  ;

type
  TevReqCellHotSpotTester = class(TevTableCellHotSpotTester)
    protected
    // internal methods
      {$IfDef Nemesis}
      function NeedCellSpot: Boolean;
        override;
        {-}
      {$EndIf  Nemesis}
  end;//TevReqCellHotSpotTester

implementation

// start class TevReqCellHotSpotTester

{$IfDef Nemesis}
function TevReqCellHotSpotTester.NeedCellSpot: Boolean;
  //override;
  {-}
begin
 Result := false;
end;
{$EndIf  Nemesis}

end.

