unit l3Msg;

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. � }
{ ������: l3Msg - �������� ��������� ���������� L3}
{ �����: 29.01.99 14:27 }
{ $Id: l3Msg.pas,v 1.13 2007/12/05 12:35:11 lulin Exp $ }

// $Log: l3Msg.pas,v $
// Revision 1.13  2007/12/05 12:35:11  lulin
// - ������� �������� ���, ������������ ������� ����� � Head'�.
//
// Revision 1.12  2006/01/18 10:38:23  lulin
// - bug fix: �� ��������������� �������� ����������.
//
// Revision 1.11  2005/10/13 06:00:26  lulin
// - cleanup.
//
// Revision 1.10  2000/12/15 15:19:01  law
// - ��������� ��������� Log.
//

{$Include l3Define.inc }

interface

uses
  l3Types
  ;

type
  {������� ��� ���������, ���������� ������ ��� ���������}
  Ml3Base = object
    public
    // public fields
      Msg : Cardinal;
  end;//Ml3Base

  {��� ��������� ��� ��������� �������� ����������� ����������� �������.
   c�: (V) MemGetModify}
  MemSetModify = object(Ml3Base)
    public
    // public fields
      Modified : CardinalBool;
  end;//MemSetModify

  {������� ��� ���������, �� ���������� WParam}
  Ml3NoWParam = object(Ml3Base)
    private
    // internal fields
      NoWParam : Cardinal;
  end;//Ml3NoWParam

  {������� ��� ���������, �� ���������� LParam}
  Ml3NoLParam = object(Ml3NoWParam)
    private
    // internal fields
      NoLParam : Long;
  end;//Ml3NoLParam

  {����� ������� ��������� �� ���������� LParam}

  {��� ��������� ��� ������ ���������� � ����������� ����������� �������.
   c�: (^) MemSetModify}
  MemGetModify = object(Ml3NoLParam)
    public
    // public fields
      Modified  : LongBool;
  end;//MemGetModify

  TEMSetReadOnly = object(Ml3Base)
    ReadOnly  : CardinalBool;
    UnusedL   : Long;
    Result    : LongBool;
  end;//TEMSetReadOnly

implementation

end.

