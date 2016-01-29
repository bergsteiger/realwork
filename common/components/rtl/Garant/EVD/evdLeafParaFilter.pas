unit evdLeafParaFilter;
{* �����, ��������������� ��� ���������� �������. }

{ ���������� "EVD"    }
{ �����: ����� �.�. �     }
{ ������: evdLeafParaFilter - }
{ �����: 12.01.2004 19:54 }
{ $Id: evdLeafParaFilter.pas,v 1.15 2014/04/08 17:13:24 lulin Exp $ }

// $Log: evdLeafParaFilter.pas,v $
// Revision 1.15  2014/04/08 17:13:24  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.14  2014/04/04 17:53:45  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.13  2014/04/03 17:10:37  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.12  2014/03/27 14:20:05  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.11  2013/10/21 15:43:12  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.10  2013/10/21 10:30:59  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.9  2013/10/18 14:11:31  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.8  2011/05/11 08:12:11  narry
// �������� ���������� � ������� (������) (260447428)
//
// Revision 1.7  2009/03/04 13:33:09  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.6  2008/04/17 09:48:24  oman
// - fix: ��� ������ ����� ������� ����� ��� ��������� ������ (cq28797)
//
// Revision 1.5  2007/09/21 14:21:04  lulin
// - bug fix: ������ �� ��������� � �����������.
//
// Revision 1.4  2007/08/09 18:05:28  lulin
// - ����������� �� ��������� ������������� �����������, �.�. ������������� ����� ���� ���������� ������� ��������.
//
// Revision 1.3  2007/08/09 13:41:54  lulin
// - ����������� �� �������� ��������.
//
// Revision 1.2  2007/08/09 11:19:25  lulin
// - cleanup.
//
// Revision 1.1  2005/06/23 13:52:47  lulin
// - ������ ��������� ���������� �������� � ����� EVD.
//
// Revision 1.13.8.1  2005/06/23 13:42:52  lulin
// - ����� ��������� �������� � ����� K2.
//
// Revision 1.13  2005/03/28 11:32:07  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.12  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.11  2005/03/18 16:11:22  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.10  2005/02/01 14:12:03  lulin
// - bug fix: ��� ������� ����������� ������ �������� ID ���������� - �.�. ����� �� ����������� ��������� ��������, �� � ������...
//
// Revision 1.9  2004/09/21 12:55:41  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.8  2004/07/02 08:20:47  law
// - bug fix: �� ���������������.
//
// Revision 1.7  2004/06/29 14:26:41  law
// - ����������� �� ������ Tk2AtomR._Set.
//
// Revision 1.6  2004/05/14 16:58:27  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.5  2004/05/14 15:16:53  law
// - remove unit: evTypesE.
//
// Revision 1.4  2004/03/16 15:20:47  law
// - new unit: evDocumentBuffer.
//
// Revision 1.3  2004/01/20 13:28:44  narry
// - update: ���������������� �������� ������� ������
//
// Revision 1.2  2004/01/20 11:24:03  law
// - bug fix: ��� ������ ��������� ��������� ��� ����������� Sub'�.
//
// Revision 1.1  2004/01/12 17:24:33  law
// - new unit: evLeafParaFilter.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  l3Variant,

  k2Types,
  k2Base,
  k2Interfaces,
  k2TagGen,
  k2TagFilter,
  k2DocumentBuffer
  ;

