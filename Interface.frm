VERSION 4.00
Begin VB.Form Interface 
   Caption         =   "Floppy Imaging "
   ClientHeight    =   4440
   ClientLeft      =   2910
   ClientTop       =   1815
   ClientWidth     =   2730
   Height          =   4860
   Icon            =   "Interface.frx":0000
   Left            =   2850
   LinkTopic       =   "Interface"
   MaxButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   2730
   Top             =   1455
   Width           =   2850
   Begin VB.Timer Windows 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2340
      Top             =   2190
   End
   Begin VB.CommandButton Command 
      Caption         =   "Windows   Format"
      Height          =   645
      Index           =   5
      Left            =   720
      TabIndex        =   4
      Top             =   3525
      Width           =   1380
   End
   Begin VB.Timer Wipe 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2340
      Top             =   1710
   End
   Begin VB.Timer Format 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2340
      Top             =   1170
   End
   Begin VB.Timer Restore 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2340
      Top             =   675
   End
   Begin VB.Timer Save 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2325
      Top             =   195
   End
   Begin VB.CommandButton Command 
      Caption         =   "Remove All Data And Formatting"
      Height          =   690
      Index           =   4
      Left            =   705
      TabIndex        =   3
      Top             =   2655
      Width           =   1395
   End
   Begin VB.CommandButton Command 
      Caption         =   "Wipe Data And Fat From Disk"
      Height          =   735
      Index           =   3
      Left            =   705
      TabIndex        =   2
      Top             =   1770
      Width           =   1380
   End
   Begin VB.CommandButton Command 
      Caption         =   "Restore Image To Disk"
      Height          =   705
      Index           =   2
      Left            =   705
      TabIndex        =   1
      Top             =   930
      Width           =   1380
   End
   Begin VB.CommandButton Command 
      Caption         =   "Save Floppy Image"
      Height          =   675
      Index           =   1
      Left            =   705
      TabIndex        =   0
      Top             =   120
      Width           =   1380
   End
   Begin MSComDlg.CommonDialog SaveAs 
      Left            =   2310
      Top             =   3150
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327681
   End
   Begin MSComDlg.CommonDialog Images 
      Left            =   2310
      Top             =   2655
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327681
   End
End
Attribute VB_Name = "Interface"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit
Private Declare Function SHFormatDrive Lib "shell32" _
    (ByVal hwnd As Long, ByVal Drive As Long, ByVal fmtID As Long, _
    ByVal options As Long) As Long
Dim i As Integer
Dim TheImage As String
Dim TheName As String
Dim RtnA As String







Private Sub DisableCommands()
For i = 1 To 5
Command(i).Enabled = False
Next
End Sub

Private Sub EnableCommands()
For i = 1 To 5
Command(i).Enabled = True
Next
End Sub

Private Sub NameImage()
Dim MsgRtn As Integer
On Error GoTo Out:
With Images
    .Flags = cdlOFNPathMustExist
    .Flags = .Flags Or cdlOFNHideReadOnly
    .Flags = .Flags Or cdlOFNNoChangeDir
    .Flags = .Flags Or cdlOFNExplorer
    .Flags = .Flags Or cdlOFNNoValidate
    .Filter = "Floppy Images (*.img)|*.img|"
    .DialogTitle = "Type a name for the image"
    .FileName = "*.img"
    .InitDir = App.Path
    .CancelError = True
    .Action = 2
End With
  If IsFile(Images.FileName) Then
  MsgRtn = MsgBox("File exists, do you want to overwrite it?", vbYesNo)
    If MsgRtn = vbYes Then
    TheName = Images.FileName
       If Right(TheName, 4) <> ".img" Then
       TheName = TheName & ".img"
       End If
    Else
    TheName = ""
    End If
  Else
  TheName = Images.FileName
    If Right(TheName, 4) <> ".img" Then
    TheName = TheName & ".img"
    End If
  End If
Exit Sub
Out:
TheName = ""
End Sub
Private Sub OpenImage()
On Error GoTo Out:
With Images
    .Flags = cdlOFNPathMustExist
    .Flags = .Flags Or cdlOFNHideReadOnly
    .Flags = .Flags Or cdlOFNNoChangeDir
    .Flags = .Flags Or cdlOFNExplorer
    .Flags = .Flags Or cdlOFNNoValidate
    .Filter = "Floppy Images (*.img)|*.img|"
    .DialogTitle = "Select a Floppy Image"
    .FileName = "*.img"
    .InitDir = App.Path
    .CancelError = True
    .Action = 1
