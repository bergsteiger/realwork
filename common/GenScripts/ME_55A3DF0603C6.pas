unit tfwDictionaryCache;

interface

uses
 l3IntfUses
 , tfwDictionaryCachePrim
 , l3Interfaces
 , l3Types
;

type
 TtfwDictionaryCache = class(TtfwDictionaryCachePrim)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwDictionaryCache
 
implementation

uses
 l3ImplUses
 , tfwMainDictionaryCache
 , l3String
;

end.
