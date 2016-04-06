unit evReqIterator;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevReqIterator" MUID: (4E81A1D3027D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , evQueryCardInt
 , evQueryCardEditor
;

type
 TevReqIterator = class(Tl3CProtoObject, IevReqIterator)
  private
   f_Model: IevQueryCard;
  protected
   function DoReq(anAction: IevReqIterator_DoReq_Action): Integer; virtual;
   function DoReqF(anAction: IevReqIterator_DoReq_Action): Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aModel: IevQueryCard); reintroduce; overload;
   class function Make(const aModel: IevQueryCard): IevReqIterator; reintroduce; overload;
   constructor Create(anEditor: TevQueryCardEditor); reintroduce; overload;
   class function Make(anEditor: TevQueryCardEditor): IevReqIterator; reintroduce; overload;
 end;//TevReqIterator

implementation

uses
 l3ImplUses
 , nevTools
 , l3Base
;

constructor TevReqIterator.Create(const aModel: IevQueryCard);
//#UC START# *4E81A27A0202_4E81A1D3027D_var*
//#UC END# *4E81A27A0202_4E81A1D3027D_var*
begin
//#UC START# *4E81A27A0202_4E81A1D3027D_impl*
 inherited Create;
 f_Model := aModel;
//#UC END# *4E81A27A0202_4E81A1D3027D_impl*
end;//TevReqIterator.Create

class function TevReqIterator.Make(const aModel: IevQueryCard): IevReqIterator;
var
 l_Inst : TevReqIterator;
begin
 l_Inst := Create(aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevReqIterator.Make

constructor TevReqIterator.Create(anEditor: TevQueryCardEditor);
//#UC START# *4E820B680303_4E81A1D3027D_var*
//#UC END# *4E820B680303_4E81A1D3027D_var*
begin
//#UC START# *4E820B680303_4E81A1D3027D_impl*
 Create((anEditor.TextSource.DocumentContainer As InevQueryDocumentContainer).ModelNotify As IevQueryCard);
//#UC END# *4E820B680303_4E81A1D3027D_impl*
end;//TevReqIterator.Create

class function TevReqIterator.Make(anEditor: TevQueryCardEditor): IevReqIterator;
var
 l_Inst : TevReqIterator;
begin
 l_Inst := Create(anEditor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevReqIterator.Make

function TevReqIterator.DoReq(anAction: IevReqIterator_DoReq_Action): Integer;
//#UC START# *4E81A119033D_4E81A1D3027D_var*
var
 l_Group : IevQueryGroup;
 l_GroupIndex : Integer;
 l_ReqIndex   : Integer;
//#UC END# *4E81A119033D_4E81A1D3027D_var*
begin
//#UC START# *4E81A119033D_4E81A1D3027D_impl*
 f_Model.StartLongOperation;
 try
  for l_GroupIndex := 0 to Pred(f_Model.GroupCount) do
  begin
   l_Group := f_Model.QueryGroup[l_GroupIndex];
   for l_ReqIndex := 0 to Pred(l_Group.ReqCount) do
   begin
    if not anAction(l_Group.Req[l_ReqIndex]) then
     Exit;
   end;//for l_ReqIndex
  end;//for l_GroupIndex
 finally
  f_Model.EndLongOperation;
 end;//try..finally
//#UC END# *4E81A119033D_4E81A1D3027D_impl*
end;//TevReqIterator.DoReq

function TevReqIterator.DoReqF(anAction: IevReqIterator_DoReq_Action): Integer;
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := DoReq(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//TevReqIterator.DoReqF

procedure TevReqIterator.ClearFields;
begin
 f_Model := nil;
 inherited;
end;//TevReqIterator.ClearFields

end.
