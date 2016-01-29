unit k2PropertyOperation;

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2PropertyOperation - }
{ �����: 18.10.2005 14:04 }
{ $Id: k2PropertyOperation.pas,v 1.15 2014/04/21 15:41:54 lulin Exp $ }

// $Log: k2PropertyOperation.pas,v $
// Revision 1.15  2014/04/21 15:41:54  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.14  2014/03/26 15:52:00  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.13  2014/03/21 17:15:17  lulin
// - ������������� ������ � ������.
//
// Revision 1.12  2014/03/21 12:39:25  lulin
// - ������������� ������ � ������.
//
// Revision 1.11  2014/03/19 18:11:11  lulin
// - ������������� ������ � ������.
//
// Revision 1.10  2014/03/18 10:26:38  lulin
// - ������������� ������ � ������.
//
// Revision 1.9  2014/03/17 16:12:12  lulin
// - ������������� ������ � ������.
//
// Revision 1.8  2013/11/05 13:43:14  lulin
// - ������ ���.
//
// Revision 1.7  2013/11/05 13:31:19  lulin
// - ��������� ���� ������ ����������� ����������� ������� ���������� ��� ������� ���� ����.
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
// Revision 1.2  2005/10/18 10:48:29  lulin
// - ���������� ������� Undo-������ ��������/���������� �����, ���������� � ���������� �����.
//
// Revision 1.1  2005/10/18 10:32:51  lulin
// - ���������� ������� Undo-������, ��������� ������� �����, ���������� � ���������� �����.
//

{$Include k2Define.inc }

interface

uses
  l3Types,

  l3Variant,

  k2Interfaces,
  k2Op,
  k2AtomOperation
  ;

type
  Tk2PropOperation = class(Tk2AtomOperation)
    protected
    // internal methods
      function  GetPtr(Old: Boolean): Pl3Variant;
        virtual;
        {-}
      function  GetP(Old: Boolean): Tl3Variant;
        {-}
      procedure SetP(Old: Boolean; Value: Tl3Variant);
        {-}
      procedure DoUndo(const Container: Ik2Op);
        override;
        {-�������� ��������}
      procedure DoRedo(const Container: Ik2Op);
        override;
        {-��������� ��������}
    protected
    // property methods
      procedure SetValue(Old: Boolean; Value: Tl3Variant);
        {-}
    public
    // public methods
      class procedure ToUndo(const anOpPack : Ik2Op;
                             anAtom   : Tl3Variant;
                             const aProp    : Tk2CustomPropertyPrim;
                             Old, New : Tl3Variant);
        reintroduce;
        {-}
      function SetParam(anAtom : Tl3Variant;
                        const aProp  : Tk2CustomPropertyPrim;
                        Old, New: Tl3Variant): Tk2PropOperation;
        reintroduce;                
        {-}
      procedure Clear;
        override;
        {-}
  end;//Tk2PropOperation

  Ok2AddProp = class(Tk2PropOperation)
    private
    // property fields
      f_New : Tl3Variant;
    protected
    // internal methods
      function  GetPtr(Old: Boolean): Pl3Variant;
        override;
        {-}
  end;//Ok2AddProp

  Ok2DelProp = class(Tk2PropOperation)
    private
    // property fields
      f_Old : Tl3Variant;
    protected
    // internal methods
      function  GetPtr(Old: Boolean): Pl3Variant;
        override;
        {-}
    public
    // public methods
(*      function SetLongParam(const anAtom : _Ik2Tag;
                            const aProp  : Tk2CustomPropertyPrim;
                            Old          : Long): Tk2PropOperation;
        {-}*)
  end;//Ok2DelProp

  Ok2ModifyProp = class(Tk2PropOperation)
    private
    // property fields
      f_Old : Tl3Variant;
      f_New : Tl3Variant;
    protected
    // internal methods
      function  GetPtr(Old: Boolean): Pl3Variant;
        override;
        {-}
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        override;
        {-��������� ��� �������� � ����������:
          nil  - ���������� ��������
          Self - ���������� ������ � ��� ����������� � ������ ������
          New  - ������������ ����� �������� }
      function CanJoinWith(anOperation: Tk2Op): Boolean;
        override;
        {-}
(*    public
    // public methods
      function SetLongParam(const anAtom : _Ik2Tag;
                            const aProp  : Tk2CustomPropertyPrim;
                            Old, New     : Long): Tk2PropOperation;
        {-}*)
  end;//Ok2ModifyProp

