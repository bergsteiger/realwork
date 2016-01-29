unit evExportGenerator;

{ ���������� "�������"  }
{ �����: ����� �.�. �   }
{ ������: evExportGenerator - }
{ �����: 10.09.1999 15:46 }
{ $Id: evExportGenerator.pas,v 1.34 2014/04/08 17:13:19 lulin Exp $ }

// $Log: evExportGenerator.pas,v $
// Revision 1.34  2014/04/08 17:13:19  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.33  2014/04/08 12:35:09  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.32  2014/04/04 07:00:00  dinishev
// Bug fix: �� ��������� ����.
//
// Revision 1.31  2014/03/28 06:14:13  dinishev
// Bug fix: �� ���������� ������ ������.
//
// Revision 1.30  2013/10/21 15:42:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.29  2013/10/21 10:30:41  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.28  2013/10/18 15:38:57  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.27  2013/04/24 09:35:36  lulin
// - ���������.
//
// Revision 1.26  2009/03/04 16:25:52  lulin
// - <K>: 137470629. Bug fix: �� ��������� ����������.
//
// Revision 1.25  2009/02/26 12:25:05  lulin
// - <K>: 137465982. �1
//
// Revision 1.24  2007/12/04 12:47:01  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.19.8.4  2007/11/28 14:16:52  dinishev
// _CleanUp
//
// Revision 1.19.8.3  2007/08/09 12:38:15  lulin
// - ������� ������������ ������ � ����������� ������� �����.
//
// Revision 1.19.8.2  2007/06/20 09:27:11  dinishev
// bug fix: �� ���������������
//
// Revision 1.19.8.1  2006/02/02 13:05:20  fireton
// - ��������� ��� ������������� � ������������ � HEAD
//
// Revision 1.19  2005/03/28 14:29:59  lulin
// - �� ������ ����������� ��������� � ����������.
//
// Revision 1.18  2005/03/28 11:32:07  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.17  2005/03/18 16:11:22  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.16  2005/03/16 19:21:53  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.15  2005/02/24 15:05:24  lulin
// - new behavior: "����� ��������" ���������, �� ��� � ��������� ����� ���� ��������� �������.
//
// Revision 1.14  2004/06/29 14:26:41  law
// - ����������� �� ������ Tk2AtomR._Set.
//
// Revision 1.13  2004/03/17 14:53:45  narry
// - update: �������������� �������
//
// Revision 1.12  2002/09/18 08:06:10  voba
// - cleanup: ������ �������� IsDefault.
//
// Revision 1.11  2001/04/27 11:38:18  voba
// - bug fix: ��������� ���������� ��������� ��������� ��������.
//
// Revision 1.10  2001/04/25 14:48:17  voba
// - new behavior: ������� �������� ������ ������ ������� �����������.
//
// Revision 1.9  2001/03/14 13:24:54  law
// - some cleaup and tuning.
//
// Revision 1.8  2001/02/28 10:12:40  law
// - ��������� Write � WriteEx ���������� � ���� - Write.
//
// Revision 1.7  2000/12/15 15:10:35  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Filer,
  l3Variant,

  k2Interfaces,
  k2TagGen,

  m3DBInterfaces,
  
  k2DocumentBuffer,
  evHndFlt
  ;

type
  TevCustomExportGenerator = class(TevCustomTopicSwitcher)
    private
    {property fields}
      f_InternalGenerator : Tk2DocumentBuffer;
      f_ExternalGenerator : Ik2TagGenerator;
      f_AccumulateHeader  : Bool;
    protected
    {internal methods}
      procedure OutHeader;
        {-}
      procedure OpenStream;
        override;
        {-���������� ���� ��� ��� ������ ���������}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-���������� ���� ��� � ����� ���������}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-���������� �� ������������� ������}
      procedure Init(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
        override;
        {-}
      procedure Done(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
        override;
        {-}
    protected
    {internal properties}
      property AccumulateHeader: Bool
        read f_AccumulateHeader
        write f_AccumulateHeader;
        {-}
    public
    {public methods}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
    public
    {public properties}
      property InternalGenerator: Tk2DocumentBuffer
        read f_InternalGenerator;
        {-}
  end;{TevCustomExportGenerator}

  TevExportGenerator = class(TevCustomExportGenerator)
    published
    {published properties}
      property Generator;
        {-}
      property Filer;
        {-}
    published
    {published events}
      property OnGenerateTopicID;
        {-}
      property OnInitTopic;
        {-}
      property OnDoneTopic;
        {-}
  end;{TevExportGenerator}

implementation

uses
  SysUtils,

  l3Base,

  k2BaseTypes,
  k2Base,
  k2Tags,

  Document_Const,
  Para_Const
  ;

procedure TevCustomExportGenerator.OutHeader;
  {-}
begin
 AccumulateHeader := false;
 Generator := f_ExternalGenerator;
 f_InternalGenerator.Root.WriteTag(Generator, l3_spfAll, [k2_tiSubs]);
 f_InternalGenerator.Finish;
end;
  
procedure TevCustomExportGenerator.OpenStream;
  {override;}
  {-���������� ���� ��� ��� ������ ���������}
begin
 f_ExternalGenerator := Generator;
 f_InternalGenerator := Tk2DocumentBuffer.Create(nil); 
 f_InternalGenerator.RewriteAtoms := False;
 Generator := f_InternalGenerator;
 inherited;
 f_ExternalGenerator.Start;
end;

procedure TevCustomExportGenerator.CloseStream(NeedUndo: Bool);
  {override;}
  {-���������� ���� ��� � ����� ���������}
begin
 f_ExternalGenerator.Finish(NeedUndo);
 if (Generator = f_ExternalGenerator) then
  Generator := f_InternalGenerator;
 inherited;
 Generator := f_ExternalGenerator;
 l3Free(f_InternalGenerator);
 f_ExternalGenerator := nil;
end;

procedure TevCustomExportGenerator.CloseStructure(NeedUndo: Bool);
  {override;}
  {-���������� �� ������������� ������}
begin
 if AccumulateHeader AND
    not NeedUndo AND
    CurrentType.IsKindOf(k2_typDocument) then OutHeader;
 inherited;
end;

procedure TevCustomExportGenerator.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
var
 l_CT : Tk2Type;  
begin
 if AccumulateHeader AND TypeID.IsKindOf(k2_typPara) then OutHeader;
 inherited;
 if Transparent then
 begin
  l_CT := CurrentType;
  if l_CT.IsKindOf(k2_typDocument) then
  begin
   {-���� ������ ����� ���������}
   AccumulateHeader := true;
   with f_InternalGenerator do
    PushChild(l_CT, Root);
   Generator := f_InternalGenerator;
   f_InternalGenerator.Root.WriteTag(Generator, l3_spfAll, [k2_tiSubs]);
  end;{..k2_idDocument..}
 end;{..Transparent..}
end;

procedure TevCustomExportGenerator.Init(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
  {override;}
  {-}
begin
 if Transparent then inherited Init(ID, Filer);
  {-���� ���� �� ������� ��������� �� ����������� ����}
end;

procedure TevCustomExportGenerator.Done(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
  {override;}
  {-}
begin
 if Transparent then
  inherited Done(ID, Filer)
  {-���� ���� �� ������� ��������� �� ����������� ����}
 else begin
  Transparent := true;
  try
   Generator := f_ExternalGenerator;
   {-������ ���� �� �������}
   try
    Init(ID, Filer);
   finally
    Generator := f_InternalGenerator;
    {-������ ���� �� ����������}
   end;{try..finally}
  finally
   Transparent := false;
  end;{try..finally}
 end;{Transparent}
end;

end.

