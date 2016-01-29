unit k2AtomOperation;

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2AtomOperation - }
{ �����: 18.10.2005 13:53 }
{ $Id: k2AtomOperation.pas,v 1.12 2014/04/08 17:13:26 lulin Exp $ }

// $Log: k2AtomOperation.pas,v $
// Revision 1.12  2014/04/08 17:13:26  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.11  2014/04/03 17:10:38  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.10  2014/03/21 12:39:25  lulin
// - ������������� ������ � ������.
//
// Revision 1.9  2014/03/19 18:11:11  lulin
// - ������������� ������ � ������.
//
// Revision 1.8  2014/03/18 10:26:38  lulin
// - ������������� ������ � ������.
//
// Revision 1.7  2014/03/17 16:12:12  lulin
// - ������������� ������ � ������.
//
// Revision 1.6  2012/07/12 18:33:21  lulin
// {RequestLink:237994598}
//
// Revision 1.5  2009/07/23 13:42:34  lulin
// - ��������� ��������� �������� ���� ���� ����.
//
// Revision 1.4  2009/07/22 17:16:40  lulin
// - ������������ ������������� �������� ������ � �������������� � ����������� ��� ��������� ��������� �����.
//
// Revision 1.3  2009/07/06 13:32:12  lulin
// - ������������ �� ����������� � ��������.
//
// Revision 1.2  2008/02/12 12:53:20  lulin
// - ����������� �� ��������� ������ �� ������� ������.
//
// Revision 1.1  2005/10/18 10:03:09  lulin
// - ���������� ������� Undo-������ ���������� � ���������� �����.
//

{$Include k2Define.inc }

interface

uses
  l3Types,

  l3Variant,

  k2Op,
  k2Interfaces
  ;

type
  Tk2AtomOperation = class(Tk2Op)
    protected
    // property fields
      f_Atom : Tl3Variant;
      f_Prop : Tk2CustomPropertyPrim;
    protected
    // property methods
      function  pm_GetAtom: Tl3Variant;
        {-}
    protected
    // internal methods
      function SetParam(anAtom : Tl3Variant;
                        const aProp  : Tk2CustomPropertyPrim): Tk2AtomOperation;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      procedure Clear;
        virtual;
        {-}
    public
    // public methods
      property Prop: Tk2CustomPropertyPrim
        read f_Prop;
        {-}
      property Atom: Tl3Variant
        read pm_GetAtom;
        {-}
  end;//Tk2AtomOperation
  
implementation

uses
  SysUtils,
  
  k2Base,
  k2BaseStruct,
  k2NullTagImpl
  ;

// start class Tk2AtomOperation 

procedure Tk2AtomOperation.Cleanup;
  {override;}
  {-}
begin
 Clear;
 inherited;
end;

procedure Tk2AtomOperation.Clear;
  {override;}
  {-}
begin
 inherited;
 FreeAndNil(f_Atom);
 f_Prop := nil;
end;

function  Tk2AtomOperation.pm_GetAtom: Tl3Variant;
  {-}
begin
 if (f_Atom = nil) then
  Result := Tk2NullTagImpl.Instance
 else
  Result := f_Atom;
end;

function Tk2AtomOperation.SetParam(anAtom : Tl3Variant;
                                   const aProp  : Tk2CustomPropertyPrim): Tk2AtomOperation;
  {-}
begin
 Clear;
 f_Prop := aProp;
 anAtom.SetRef(f_Atom);
 Result := Self;
end;

end.

