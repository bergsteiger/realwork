unit ddSectionProperty;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddSectionProperty.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddSectionProperty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  RTFtypes,
  ddDocumentProperty,
  ddPropertyObject
  ;

type
 TddSectionProperty = class(TddDocumentProperty)
 private
 // private fields
   f_cCols : Integer;
    {* Поле для свойства cCols}
   f_ColsSpace : Integer;
    {* Поле для свойства ColsSpace}
   f_EndHere : Boolean;
    {* Поле для свойства EndHere}
   f_Landscape : Boolean;
    {* Поле для свойства Landscape}
   f_LineBetween : Boolean;
    {* Поле для свойства LineBetween}
   f_Unlocked : Boolean;
    {* Поле для свойства Unlocked}
   f_pgnFormat : TPGN;
    {* Поле для свойства pgnFormat}
   f_SBK : TSBK;
    {* Поле для свойства SBK}
 public
 // overridden public methods
   constructor Create; override;
     {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
   procedure Clear; override;
   procedure AssignFrom(anOther: TddPropertyObject); override;
 public
 // public properties
   property cCols: Integer
     read f_cCols
     write f_cCols;
   property ColsSpace: Integer
     read f_ColsSpace
     write f_ColsSpace;
   property EndHere: Boolean
     read f_EndHere
     write f_EndHere;
   property Landscape: Boolean
     read f_Landscape
     write f_Landscape;
   property LineBetween: Boolean
     read f_LineBetween
     write f_LineBetween;
   property Unlocked: Boolean
     read f_Unlocked
     write f_Unlocked;
   property pgnFormat: TPGN
     read f_pgnFormat
     write f_pgnFormat;
   property SBK: TSBK
     read f_SBK
     write f_SBK;
 end;//TddSectionProperty

implementation

// start class TddSectionProperty

constructor TddSectionProperty.Create;
//#UC START# *47914F960008_51DBBE7802D5_var*
//#UC END# *47914F960008_51DBBE7802D5_var*
begin
//#UC START# *47914F960008_51DBBE7802D5_impl*
 inherited Create;
 Clear;
//#UC END# *47914F960008_51DBBE7802D5_impl*
end;//TddSectionProperty.Create

procedure TddSectionProperty.Clear;
//#UC START# *518A13330058_51DBBE7802D5_var*
//#UC END# *518A13330058_51DBBE7802D5_var*
begin
//#UC START# *518A13330058_51DBBE7802D5_impl*
 inherited;
 f_cCols := 0;                  { number of column }
 ColsSpace:= 720;    { пространство между колонками }
 LineBetween:= False;  { линия между колонками }
 SBK:= sbkPg;                    { section break type  }
 pgnFormat:= pgDec;              { how the page number is formatted      }
 EndHere:= False; { конечные сноски в конце секции }
 Unlocked:= True; { раздел открыт для форм }
 Landscape:= False;
//#UC END# *518A13330058_51DBBE7802D5_impl*
end;//TddSectionProperty.Clear

procedure TddSectionProperty.AssignFrom(anOther: TddPropertyObject);
//#UC START# *5301DFE6002C_51DBBE7802D5_var*
//#UC END# *5301DFE6002C_51DBBE7802D5_var*
begin
//#UC START# *5301DFE6002C_51DBBE7802D5_impl*
 if (anOther Is TddSectionProperty) then
 begin
  cCols:= TddSectionProperty(anOther).cCols;
  ColsSpace:= TddSectionProperty(anOther).ColsSpace;
  EndHere:= TddSectionProperty(anOther).EndHere;
  Landscape:= TddSectionProperty(anOther).Landscape;
  LineBetween:= TddSectionProperty(anOther).LineBetween;
  pgnFormat:= TddSectionProperty(anOther).pgnFormat;
  SBK:= TddSectionProperty(anOther).SBK;
  Unlocked:= TddSectionProperty(anOther).Unlocked;
 end else
  inherited AssignFrom(anOther);
//#UC END# *5301DFE6002C_51DBBE7802D5_impl*
end;//TddSectionProperty.AssignFrom

end.