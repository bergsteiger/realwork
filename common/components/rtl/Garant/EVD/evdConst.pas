unit evdConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/evdConst.pas"
// �����: 09.11.1999 15:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EVD::Const
//
// ��������� ����������� ������������� ������� evd.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

type
 TevTypeID = (
  {* ��� ������ ����. }
   ev_idChild
 , ev_idAtom
 , ev_idLong
 , ev_idString32
 , ev_idComponent
 , ev_idSInt8
 , ev_idUInt8
 , ev_idSInt16
 , ev_idUInt16
 , ev_idSInt32
 , ev_idUInt32
 , ev_idSInt64
 , ev_idUInt64
 , ev_idString8
 , ev_idString16
 , ev_idStream
 , ev_idTransparent
 , ev_idCodePage
 , ev_idFontName
 , ev_idFontID
 , ev_idShortCodePage
 );//TevTypeID

const
  { UnpackedEVD }
 unpack_idFill = 0;
  { ����������� ������������. }
 unpack_idFinish = 65535;
  { ����������� ������ ����. }
 unpack_idKey1 = $6525;
  { ������� ���������� �������� ������. }
 unpack_idKey2 = $4525;
  { ������� ���������� �������� ������. }
 unpack_idKey3 = $6225;
  { ������� ������ �������� ������. }
 unpack_idKey4 = $4225;
  { ������� ������ �������� ������. }
 unpack_idMask = unpack_idFinish - 2;
  { ����� ������������� ������. }
 unpack_idChildren = unpack_idFinish - 3;
  { ������� ������ ������ �������� �����. }
 unpack_idRollback = unpack_idFinish - 4;
  { ������� ������ ����. }
 unpack_idMaskEx = unpack_idFinish - 5;
  { ����������� ����� ������������� ������. }
 unpack_idLink = unpack_idFinish - 6;
  { ������ �� ������ � ������ IStorage. }
 unpack_idDefaultChild = unpack_idFinish - 7;
  { �������� ��� � ����� �� ���������. }
  { PackedEVD }
 evd_pack_idFill = 0;
  { ����������� ������������. }
 evd_pack_idFinish = 255;
  { ����������� ������ ����. }
 evd_pack_idPercent = 37;
  { ������ % }
 evd_pack_idSmallE = 101;
  { ������ e }
 evd_pack_idCapitalE = 69;
  { ������ E }
 evd_pack_idSmallB = 98;
  { ������ b }
 evd_pack_idCapitalB = 66;
  { ������ B }
 evd_pack_idSmallP = 112;
  { ������ p }
 evd_pack_idCapitalP = 80;
  { ������ P }
 evd_pack_idChildren = evd_pack_idFinish - 1;
  { ������� ������ ������ �������� �����. }
 evd_pack_idRollback = evd_pack_idFinish - 2;
  { ������� ������ ����. }
 evd_pack_idLink = evd_pack_idFinish - 3;
  { ������ �� ������ � ������ IStorage. }
 evd_pack_idDefaultChild = evd_pack_idFinish - 4;
  { �������� ��� � ����� �� ���������. }

implementation

end.