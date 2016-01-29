unit NOT_FINISHED_evCustomTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evCustomTextSource.pas"
// Начат: 09.04.1997 15:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::TextSources::TevCustomTextSource
//
// Реализация источника документа.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevBase,
  l3InterfacedComponent,
  nevTools,
  l3Variant
  ;

type
 TevGetControlItemImgEvent = procedure (aSender: TObject;
  const aControl: TnevControlInfo;
  out theImageInfo: TnevControlImageInfo) of object;

 TevDocumentChangedEvent = procedure (aSender: TObject;
  anOldDocument: Tl3Tag;
  aNewDocument: Tl3Tag) of object;

 TevCustomTextSource = class(Tl3InterfacedComponent)
  {* Реализация источника документа. }
 protected
 // protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; virtual;
 end;//TevCustomTextSource

implementation

// start class TevCustomTextSource

function TevCustomTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482BFB7C00B6_var*
//#UC END# *482D9A030221_482BFB7C00B6_var*
begin
//#UC START# *482D9A030221_482BFB7C00B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *482D9A030221_482BFB7C00B6_impl*
end;//TevCustomTextSource.DoMakeDocumentContainer

end.