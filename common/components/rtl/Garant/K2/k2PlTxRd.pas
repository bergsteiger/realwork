unit k2PlTxRd;

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2PlTxRd -      }
{ �����: 23.04.1999 18:27 }
{ $Id: k2PlTxRd.pas,v 1.19 2014/03/20 12:33:49 lulin Exp $ }

// $Log: k2PlTxRd.pas,v $
// Revision 1.19  2014/03/20 12:33:49  lulin
// - ������������� ������ � ������.
//
// Revision 1.18  2014/02/28 14:54:26  lulin
// - ������������� ����������.
//
// Revision 1.17  2008/02/05 18:20:40  lulin
// - ������� �������� �������� �����.
//
// Revision 1.16  2008/02/05 17:39:37  lulin
// - ����������� �� ��������� ������������ �������.
//
// Revision 1.15  2008/02/05 16:13:16  lulin
// - ��������� ������� ������ �� ������� ��������.
//
// Revision 1.14  2008/02/05 12:49:23  lulin
// - �������� ������� �������.
//
// Revision 1.13  2000/12/15 15:18:58  law
// - ��������� ��������� Log.
//

{$I k2Define.inc }

interface

uses
  l3Types,
  l3Base,
  l3Variant,

  k2Types,
  k2TagGen,
  k2Interfaces
  ;

type
  Tk2CustomPlainTextReader = class(Tk2TagGenerator)
    protected
    {internal methods}
      procedure DoText(S: Tl3PrimString);
        virtual;
        abstract;
        {-����� ���������� ��� ������ ������ ������}
    public
    {public methods}
      procedure AddAtom(AtomIndex: Long; aValue: Tl3Variant);
        override;
        {-}
  end;{Tk2CustomPlainTextReader}

implementation

uses
  k2Tags
  ;

{ start class Tk2CustomPlainTextReader }

procedure Tk2CustomPlainTextReader.AddAtom(AtomIndex: Long; aValue: Tl3Variant);
  {override;}
  {-}
begin
 inherited AddAtom(AtomIndex, aValue);
 if (AtomIndex = k2_tiText) then begin
//  Case TK of
//   k2_tkObject:
    if (aValue is Tl3PrimString) then
     DoText(Tl3PrimString(aValue))
    else
     Assert(false);
//  end;{Case TI^.Kind}
 end;{AtomIndex = k2_tiText}
end;

end.

