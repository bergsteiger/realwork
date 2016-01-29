unit nevControlsBlock;
 {* Блок контролов как контрол. }

{ Библиотека "Эверест"    }
{ Начал: Лукьянец Р.В.       }
{ Модуль: nevControlPara - }
{ Начат: 07.09.2006 11:11 }

// $Log: nevControlsBlock.pas,v $
// Revision 1.10  2014/04/07 17:57:03  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2011/07/13 17:38:33  lulin
// {RequestLink:228688745}.
//
// Revision 1.8  2011/06/08 16:06:36  lulin
// {RequestLink:267326476}.
//
// Revision 1.7  2011/02/14 18:09:52  lulin
// {RequestLink:231670346}.
// - при всякого рода навигациях по тексту учитываем, что параграфы могут быть схлопнутыми.
//
// Revision 1.6  2009/07/10 16:15:46  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.5  2009/07/08 15:51:59  lulin
// {RequestLink:141264340}. №7.
//
// Revision 1.4  2009/04/15 11:14:08  lulin
// [$143396720]. Убираем лишний параметр из конструкторов и фабричных методов.
//
// Revision 1.3  2008/03/03 13:20:30  lulin
// - nevTools перенесён на модель. Теперь всё компилируется.
//
// Revision 1.2  2007/12/04 12:47:51  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.5  2007/09/14 13:26:13  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.1.2.4.2.2  2007/09/12 16:36:17  lulin
// - переименовано свойство.
//
// Revision 1.1.2.4.2.1  2007/09/12 15:23:07  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.1.2.4  2007/07/18 15:07:23  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.1.2.3  2007/02/07 18:14:00  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.1.2.2  2006/10/02 11:38:39  lulin
// - объединяем с веткой в которой размеры параграфов подсчитываются методами канвы.
//
// Revision 1.1.2.1.2.1  2006/09/28 17:23:45  lulin
// - перерисовка блока при раскрытии/закрытии перенесена в более правильное место.
//
// Revision 1.1.2.1  2006/09/11 13:57:04  oman
// - fix: Более правильная реализация IevCommonControl
//

{$Include nevDefine.inc }

interface

uses
  l3Interfaces,
  
  k2Interfaces,
  k2TagTool,

  evdTypes,
  
  evQueryCardInt,

  nevBase,
  nevTools,
  nevParaList
  ;

type
  TnevControlsBlock = class(TnevParaList, IevCommonControl)
  private
   function Get_Upper: Boolean;
     {-}
   procedure Set_Upper(Value: Boolean);
     {-}
   function  Get_ControlType: TevControlType;
     {-}
   function  Get_Flat: Boolean;
     {-}
   function  Get_Enabled: Boolean;
     {-}
   function  Get_Checked: Boolean;
   procedure Set_Checked(aValue: Boolean);
     {-}
   function  Get_Text: Tl3WString;
     {* - Текст контрола. }
   function  Get_Name: Tl3WString;
     {* - Имя контрола. }
   function pm_GetCollapsed: Boolean;
     {-}
   procedure pm_SetCollapsed(aValue: Boolean);
     {-}
  protected
    function TreatCollapsedAsHidden: Boolean; override;
  public
   class function Make(aTag       : Tl3Variant): IevCommonControl;
     reintroduce;
  end;//TnevControlsBlock

implementation

uses
 SysUtils,

 l3Base,
 l3String,

 k2Tags
 ;

{ TnevControlsBlock }

function TnevControlsBlock.Get_Checked: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiChecked];
end;

function TnevControlsBlock.Get_ControlType: TevControlType;
begin
 Result := ev_ctCollapsedPanel;
end;

function TnevControlsBlock.Get_Enabled: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiEnabled];
end;

function TnevControlsBlock.Get_Flat: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiFlat];
end;

function TnevControlsBlock.Get_Name: Tl3WString;
begin
 Result := GetRedirect.PCharLenA[k2_tiName];
end;

function TnevControlsBlock.Get_Text: Tl3WString;
begin
 Result := GetRedirect.PCharLenA[k2_tiText];
end;

procedure TnevControlsBlock.Set_Checked(aValue: Boolean);
begin
 GetRedirect.BoolW[k2_tiChecked, nil] := aValue;
end;

class function TnevControlsBlock.Make(aTag: Tl3Variant): IevCommonControl;
var
 l_Para : TnevControlsBlock;
begin
 l_Para := Create(aTag);
 try
  Result := l_Para;
 finally
  l3Free(l_Para);
 end;//try..finally
end;

function TnevControlsBlock.Get_Upper: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiUpper];
end;

procedure TnevControlsBlock.Set_Upper(Value: Boolean);
begin
 GetRedirect.BoolW[k2_tiUpper, nil{StartOp}] := Value;
end;

function TnevControlsBlock.pm_GetCollapsed: Boolean;
begin
 Result := GetRedirect.BoolA[k2_tiCollapsed];
end;

procedure TnevControlsBlock.pm_SetCollapsed(aValue: Boolean);
begin
 GetRedirect.BoolW[k2_tiCollapsed, nil] := aValue;
end;

function TnevControlsBlock.TreatCollapsedAsHidden: Boolean;
begin
 Result := false;
end;

end.

