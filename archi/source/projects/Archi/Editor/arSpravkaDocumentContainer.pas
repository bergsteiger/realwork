unit arSpravkaDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editor"
// Модуль: "w:/archi/source/projects/Archi/Editor/arSpravkaDocumentContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::DocumentContainer::TarSpravkaDocumentContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  arDocumentContainer,
  evOpProc
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarSpravkaDocumentContainer = class(TarDocumentContainer)
 protected
 // overridden protected methods
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
 end;//TarSpravkaDocumentContainer
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  evdStyles
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}

// start class TarSpravkaDocumentContainer

procedure TarSpravkaDocumentContainer.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_4F9501970235_var*
//#UC END# *47F35245009A_4F9501970235_var*
begin
//#UC START# *47F35245009A_4F9501970235_impl*
 inherited MakeProcessor(theProcessor);
 theProcessor.DefaultStyle := ev_saNormalNote;
//#UC END# *47F35245009A_4F9501970235_impl*
end;//TarSpravkaDocumentContainer.MakeProcessor

{$IfEnd} //AppClientSide

end.