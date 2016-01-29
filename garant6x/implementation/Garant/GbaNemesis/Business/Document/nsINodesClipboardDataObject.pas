unit nsINodesClipboardDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsINodesClipboardDataObject.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::Document::TnsINodesClipboardDataObject
//
// ������ ������ �� �������������� ������ ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  nevTools,
  evEvdDataObject,
  nevBase,
  evdInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsINodesClipboardDataObject = class(TevEvdDataObject)
  {* ������ ������ �� �������������� ������ ������. }
 private
 // private fields
   f_Document : INodesClipboard;
   f_OnlyFirstLevel : Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
     {* ��������� ����� � G }
 public
 // public methods
   constructor Create(const aData: INodesClipboard;
    aOnlyFirstLevel: Boolean); reintroduce;
   class function Make(const aData: INodesClipboard;
    aOnlyFirstLevel: Boolean = false): InevStorable; reintroduce;
 end;//TnsINodesClipboardDataObject
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsConvert
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsINodesClipboardDataObject

constructor TnsINodesClipboardDataObject.Create(const aData: INodesClipboard;
  aOnlyFirstLevel: Boolean);
//#UC START# *48F87FE50381_47F230A0012C_var*
//#UC END# *48F87FE50381_47F230A0012C_var*
begin
//#UC START# *48F87FE50381_47F230A0012C_impl*
 inherited Create(nil);
 f_Document := aData;
 f_OnlyFirstLevel := aOnlyFirstLevel;
//#UC END# *48F87FE50381_47F230A0012C_impl*
end;//TnsINodesClipboardDataObject.Create

class function TnsINodesClipboardDataObject.Make(const aData: INodesClipboard;
  aOnlyFirstLevel: Boolean = false): InevStorable;
var
 l_Inst : TnsINodesClipboardDataObject;
begin
 l_Inst := Create(aData, aOnlyFirstLevel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsINodesClipboardDataObject.Cleanup;
//#UC START# *479731C50290_47F230A0012C_var*
//#UC END# *479731C50290_47F230A0012C_var*
begin
//#UC START# *479731C50290_47F230A0012C_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_47F230A0012C_impl*
end;//TnsINodesClipboardDataObject.Cleanup

procedure TnsINodesClipboardDataObject.DoStore(const G: InevTagGenerator;
  aFlags: TevdStoreFlags);
//#UC START# *48EA34990191_47F230A0012C_var*
//#UC END# *48EA34990191_47F230A0012C_var*
begin
//#UC START# *48EA34990191_47F230A0012C_impl*
 f_Document.AsEvd(bsBusinessToAdapter(f_OnlyFirstLevel), f_Stream);
 try
  inherited;
 finally
  f_Stream := nil;
 end;//try..finally
//#UC END# *48EA34990191_47F230A0012C_impl*
end;//TnsINodesClipboardDataObject.DoStore

{$IfEnd} //not Admin AND not Monitorings

end.