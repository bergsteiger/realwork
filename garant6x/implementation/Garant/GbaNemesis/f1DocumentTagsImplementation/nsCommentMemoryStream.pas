unit nsCommentMemoryStream;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCommentMemoryStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsCommentMemoryStream" MUID: (4CED41A900AA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3Memory
 , l3IID
;

type
 TnsCommentMemoryStream = class(Tl3MemoryStream)
  protected
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* метод для реализации QueryInterface (Для перекрытия в потомках) }
 end;//TnsCommentMemoryStream

implementation

uses
 l3ImplUses
 , l3Interfaces
 //#UC START# *4CED41A900AAimpl_uses*
 //#UC END# *4CED41A900AAimpl_uses*
;

function TnsCommentMemoryStream.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* метод для реализации QueryInterface (Для перекрытия в потомках) }
//#UC START# *48F475350256_4CED41A900AA_var*
//#UC END# *48F475350256_4CED41A900AA_var*
begin
//#UC START# *48F475350256_4CED41A900AA_impl*
 if IID.SomeOf([Il3MemoryPool, Il3HandleMemoryPool]) then
  Result.SetNoInterface
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *48F475350256_4CED41A900AA_impl*
end;//TnsCommentMemoryStream.COMQueryInterface

end.
