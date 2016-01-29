unit evSegOp;

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evSegOp -       }
{ �����: 26.09.2001 15:13 }
{ $Id: evSegOp.pas,v 1.25 2014/04/11 15:30:29 lulin Exp $ }

// $Log: evSegOp.pas,v $
// Revision 1.25  2014/04/11 15:30:29  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.24  2014/04/08 17:13:19  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.23  2014/03/27 14:19:58  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.22  2014/03/21 12:39:22  lulin
// - ������������� ������ � ������.
//
// Revision 1.21  2014/03/17 16:12:08  lulin
// - ������������� ������ � ������.
//
// Revision 1.20  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.19  2011/06/14 16:11:40  lulin
// {RequestLink:269066487}.
//
// Revision 1.18  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.17  2011/02/18 12:11:56  lulin
// - ��������� ����������� ��� ���������.
//
// Revision 1.16  2010/12/10 12:31:25  lulin
// - bug fix: �� ���������� � ���������� _nsTool.
//
// Revision 1.15  2009/07/23 13:42:11  lulin
// - ��������� ��������� �������� ���� ���� ����.
//
// Revision 1.14  2008/02/21 18:37:17  lulin
// - ������� �������� ��������.
//
// Revision 1.13  2008/02/21 18:13:20  lulin
// - ����������� �� �������� �����.
//
// Revision 1.12  2007/12/04 12:47:04  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.10.8.3  2007/09/04 17:06:00  lulin
// - cleanup.
//
// Revision 1.10.8.2  2005/11/09 15:28:24  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.10.8.1  2005/10/18 10:32:48  lulin
// - ���������� ������� Undo-������, ��������� ������� �����, ���������� � ���������� �����.
//
// Revision 1.10  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.9  2005/03/24 15:25:51  lulin
// - ������� �������� ������.
//
// Revision 1.8  2005/03/24 13:14:37  lulin
// - ������� �������� ������� �������������� Tk2AtomR � _Ik2Tag.
//
// Revision 1.7  2005/03/21 16:28:16  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.6  2005/03/04 13:59:17  lulin
// - remove method: Tk2AtomR._AddChild.
//
// Revision 1.5  2005/02/03 14:33:43  lulin
// - ��� Undo-������� ���������� ��������� ������ _ToUndo, ������ �������������.
//
// Revision 1.4  2002/02/15 15:51:17  law
// - comments: xHelpGen.
//
// Revision 1.3  2002/01/10 15:23:59  law
// - bug fix: �� ��������������� � ���������� l3ConsoleApp.
//
// Revision 1.2  2001/09/26 13:03:05  law
// - optimize: ���������� ������� Undo-������.
//
// Revision 1.1  2001/09/26 12:03:35  law
// - bug fix: �������� � Undo ������. ������ �770. ��. _TestSet\Segments\Hyperlinks\3.evd .
//

{$Include evDefine.inc }

interface

{$IfDef k2ForEditor}
uses
  l3Interfaces,
  l3Types,
  l3Base,
  l3Variant,
  
  k2Interfaces,
  k2Op,
  k2PropertyOperation,

  nevBase
  ;
  
type
  OevSaveSegmentStart = class(Tk2PropOperation)
    private
    // internal fields
      f_Start : Tl3Variant;
    protected
    // internal methods
      function  GetPtr(Old: Bool): Pl3Variant;
        override;
        {-}
    public
    // public methods
      class procedure ToUndo(const anOpPack : InevOp;
                             aSegment : Tl3Variant;
                             aStart   : Tl3Variant);
        {-}
      constructor Create(aSegment : Tl3Variant;
                         aStart   : Tl3Variant);
        reintroduce;
        {-}
      function  CompareWith(anOp: Tk2Op): Integer;
        override;
        {-}
  end;//OevSaveSegmentStart
{$EndIf k2ForEditor}

implementation

{$IfDef k2ForEditor}
{$IfNDef k2ForEditor}
  !!! ������: �� ���������� ��������� k2ForEditor.
{$EndIf  k2ForEditor}

uses
  k2Base,
  k2Tags,
  k2NullTagImpl
  ;

// start class OevSaveSegmentStart

constructor OevSaveSegmentStart.Create(aSegment : Tl3Variant;
                                       aStart   : Tl3Variant);
  //reintroduce;
  {-}
begin
 inherited Create;
 SetParam(aSegment, Tk2Type(aSegment.TagType).Prop[k2_tiStart], Tk2NullTagImpl.Instance, Tk2NullTagImpl.Instance);
 aStart.SetRef(f_Start);
end;

class procedure OevSaveSegmentStart.ToUndo(const anOpPack : InevOp;
                                           aSegment : Tl3Variant;
                                           aStart   : Tl3Variant);
  {-}
var
 l_Op : OevSaveSegmentStart;
begin
 if (anOpPack <> nil) then
 begin
  l_Op := Create(aSegment, aStart);
  try
   l_Op.Put(anOpPack);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

function  OevSaveSegmentStart.GetPtr(Old: Bool): Pl3Variant;
  //override;
  {-}
begin
 Result := @f_Start;
end;

function OevSaveSegmentStart.CompareWith(anOp: Tk2Op): Integer;
  //override;
  {-}
begin
 if (anOp Is OevSaveSegmentStart) then
 begin
  if Atom.IsSame(OevSaveSegmentStart(anOp).Atom) AND
     (f_Start = OevSaveSegmentStart(anOp).f_Start) then
   Result := 0
  else
   Result := -1;
 end//anOp Is OevSaveSegmentStart
 else
  Result := inherited CompareWith(anOp);
end;
{$EndIf k2ForEditor}

end.

