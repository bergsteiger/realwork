unit l3Storable.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , Classes
;

type
 _l3Storable_ = class
  {* Объект умеющий писать/читать себя. }
  procedure SaveToFile(const aFileName: AnsiString);
   {* Сохранить в файл. }
  procedure SaveToStream(const aStream: IStream); overload;
   {* Сохранить в поток. }
  procedure SaveToStream(aStream: TStream); overload;
   {* Сохраняет в поток. }
  procedure LoadFromFile(const aFileName: AnsiString;
   aNeedSort: Boolean);
   {* Загружает из файла. }
  procedure LoadFromStream(const aStream: IStream;
   aNeedSort: Boolean); overload;
   {* Загружает из потока. }
  procedure LoadFromStream(aStream: TStream;
   aNeedSort: Boolean); overload;
   {* Загружает из потока. }
 end;//_l3Storable_
 
implementation

uses
 l3ImplUses
 , l3Stream
 , SysUtils
;

end.