End With
  If IsFile(Images.FileName) Then
  TheImage = Images.FileName
  Else
  TheImage = ""
  End If
Exit Sub
Out:
TheImage = ""
End Sub






Private Sub Form_Load()
Me.Left = (Screen.Width - Me.Width) / 2
Me.Top = (Screen.Height - Me.Height) / 2
Shell "Notepad.exe " & App.Path & "\ReadMe.txt", 1
End Sub

Private Sub Format_Timer()
If Not TaskRunning Then
  If IsFile(App.Path & "\Temp") Then
  Kill App.Path & "\Temp"
  End If
  If IsFile(App.Path & "\Temp.img") Then
  Kill App.Path & "\Temp.img"
  End If
EnableCommands
Format.Enabled = False
End If
End Sub

Private Sub Restore_Timer()
If Not TaskRunning Then
  If IsFile(App.Path & "\Temp.img") Then
  Kill App.Path & "\Temp.img"
  End If
EnableCommands
Restore.Enabled = False
End If
End Sub

Private Sub Save_Timer()
If Not TaskRunning Then
EnableCommands
  If IsFile(App.Path & "\Temp.img") Then
  Name App.Path & "\Temp.img" As TheName
  End If
Save.Enabled = False
End If
End Sub

Private Sub Command_Click(Index As Integer)
Dim MsgRtn As Integer
If CheckDriveA Then
DisableCommands
Select Case Index
  Case 1
  NameImage
  If TheName = "" Then
  EnableCommands
  Else
  MsgRtn = MsgBox("Creating disk image " & TheName & ", continue?", vbYesNo)
    If MsgRtn = vbYes Then
    ChDir App.Path
    TaskID = ExecuteTask(App.Path & "\Save.bat")
    Save.Enabled = True
    Else
    EnableCommands
    End If
  End If
'*************
  Case 2
  OpenImage
  If TheImage = "" Then
  EnableCommands
  Else
  MsgRtn = MsgBox("Restoring disk image " & TheImage & " to the disk in Drive A:, continue?", vbYesNo)
    If MsgRtn = vbYes Then
    FileCopy TheImage, App.Path & "\Temp.img"
    ChDir App.Path
    TaskID = ExecuteTask(App.Path & "\Restore.bat")
    Restore.Enabled = True
    Else
    EnableCommands
    End If
  End If
'**********
  Case 3
  MsgRtn = MsgBox("All information on disk will be lost. Continue?", vbYesNo)
  If MsgRtn = vbYes Then
  CreateBlank 2847, App.Path & "\temp"
  ChDir App.Path
  TaskID = ExecuteTask(App.Path & "\Format.bat")
  Format.Enabled = True
  Else
  EnableCommands
  End If
'**********
  Case 4
  MsgRtn = MsgBox("All information and formatting on disk will be lost. Continue?", vbYesNo)
  If MsgRtn = vbYes Then
  CreateBlank 2880, App.Path & "\temp.img"
  ChDir App.Path
  TaskID = ExecuteTask(App.Path & "\Wipe.bat")
  Wipe.Enabled = True
  Else
  EnableCommands
  End If
'***********
  Case 5
  TaskID = ExecuteTask(SHFormatDrive(Me.hwnd, 0, 0&, 0&))
  Windows.Enabled = True
  Case Else
End Select
End If
End Sub
Private Function CheckDriveA() As Boolean
On Error GoTo Out:
RtnA = Dir("A:\*.*")
CheckDriveA = True
Exit Function
Out:
CheckDriveA = False
MsgBox "Error reading drive A, insert disk and retry."
End Function

Private Sub Windows_Timer()
If Not TaskRunning Then
EnableCommands
Windows.Enabled = False
End If
End Sub

Private Sub Wipe_Timer()
Dim RetVal As Long
If Not TaskRunning Then
  If IsFile(App.Path & "\Temp.img") Then
  Kill App.Path & "\Temp.img"
  End If
EnableCommands
RetVal = SHFormatDrive(Me.hwnd, 0, 0&, 0&)
Wipe.Enabled = False
End If
End Sub


