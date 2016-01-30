unit evReqIterator;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqIterator.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

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

procedure TevReqIterator.ClearFields;
begin
 f_Model := nil;
 inherited;
end;//TevReqIterator.ClearFields

end.
