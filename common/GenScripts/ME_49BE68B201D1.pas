unit l3ProxyStream;

interface

uses
 l3IntfUses
 , l3BaseStream
 , l3Interfaces
 , Classes
;

type
 Tl3ProxyStream = class(Tl3Stream)
  {* ����� �������� ������� ��� ������ ������� }
  procedure Create(const aStream: IStream);
  function Make(const aStream: IStream): IStream;
   {* ������ ������ ��� ������� }
  procedure CloseInner;
   {* ����������� ���������� ����� }
 end;//Tl3ProxyStream
 
implementation

uses
 l3ImplUses
 , ComObj
 , l3Types
;

end.
