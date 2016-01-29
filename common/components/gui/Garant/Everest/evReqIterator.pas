unit evReqIterator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evReqIterator.pas"
// Начат: 27.09.2011 14:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qfUtils::TevReqIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evQueryCardInt,
  evQueryCardEditor,
  l3CProtoObject
  ;

type
 TevReqIterator = class(Tl3CProtoObject, IevReqIterator)
 private
 // private fields
   f_Model : IevQueryCard;
 protected
 // realized methods
   {iterator} function DoReq(anAction: IevReqIterator_DoReq_Action): Integer;
   {iterator} function DoReqF(anAction: IevReqIterator_DoReq_Action): Integer;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aModel: IevQueryCard); reintroduce; overload; 
   class function Make(const aModel: IevQueryCard): IevReqIterator; reintroduce; overload; 
     {* Сигнатура фабрики TevReqIterator.Make }
   constructor Create(anEditor: TevQueryCardEditor); overload; 
   class function Make(anEditor: TevQueryCardEditor): IevReqIterator; reintroduce; overload; 
     {* Сигнатура фабрики TevReqIterator.Make$1 }
 end;//TevReqIterator

implementation

uses
  l3Base,
  nevTools
  ;

// start class TevReqIterator

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
end;

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
end;

procedure TevReqIterator.ClearFields;
 {-}
begin
 f_Model := nil;
 inherited;
end;//TevReqIterator.ClearFields

{iterator} function TevReqIterator.DoReq(anAction: IevReqIterator_DoReq_Action): Integer;
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

{iterator} function TevReqIterator.DoReqF(anAction: IevReqIterator_DoReq_Action): Integer;
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := DoReq(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;

end.