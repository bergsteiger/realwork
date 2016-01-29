unit l3VCLFormPtrList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , Forms
;

type
 Tl3VCLFormPtrList = class(_l3ObjectPtrList_)
  {* Список УКАЗАТЕЛЕЙ на формы VCL }
 end;//Tl3VCLFormPtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
