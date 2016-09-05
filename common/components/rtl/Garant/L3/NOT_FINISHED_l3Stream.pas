unit NOT_FINISHED_l3Stream;
 {* Различные потоки данных. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Stream.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3Stream" MUID: (47A080670100)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , Classes
 , l3BaseStream
 , l3Memory
;

type
 Tl3BufferState = (
  {* Состояние буфера. }
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

procedure l3CompareFiles;
procedure l3IStream2Stream(const anIStream: IStream;
 out theStream: TStream);
 {* преобразует IStream в TStream. }
function l3Stream2IStream(aStream: TStream): IStream;
 {* преобразует TStream в IStream. }
function l3CopyStream(anInStream: TStream;
 anOutStream: TStream): Large;
 {* копирует из одного потока в другой. }
function l3CompareStreams(const aStream1: IStream;
 const aStream2: IStream): Boolean; overload;
 {* сравнивает побайтово два потока. }
function l3CompareStreams(aStream1: TStream;
 aStream2: TStream): Boolean; overload;
 {* сравнивает побайтово два потока. }

implementation

uses
 l3ImplUses
 //#UC START# *47A080670100impl_uses*
 //#UC END# *47A080670100impl_uses*
;

procedure l3CompareFiles;
//#UC START# *4B2FC528001C_47A080670100_var*
//#UC END# *4B2FC528001C_47A080670100_var*
begin
//#UC START# *4B2FC528001C_47A080670100_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2FC528001C_47A080670100_impl*
end;//l3CompareFiles

procedure l3IStream2Stream(const anIStream: IStream;
 out theStream: TStream);
 {* преобразует IStream в TStream. }
//#UC START# *47A080A301E7_47A080670100_var*
//#UC END# *47A080A301E7_47A080670100_var*
begin
//#UC START# *47A080A301E7_47A080670100_impl*
 assert(false, 'L3IStream2Stream not implemented');
//#UC END# *47A080A301E7_47A080670100_impl*
end;//l3IStream2Stream

function l3Stream2IStream(aStream: TStream): IStream;
 {* преобразует TStream в IStream. }
//#UC START# *47A080BA000E_47A080670100_var*
//#UC END# *47A080BA000E_47A080670100_var*
begin
//#UC START# *47A080BA000E_47A080670100_impl*
 assert(false, 'L3Stream2IStream not implemented');
//#UC END# *47A080BA000E_47A080670100_impl*
end;//l3Stream2IStream

function l3CopyStream(anInStream: TStream;
 anOutStream: TStream): Large;
 {* копирует из одного потока в другой. }
//#UC START# *47A080C802F4_47A080670100_var*
//#UC END# *47A080C802F4_47A080670100_var*
begin
//#UC START# *47A080C802F4_47A080670100_impl*
 assert(false, 'L3CopyStream not implemented');
//#UC END# *47A080C802F4_47A080670100_impl*
end;//l3CopyStream

function l3CompareStreams(const aStream1: IStream;
 const aStream2: IStream): Boolean;
 {* сравнивает побайтово два потока. }
//#UC START# *47A0811D03D3_47A080670100_var*
//#UC END# *47A0811D03D3_47A080670100_var*
begin
//#UC START# *47A0811D03D3_47A080670100_impl*
 assert(false, 'L3CompareStreams not implemented');
//#UC END# *47A0811D03D3_47A080670100_impl*
end;//l3CompareStreams

function l3CompareStreams(aStream1: TStream;
 aStream2: TStream): Boolean;
 {* сравнивает побайтово два потока. }
//#UC START# *47A081370242_47A080670100_var*
//#UC END# *47A081370242_47A080670100_var*
begin
//#UC START# *47A081370242_47A080670100_impl*
 assert(false, 'L3CompareStreams not implemented');
//#UC END# *47A081370242_47A080670100_impl*
end;//l3CompareStreams

end.
