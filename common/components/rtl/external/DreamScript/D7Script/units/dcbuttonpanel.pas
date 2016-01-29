{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcButtonPanel;

interface
{$I dc.inc}
Uses Messages, Windows, Classes, Consts, Controls, ExtCtrls, Forms, StdCtrls, SysUtils;

Type
  TButtonType=(btOk,btCancel,btYes,btNo,btAbort,btRetry,btIgnore,btAll,btClose,btHelp);
  TButtonTypes=Set Of TButtonType;

  TButtonAlign=(baBegin,baMiddle,baEnd);
  TButtons=Array[TButtonType] Of TButton;

  TDCButtonPanel=Class(TPanel)
  Private
    FButtonAlign:TButtonAlign;
    FButtons:TButtons;
    FButtonSpace:Integer;
    FButtonTypes:TButtonTypes;
    FPrevAlign:TAlign;
    Function GetListOfButtons:TList;
    Function IsVerticalAlign:Boolean;
    Procedure SetButtonAlign(Value:TButtonAlign);
    Procedure SetButtonSpace(Value:Integer);
    Procedure SetButtonTypes(Value:TButtonTypes);
    Function UniqueName(Const BaseName:String):String;
  Protected
    Procedure AlignControls(AControl:TControl;Var Rect:TRect);override;
    Procedure CreateParams(var Params: TCreateParams);override;
    Procedure Notification(Component:TComponent;Operation:TOperation);override;
    Procedure WMEraseBkgnd(Var Message:TMessage);message WM_ERASEBKGND;
  Public
    Constructor Create(AOwner:TComponent);override;
    Destructor Destroy;override;
  Published
    Property ButtonAlign:TButtonAlign read FButtonAlign write SetButtonAlign;
    Property ButtonSpace:Integer read FButtonSpace write SetButtonSpace;
    Property ButtonTypes:TButtonTypes read FButtonTypes write SetButtonTypes stored False;
  End;

Type
  TDCPanelButton=Class(TButton)
  Private
    FButtonType:TButtonType;
    Procedure ReadData(Reader:TReader);
    Procedure WriteData(Writer:TWriter);
  Protected
    Procedure DefineProperties(Filer:TFiler);override;
    Procedure SetParent(AParent:TWinControl);override;
  Public
    Property ButtonType:TButtonType read FButtonType write FButtonType;  
  End;

implementation

Const
  ButtonResults:Array[TButtonType] Of TModalResult=(mrOk,mrCancel,mrYes,mrNo,mrAbort,mrRetry,
                 mrIgnore,mrAll,mrOk,mrNone);
Const
  ButtonNames:Array[TButtonType] Of String=('Ok','Cancel','Yes','No','Abort','Retry',
                 'Ignore','All','Close','Help');
Const
  ButtonNamePrefix='btn';
  ButtonNamePostfix='';

Var
  ButtonCaptions:Array[TButtonType] Of String;

Procedure TDCPanelButton.DefineProperties(Filer:TFiler);
Begin
  Inherited;
  Filer.DefineProperty('ButtonType',ReadData,WriteData,True);
End;

{---------------------------------------------------------}

Procedure TDCPanelButton.ReadData(Reader:TReader);
Var
  Panel:TDCButtonPanel;
Begin
  FButtonType:=TButtonType(Byte(Reader.ReadInteger));
  If Parent Is TDCButtonPanel Then
  Begin
    Panel:=TDCButtonPanel(Parent);
    Panel.FButtons[ButtonType]:=Self;
    Include(Panel.FButtonTypes,ButtonType);
  End;
End;

{---------------------------------------------------------}

Procedure TDCPanelButton.SetParent(AParent:TWinControl);
Begin
  Inherited;
End;

{---------------------------------------------------------}

Procedure TDCPanelButton.WriteData(Writer:TWriter);
Begin
  Writer.WriteInteger(Integer(FButtonType));
End;

{---------------------------------------------------------}
{---------------------------------------------------------}
{---------------------------------------------------------}

Constructor TDCButtonPanel.Create(AOwner:TComponent);
Begin
  Inherited;
  ControlStyle:=ControlStyle-[csSetCaption];
  Caption:='';
  FButtonSpace:=10;
  FButtonAlign:=baEnd;
End;

{---------------------------------------------------------}

Destructor TDCButtonPanel.Destroy;
Var
  I:TButtonType;
Begin
  For I:=Low(TButtonType) To High(TButtonType) Do
    If I In FButtonTypes Then
      FButtons[I].Free;
  Inherited;
End;

{---------------------------------------------------------}

Procedure TDCButtonPanel.AlignControls(AControl:TControl;Var Rect:TRect);
Var
  Buttons:TList;
  ControlLen:Integer;
  AButtonSpace:Integer;
  Pos:Integer;
  Function GetTotalSpace:Integer;
  Var
    I:Integer;
  Begin
    Result:=ControlLen;
    For I:=0 To Buttons.Count-1 Do
      With TControl(Buttons[I]) Do
        If Visible Then
          If IsVerticalAlign Then
            Dec(Result,Height)
          Else
            Dec(Result,Width);
  End;

  Function GetVisibleCount:Integer;
  Var
    I:Integer;
    Res:Integer;
  Begin
    Res:=0;
    For I:=0 To Buttons.Count-1 Do
      If TControl(Buttons[I]).Visible Then
        Inc(Res);
    Result:=Res;
  End;

  Procedure AlignButtons;
  Var
    I:Integer;
  Begin
    For I:=0 To Buttons.Count-1 Do
      If IsVerticalAlign Then
        With TControl(Buttons[I]) Do
        Begin
          Top:=Pos;
          Left:=(Self.ClientWidth-Width) Div 2;
          If Visible Then
            Inc(Pos,AButtonSpace+Height);
        End
      Else
        With TControl(Buttons[I]) Do
        Begin
          Left:=Pos;
          Top:=(Self.ClientHeight-Height) Div 2;
          If Visible Then
            Inc(Pos,AButtonSpace+Width);
        End;
  End;
Var
  VisibleCount:Integer;  
Begin
  Inherited;
  Try
    If (FPrevAlign<>alNone) And (Align=alNone)Then
      Exit;
    Buttons:=GetListOfButtons;
    VisibleCount:=GetVisibleCount;
    Try
      If VisibleCount=0 Then
        Exit;
      If IsVerticalAlign Then
        ControlLen:=ClientHeight
      Else
        ControlLen:=ClientWidth;
      Case FButtonAlign Of
        baBegin:
          Begin
            AButtonSpace:=FButtonSpace;
            Pos:=AButtonSpace;
          End;
        baMiddle:
          Begin
            AButtonSpace:=GetTotalSpace Div (VisibleCount+1);
            Pos:=AButtonSpace;
          End;
        baEnd:
          Begin
            AButtonSpace:=FButtonSpace;
            Pos:=GetTotalSpace-VisibleCount*AButtonSpace;
          End;
      End;
     AlignButtons;
    Finally
      Buttons.Free;
    End;
  Finally
    FPrevAlign:=Align;
  End;
End;

{---------------------------------------------------------}

Procedure TDCButtonPanel.CreateParams(var Params: TCreateParams);
Begin
  Inherited CreateParams(Params);
  With Params do
    WindowClass.Style:=WindowClass.Style And Not (CS_HREDRAW Or CS_VREDRAW);
End;

{---------------------------------------------------------}

Function TDCButtonPanel.GetListOfButtons:TList;
  Procedure InsertControlInList(Control:TControl;List:TList;IsVertical:Boolean);
  Var
    I:Integer;
  Begin
    For I:=0 To List.Count-1 Do
       If IsVertical Then
       Begin
         If (Control.Top<TControl(List[I]).Top) {And (FButtonAlign<>baEnd)) Or
            ((Control.Top>=TControl(List[I]).Top) And (FButtonAlign=baEnd))} Then
         Begin;
           List.Insert(I,Control);
           Exit;
         End
       End
       Else
         If (Control.Left<TControl(List[I]).Left) {And (FButtonAlign<>baEnd)) Or
            (Control.Left>=TControl(List[I]).Left) And (FButtonAlign=baEnd)} Then
         Begin;
           List.Insert(I,Control);
           Exit;
         End;
    List.Insert(List.Count,Control);
  End;
