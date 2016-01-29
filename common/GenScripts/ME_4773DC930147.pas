unit l3LongintListPrim;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , Classes
;

type
 Tl3LongintListPrim = class(_l3AtomicList_)
  {* Список целых чисел. }
  procedure Load(aStream: TStream);
  procedure Save(aStream: TStream);
  function Delete(anIndex: Integer): Integer;
   {* удалить элемент с индексом Index. }
  procedure SaveToStream(aStream: TStream);
   {* Сохраняет в поток. }
  procedure LoadFromStream(aStream: TStream;
   aNeedSort: Boolean);
   {* Загружает из потока. }
 end;//Tl3LongintListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3Stream
;

end.
