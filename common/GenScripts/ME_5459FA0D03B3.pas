unit m3HashHandleListPrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3HashHandleListPrim.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3HashHandle
 , l3ProtoDataContainer
 , Classes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
;

type
 _ItemType_ = Tm3HashHandle;
 {$Include m3AutoAllocList.imp.pas}
 Tm3HashHandleListPrim = class(_m3AutoAllocList_)
 end;//Tm3HashHandleListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tm3HashHandleListPrim;

{$Include m3AutoAllocList.imp.pas}

end.