Var
  I:Integer;
  Control:TControl;
Begin
  Result:=TList.Create;
  For I:=0 To ControlCount-1 Do
  Begin
    Control:=Controls[I];
    If (Control Is TButton) And (Control.Align=alNone) Then
    Begin
      InsertControlInList(Control,Result,IsVerticalAlign);
    End;
  End;
End;

{---------------------------------------------------------}

Function TDCButtonPanel.IsVerticalAlign:Boolean;
Begin
  Result:=Align In [alLeft,alRight];
End;

{---------------------------------------------------------}

Procedure TDCButtonPanel.Notification(Component:TComponent;Operation:TOperation);
Var
  I:TButtonType;
Begin
  Inherited;
  If Operation=opRemove Then
  Begin
    For I:=Low(TButtonType) To High(TButtonType) Do
      If FButtons[I]=Component Then
      Begin
        FButtons[I]:=Nil;
        FButtonTypes:=FButtonTypes-[I];
      End
  End;    
End;

{---------------------------------------------------------}

Procedure TDCButtonPanel.SetButtonAlign(Value:TButtonAlign);
Begin
  If FButtonAlign=Value Then
    Exit;
  FButtonAlign:=Value;
  ReAlign;
End;

{---------------------------------------------------------}

Procedure TDCButtonPanel.SetButtonSpace(Value:Integer);
Begin
  If FButtonSpace=Value Then
    Exit;
  FButtonSpace:=Value;
  Realign;
