unit k2TagTerminator;

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2TagTerminator - }
{ �����: 14.05.2004 20:26 }
{ $Id: k2TagTerminator.pas,v 1.2 2007/08/09 12:38:17 lulin Exp $ }

// $Log: k2TagTerminator.pas,v $
// Revision 1.2  2007/08/09 12:38:17  lulin
// - ������� ������������ ������ � ����������� ������� �����.
//
// Revision 1.1  2004/05/14 16:58:51  law
// - new units: k2TagTerminator, k2TagFilter.
//

{$I k2Define.inc }

interface

uses
  k2StackGenerator
  ;

type
  Tk2TagTerminator = class(Tk2CustomStackGeneratorEx)
   {* �������� �����. }
    protected
    {internal methods}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Boolean);
        override;
        {-}
    public
    {public properties}
      property Generator;
        {-}
  end;{Tk2TagTerminator}
  {* �� ���������� ����� ���� ����. }
  
implementation

// start class Tk2TagTerminator 

procedure Tk2TagTerminator.OpenStream;
  {override;}
  {-}
begin
 inherited;
 if (Generator <> nil) then Generator.Start;
end;

procedure Tk2TagTerminator.CloseStream(NeedUndo: Boolean);
  {override;}
  {-}
begin
 if (Generator <> nil) then Generator.Finish(NeedUndo);
 inherited;
end;

end.

