unit NOT_FINISHED_nsContentsTagNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/NOT_FINISHED_nsContentsTagNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsContentsTagNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  k2Interfaces,
  nsContentsNode
  ;

type
 TnsContentsTagNode = class(TnsContentsNode)
 private
 // private fields
   f_Tag : Ik2Tag;
    {* Тег, который представляет нода.}
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//TnsContentsTagNode

implementation

// start class TnsContentsTagNode

procedure TnsContentsTagNode.ClearFields;
 {-}
begin
 f_Tag := nil;
 inherited;
end;//TnsContentsTagNode.ClearFields

end.