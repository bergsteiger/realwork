// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit mtmanager_int;

interface

uses
  osthread;

type
  TOperationKind = (odAccept, odReader, odWriter, odDeCode, odORB);
  //TOP_id_type = integer;
  TMTMesType = (mtTerminate, mtProcess);
  TWorkerThreadState = (wtsTransition, wtsIdle, wtsBusy, wtsStop);
  TORBMsgEvent = (omeKillConn, omeCloseConn);
  TConcurrencyModel = (cmThreadPool, cmThreadPerConnection, cmThreadPerRequest);

  IThreadPool = interface;
  IMsgChannel = interface;
  IMsgType = interface;
  IPassiveMsgQueue = interface;
  IOperationInfoNode = interface;
  IWorkerThread = interface;
  IOperation = interface;

  IMsgType = interface
  ['{2CF35D50-DFB6-4E5F-BAB7-55215DB44C23}']
    function get_type: TMTMesType;
    procedure set_type(msgType: TMTMesType);
    function data: pointer;
  end;

  IMsgChannel = interface
  ['{B769EDA6-0705-45B7-9A2F-6789E60D68C3}']
    procedure set_thread_pool(tp: IThreadPool);
    function get_thread_pool: IThreadPool; overload;
    function check_msg(var kt: IWorkerThread): boolean;
    function get_msg(idType: TOperationKind): IMsgType;
    procedure put_msg(nextOpId: TOperationKind; msg: IMsgType);
  end;

  IThreadPoolManager = interface(IMsgChannel)
  ['{926B8D66-0A44-438C-A877-447D259B5306}']
    function get_operation(opId: TOperationKind): IOperation;
    function get_idle_thread(const opId: TOperationKind): IWorkerThread;
    function get_thread_pool(const opId: TOperationKind): IThreadPool; overload;
    procedure shutdown();
  end;
  
  IThreadPool = interface(IMsgChannel)
  ['{EA157D4A-A634-4DA4-8075-6481738E0A47}']
    function remove_thread(kt: IWorkerThread): boolean;
    function get_idle_thread(): IWorkerThread;
    procedure mark_busy(wt: IWorkerThread);
    procedure mark_idle(wt: IWorkerThread);
    function get_operation(): IOperation;
    procedure set_operation(op: IOperation);
    procedure set_thread_pool_manager(tpm: IThreadPoolManager);
    procedure clear();
    function optype: integer;
  end;

  IPassiveMsgQueue = interface(IMsgChannel)
  ['{690A440B-901D-481D-BDCC-925C10FC9C02}']
    procedure set_worker_thread(kt: IWorkerThread);
  end;

  IDirectMsgConnector = interface(IMsgChannel)
  ['{3A7AD245-A110-4875-B8CB-ECE88EAFAE5F}']
    procedure set_operation(op: IOperation);
  end;

  IWorkerThread = interface(IORBThread)
  ['{34984C6C-B15A-4981-894A-F9D98EAD5A86}']
    function get_state: TWorkerThreadState;
    procedure set_state(const Value: TWorkerThreadState);
    //function get_no: integer;
    //procedure set_no(value: integer);
    procedure set_thread_pool(AThreadPool: IThreadPool);
    function get_thread_pool: IThreadPool;
    procedure register_operation(op: IOperation);
    procedure deregister_operation(op: IOperation);
    procedure post_state_change();
    procedure put_msg(msgType: IMsgType);
    procedure mark_idle();
    procedure mark_busy();
    procedure terminate(exitval: pointer);
    function start(arg: pointer = nil): TThreadErrorType;
  end;

  IOperation = interface(IMsgChannel)
  ['{3A757B50-63CF-4E48-836D-2C9023904D51}']
    function get_info(): IOperationInfoNode;
    procedure set_info(value: IOperationInfoNode);
    function get_thread(): IWorkerThread;
    procedure set_thread(value: IWorkerThread);
    procedure start();
    procedure init_shutdown();
    procedure finalize_shutdown();
    procedure send_msg(nextOpId: TOperationKind; msg: IMsgType);
    procedure process(msg: IMsgType);
    procedure run();
    function copy(): IOperation;
  end;

  IActiveOperation = interface(IOperation)
  ['{3153E4B1-BC30-4AC0-A1A2-EF57B45CABE2}']
    procedure register_input_mc(mc: IPassiveMsgQueue);
    function get_input_mc(): IPassiveMsgQueue;
  end;

  IPassiveOperation = interface(IOperation)
  ['{6E44B51F-EAAF-4BF3-B9D3-E1ADA62F7795}']
  end;

  IOperationInfoNode = interface
  ['{A10D5789-FADC-45EB-BC82-64FFD0C163FC}']
    function get_thread_pool(): IThreadPool;
    procedure set_thread_pool(tp: IThreadPool);
    function get_OP_id(): TOperationKind;
    procedure set_OP_id(id: TOperationKind);
    function get_nextOP(): IMsgChannel;
    procedure set_nextOP(nextOP: IMsgChannel);
  end;

implementation

end.
