unit ddBreak;

// Модуль: "w:\common\components\rtl\Garant\dd\ddBreak.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddBreak" MUID: (51E8EFD50162)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , RTFtypes
 , ddSectionProperty
 , ddCustomDestination
 , k2Interfaces
 , ddTypes
;

type
 TddBreak = class(TddDocumentAtom)
  private
   f_BreakType: TddBreakType;
   f_SEP: TddSectionProperty;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function HasDefaultParams: Boolean;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   constructor Create(aDetination: TddCustomDestination); override;
   function IsBreak: Boolean; override;
  public
   property BreakType: TddBreakType
    read f_BreakType
    write f_BreakType;
   property SEP: TddSectionProperty
    read f_SEP;
 end;//TddBreak

implementation

uses
 l3ImplUses
 , PageBreak_Const
 , SectionBreak_Const
 , k2Tags
 , l3Interfaces
 , l3MinMax
 , SysUtils
 , ddDocumentProperty
 //#UC START# *51E8EFD50162impl_uses*
 //#UC END# *51E8EFD50162impl_uses*
;

function TddBreak.HasDefaultParams: Boolean;
//#UC START# *53883BAC01A0_51E8EFD50162_var*
//#UC END# *53883BAC01A0_51E8EFD50162_var*
begin
//#UC START# *53883BAC01A0_51E8EFD50162_impl*
 Result := not SEP.Landscape and (SEP.xaPage = defPageWidth) and (SEP.yaPage = defPageHeight);
//#UC END# *53883BAC01A0_51E8EFD50162_impl*
end;//TddBreak.HasDefaultParams

procedure TddBreak.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_51E8EFD50162_var*
//#UC END# *518A504F00F5_51E8EFD50162_var*
begin
//#UC START# *518A504F00F5_51E8EFD50162_impl*
 case BreakType of
   breakPage :
       begin
        Generator.StartChild(k2_typPageBreak);
        Generator.Finish;
       end;
   breakSection:
       begin
        Generator.StartChild(k2_typSectionBreak);
        try
         Generator.StartTag(k2_tiParas);
         try
          if SEP.Landscape then
          begin
           Generator.AddIntegerAtom(k2_tiOrientation, Ord(l3_poLandscape));
           Generator.AddIntegerAtom(k2_tiHeight, Max(SEP.yaPage, SEP.xaPage));
           Generator.AddIntegerAtom(k2_tiWidth, Min(SEP.xaPage, SEP.yaPage));
          end
          else
          begin
           Generator.AddIntegerAtom(k2_tiOrientation, Ord(l3_poPortrait));
           Generator.AddIntegerAtom(k2_tiHeight, Max(SEP.yaPage, SEP.xaPage));
           Generator.AddIntegerAtom(k2_tiWidth, Min(SEP.xaPage, SEP.yaPage));
          end;
         finally
          Generator.Finish;
         end;{try..finally}
        finally
         Generator.Finish;
        end;
       end;
 end;
//#UC END# *518A504F00F5_51E8EFD50162_impl*
end;//TddBreak.Write2Generator

procedure TddBreak.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51E8EFD50162_var*
//#UC END# *479731C50290_51E8EFD50162_var*
begin
//#UC START# *479731C50290_51E8EFD50162_impl*
 FreeAndNil(f_SEP);
 inherited;
//#UC END# *479731C50290_51E8EFD50162_impl*
end;//TddBreak.Cleanup

constructor TddBreak.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_51E8EFD50162_var*
//#UC END# *51E91BA80051_51E8EFD50162_var*
begin
//#UC START# *51E91BA80051_51E8EFD50162_impl*
 inherited Create(aDetination);
 f_SEP := TddSectionProperty.Create;
//#UC END# *51E91BA80051_51E8EFD50162_impl*
end;//TddBreak.Create

function TddBreak.IsBreak: Boolean;
//#UC START# *5268D65201D6_51E8EFD50162_var*
//#UC END# *5268D65201D6_51E8EFD50162_var*
begin
//#UC START# *5268D65201D6_51E8EFD50162_impl*
 Result := True;
//#UC END# *5268D65201D6_51E8EFD50162_impl*
end;//TddBreak.IsBreak

end.
