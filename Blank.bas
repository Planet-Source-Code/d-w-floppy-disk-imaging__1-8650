Attribute VB_Name = "Blank"
Option Explicit
Public Sub CreateBlank(Blocks As Long, FileName As String)
Dim Block1 As String  'Use 2847 Blocks for Data (1,457,664 Bytes)
Dim Block2 As String  'Use 2882 Blocks for Data and FAT (1,474,664 Bytes)
Dim hFileHandle As Integer
Dim iLoop As Long
Dim Offset As Long
Const BLOCKSIZE = 512
Block1 = String(BLOCKSIZE, Chr("0")) ' hex:00
Block2 = String(BLOCKSIZE, Chr("0"))
hFileHandle = FreeFile
Open FileName For Binary As hFileHandle
For iLoop = 1 To Blocks
Offset = Seek(hFileHandle)
Put hFileHandle, , Block1 'do it twice if it matters
Put hFileHandle, Offset, Block2 'not actually writing to floppy yet.
Next iLoop
Close hFileHandle
End Sub





