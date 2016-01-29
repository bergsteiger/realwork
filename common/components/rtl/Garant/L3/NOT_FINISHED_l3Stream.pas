unit NOT_FINISHED_l3Stream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Stream.pas"
// �����: 28.01.1999 18:24
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Stream
//
// ��������� ������ ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  Classes,
  l3Memory,
  l3BaseStream
  ;

type
 Tl3BufferState = (
  {* ��������� ������. }
   bsUnknown
 , bsRead
 , bsWrite
 );//Tl3BufferState

 Tl3TextStream = class
 end;//Tl3TextStream

 Tl3NamedTextStream = class
 end;//Tl3NamedTextStream

 Tl3FileStream = class
 end;//Tl3FileStream

 Tl3HandleStream = class(Tl3Stream)
 end;//Tl3HandleStream

 Tl3TempFileStream = class(Tl3HandleStream)
 end;//Tl3TempFileStream

 Tl3NamedFileStream = class
 end;//Tl3NamedFileStream

 Tl3ResourceStream = class(Tl3ConstMemoryStream)
 end;//Tl3ResourceStream

procedure L3IStream2Stream(const anIStream: IStream;
  out theStream: TStream);
   {* ����������� IStream � TStream. }
function L3Stream2IStream(aStream: TStream): IStream;
   {* ����������� TStream � IStream. }
function L3CopyStream(anInStream: TStream;
  anOutStream: TStream): Large;
   {* �������� �� ������ ������ � ������. }
function L3CompareStreams(const aStream1: IStream;
  const aStream2: IStream): Boolean; overload; 
   {* ���������� ��������� ��� ������. }
function L3CompareStreams(aStream1: TStream;
  aStream2: TStream): Boolean; overload; 
   {* ���������� ��������� ��� ������. }
procedure L3CompareFiles;
   {* ��������� ������ l3CompareFiles }

implementation

// unit methods

procedure L3CompareFiles;
//#UC START# *4B2FC528001C_47A080670100_var*
//#UC END# *4B2FC528001C_47A080670100_var*
begin
//#UC START# *4B2FC528001C_47A080670100_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2FC528001C_47A080670100_impl*
end;//L3CompareFiles
// unit methods

procedure L3IStream2Stream(const anIStream: IStream;
  out theStream: TStream);
//#UC START# *47A080A301E7_47A080670100_var*
//#UC END# *47A080A301E7_47A080670100_var*
begin
//#UC START# *47A080A301E7_47A080670100_impl*
 assert(false, 'L3IStream2Stream not implemented');
//#UC END# *47A080A301E7_47A080670100_impl*
end;//L3IStream2Stream

function L3Stream2IStream(aStream: TStream): IStream;
//#UC START# *47A080BA000E_47A080670100_var*
//#UC END# *47A080BA000E_47A080670100_var*
begin
//#UC START# *47A080BA000E_47A080670100_impl*
 assert(false, 'L3Stream2IStream not implemented');
//#UC END# *47A080BA000E_47A080670100_impl*
end;//L3Stream2IStream

function L3CopyStream(anInStream: TStream;
  anOutStream: TStream): Large;
//#UC START# *47A080C802F4_47A080670100_var*
//#UC END# *47A080C802F4_47A080670100_var*
begin
//#UC START# *47A080C802F4_47A080670100_impl*
 assert(false, 'L3CopyStream not implemented');
//#UC END# *47A080C802F4_47A080670100_impl*
end;//L3CopyStream

function L3CompareStreams(const aStream1: IStream;
  const aStream2: IStream): Boolean;
//#UC START# *47A0811D03D3_47A080670100_var*
//#UC END# *47A0811D03D3_47A080670100_var*
begin
//#UC START# *47A0811D03D3_47A080670100_impl*
 assert(false, 'L3CompareStreams not implemented');
//#UC END# *47A0811D03D3_47A080670100_impl*
end;//L3CompareStreams

function L3CompareStreams(aStream1: TStream;
  aStream2: TStream): Boolean;
//#UC START# *47A081370242_47A080670100_var*
//#UC END# *47A081370242_47A080670100_var*
begin
//#UC START# *47A081370242_47A080670100_impl*
 assert(false, 'L3CompareStreams not implemented');
//#UC END# *47A081370242_47A080670100_impl*
end;//L3CompareStreams

end.