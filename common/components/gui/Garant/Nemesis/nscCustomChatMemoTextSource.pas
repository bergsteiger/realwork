unit nscCustomChatMemoTextSource;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoTextSource.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscCustomChatMemoTextSource" MUID: (4A8BB2760229)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evCustomMemoTextSource
 , nevTools
;

type
 TnscCustomChatMemoTextSource = class(TevCustomMemoTextSource)
  protected
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TnscCustomChatMemoTextSource
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscCustomChatMemoContainer
;

function TnscCustomChatMemoTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4A8BB2760229_var*
//#UC END# *482D9A030221_4A8BB2760229_var*
begin
//#UC START# *482D9A030221_4A8BB2760229_impl*
 Result := TnscCustomChatMemoContainer.Make;
//#UC END# *482D9A030221_4A8BB2760229_impl*
end;//TnscCustomChatMemoTextSource.DoMakeDocumentContainer
{$IfEnd} // Defined(Nemesis)

end.
