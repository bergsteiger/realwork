unit l3CharSkipper;

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3CharSkipper -             }
{ �����: 03.05.2001 17:39             }
{ $Id: l3CharSkipper.pas,v 1.5 2015/09/25 09:44:34 dinishev Exp $ }

// $Log: l3CharSkipper.pas,v $
// Revision 1.5  2015/09/25 09:44:34  dinishev
// {Requestlink:607284377}
//
// Revision 1.4  2013/04/04 11:22:01  lulin
// - ���������.
//
// Revision 1.3  2008/02/14 17:09:15  lulin
// - cleanup.
//
// Revision 1.2  2001/05/07 06:54:39  law
// - new method: � ���������� Il3CharSkipper �������� ����� Index.
//
// Revision 1.1  2001/05/04 11:00:45  law
// - new class: ������� ������� ���������� Il3CharSkipper.
//

{$I l3Define.inc }

interface

uses
  l3Types,
  l3Base,
  l3InternalInterfaces,
  l3CacheableBase
  ;

type
  Tl3CharSkipper = class(Tl3CacheableBase, Il3CharSkipper)
    private
    //internal fields
      f_String : Tl3CustomString;
      f_Index  : Long;
    protected
    //internal methods
      procedure Cleanup;
        override;
        {-}
    public
    //public methods
      procedure Init(aString: TObject);
        virtual;
        {-}
      function  GetChar: AnsiChar;
        virtual;
        {-}
      function  Index: Long;
        {-}
      function EOL: Boolean;
        {-}  
  end;//Tl3CharSkipper

implementation

// start class Tl3CharSkipper

procedure Tl3CharSkipper.Cleanup;
  //override;
  {-}
begin
 inherited;
 l3Free(f_String);
 f_Index := -1;
end;

procedure Tl3CharSkipper.Init(aString: TObject);
  {-}
begin
 l3Set(f_String, aString As Tl3CustomString);
 f_Index := -1;
end;

function Tl3CharSkipper.GetChar: AnsiChar;
  {-}
begin
 Inc(f_Index);
 Result := f_String.Ch[f_Index];
end;

function Tl3CharSkipper.Index: Long;
  {-}
begin
 Result := f_Index;
end;

function Tl3CharSkipper.EOL: Boolean;
begin
 Result := f_Index >= f_String.Len;
end;

end.

