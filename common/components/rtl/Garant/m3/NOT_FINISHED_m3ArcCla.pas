unit NOT_FINISHED_m3ArcCla;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3"
// ������: "w:/common/components/rtl/Garant/m3/NOT_FINISHED_m3ArcCla.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m3::ArchiveStreams::m3ArcCla
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3BaseArcStream
  ;

type
 Tm3ArcInflateStream = {abstract} class(Tm3BaseArcStream)
 end;//Tm3ArcInflateStream

 Tm3ArcDeflateStream = {abstract} class(Tm3BaseArcStream)
 end;//Tm3ArcDeflateStream

 Tm3LZOInflateStream = class(Tm3ArcInflateStream)
 end;//Tm3LZOInflateStream

 Tm3LZODeflateStream = class(Tm3ArcDeflateStream)
 end;//Tm3LZODeflateStream

implementation

uses
  m3ArcHandle,
  m3ArcHandleList
  ;

end.