End;

{---------------------------------------------------------}

Procedure TDCButtonPanel.SetButtonTypes(Value:TButtonTypes);
  Procedure DeleteButtons;
  Var
    ButtonType:TButtonType;
  Begin
    For ButtonType:=Low(TButtonType) To High(TButtonType) Do
      If  (ButtonType In FButtonTypes) And Not (ButtonType In Value) Then
      Begin
        FButtons[ButtonType].Free;
        FButtons[ButtonType]:=Nil;
      End;
  End;
  Procedure CreateButtons;
  Var
    ButtonType:TButtonType;
    Button:TDCPanelButton;
    Procedure PosButton(Button:TDCPanelButton);
    Var
      I:TButtonType;
      MaxPos:Integer;
      APos:Integer;
    Begin
      MaxPos:=MaxInt;
      For I:=Low(ButtonType) To High(TButtonType) Do
        If (I In FButtonTypes) And (I<>Button.ButtonType) Then
        Begin
          If IsVerticalAlign Then
            APos:=FButtons[I].Top+1
          Else
            APos:=FButtons[I].Left+1;
          If APos>MaxPos Then
            MaxPos:=APos;
        End;
      If IsVerticalAlign Then
        Button.Top:=MaxPos
      Else
        Button.Left:=MaxPos
    End;
  Var
    CancelButton:TButton;
    DefaultButton:TButton;
  Begin
    If csLoading In ComponentState Then
      Exit;
    CancelButton:=Nil;
    DefaultButton:=Nil;
    For ButtonType:=Low(TButtonType) To High(TButtonType) Do
      If  Not (ButtonType In FButtonTypes) And (ButtonType In Value) Then
      Begin
        Button:=TDCPanelButton.Create(Owner);
        FButtons[ButtonType]:=Button;
        Button.ButtonType:=ButtonType;
        Button.Name:=UniqueName(ButtonNamePrefix+ButtonNames[ButtonType]+ButtonNamePostfix);

        Button.Caption:=ButtonCaptions[ButtonType];
        Button.ModalResult:=ButtonResults[ButtonType];
        If (ButtonType=btOk) And (DefaultButton<>Nil) Then
          DefaultButton:=Button;
        If (ButtonType=btCancel) And (CancelButton<>Nil) Then
          CancelButton:=Button;
        If (ButtonType=btClose) And (DefaultButton<>Nil) Then
          DefaultButton:=Button;
        If IsVerticalAlign Then
          Button.Top:=High(SmallInt)
        Else
          Button.Left:=High(SmallInt);
        PosButton(Button);
        Button.Parent:=Self;
      End;
    If CancelButton<>Nil Then
      CancelButton.Cancel:=True;
    If DefaultButton<>Nil Then
      DefaultButton.Default:=True;
  End;
Begin
  If FButtonTypes=Value Then
    Exit;
  DeleteButtons;
  CreateButtons;
  FButtonTypes:=Value;
  ReAlign;
End;

{---------------------------------------------------------}

Function TDCButtonPanel.UniqueName(Const BaseName:String):String;
Var
  I:Integer;
Begin
  I:=1;
  Result:=BaseName;
  Repeat
    If Owner.FindComponent(Result)=Nil Then
      Exit;
    Result:=BaseName+IntToStr(I);
  Until False;
End;

{---------------------------------------------------------}

Procedure TDCButtonPanel.WMEraseBkgnd(Var Message:TMessage);
Begin
End;

Initialization
  ButtonCaptions[btOk] := {$IFNDEF D3}LoadStr({$ENDIF}SOkButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btCancel] := {$IFNDEF D3}LoadStr({$ENDIF}SCancelButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btYes] := {$IFNDEF D3}LoadStr({$ENDIF}SYesButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btNo] := {$IFNDEF D3}LoadStr({$ENDIF}SNoButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btAbort] := {$IFNDEF D3}LoadStr({$ENDIF}SAbortButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btRetry] := {$IFNDEF D3}LoadStr({$ENDIF}SRetryButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btIgnore] := {$IFNDEF D3}LoadStr({$ENDIF}SIgnoreButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btAll] := {$IFNDEF D3}LoadStr({$ENDIF}SAllButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btClose] := {$IFNDEF D3}LoadStr({$ENDIF}SCloseButton{$IFNDEF D3}){$ENDIF};
  ButtonCaptions[btHelp] := {$IFNDEF D3}LoadStr({$ENDIF}SHelpButton{$IFNDEF D3}){$ENDIF};
  If GetClass(TDCPanelButton.ClassName)=Nil Then
    RegisterClass(TDCPanelButton);
end.
