unit evCommentParaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\evCommentParaCursor.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evDocumentPartCursor
 , nevTools
 , nevBase
;

type
 TevCommentParaCursor = class(TevDocumentPartCursor)
  protected
   function DoDeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function IsShowingDocumentParts(const aView: InevControlView): Boolean; override;
 end;//TevCommentParaCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;

function TevCommentParaCursor.DoDeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7F5022C_4A40EB120375_var*
//#UC END# *4A38F7F5022C_4A40EB120375_var*
begin
//#UC START# *4A38F7F5022C_4A40EB120375_impl*
 inherited DoDeleteChar(aView, aDrawLines, anOp);
 Result := true;
//#UC END# *4A38F7F5022C_4A40EB120375_impl*
end;//TevCommentParaCursor.DoDeleteChar

function TevCommentParaCursor.IsShowingDocumentParts(const aView: InevControlView): Boolean;
//#UC START# *4A3FA3FA0033_4A40EB120375_var*
//#UC END# *4A3FA3FA0033_4A40EB120375_var*
begin
//#UC START# *4A3FA3FA0033_4A40EB120375_impl*
 {$IfDef Nemesis}
 Result := false;
 {$Else  Nemesis}
 Result := true;
 {$EndIf Nemesis}
//#UC END# *4A3FA3FA0033_4A40EB120375_impl*
end;//TevCommentParaCursor.IsShowingDocumentParts
{$IfEnd} // Defined(evUseVisibleCursors)

end.
