unit f1QueryDocumentContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\QueryCardProcessing\f1QueryDocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , evQueryDocumentContainer
 , nsQueryInterfaces
 , ActiveX
 , SearchUnit
 , evQueryCardInt
 , IOUnit
 , l3Interfaces
 , l3Variant
 , nevTools
;

type
 Tf1QueryDocumentContainer = class(TevQueryDocumentContainer)
  private
   f_CardType: TlgQueryType;
    {* Тип карточки }
  public
   constructor Create; reintroduce;
   class function Make(aCardType: TlgQueryType;
    const aModel: IevAdapterModel): InevDocumentContainer; reintroduce;
 end;//Tf1QueryDocumentContainer
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , DataAdapter
 , nsSearchClasses
 , evdTypes
 , k2IUnknownTag
 , evTypes
 , k2Tags
 , Table_Const
 , ReqRow_Const
 , ControlsBlock_Const
 , nsTypes
 , l3String
 , k2String_Const
 , l3Types
 , k2IUnknown_Const
 , SysUtils
 , l3TreeInterfaces
 , DynamicTreeUnit
 , nsTreeUtils
 , nsAttributeTreeStruct
 , nsINodeWrap
;

constructor Tf1QueryDocumentContainer.Create;
//#UC START# *4CCEADD30141_4CCEACEC0101_var*
var
 l_Info : IQueryCardInfo;
 l_T : Integer;
 l_R : Integer;
 l_B : Integer;
//#UC END# *4CCEADD30141_4CCEACEC0101_var*
begin
//#UC START# *4CCEADD30141_4CCEACEC0101_impl*
 inherited Create(nil);
 f_CardType := aCardType;
 Case f_CardType of
  lg_qtAttribute :
   l_Info := DefDataAdapter.NativeAdapter.CreateQueryCardInfo(QCT_ATTRIBUTE);
  lg_qtLegislationReview :
   l_Info := DefDataAdapter.NativeAdapter.CreateQueryCardInfo(QCT_REVIEW);
  lg_qtSendConsultation:
   l_Info := DefDataAdapter.NativeAdapter.CreateQueryCardInfo(QCT_CONSULTING);
  lg_qtInpharmSearch:
   l_Info := DefDataAdapter.NativeAdapter.CreateQueryCardInfo(QCT_PHARM);
  lg_qtPostingOrder:
   l_Info := DefDataAdapter.NativeAdapter.CreateQueryCardInfo(QCT_PRIME);
  else
   Assert(false);
 end;//Case f_CardType
 try
  l_Info.GetEvdCard(l_S);
  Assert(l_S <> nil);
  try
   Self.WriteTag(nil, cf_EverestBin, l_S, nil);
  finally
   l_S := nil;
  end;//try..finally
  l_Info.GetExistAttrs(l_L);
  Assert(l_L <> nil);
  try
   with Document do
    for l_B := 0 to Pred(ChildrenCount) do
     with Child[l_B] do
      if IsKindOf(k2_typControlsBlock) then
      begin
       for l_T := 0 to Pred(ChildrenCount) do
        with Child[l_T] do
         if IsKindOf(k2_typTable) then
         begin
          l_R := 0;
          while (l_R < ChildrenCount) do
          begin
           if not ProcessRow(Child[l_R]) then
           begin
            DeleteChild(l_R);
            continue;
           end//not ProcessRow(Child[l_R])
           else
            Inc(l_R);
          end;//l_R < ChildrenCount
         end;//IsKindOf(k2_typTable)
      end;//IsKindOf(k2_typControlsBlock)
  finally
   l_L := nil;
  end;//try..finally
 finally
  l_Info := nil;
 end;//try..finally
//#UC END# *4CCEADD30141_4CCEACEC0101_impl*
end;//Tf1QueryDocumentContainer.Create

class function Tf1QueryDocumentContainer.Make(aCardType: TlgQueryType;
 const aModel: IevAdapterModel): InevDocumentContainer;
var
 l_Inst : Tf1QueryDocumentContainer;
begin
 l_Inst := Create(aCardType, aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tf1QueryDocumentContainer.Make
{$IfEnd} // NOT Defined(Admin)

end.
