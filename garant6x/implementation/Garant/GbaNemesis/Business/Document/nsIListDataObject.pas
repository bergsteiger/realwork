unit nsIListDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsIListDataObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::Document::TnsIListDataObject
//
// -
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicDocListUnit,
  nevTools,
  evEvdDataObject,
  nevBase,
  evdInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsIListDataObject = class(TevEvdDataObject)
  {* - }
 private
 // private fields
   f_Document : IDynList;
   f_OnlyFirstLevel : Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
     {* сохраняет поток в G }
 public
 // public methods
   constructor Create(const aData: IDynList;
    aOnlyFirstLevel: Boolean); reintroduce;
   class function Make(const aData: IDynList;
    aOnlyFirstLevel: Boolean = false): InevStorable; reintroduce;
 end;//TnsIListDataObject
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsConvert
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsIListDataObject

constructor TnsIListDataObject.Create(const aData: IDynList;
  aOnlyFirstLevel: Boolean);
//#UC START# *48F885150025_47F23C2A0219_var*
//#UC END# *48F885150025_47F23C2A0219_var*
begin
//#UC START# *48F885150025_47F23C2A0219_impl*
 inherited Create(nil);
 f_Document := aData;
 f_OnlyFirstLevel := aOnlyFirstLevel;
//#UC END# *48F885150025_47F23C2A0219_impl*
end;//TnsIListDataObject.Create

class function TnsIListDataObject.Make(const aData: IDynList;
  aOnlyFirstLevel: Boolean = false): InevStorable;
var
 l_Inst : TnsIListDataObject;
begin
 l_Inst := Create(aData, aOnlyFirstLevel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsIListDataObject.Cleanup;
//#UC START# *479731C50290_47F23C2A0219_var*
//#UC END# *479731C50290_47F23C2A0219_var*
begin
//#UC START# *479731C50290_47F23C2A0219_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_47F23C2A0219_impl*
end;//TnsIListDataObject.Cleanup

procedure TnsIListDataObject.DoStore(const G: InevTagGenerator;
  aFlags: TevdStoreFlags);
//#UC START# *48EA34990191_47F23C2A0219_var*
//#UC END# *48EA34990191_47F23C2A0219_var*
begin
//#UC START# *48EA34990191_47F23C2A0219_impl*
 f_Document.AsEvd(bsBusinessToAdapter(f_OnlyFirstLevel), f_Stream);
 try
  inherited;
 finally
  f_Stream := nil;
 end;//try..finally
//#UC END# *48EA34990191_47F23C2A0219_impl*
end;//TnsIListDataObject.DoStore

{$IfEnd} //not Admin AND not Monitorings

end.