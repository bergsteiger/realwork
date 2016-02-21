unit evQueryCardProcessor;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evQueryCardProcessor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEditorWindowProcessor
 , l3Variant
 , l3Types
 , nevBase
;

type
 TevQueryCardProcessor = class(TevEditorWindowProcessor)
  private
   function NeedAdd(Parent: Tl3Variant;
    Child: Tl3Variant;
    var aIndex: Integer): Boolean; virtual;
  protected
   procedure DoCheckParaOp(aParent: Tl3Variant;
    var aChild: Tl3Variant;
    anOp: Tl3Operation;
    anIndex: TnevParaIndex); override;
    {* проверить операцию с параграфом }
   procedure DoAfterUndoRedo; override;
   procedure DoParaOp(Parent: Tl3Variant;
    Child: Tl3Variant;
    Op: Tl3Operation); override;
    {* завершить операцию с параграфом }
 end;//TevQueryCardProcessor

implementation

uses
 l3ImplUses
 , SysUtils
 , evControlParaConst
 , k2Except
 , k2Tags
 , ReqRow_Const
 , ReqCell_Const
 , nevTools
;

function TevQueryCardProcessor.NeedAdd(Parent: Tl3Variant;
 Child: Tl3Variant;
 var aIndex: Integer): Boolean;
//#UC START# *48E4CB1A03B7_48DBA722010B_var*
//#UC END# *48E4CB1A03B7_48DBA722010B_var*
begin
//#UC START# *48E4CB1A03B7_48DBA722010B_impl*
 aIndex := Parent.IndexOfChild(Child);
 if aIndex = 0 then
  Result := False
 else
  if aIndex = Parent.ChildrenCount - 1 then
   Result := True
  else
   if Parent.Child[aIndex - 1].StrA[k2_tiReqID] <> Child.StrA[k2_tiReqID] then
    Result := False
   else
    Result := Parent.Child[aIndex + 1].StrA[k2_tiReqID] <> Child.StrA[k2_tiReqID];
 if Result then
  Dec(aIndex)
 else
  Inc(aIndex);
//#UC END# *48E4CB1A03B7_48DBA722010B_impl*
end;//TevQueryCardProcessor.NeedAdd

procedure TevQueryCardProcessor.DoCheckParaOp(aParent: Tl3Variant;
 var aChild: Tl3Variant;
 anOp: Tl3Operation;
 anIndex: TnevParaIndex);
 {* проверить операцию с параграфом }
//#UC START# *48E4CB990000_48DBA722010B_var*
var
 l_Container: InevQueryDocumentContainer;
//#UC END# *48E4CB990000_48DBA722010B_var*
begin
//#UC START# *48E4CB990000_48DBA722010B_impl*
 if Supports(Document, InevQueryDocumentContainer, l_Container) then
  case anOp of
   l3_opInsert:
      if aChild.IsKindOf(k2_typReqRow) or aParent.IsKindOf(k2_typReqRow)
        or aParent.IsKindOf(k2_typReqCell) then
       //Вторая проверка - чтобы исключить возможность вставить второе поле в
       //одну и ту же строку в этом случае aChild - k2_idTextPara, что не есть
       //хорошо. :-(
       if not InUndo and not l_Container.ModelNotify.CanInsertPara then
        raise Ek2CannotAddChild.Create('Нельзя вставить новый контрол в КЗ!');
  end;
 inherited;
//#UC END# *48E4CB990000_48DBA722010B_impl*
end;//TevQueryCardProcessor.DoCheckParaOp

procedure TevQueryCardProcessor.DoAfterUndoRedo;
//#UC START# *48E4CBD6038B_48DBA722010B_var*
var
 l_Container: InevQueryDocumentContainer;
//#UC END# *48E4CBD6038B_48DBA722010B_var*
begin
//#UC START# *48E4CBD6038B_48DBA722010B_impl*
 if Supports(Document, InevQueryDocumentContainer, l_Container) then
  l_Container.ModelNotify.UpdateState;
//#UC END# *48E4CBD6038B_48DBA722010B_impl*
end;//TevQueryCardProcessor.DoAfterUndoRedo

procedure TevQueryCardProcessor.DoParaOp(Parent: Tl3Variant;
 Child: Tl3Variant;
 Op: Tl3Operation);
 {* завершить операцию с параграфом }
//#UC START# *48E4CBE8018B_48DBA722010B_var*
var
 l_Container : InevQueryDocumentContainer;
 l_Index     : Integer;
 l_Add       : Boolean;
//#UC END# *48E4CBE8018B_48DBA722010B_var*
begin
//#UC START# *48E4CBE8018B_48DBA722010B_impl*
 inherited;
 if InUndo and Child.IsKindOf(k2_typReqRow) and
  Supports(Document, InevQueryDocumentContainer, l_Container) then
   case Op of
    l3_opInsert: begin
       l_Add := NeedAdd(Parent, Child, l_Index);
       l_Container.ModelNotify.InsertOnUndo(Parent.Child[l_Index], Child, l_Add);
      end;
    l3_opDelete:
       l_Container.ModelNotify.DeleteOnUndo(Child);
    end;
//#UC END# *48E4CBE8018B_48DBA722010B_impl*
end;//TevQueryCardProcessor.DoParaOp

end.
