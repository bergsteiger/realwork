unit arSpravkaDocumentContainer;

// Модуль: "w:\archi\source\projects\Archi\Editor\arSpravkaDocumentContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarSpravkaDocumentContainer" MUID: (4F9501970235)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arDocumentContainer
 , evOpProc
;

type
 TarSpravkaDocumentContainer = class(TarDocumentContainer)
  protected
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
 end;//TarSpravkaDocumentContainer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , evdStyles
;

procedure TarSpravkaDocumentContainer.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_4F9501970235_var*
//#UC END# *47F35245009A_4F9501970235_var*
begin
//#UC START# *47F35245009A_4F9501970235_impl*
 inherited MakeProcessor(theProcessor);
 theProcessor.DefaultStyle := ev_saNormalNote;
//#UC END# *47F35245009A_4F9501970235_impl*
end;//TarSpravkaDocumentContainer.MakeProcessor
{$IfEnd} // Defined(AppClientSide)

end.
