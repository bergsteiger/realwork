unit nevActiveHyperlink;
 {* Активная гиперссылка }

// Модуль: "w:\common\components\gui\Garant\Everest\nevActiveHyperlink.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , l3CProtoObject
 , nevTools
 , l3Variant
;

type
 InevActiveHyperlink = interface(InevActiveElement)
  ['{2FAD6248-B71E-4E2F-8F01-263AE880319D}']
  function Get_Hyperlink: Tl3Tag;
  property Hyperlink: Tl3Tag
   read Get_Hyperlink;
 end;//InevActiveHyperlink

 TnevActiveHyperlink = class(Tl3CProtoObject, InevActiveHyperlink)
  {* Активная гиперссылка }
  private
   f_Para: InevPara;
   f_Hyperlink: Tl3Tag;
  protected
   function IsSame(const anElement: InevActiveElement): Boolean;
   function Get_Hyperlink: Tl3Tag;
   function Get_Para: InevPara;
   procedure Invalidate;
    {* Перерисовывает область активного элемента }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(const aPara: InevPara;
    aHyperlink: Tl3Variant); reintroduce;
   class function Make(const aPara: InevPara;
    aHyperlink: Tl3Variant): InevActiveHyperlink; reintroduce;
 end;//TnevActiveHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , SysUtils
 , k2Tags
;

constructor TnevActiveHyperlink.Create(const aPara: InevPara;
 aHyperlink: Tl3Variant);
//#UC START# *4A27C50D027C_4A27C4D20100_var*
//#UC END# *4A27C50D027C_4A27C4D20100_var*
begin
//#UC START# *4A27C50D027C_4A27C4D20100_impl*
 inherited Create;
 Assert(aPara <> nil);
 Assert(aHyperlink <> nil);
 f_Para := aPara;
 aHyperlink.SetRef(f_Hyperlink);
//#UC END# *4A27C50D027C_4A27C4D20100_impl*
end;//TnevActiveHyperlink.Create

class function TnevActiveHyperlink.Make(const aPara: InevPara;
 aHyperlink: Tl3Variant): InevActiveHyperlink;
var
 l_Inst : TnevActiveHyperlink;
begin
 l_Inst := Create(aPara, aHyperlink);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevActiveHyperlink.Make

function TnevActiveHyperlink.IsSame(const anElement: InevActiveElement): Boolean;
//#UC START# *4A27C48E017F_4A27C4D20100_var*
var
 l_E  : InevActiveHyperlink;
 l_HL : Tl3Variant;
//#UC END# *4A27C48E017F_4A27C4D20100_var*
begin
//#UC START# *4A27C48E017F_4A27C4D20100_impl*
 Result := false;
 if Supports(anElement, InevActiveHyperlink, l_E) then
  try
   if f_Para.AsObject.IsSame(l_E.Para.AsObject) then
   begin
    l_HL := l_E.Hyperlink;
    Result := f_Hyperlink.IsSame(l_HL);
    if not Result then
     // - пытаемся обработать многослойные конструкции
     Result := //(f_Hyperlink.TagType.ID = l_HL.TagType.ID) AND
               // http://mdp.garant.ru/pages/viewpage.action?pageId=176751058
               // - не надо сравнивать типы тегов, т.к. гиперссылка может перекрывать
               //   другое оформление и поверх этого оформления надо показывать
               //   стиль активной гиперссылки
               (l_HL.IntA[k2_tiStart] >= f_Hyperlink.IntA[k2_tiStart]) AND
               (l_HL.IntA[k2_tiFinish] <= f_Hyperlink.IntA[k2_tiFinish]);
   end;//f_Para.IsSame(l_E.Para)
  finally
   l_E := nil;
  end;//try..finally
//#UC END# *4A27C48E017F_4A27C4D20100_impl*
end;//TnevActiveHyperlink.IsSame

function TnevActiveHyperlink.Get_Hyperlink: Tl3Tag;
//#UC START# *4A27C5C600AC_4A27C4D20100get_var*
//#UC END# *4A27C5C600AC_4A27C4D20100get_var*
begin
//#UC START# *4A27C5C600AC_4A27C4D20100get_impl*
 Result := f_Hyperlink;
//#UC END# *4A27C5C600AC_4A27C4D20100get_impl*
end;//TnevActiveHyperlink.Get_Hyperlink

function TnevActiveHyperlink.Get_Para: InevPara;
//#UC START# *4A27C5CD001C_4A27C4D20100get_var*
//#UC END# *4A27C5CD001C_4A27C4D20100get_var*
begin
//#UC START# *4A27C5CD001C_4A27C4D20100get_impl*
 Result := f_Para;
//#UC END# *4A27C5CD001C_4A27C4D20100get_impl*
end;//TnevActiveHyperlink.Get_Para

procedure TnevActiveHyperlink.Invalidate;
 {* Перерисовывает область активного элемента }
//#UC START# *4FBF5595010C_4A27C4D20100_var*
//#UC END# *4FBF5595010C_4A27C4D20100_var*
begin
//#UC START# *4FBF5595010C_4A27C4D20100_impl*
 f_Para.Invalidate([]);
//#UC END# *4FBF5595010C_4A27C4D20100_impl*
end;//TnevActiveHyperlink.Invalidate

procedure TnevActiveHyperlink.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A27C4D20100_var*
//#UC END# *479731C50290_4A27C4D20100_var*
begin
//#UC START# *479731C50290_4A27C4D20100_impl*
 f_Para := nil;
 FreeAndNil(f_Hyperlink);
 inherited;
//#UC END# *479731C50290_4A27C4D20100_impl*
end;//TnevActiveHyperlink.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TnevActiveHyperlink.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4A27C4D20100_var*
//#UC END# *47A6FEE600FC_4A27C4D20100_var*
begin
//#UC START# *47A6FEE600FC_4A27C4D20100_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4A27C4D20100_impl*
end;//TnevActiveHyperlink.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // Defined(evNeedHotSpot)
end.