type
  TevdLeafParaFilter = class(Tk2TagFilter)
   {* �����, ��������������� ��� ���������� �������. }
    private
    // internal fields
      f_Buffer: Tk2DocumentBuffer;
      f_Filtered: Boolean;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function  ParaTypeForFiltering: Tk2Type;
        virtual;
        {* Summary
          �������, ������������ ��� �������, ��� ������� �����
          ����������� ����������.                              }
      function  NeedWritePara(aLeaf: Tl3Variant): Boolean;
        virtual;
        {* Summary
          ���������� ����� �� ����������� ���������� �����.  }
      procedure DoWritePara(aLeaf: Tl3Variant);
        virtual;
        {* Summary
          ������ ����������� ������ � ���������. ��������� �������
          ��������� � ���������� ������.                           }
      procedure WritePara(aLeaf: Tl3Variant);
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-}
  end;{* Summary
        �����, ��������������� ��� ���������� �������.
        
        Description
        �����, ����������� "���������" ������. ��������� ����������
        �������� �������� <LINK TevdLeafParaFilter.ParaTypeForFiltering, ParaTypeForFiletring>
        (���� ����� ����������� ���� ���) � <LINK TevdLeafParaFilter.NeedWritePara@Tk2AtomR, NeedWritePara>
        (���� ����� ����������� ��������� ����� ��� �������
        ���������� �������� � �������� �������). ������
        ���������������� ������ ����������� � ������ <LINK TevdLeafParaFilter.DoWritePara@Tk2AtomR, DoWritePara>,
        ���������� �������, ����� ������� ��������� � ����������
        ������.                                                                                                  }
  
implementation

uses
  l3Base,

  k2Tags,

  LeafPara_Const,
  Document_Const
  ;

// start class TevdLeafParaFilter  

constructor TevdLeafParaFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_Buffer := Tk2DocumentBuffer.Create;
 f_Buffer.Start;
 f_Filtered := false;
end;

procedure TevdLeafParaFilter.Cleanup;
begin
 // � ���������� Rollback ����� �� ������� ������ �� ����
 // ������� ���������� ������ ����� ���� �� ����� 1.
 // � ��������� ������ �� Create ����� ���� �������.
 Assert(f_Buffer.CurrentStartLevel <= 1);
 if (f_Buffer.CurrentStartLevel = 1) then
  f_Buffer.Finish;
 l3Free(f_Buffer);
 inherited;
end;

function TevdLeafParaFilter.ParaTypeForFiltering: Tk2Type;
  //virtual;
  {-}
begin
 Result := k2_typLeafPara;
end;

function TevdLeafParaFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

procedure TevdLeafParaFilter.DoWritePara(aLeaf: Tl3Variant);
  //virtual;
  {-}
begin
 if (Generator <> nil) then
 begin
  Generator.StartChild(Tk2Type(aLeaf.TagType));
  try
   aLeaf.WriteTag(Generator);
  finally
   Generator.Finish;
  end;//try..finally
 end; //Generator <> nil
end;

procedure TevdLeafParaFilter.WritePara(aLeaf: Tl3Variant);
  {-}
begin
 if (aLeaf <> nil) then
  if NeedWritePara(aLeaf) then
   DoWritePara(aLeaf);
end;

procedure TevdLeafParaFilter.StartChild(TypeID: Tl3VariantDef);
var
 CT : Tk2Type;
begin
 CT := Tk2Type(TypeID);
 if CT.IsKindOf(k2_typDocument) then
  f_Filtered:= false
 else
 if not f_Filtered AND CT.IsKindOf(ParaTypeForFiltering) then
 begin
  f_Filtered := true;
  IncSkipTags;
 end;
 if f_Filtered then
  f_Buffer.StartChild(TypeID);
 inherited;
end;

procedure TevdLeafParaFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if f_Filtered then
  f_Buffer.AddAtomEx(AtomIndex, Value);
 inherited;
end;

procedure TevdLeafParaFilter.StartTag(TagID: Long);
begin
 if f_Filtered then
  f_Buffer.StartTag(TagID);
 inherited;
end;

procedure TevdLeafParaFilter.CloseStructure(NeedUndo: Bool);
var
 l_NeedDecSkipTags : Boolean;
begin
 l_NeedDecSkipTags := false;
 if f_Filtered then
 begin
  f_Buffer.Finish(NeedUndo);
  if not NeedUndo AND CurrentType.IsKindOf(ParaTypeForFiltering) AND (SkipLevel = 2) then
  begin
   f_Filtered:= false;
   WritePara(f_Buffer.Root);
   f_Buffer.Root := nil;
   l_NeedDecSkipTags := true;
  end;//not NeedUndo
 end;//f_Filtered
 inherited;
 if l_NeedDecSkipTags then
  DecSkipTags;
end;

end.

