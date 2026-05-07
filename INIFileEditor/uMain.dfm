object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 
    'Indstillinger til windows serviceprogram (EasyPOS to Business Ce' +
    'ntral)'
  ClientHeight = 715
  ClientWidth = 1371
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 728
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1371
    Height = 715
    ActivePage = tsProgram
    Align = alClient
    TabOrder = 0
    object tsProgram: TTabSheet
      Caption = 'Program'
      object Label1: TLabel
        Left = 16
        Top = 28
        Width = 751
        Height = 15
        Caption = 
          'At which hour should the routine run (can be an hour like 22, or' +
          ' between 2 hours (both included like 2204) or how many minutes b' +
          'etween runs'
      end
      object Label2: TLabel
        Left = 16
        Top = 105
        Width = 135
        Height = 15
        Caption = 'Select folder to place logs'
      end
      object lblDatabase: TLabel
        Left = 16
        Top = 183
        Width = 96
        Height = 15
        Caption = 'EasyPOS Database'
      end
      object lblUser: TLabel
        Left = 16
        Top = 260
        Width = 65
        Height = 15
        Caption = 'Firebird user'
      end
      object lblPassword: TLabel
        Left = 16
        Top = 338
        Width = 93
        Height = 15
        Caption = 'Firebird password'
      end
      object lblDepartment: TLabel
        Left = 16
        Top = 415
        Width = 110
        Height = 15
        Caption = 'EasyPOS department'
      end
      object lblMachine: TLabel
        Left = 16
        Top = 493
        Width = 94
        Height = 15
        Caption = 'EasyPOS Machine'
      end
      object lblLastruntime: TLabel
        Left = 87
        Top = 50
        Width = 76
        Height = 15
        Caption = 'lblLastruntime'
      end
      object edPassword: TEdit
        Left = 16
        Top = 355
        Width = 200
        Height = 23
        PasswordChar = '*'
        TabOrder = 5
        Text = 'Set Firebird password'
      end
      object edDepartment: TEdit
        Left = 16
        Top = 432
        Width = 200
        Height = 23
        TabOrder = 6
        Text = 'Set EasyPOS Department '
      end
      object edMachine: TEdit
        Left = 16
        Top = 509
        Width = 200
        Height = 23
        TabOrder = 7
        Text = 'Set EasyPOS Machine'
      end
      object edTimer: TEdit
        Left = 16
        Top = 47
        Width = 65
        Height = 23
        Hint = 'Enter minutes between service will check and do export'
        TabOrder = 0
      end
      object edLogFolder: TEdit
        Left = 16
        Top = 124
        Width = 665
        Height = 23
        TabOrder = 2
        TextHint = 'Select folder where logs are stored'
      end
      object edDatabase: TEdit
        Left = 16
        Top = 201
        Width = 665
        Height = 23
        TabOrder = 3
        TextHint = 'Set EasyPOS Connection string'
      end
      object edUser: TEdit
        Left = 16
        Top = 278
        Width = 200
        Height = 23
        TabOrder = 4
        TextHint = 'Set Firebird user'
      end
      object cbOnlyTest: TCheckBox
        Left = 16
        Top = 568
        Width = 357
        Height = 19
        Caption = 
          'Only run as test (noting will be syncronized to Business Central' +
          ')'
        TabOrder = 8
      end
      object btnSelectFolder: TBitBtn
        Left = 696
        Top = 122
        Width = 25
        Height = 25
        Caption = '*'
        TabOrder = 9
        TabStop = False
        OnClick = btnSelectFolderClick
      end
      object cbHvertMinut: TCheckBox
        Left = 16
        Top = 73
        Width = 230
        Height = 17
        Caption = 'K'#248'r i stedet hvert angivet minut'
        TabOrder = 1
      end
      object btnTestDB: TButton
        Left = 16
        Top = 620
        Width = 170
        Height = 30
        Caption = 'Test DB Connection'
        TabOrder = 10
        OnClick = btnTestDBClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Business Central'
      object lblBaseURL: TLabel
        Left = 24
        Top = 15
        Width = 48
        Height = 15
        Caption = 'Base URL'
      end
      object lblPort: TLabel
        Left = 24
        Top = 84
        Width = 97
        Height = 15
        Caption = 'Port (0 is disabled)'
      end
      object lblTenant: TLabel
        Left = 24
        Top = 153
        Width = 36
        Height = 15
        Caption = 'Tenant'
      end
      object lblClientID: TLabel
        Left = 24
        Top = 292
        Width = 45
        Height = 15
        Caption = 'Client ID'
      end
      object lblClientPassword: TLabel
        Left = 24
        Top = 361
        Width = 84
        Height = 15
        Caption = 'Client Password'
      end
      object lblActiveCompany: TLabel
        Left = 24
        Top = 430
        Width = 88
        Height = 15
        Caption = 'Active Company'
      end
      object lblEnvironment: TLabel
        Left = 24
        Top = 222
        Width = 68
        Height = 15
        Caption = 'Environment'
      end
      object lblCustomer: TLabel
        Left = 24
        Top = 499
        Width = 52
        Height = 15
        Caption = 'Customer'
      end
      object edBCBaseURL: TEdit
        Left = 24
        Top = 40
        Width = 665
        Height = 23
        TabOrder = 0
        Text = 'Set Business Central baseURL'
      end
      object edBCPOrt: TEdit
        Left = 24
        Top = 107
        Width = 65
        Height = 23
        TabOrder = 1
      end
      object edBCCompanyURL: TEdit
        Left = 24
        Top = 175
        Width = 665
        Height = 23
        TabOrder = 2
        TextHint = 'Set Business Central tenant'
      end
      object edBCUser: TEdit
        Left = 24
        Top = 314
        Width = 665
        Height = 23
        TabOrder = 4
        TextHint = 'Set client ID'
      end
      object edBCPassword: TEdit
        Left = 24
        Top = 382
        Width = 665
        Height = 23
        TabOrder = 5
        Text = 'Set client password'
      end
      object edBCActiveCompany: TEdit
        Left = 24
        Top = 450
        Width = 665
        Height = 23
        TabOrder = 6
        Text = 'Set active company in Business Central'
      end
      object edEnvironment: TEdit
        Left = 24
        Top = 243
        Width = 665
        Height = 23
        TabOrder = 3
        TextHint = 'Set Business Central Environment'
      end
      object edBusinessCentralKunde: TEdit
        Left = 24
        Top = 518
        Width = 665
        Height = 23
        TabOrder = 7
        TextHint = 'Set the name of the customer'
      end
      object btnTestBC: TButton
        Left = 24
        Top = 570
        Width = 200
        Height = 30
        Caption = 'Test BC Connection'
        TabOrder = 8
        OnClick = btnTestBCClick
      end
      object lblBCFullURL: TLabel
        Left = 24
        Top = 620
        Width = 330
        Height = 15
        Caption = 'Paste a full Business Central URL here to auto-fill fields above:'
      end
      object edBCFullURL: TEdit
        Left = 24
        Top = 639
        Width = 565
        Height = 23
        TabOrder = 9
        TextHint = 'https://api.businesscentral.dynamics.com/v2.0/{tenant}/{env}/ODataV4/...'
      end
      object btnParseURL: TButton
        Left = 600
        Top = 637
        Width = 89
        Height = 27
        Caption = 'Parse URL'
        TabOrder = 10
        OnClick = btnParseURLClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Mail'
      object lblFromName: TLabel
        Left = 32
        Top = 23
        Width = 61
        Height = 15
        Caption = 'From name'
      end
      object lblRecipientMail: TLabel
        Left = 32
        Top = 268
        Width = 75
        Height = 15
        Caption = 'Recipient mail'
      end
      object lblSubject: TLabel
        Left = 32
        Top = 329
        Width = 39
        Height = 15
        Caption = 'Subject'
      end
      object lblHost: TLabel
        Left = 32
        Top = 391
        Width = 25
        Height = 15
        Caption = 'Host'
      end
      object lblPort2: TLabel
        Left = 32
        Top = 452
        Width = 22
        Height = 15
        Caption = 'Port'
      end
      object lblUsername: TLabel
        Left = 32
        Top = 513
        Width = 53
        Height = 15
        Caption = 'Username'
      end
      object lblFromMail: TLabel
        Left = 32
        Top = 84
        Width = 54
        Height = 15
        Caption = 'From mail'
      end
      object lblReplyToName: TLabel
        Left = 32
        Top = 145
        Width = 76
        Height = 15
        Caption = 'Reply to name'
      end
      object lblReplyToMail: TLabel
        Left = 32
        Top = 207
        Width = 69
        Height = 15
        Caption = 'Reply to mail'
      end
      object lblMailPassword: TLabel
        Left = 32
        Top = 575
        Width = 50
        Height = 15
        Caption = 'Password'
      end
      object edMailSenderName: TEdit
        Left = 32
        Top = 44
        Width = 665
        Height = 23
        TabOrder = 0
        TextHint = 'Set the name of the sender when an errormessage is send'
      end
      object edMailSenderMail: TEdit
        Left = 32
        Top = 105
        Width = 665
        Height = 23
        TabOrder = 1
        TextHint = 'Set the mail from which an errormessage is send'
      end
      object edMailReplyToName: TEdit
        Left = 32
        Top = 166
        Width = 665
        Height = 23
        TabOrder = 2
        TextHint = 'Set the reply to name when an errormessage is send'
      end
      object edMailReplyToMail: TEdit
        Left = 32
        Top = 228
        Width = 665
        Height = 23
        TabOrder = 3
        TextHint = 'Set the reply to email when an errormessage is send'
      end
      object edMailReciever: TEdit
        Left = 32
        Top = 289
        Width = 665
        Height = 23
        TabOrder = 4
        TextHint = 'Set recipients mail (divided by ; if more than one)'
      end
      object edMailSubject: TEdit
        Left = 32
        Top = 350
        Width = 665
        Height = 23
        TabOrder = 5
        TextHint = 'Set the subject of the mail'
      end
      object edMailSMTPHost: TEdit
        Left = 32
        Top = 412
        Width = 665
        Height = 23
        TabOrder = 6
        TextHint = 'Set the SMTP host'
      end
      object edMailSMTPPort: TEdit
        Left = 32
        Top = 473
        Width = 65
        Height = 23
        TabOrder = 7
      end
      object edMailSMTPUSername: TEdit
        Left = 32
        Top = 534
        Width = 665
        Height = 23
        TabOrder = 8
        TextHint = 'Set the SMTP Username'
      end
      object edMailSMTPPassword: TEdit
        Left = 32
        Top = 596
        Width = 665
        Height = 23
        TabOrder = 9
        TextHint = 'Set the SMTP password'
      end
      object cbUseTLS: TCheckBox
        Left = 120
        Top = 475
        Width = 60
        Height = 17
        Caption = 'Use TLS'
        TabOrder = 10
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Syncronize'
      object cbSyncItems: TCheckBox
        Left = 16
        Top = 32
        Width = 200
        Height = 17
        Caption = 'Syncronize items'
        TabOrder = 0
      end
      object cbSyncFinancialRecords: TCheckBox
        Left = 16
        Top = 75
        Width = 200
        Height = 17
        Caption = 'Syncronize financial records'
        TabOrder = 1
      end
      object cbSyncSalesTrans: TCheckBox
        Left = 16
        Top = 119
        Width = 200
        Height = 17
        Caption = 'Syncronize sales transactions'
        TabOrder = 2
      end
      object cbSyncMovements: TCheckBox
        Left = 16
        Top = 162
        Width = 250
        Height = 17
        Caption = 'Syncronize movement transactions'
        TabOrder = 3
      end
      object cbSyncStockRegulations: TCheckBox
        Left = 16
        Top = 206
        Width = 280
        Height = 17
        Caption = 'Syncronize stock regulation transactions'
        TabOrder = 4
      end
      object cbSyncCostpriceToEasyPOS: TCheckBox
        Left = 16
        Top = 250
        Width = 350
        Height = 17
        Caption = 'Syncronize costprices from Business Central to EasyPOS'
        TabOrder = 5
      end
    end
    object tsItems: TTabSheet
      Caption = 'Items'
      object lblItemsDays: TLabel
        Left = 24
        Top = 34
        Width = 335
        Height = 15
        Caption = 
          'Days to look back if routine has never run (no value in Last Run' +
          ')'
      end
      object lblItemsLastRun: TLabel
        Left = 24
        Top = 160
        Width = 42
        Height = 15
        Caption = 'Last run'
      end
      object lblItemsDepartment: TLabel
        Left = 24
        Top = 97
        Width = 131
        Height = 15
        Caption = 'Department to limit SQL '
      end
      object lblItemsLastTry: TLabel
        Left = 24
        Top = 223
        Width = 73
        Height = 15
        Caption = 'Last try to run'
      end
      object edItemsDAys: TEdit
        Left = 24
        Top = 55
        Width = 65
        Height = 23
        Hint = 'Enter minutes between service will check and do export'
        TabOrder = 0
      end
      object edItemsLastRun: TEdit
        Left = 24
        Top = 179
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object edItemsDeparetment: TEdit
        Left = 24
        Top = 117
        Width = 65
        Height = 23
        TabOrder = 2
      end
      object edItemsLastTry: TEdit
        Left = 24
        Top = 242
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Financial records'
      object lblFinDays: TLabel
        Left = 32
        Top = 42
        Width = 335
        Height = 15
        Caption = 
          'Days to look back if routine has never run (no value in Last Run' +
          ')'
      end
      object lblFinLastRun: TLabel
        Left = 32
        Top = 168
        Width = 42
        Height = 15
        Caption = 'Last run'
      end
      object lblFinLastTry: TLabel
        Left = 32
        Top = 231
        Width = 73
        Height = 15
        Caption = 'Last try to run'
      end
      object edFinancialRecordsDAys: TEdit
        Left = 32
        Top = 63
        Width = 65
        Height = 23
        TabOrder = 0
      end
      object edFinancialRecordsLastRun: TEdit
        Left = 32
        Top = 187
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object edFinancialRecordsLastTry: TEdit
        Left = 32
        Top = 250
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Sales transaction'
      object lblSalesDays: TLabel
        Left = 32
        Top = 42
        Width = 335
        Height = 15
        Caption = 
          'Days to look back if routine has never run (no value in Last Run' +
          ')'
      end
      object lblSalesLastTry: TLabel
        Left = 32
        Top = 231
        Width = 73
        Height = 15
        Caption = 'Last try to run'
      end
      object lblSalesLastRun: TLabel
        Left = 32
        Top = 168
        Width = 42
        Height = 15
        Caption = 'Last run'
      end
      object edSalesTransactionsDays: TEdit
        Left = 32
        Top = 63
        Width = 65
        Height = 23
        TabOrder = 0
      end
      object edSalesTransactionsLastRun: TEdit
        Left = 32
        Top = 187
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object edSalesTransactionsLastTry: TEdit
        Left = 32
        Top = 255
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Movements transactions'
      object lblMovDays: TLabel
        Left = 32
        Top = 42
        Width = 335
        Height = 15
        Caption = 
          'Days to look back if routine has never run (no value in Last Run' +
          ')'
      end
      object lblMovLastTry: TLabel
        Left = 32
        Top = 231
        Width = 73
        Height = 15
        Caption = 'Last try to run'
      end
      object lblMovLastRun: TLabel
        Left = 32
        Top = 168
        Width = 42
        Height = 15
        Caption = 'Last run'
      end
      object edMovementsTransactionsDays: TEdit
        Left = 32
        Top = 63
        Width = 65
        Height = 23
        TabOrder = 0
      end
      object edMovementTransactionsLastRun: TEdit
        Left = 32
        Top = 187
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object edMovementTransactionsLastTry: TEdit
        Left = 32
        Top = 250
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Stock regulation transations'
      object lblStockDays: TLabel
        Left = 32
        Top = 42
        Width = 335
        Height = 15
        Caption = 
          'Days to look back if routine has never run (no value in Last Run' +
          ')'
      end
      object lblStockLastTry: TLabel
        Left = 32
        Top = 231
        Width = 73
        Height = 15
        Caption = 'Last try to run'
      end
      object lblStockLastRun: TLabel
        Left = 32
        Top = 168
        Width = 42
        Height = 15
        Caption = 'Last run'
      end
      object edStockRegulationTransactionsDays: TEdit
        Left = 32
        Top = 63
        Width = 65
        Height = 23
        TabOrder = 0
      end
      object edStockRegulationTransactionsLastRun: TEdit
        Left = 32
        Top = 187
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object edStockRegulationTransactionsLastTry: TEdit
        Left = 32
        Top = 250
        Width = 665
        Height = 23
        Enabled = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Costprice from Business Central'
      object lblCostpriceItems: TLabel
        Left = 40
        Top = 50
        Width = 257
        Height = 15
        Caption = 'How many items should be handled in one cycle'
      end
      object edNumberofUtemsToUpdateCostprice: TEdit
        Left = 40
        Top = 71
        Width = 65
        Height = 23
        Hint = 'Enter how many items should be handled in a cycle. '
        TabOrder = 0
      end
    end
    object tsGeneralLog: TTabSheet
      Caption = 'Programlog'
      OnShow = tsGeneralLogShow
      object mmoLog: TMemo
        Left = 217
        Top = 0
        Width = 1150
        Height = 690
        Align = alClient
        TabOrder = 0
      end
      object lbLogFiles: TListBox
        Left = 0
        Top = 0
        Width = 217
        Height = 690
        Align = alLeft
        ItemHeight = 15
        TabOrder = 1
        OnClick = lbLogFilesClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Business Central Log'
      OnShow = TabSheet5Show
      object lbBCLogFiles: TListBox
        Left = 0
        Top = 0
        Width = 297
        Height = 690
        Align = alLeft
        ItemHeight = 15
        TabOrder = 0
        OnClick = lbBCLogFilesClick
      end
      object mmoBCLogs: TMemo
        Left = 297
        Top = 0
        Width = 1070
        Height = 690
        Align = alClient
        TabOrder = 1
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Finanseksportlog'
      OnShow = TabSheet6Show
      object lbFinansLogFiles: TListBox
        Left = 0
        Top = 0
        Width = 297
        Height = 690
        Align = alLeft
        ItemHeight = 15
        TabOrder = 0
        OnClick = lbFinansLogFilesClick
      end
      object mmoFinansLog: TMemo
        Left = 297
        Top = 0
        Width = 1070
        Height = 690
        Align = alClient
        TabOrder = 1
      end
    end
  end
end