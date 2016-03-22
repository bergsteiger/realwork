unit evDecorHyperlink;

// Модуль: "w:\common\components\gui\Garant\Everest\evDecorHyperlink.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDecorHyperlink" MUID: (4E1DD8400344)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evHyperlinkProxy
 , nevTools
 , nevNavigation
;

type
 RevDecorHyperlink = class of TevDecorHyperlink;

 TevDecorHyperlink = class(TevHyperlinkProxy)
  private
   f_Para: InevPara;
  protected
   function DoFromDocumentExternalHandle: Integer; override;
   procedure ClearFields; override;
  public
   constructor Create(const aPara: InevPara;
    const aLink: IevHyperlink); reintroduce;
   class function Make(const aPara: InevPara;
    const aLink: IevHyperlink): IevHyperlink; reintroduce;
 end;//TevDecorHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , Document_Const
 , k2Tags
 , l3Variant
;

constructor TevDecorHyperlink.Create(const aPara: InevPara;
 const aLink: IevHyperlink);
//#UC START# *4E1DD88E02EE_4E1DD8400344_var*
//#UC END# *4E1DD88E02EE_4E1DD8400344_var*
begin
//#UC START# *4E1DD88E02EE_4E1DD8400344_impl*
 Assert(aPara <> nil);
 inherited Create(aLink);
 f_Para := aPara;
//#UC END# *4E1DD88E02EE_4E1DD8400344_impl*
end;//TevDecorHyperlink.Create

class function TevDecorHyperlink.Make(const aPara: InevPara;
 const aLink: IevHyperlink): IevHyperlink;
var
 l_Inst : TevDecorHyperlink;
begin
 l_Inst := Create(aPara, aLink);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevDecorHyperlink.Make

function TevDecorHyperlink.DoFromDocumentExternalHandle: Integer;
//#UC START# *4E1DDB7D0368_4E1DD8400344_var*
var
 l_Doc : Tl3Variant;
//#UC END# *4E1DDB7D0368_4E1DD8400344_var*
begin
//#UC START# *4E1DDB7D0368_4E1DD8400344_impl*
 Result := inherited DoFromDocumentExternalHandle;
 if (Result <= 0) then
  if evInPara(f_Para.AsObject, k2_typDocument, l_Doc) then
   Result := l_Doc.rLong(k2_tiExternalHandle, -1);
//#UC END# *4E1DDB7D0368_4E1DD8400344_impl*
end;//TevDecorHyperlink.DoFromDocumentExternalHandle

procedure TevDecorHyperlink.ClearFields;
begin
 f_Para := nil;
 inherited;
end;//TevDecorHyperlink.ClearFields
{$IfEnd} // Defined(evNeedHotSpot)

end.
