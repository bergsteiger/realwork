(*
//
// module:  pkgtoolsmf.pas
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: pkgtoolsmf.pas,v 1.5 2000/01/06 14:39:12 migel Exp $
//
*)
unit    PKGToolsMF;


 {$I m0Define.inc}
 {$I m0DefOpt.inc}


 interface


 uses
        Windows,Messages,SysUtils,Consts,Classes{$IFDEF _m0USEFORMS1},Forms{$ENDIF},
        Dialogs,Controls,StdCtrls,ExtCtrls,ComCtrls,

        m0Const,m0AddTyp,m0DTFLib,m0MEMLib,
        mgConst,mgPrgMgr,mgBasStr,mgBasSor,mgBasObj,mgJouSrv,mgPKGSet;


 const
        CUnknownTime              = '??:??:??';
        CPercentFormat            = '%3d%%';

        CMainThreadID             = $4449544d; {"MTID"}

        CDataProgress             = WM_USER+1;
        COperProgress             = WM_USER+2;

        CThreadException          = WM_USER+3;
        CThreadBegin              = WM_USER+4;
        CThreadEnd                = WM_USER+5;


 type
        PProgressInfo             = ^TProgressInfo;
        TProgressInfo             = packed record

                                     RState: Byte;
                                     
                                     RPercent: Integer;
                                     RValue: Longint;
                                     RMessage: string;

                                    end;

        TMainForm                 = class(TForm)
         private


          FCAllocMemLabel:        string;
          FCNameLabel:            string;

          FPackageSet:            TmgBasePackageSet;

          FDataTime:              TDateTime;
          FOperTime:              TDateTime;
          FSummTime:              TDateTime;


                procedure         mm_DataProgress     (var   AMessage: TMessage
                                                      ); message CDataProgress;

                procedure         mm_OperProgress     (var   AMessage: TMessage
                                                      ); message COperProgress;


                procedure         mm_ThreadException  (var   AMessage: TMessage
                                                      ); message CThreadException;

                procedure         mm_ThreadBegin      (var   AMessage: TMessage
                                                      ); message CThreadBegin;

                procedure         mm_ThreadEnd        (var   AMessage: TMessage
                                                      ); message CThreadEnd;


                procedure         ChangePackageName   (const AName: string
                                                      );


         protected


         published


          FAllocMemLabel:         TLabel;
          FBottomPanel:           TPanel;
          FButtonPanel:           TPanel;
          FChangeButton:          TButton;
          FChangeDialog:          TOpenDialog;
          FClientPanel:           TPanel;
          FDataPanel:             TPanel;
          FDataPercentPanel:      TPanel;
          FDataProgressBar:       TProgressBar;
          FDataProgressPanel:     TPanel;
          FDataStatusPanel:       TPanel;
          FDataTimePanel:         TPanel;
          FDebugGroupBox:         TGroupBox;
          FExitButton:            TButton;
          FExportButton:          TButton;
          FInfoGroupBox:          TGroupBox;
          FNameLabel:             TLabel;
          FOperPanel:             TPanel;
          FOperPercentPanel:      TPanel;
          FOperProgressBar:       TProgressBar;
          FOperProgressPanel:     TPanel;
          FOperStatusPanel:       TPanel;
          FOperTimePanel:         TPanel;
          FOptionsRadioGroup:     TRadioGroup;
          FSummTimePanel:         TPanel;
          FTimer:                 TTimer;
          FUpdateButton:          TButton;


                procedure         FormCreate          (      ASender: TObject
                                                      );

                procedure         FormDestroy         (      ASender: TObject
                                                      );

                procedure         FormAutoStart       (      ASender: TObject;
                                                       var   ADone: Boolean
                                                      );


                procedure         TimerTimer          (      ASender: TObject
                                                      );


                procedure         ChangeButtonClick   (      ASender: TObject
                                                      );

                procedure         UpdateButtonClick   (      ASender: TObject
                                                      );

                procedure         ExportButtonClick   (      ASender: TObject
                                                      );

                procedure         ExitButtonClick     (      ASender: TObject
                                                      );


         end;


        TMainFormThread           = class(TThread)
         private


          FParentHandle:          THandle;

          FBuildAll:              LongBool;
          FPackageSet:            TmgBasePackageSet;

          FExportMode:            LongBool;
          FUpdateMode:            LongBool;

          
                procedure         DataProgress        (      AState: Byte;
                                                             APercent: Integer;
                                                             AValue: Longint;
                                                       const AMessage: string
                                                      );

                procedure         OperProgress        (      AState: Byte;
                                                             APercent: Integer;
                                                             AValue: Longint;
                                                       const AMessage: string
                                                      );


         protected


                procedure         Execute             (
                                                      ); override;


         public


                constructor       Create              (      AParentHandle: THandle;
                                                             APackageSet: TmgBasePackageSet;
                                                             ABuildAll: LongBool;
                                                             AExportMode: LongBool;
                                                             AUpdateMode: LongBool
                                                      );


         end;


 var
        MainForm:                 TMainForm;


 implementation {$R *.DFM}


 { -- TMainForm.private -- }

 procedure   TMainForm.mm_DataProgress(var   AMessage: TMessage
                                      );
 var
        LTime:                    TDateTime;
 begin

  with AMessage do
   begin

    if (WParam = CMainThreadID)
     then
      begin

       try

        with PProgressInfo(LParam)^ do
         begin

          case RState of

           CmgPrgMgrBeg: begin

                          FDataTime:=Now();

                          FDataStatusPanel.Caption:=RMessage;

                          FDataProgressBar.Position:=0;
                          FDataPercentPanel.Caption:=Format(CPercentFormat,[0]);

                          FDataTimePanel.Caption:=CUnknownTime;

                         end;

           CmgPrgMgrCur: begin

                          LTime:=Now()-FDataTime;
                          LTime:=((100*LTime)/RPercent)-LTime;

                          FDataTimePanel.Caption:=m0DTFTimeToStr(LTime);

                          FDataProgressBar.Position:=RPercent;
                          FDataPercentPanel.Caption:=Format(CPercentFormat,[RPercent]);

                         end;

           CmgPrgMgrEnd: begin

                          FDataTimePanel.Caption:='';

                          FDataProgressBar.Position:=0;
                          FDataStatusPanel.Caption:='';

                          FDataPercentPanel.Caption:='';

                         end;

          end;

         end;

        FDataPanel.Repaint();

       finally

        m0MEMFree(Pointer(LParam));

       end;

      end;

   end;

 end;

 procedure   TMainForm.mm_OperProgress(var   AMessage: TMessage
                                      );
 var
        LTime:                    TDateTime;
 begin

  with AMessage do
   begin

    if (WParam = CMainThreadID)
     then
      begin

       try

        with PProgressInfo(LParam)^ do
         begin

          case RState of

           CmgPrgMgrBeg: begin

                          FOperTime:=Now();

                          FOperStatusPanel.Caption:=RMessage;

                          FOperProgressBar.Position:=0;
                          FOperPercentPanel.Caption:=Format(CPercentFormat,[0]);

                          FOperTimePanel.Caption:=CUnknownTime;

                         end;

           CmgPrgMgrCur: begin

                          LTime:=Now()-FOperTime;
                          LTime:=((100*LTime)/RPercent)-LTime;

                          FOperTimePanel.Caption:=m0DTFTimeToStr(LTime);

                          FOperProgressBar.Position:=RPercent;
                          FOperPercentPanel.Caption:=Format(CPercentFormat,[RPercent]);

                         end;

           CmgPrgMgrEnd: begin

                          FOperTimePanel.Caption:='';

                          FOperProgressBar.Position:=0;
                          FOperStatusPanel.Caption:='';

                          FOperPercentPanel.Caption:='';

                         end;

          end;

         end;

        FOperPanel.Repaint();

       finally

        m0MEMFree(Pointer(LParam));

       end;

      end;

   end;

 end;

 procedure   TMainForm.mm_ThreadException(var   AMessage: TMessage
                                         );
 begin

  with AMessage do
   begin

    if (WParam = CMainThreadID)
     then
      begin

       raise Exception(LParam);

      end;

   end;

 end;

 procedure   TMainForm.mm_ThreadBegin(var   AMessage: TMessage
                                     );
 begin

  FSummTime:=Now();

  FChangeButton.Enabled:=False;
  FExitButton.Enabled:=False;
  FExportButton.Enabled:=False;
  FOptionsRadioGroup.Enabled:=False;
  FUpdateButton.Enabled:=False;

 end;

 procedure   TMainForm.mm_ThreadEnd(var   AMessage: TMessage
                                   );
 begin

  FUpdateButton.Enabled:=True;
  FOptionsRadioGroup.Enabled:=True;
  FExportButton.Enabled:=True;
  FExitButton.Enabled:=True;
  FChangeButton.Enabled:=True;

  FSummTimePanel.Caption:=m0DTFTimeToStr(Now()-FSummTime);

 end;

 procedure   TMainForm.ChangePackageName(const AName: string
                                        );
 begin

  with FPackageSet do
   begin

    Name:=AName;

    if (Name <> '')
     then
      begin

       FExportButton.Enabled:=True;
       FUpdateButton.Enabled:=True;

       FNameLabel.Caption:=FCNameLabel+FPackageSet.Name;

      end
     else
      begin

       FUpdateButton.Enabled:=False;
       FExportButton.Enabled:=False;

      end;

   end;

 end;


 { -- TMainForm.protected -- }


 { -- TMainForm.published -- }

 procedure   TMainForm.FormCreate(      ASender: TObject
                                 );
 begin

  Caption:=Application.Title;

  FCAllocMemLabel:=FAllocMemLabel.Caption;
  FCNameLabel:=FNameLabel.Caption;

  FPackageSet:=TmgBasePackageSet.Create();

  TimerTimer(Self);

  Application.OnIdle:=FormAutoStart;

 end;

 procedure   TMainForm.FormDestroy(      ASender: TObject
                                  );
 begin

  FPackageSet.Free();

 end;

 procedure   TMainForm.FormAutoStart(      ASender: TObject;
                                     var   ADone: Boolean
                                    );
 begin

  Application.OnIdle:=nil;

  if (ParamCount() > 0)
   then
    begin

     ChangePackageName(ParamStr(1));
     UpdateButtonClick(Self);

    end;

 end;

 procedure   TMainForm.TimerTimer(      ASender: TObject
                                 );
 begin

  FAllocMemLabel.Caption:=FCAllocMemLabel+IntToHex(m0MEMLocalSize,8);

  if not(FExitButton.Enabled)
   then
    begin

     FSummTimePanel.Caption:=m0DTFTimeToStr(Now()-FSummTime);

    end;

 end;

 procedure   TMainForm.ChangeButtonClick(      ASender: TObject
                                        );
 begin

  with FChangeDialog do
   begin

    if Execute()
     then
      begin

       ChangePackageName(FileName);

      end;

   end;

 end;

 procedure   TMainForm.UpdateButtonClick(      ASender: TObject
                                        );
 begin

  TMainFormThread.Create(Handle,FPackageSet,(FOptionsRadioGroup.ItemIndex = 1),False,True);

 end;

 procedure TMainForm.ExportButtonClick(      ASender: TObject);
 begin

  TMainFormThread.Create(Handle,FPackageSet,(FOptionsRadioGroup.ItemIndex = 1),True,False);

 end;

 procedure   TMainForm.ExitButtonClick(      ASender: TObject
                                      );
 begin

  Close();

 end;


 { -- TMainFormThread.private -- }

 procedure   TMainFormThread.DataProgress(      AState: Byte;
                                                APercent: Integer;
                                                AValue: Longint;
                                          const AMessage: string
                                         );
 var
        LProgressInfo:            PProgressInfo;
 begin

  m0MEMAlloc(Pointer(LProgressInfo),SizeOf(LProgressInfo^),#000);

  with LProgressInfo^ do
   begin

    RState:=AState;
    
    RPercent:=APercent;
    RValue:=AValue;
    RMessage:=AMessage;

   end;

  PostMessage(FParentHandle,CDataProgress,CMainThreadID,Longint(LProgressInfo));

 end;

 procedure   TMainFormThread.OperProgress(      AState: Byte;
                                                APercent: Integer;
                                                AValue: Longint;
                                          const AMessage: string
                                         );
 var
        LProgressInfo:            PProgressInfo;
 begin

  m0MEMAlloc(Pointer(LProgressInfo),SizeOf(LProgressInfo^),#000);

  with LProgressInfo^ do
   begin

    RState:=AState;
    
    RPercent:=APercent;
    RValue:=AValue;
    RMessage:=AMessage;

   end;

  PostMessage(FParentHandle,COperProgress,CMainThreadID,Longint(LProgressInfo));

 end;


 { -- TMainFormThread.protected -- }

 procedure   TMainFormThread.Execute(
                                    );
 type
        PRaiseFrame               = ^TRaiseFrame;
        TRaiseFrame               = record
                                     NextRaise: PRaiseFrame;
                                     ExceptAddr: Pointer;
                                     ExceptObject: TObject;
                                     ExceptionRecord: PExceptionRecord;
                                    end;
 var
        LExceptObject:            TObject;
 begin

  SendMessage(FParentHandle,CThreadBegin,0,0);
   try

    try

     with FPackageSet do
      begin

       CopyProc:=OperProgress;
       DataProc:=DataProgress;
       IndxProc:=OperProgress;
       ListProc:=OperProgress;

       if FExportMode
        then
         begin

          ExportDictionary();

         end;

       if FUpdateMode
        then
         begin

          UpdateExchange(CmgJouSrvAdmLock,FBuildAll);

         end;

      end;

    except

     if (RaiseList <> nil)
      then
       begin

        LExceptObject:=PRaiseFrame(RaiseList)^.ExceptObject;
        PRaiseFrame(RaiseList)^.ExceptObject:=nil;

        PostMessage(FParentHandle,CThreadException,CMainThreadID,Longint(LExceptObject));

       end;

    end;

   finally

    SendMessage(FParentHandle,CThreadEnd,0,0);

   end;

 end;


 { -- TMainFormThread.public -- }

 constructor TMainFormThread.Create(      AParentHandle: THandle;
                                          APackageSet: TmgBasePackageSet;
                                          ABuildAll: LongBool;
                                          AExportMode: LongBool;
                                          AUpdateMode: LongBool
                                   );
 begin

  inherited Create(True);

  FParentHandle:=AParentHandle;

  FBuildAll:=ABuildAll;
  FPackageSet:=APackageSet;

  FExportMode:=AExportMode;
  FUpdateMode:=AUpdateMode;

  FreeOnTerminate:=True;
  Resume();

 end;


end.