implementation

uses
  SysUtils,
  
  l3Base,
  
  k2Base,
  k2BaseStruct,
  k2NullTagImpl
  ;

// start class Tk2PropOperation 

class procedure Tk2PropOperation.ToUndo(const anOpPack : Ik2Op;
                                        anAtom   : Tl3Variant;
                                        const aProp    : Tk2CustomPropertyPrim;
                                        Old, New : Tl3Variant);
  {-}
var
 l_Op : Tk2PropOperation;
begin
 if (anOpPack <> nil) then
 begin
  l_Op := Create.SetParam(anAtom, aProp, Old, New);
  try
   l_Op.Put(anOpPack);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

procedure Tk2PropOperation.Clear;
  {override;}
  {-}
begin
 if (f_Prop <> nil) then
 begin
  SetP(true, nil);
  SetP(false, nil);
 end;{f_Prop <> nil}
 inherited Clear;
end;

function Tk2PropOperation.SetParam(anAtom   : Tl3Variant;
                                   const aProp    : Tk2CustomPropertyPrim;
                                   Old, New : Tl3Variant): Tk2PropOperation;
  {-}
begin
 inherited SetParam(anAtom, aProp);
 if (f_Prop <> nil) then
 begin
  SetValue(true, Old);
  SetValue(false, New);
 end;{f_Prop <> nil}
 Result := Self;
end;

function Tk2PropOperation.GetPtr(Old: Boolean): Pl3Variant;
  //virtual;
  {-}
begin
 Result := nil;
end;

function Tk2PropOperation.GetP(Old: Boolean): Tl3Variant;
  {virtual;}
  {-}
var
 l_Ptr : Pl3Variant;
begin
 if (f_Prop = nil) then
  Result := Tk2NullTagImpl.Instance
 else
 begin
  l_Ptr := GetPtr(Old);
  if (l_Ptr = nil) OR (l_Ptr^ = nil) then
   Result := Tk2NullTagImpl.Instance
  else
   Result := l_Ptr^;
 end;//f_Prop = nil
end;

procedure Tk2PropOperation.SetP(Old: Boolean; Value: Tl3Variant);
  {virtual;}
  {-}
var
 l_Ptr : Pl3Variant;
begin
 l_Ptr := GetPtr(Old);
 if (l_Ptr <> nil) then
  Value.SetRef(l_Ptr^);
end;

procedure Tk2PropOperation.DoUndo(const Container: Ik2Op);
  {override;}
  {-�������� ��������}
begin
 Atom.AttrW[f_Prop.TagIndex, Container] := GetP(true);
end;

procedure Tk2PropOperation.DoRedo(const Container: Ik2Op);
  {override;}
  {-��������� ��������}
begin
 Atom.AttrW[f_Prop.TagIndex, Container] := GetP(false);
end;

procedure Tk2PropOperation.SetValue(Old: Boolean; Value: Tl3Variant);
  {-}
begin
 if (Self <> nil) then
  SetP(Old, Value);
end;

// start class Ok2AddProp 

function Ok2AddProp.GetPtr(Old: Boolean): Pl3Variant;
  {override;}
  {-}
begin
 if Old then
  Result := inherited GetPtr(Old)
 else
  Result := @f_New;
end;

// start class Ok2DelProp 

function Ok2DelProp.GetPtr(Old: Boolean): Pl3Variant;
  {override;}
  {-}
begin
 if Old then
  Result := @f_Old
 else
  Result := inherited GetPtr(Old);
end;

// start class Ok2ModifyProp 

function Ok2ModifyProp.GetPtr(Old: Boolean): Pl3Variant;
  {override;}
  {-}
begin
 if Old then
  Result := @f_Old
 else
  Result := @f_New;
end;

function Ok2ModifyProp.DoJoin(anOperation: Tk2Op): Tk2Op;
  //override;
  {-��������� ��� �������� � ����������:
    nil  - ���������� ��������
    Self - ���������� ������ � ��� ����������� � ������ ������
    New  - ������������ ����� �������� }
begin
 Result := nil;
// if (anOperation Is Ok2ModifyProp) then
end;

function Ok2ModifyProp.CanJoinWith(anOperation: Tk2Op): Boolean;
  //override;
  {-}
begin
 Result := (anOperation Is Ok2ModifyProp);
end;

end.

