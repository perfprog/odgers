Imports System.Data

Partial Class test_files
    Inherits System.Web.UI.Page
    Dim dvF As System.Data.DataView

    

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Files_ListOnly("c:\inetpub\wwwroot\odgers_live\hoganreports")
    End Sub


    Sub Files_ListOnly(sFolderName As String)
        'Dim sFolderName As String
        Dim files() As System.IO.FileSystemInfo
        Dim di As System.IO.DirectoryInfo, i1 As Integer
        Dim dv As System.Data.DataView
        Dim dStartdate As Date

        'Get StartDate
        dv = CF.DataView_Get("Select Top 1 EmailDate as StartDate from ReportLog where RecordID=2392 order by RecordID Desc")
        dStartdate = dv.Table.Rows(0)("StartDate")
        dStartdate = dStartdate.AddSeconds(1)
        ReportLog.Debug_Show(dStartdate)

        'Get Files
        di = New System.IO.DirectoryInfo(sFolderName)
        files = di.GetFileSystemInfos("*.pdf")

        Array.Sort(files, New ReportLog.DateComparer)

        For i1 = 0 To files.Length - 1
            If DateDiff(DateInterval.Second, dStartdate, files(i1).LastWriteTime) > 10 Then
                ReportLog.Debug_Show(files(i1).FullName & ">>" & files(i1).LastWriteTime)
            End If
        Next
    End Sub
End Class
