unit nsCommentMemoryStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsCommentMemoryStream.pas"
// Начат: 24.11.2010 19:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsCommentMemoryStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Memory,
  l3IID
  ;

type
 TnsCommentMemoryStream = class(Tl3MemoryStream)
 protected
 // overridden protected methods
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* метод для реализации QueryInterface (Для перекрытия в потомках) }
 end;//TnsCommentMemoryStream

implementation

uses
  l3Interfaces
  ;

// start class TnsCommentMemoryStream

function TnsCommentMemoryStream.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
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