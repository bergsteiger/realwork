unit evReqRowHotSpotTester;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evReqRowHotSpot - }
{ �����: 25.06.2005 17:36 }
{ $Id: evReqRowHotSpotTester.pas,v 1.1 2014/07/28 15:27:39 lulin Exp $ }

// $Log: evReqRowHotSpotTester.pas,v $
// Revision 1.1  2014/07/28 15:27:39  lulin
// - ������ ������� �����������.
//
// Revision 1.2  2007/12/04 12:47:04  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.1  2005/08/25 14:12:52  lulin
// - new behavior: ��� �� �� ������� Hint'� � ������ ��� ����� � ����� ������� � ����������.
//

{$Include evDefine.inc }

interface

uses
  evTableRowHotSpot
  ;

type
  TevReqRowHotSpotTester = class(TevTableRowHotSpotTester)
    protected
    // internal methods
      {$IfDef Nemesis}
      function NeedRowSpot: Boolean;
        override;
        {-}
      {$EndIf  Nemesis}
  end;//TevReqRowHotSpotTester

implementation

// start class TevReqRowHotSpotTester

{$IfDef Nemesis}
function TevReqRowHotSpotTester.NeedRowSpot: Boolean;
  //override;
  {-}
begin
 Result := false;
end;
{$EndIf  Nemesis}

end.

