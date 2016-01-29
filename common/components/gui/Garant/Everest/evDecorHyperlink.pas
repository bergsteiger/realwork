unit evDecorHyperlink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evDecorHyperlink.pas"
// �����: 13.07.2011 21:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevDecorHyperlink
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot)}
uses
  nevTools,
  nevNavigation,
  evHyperlinkProxy,
  afwNavigation,
  l3Types,
  evdTypes,
  l3Variant
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 RevDecorHyperlink = class of TevDecorHyperlink;

 TevDecorHyperlink = class(TevHyperlinkProxy)
 private
 // private fields
   f_Para : InevPara;
 protected
 // overridden protected methods
   function DoFromDocumentExternalHandle: Integer; override;
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aPara: InevPara;
     const aLink: IevHyperlink); reintroduce;
   class function Make(const aPara: InevPara;
     const aLink: IevHyperlink): IevHyperlink; reintroduce;
     {* ��������� ������� TevDecorHyperlink.Make }
 end;//TevDecorHyperlink
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  Document_Const,
  k2Tags
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

// start class TevDecorHyperlink

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
end;

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
 {-}
begin
 {$If defined(evNeedHotSpot)}
 f_Para := nil;
 {$IfEnd} //evNeedHotSpot
 inherited;
end;//TevDecorHyperlink.ClearFields

{$IfEnd} //evNeedHotSpot

end.