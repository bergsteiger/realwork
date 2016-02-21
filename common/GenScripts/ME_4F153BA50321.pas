unit nsWarningDocumentContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsWarningDocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , eeDocumentContainer
 {$IfEnd} // Defined(Nemesis)
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , l3Variant
;

type
 TnsWarningDocumentContainer = class(TeeDocumentContainer)
  private
   f_ViewArea: IdsWarning;
   f_UserType: TvcmUserType;
  protected
   function GetDocument: Tl3Tag; override;
   procedure ClearFields; override;
  public
   constructor Create(const aViewArea: IdsWarning;
    aUserType: TvcmUserType); reintroduce;
   class function Make(const aViewArea: IdsWarning;
    aUserType: TvcmUserType): InevDocumentContainer; reintroduce;
 end;//TnsWarningDocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TnsWarningDocumentContainer.Create(const aViewArea: IdsWarning;
 aUserType: TvcmUserType);
//#UC START# *4F153CE400E6_4F153BA50321_var*
//#UC END# *4F153CE400E6_4F153BA50321_var*
begin
//#UC START# *4F153CE400E6_4F153BA50321_impl*
 inherited Create;
 f_ViewArea := aViewArea;
 f_UserType := aUserType;
//#UC END# *4F153CE400E6_4F153BA50321_impl*
end;//TnsWarningDocumentContainer.Create

class function TnsWarningDocumentContainer.Make(const aViewArea: IdsWarning;
 aUserType: TvcmUserType): InevDocumentContainer;
var
 l_Inst : TnsWarningDocumentContainer;
begin
 l_Inst := Create(aViewArea, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsWarningDocumentContainer.Make

function TnsWarningDocumentContainer.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4F153BA50321_var*
//#UC END# *47F27DA80172_4F153BA50321_var*
begin
//#UC START# *47F27DA80172_4F153BA50321_impl*
 Result := inherited GetDocument;
 if (Result = nil) OR not Result.IsValid then
 begin
  f_ViewArea.GenerateWarning(Self{Viewer.TextSource}.GetGenerator(nil{Viewer.View}, nil), f_UserType);
  Result := inherited GetDocument;
  // - надо вернуть то, что нагенерировали
  Assert(Result.IsValid);
 end;//Result = nil
//#UC END# *47F27DA80172_4F153BA50321_impl*
end;//TnsWarningDocumentContainer.GetDocument

procedure TnsWarningDocumentContainer.ClearFields;
begin
 f_ViewArea := nil;
 inherited;
end;//TnsWarningDocumentContainer.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
