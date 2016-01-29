unit l3Storable.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , Classes
;

type
 _l3Storable_ = class
  {* ������ ������� ������/������ ����. }
  procedure SaveToFile(const aFileName: AnsiString);
   {* ��������� � ����. }
  procedure SaveToStream(const aStream: IStream); overload;
   {* ��������� � �����. }
  procedure SaveToStream(aStream: TStream); overload;
   {* ��������� � �����. }
  procedure LoadFromFile(const aFileName: AnsiString;
   aNeedSort: Boolean);
   {* ��������� �� �����. }
  procedure LoadFromStream(const aStream: IStream;
   aNeedSort: Boolean); overload;
   {* ��������� �� ������. }
  procedure LoadFromStream(aStream: TStream;
   aNeedSort: Boolean); overload;
   {* ��������� �� ������. }
 end;//_l3Storable_
 
implementation

uses
 l3ImplUses
 , l3Stream
 , SysUtils
;

end.
