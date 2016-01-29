unit evExtDisp;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evExtDisp -     }
{ Начат: 04.10.2001 11:31 }
{ $Id: evExtDisp.pas,v 1.6 2014/02/13 13:53:27 lulin Exp $ }

// $Log: evExtDisp.pas,v $
// Revision 1.6  2014/02/13 13:53:27  lulin
// - рефакторим безликие списки.
//
// Revision 1.5  2007/12/04 12:47:41  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.4.56.2  2007/04/20 11:17:15  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.4.56.1  2007/04/20 11:07:35  lulin
// - убираем ненужную функциональность.
//
// Revision 1.4  2001/12/28 12:31:07  law
// - new prop: в описание операции добавлено свойство ShortCut.
//
// Revision 1.3  2001/10/10 10:56:39  law
// - new behavior: заточка под Action от Delphi 6.0.
//
// Revision 1.2  2001/10/04 12:42:37  law
// - new behavior: сделан котнроль за сохранением свойств Category и AutoCheck.
//
// Revision 1.1  2001/10/04 08:05:53  law
// - new behavior: сделана возмозность определения парамеров операций по умолчанию.
//

{$Include evDefine.inc }

interface

{$IfDef evNeedDisp}

uses
  Classes,

  l3Types,

  evActionInterfaces,
  evStandardActions,
  evDisp
  ;

type
  TevExOperationDescriptor = class(TevOperationDescriptor, IevExtActionDescriptor)
    private
    // property fields
      f_Caption    : String;
      f_Hint       : String;
      f_AutoCheck  : Bool;
      f_GroupIndex : Integer;
      f_ShortCut   : TShortCut;
    protected
    // property methods
      function pm_GetHint: String;
        {-}
      function pm_GetCaption: String;
        {-}
      function pm_GetAutoCheck: Bool;
        {-}
      function pm_GetGroupIndex: Integer;
        {-}
      function pm_GetShortCut: TShortCut;
        {-}
(*    public
    // public methods
      procedure Assign(P: TPersistent);
        override;
        {-}*)
    public
    // public properties
      property Hint: String
        read f_Hint
        write f_Hint;
        {-}
      property Caption: String
        read f_Caption
        write f_Caption;
        {-}
      property AutoCheck: Bool
        read f_AutoCheck
        write f_AutoCheck;
        {-}
      property GroupIndex: Integer
        read f_GroupIndex
        write f_GroupIndex;
        {-}
      property ShortCut: TShortCut
        read f_ShortCut
        write f_ShortCut;
        {-}
  end;//TevExOperationDescriptor

function evAddOperationDescriptor(anOpCode       : TevOperation;
                                  const aCaption : String;
                                  const aHint    : String = '';
                                  const aShortCut : String = '';
                                  anAutoCheck    : Bool = false;
                                  aGroupIndex    : Integer = -1): TevExOperationDescriptor;
  {-}
{$EndIf evNeedDisp}  

implementation

{$IfDef evNeedDisp}
uses
  Menus
  ;

function evAddOperationDescriptor(anOpCode       : TevOperation;
                                  const aCaption : String;
                                  const aHint    : String = '';
                                  const aShortCut : String = '';
                                  anAutoCheck    : Bool = false;
                                  aGroupIndex    : Integer = -1): TevExOperationDescriptor;
  {-}
begin
 Result := evOperationDispatcher.AddOperationDescriptor(anOpCode, TevExOperationDescriptor) As TevExOperationDescriptor;
 if (Result <> nil) then begin
  Result.Caption := aCaption;
  Result.Hint := aHint;
  Result.AutoCheck := anAutoCheck;
  Result.GroupIndex := aGroupIndex;
  if (aShortCut <> '') then
   Result.ShortCut := TextToShortCut(aShortCut);
 end;//Result <> nil
end;

// start class TevExOperationDescriptor

(*procedure TevExOperationDescriptor.Assign(P: TPersistent);
  //override;
  {-}
begin
 inherited;
 if (P Is TevExOperationDescriptor) then begin
  Caption := TevExOperationDescriptor(P).Caption;
  Hint := TevExOperationDescriptor(P).Hint;
  AutoCheck := TevExOperationDescriptor(P).AutoCheck;
  GroupIndex := TevExOperationDescriptor(P).GroupIndex;
  ShortCut := TevExOperationDescriptor(P).ShortCut;
 end;//P Is TevExOperationDescriptor
end;*)

function TevExOperationDescriptor.pm_GetHint: String;
  {-}
begin
 if (Hint = '') then
  Result := Caption
 else
  Result := Hint;
end;

function TevExOperationDescriptor.pm_GetCaption: String;
  {-}
begin
 Result := Caption;
end;

function TevExOperationDescriptor.pm_GetAutoCheck: Bool;
  {-}
begin
 Result := AutoCheck;
end;

function TevExOperationDescriptor.pm_GetGroupIndex: Integer;
  {-}
begin
 Result := GroupIndex;
end;

function TevExOperationDescriptor.pm_GetShortCut: TShortCut;
  {-}
begin
 Result := ShortCut; 
end;
{$EndIf  evNeedDisp}

end.

