unit NOT_FINISHED_arSpravkaTextOfDocument;
 {* �extSource ��� �������. }

// ������: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arSpravkaTextOfDocument.pas"
// ���������: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arTextOfDocument
 , nevTools
;

type
 TarSpravkaTextOfDocument = class(TarTextOfDocument)
  {* �extSource ��� �������. }
  protected
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TarSpravkaTextOfDocument
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , arSpravkaDocumentContainer
;

function TarSpravkaTextOfDocument.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4F9502130133_var*
//#UC END# *482D9A030221_4F9502130133_var*
begin
//#UC START# *482D9A030221_4F9502130133_impl*
 !!! Needs to be implemented !!!
//#UC END# *482D9A030221_4F9502130133_impl*
end;//TarSpravkaTextOfDocument.DoMakeDocumentContainer
{$IfEnd} // Defined(AppClientSide)

end.
